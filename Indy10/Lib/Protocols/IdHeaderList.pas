{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11609: IdHeaderList.pas 
{
{   Rev 1.9    10/26/2004 10:10:58 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.8    3/6/2004 2:53:30 PM  JPMugaas
{ Cleaned up an if as per Bug #79.
}
{
{   Rev 1.7    2004.02.03 5:43:42 PM  czhower
{ Name changes
}
{
{   Rev 1.6    2004.01.27 1:39:26 AM  czhower
{ CharIsInSet bug fix
}
{
{   Rev 1.5    1/22/2004 3:50:04 PM  SPerry
{ fixed set problems (with CharIsInSet)
}
{
{   Rev 1.4    1/22/2004 7:10:06 AM  JPMugaas
{ Tried to fix AnsiSameText depreciation.
}
{
{   Rev 1.3    10/5/2003 11:43:50 PM  GGrieve
{ Use IsLeadChar
}
{
{   Rev 1.2    10/4/2003 9:15:14 PM  GGrieve
{ DotNet changes
}
{
{   Rev 1.1    2/25/2003 12:56:20 PM  JPMugaas
{ Updated with Hadi's fix for a bug .  If complete boolean expression i on, you
{ may get an Index out of range error.
}
{
{   Rev 1.0    11/13/2002 07:53:52 AM  JPMugaas
}
unit IdHeaderList;

{
 2002-Jan-27 Don Siders
  - Modified FoldLine to include Comma in break character set.

 2000-May-31 J. Peter Mugaas
  - started this class to facilitate some work on Indy so we don't have to
    convert '=' to ":" and vice-versa just to use the Values property.
  }

{
 NOTE:  This is a modification of Borland's TStrings definition in a
        TStringList descendant.  I had to conceal the original Values to do
        this since most of low level property setting routines aren't virtual   
        and are private.
}

interface

uses
  Classes,
  IdSys,
  IdTStrings;

type
  TIdHeaderList = class(TIdStringList)
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
    function FoldLine(AString : string) : TIdStringList;
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
    procedure AddStdValues(ASrc: TIdStrings);
    procedure ConvertToStdValues(ADest: TIdStrings);
    constructor Create;
    { This method  given a name specified by AName extracts all of the values for that name - and puts them in a new string
    list (just the values) one per line in the ADest TIdStrings.}
    procedure Extract(const AName: string; ADest: TIdStrings);
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
  IdGlobalProtocols;

{This is taken from Borland's SysUtils and modified for our folding}    {Do not Localize}
function FoldWrapText(const Line, BreakStr, BreakChars : string;
  MaxCol: Integer): string;
const
  QuoteChars = '"';    {Do not Localize}
var
  Col, Pos: Integer;
  LinePos, LineLen: Integer;
  BreakLen, BreakPos: Integer;
  QuoteChar, CurChar: Char;
  ExistingBreak: Boolean;
begin
  Col := 1;
  Pos := 1;
  LinePos := 1;
  BreakPos := 0;
  QuoteChar := ' ';    {Do not Localize}
  ExistingBreak := False;
  LineLen := Length(Line);
  BreakLen := Length(BreakStr);
  Result := '';    {Do not Localize}
  while Pos <= LineLen do
  begin
    CurChar := Line[Pos];
    if IsLeadChar(CurChar) then
    begin
      Inc(Pos);
      Inc(Col);
    end  //if CurChar in LeadBytes then
    else
      if CurChar = BreakStr[1] then
      begin
        if QuoteChar = ' ' then    {Do not Localize}
        begin
          ExistingBreak := TextIsSame(BreakStr, Copy(Line, Pos, BreakLen));
          if ExistingBreak then
          begin
            Inc(Pos, BreakLen-1);
            BreakPos := Pos;
          end; //if ExistingBreak then
        end // if QuoteChar = ' ' then    {Do not Localize}
      end // if CurChar = BreakStr[1] then
      else
        if CharIsInSet(CurChar, 1, BreakChars) then
        begin
          if QuoteChar = ' ' then    {Do not Localize}
            BreakPos := Pos
        end  // if CurChar in BreakChars then
        else
        if CharIsInSet(CurChar, 1, QuoteChars) then
          if CurChar = QuoteChar then
            QuoteChar := ' '    {Do not Localize}
          else
            if QuoteChar = ' ' then    {Do not Localize}
              QuoteChar := CurChar;
    Inc(Pos);
    Inc(Col);
    if not (CharIsInSet(QuoteChar, 1, QuoteChars)) and (ExistingBreak or
      ((Col > MaxCol) and (BreakPos > LinePos))) then
    begin
      Col := Pos - BreakPos;
      Result := Result + Copy(Line, LinePos, BreakPos - LinePos + 1);
      if not (CharIsInSet(CurChar, 1, QuoteChars)) then
        while (Pos <= LineLen) and (CharIsInSet(Line, Pos, BreakChars + #13+#10)) do Inc(Pos);
      if not ExistingBreak and (Pos < LineLen) then
        Result := Result + BreakStr;
      Inc(BreakPos);
      LinePos := BreakPos;
      ExistingBreak := False;
    end; //if not
  end; //while Pos <= LineLen do
  Result := Result + Copy(Line, LinePos, MaxInt);
end;

{ TIdHeaderList }

procedure TIdHeaderList.AddStdValues(ASrc: TIdStrings);
var
  i: integer;
begin
  for i := 0 to ASrc.Count - 1 do begin
    Add(  Sys.ReplaceOnlyFirst (ASrc[i], '=', NameValueSeparator));    {Do not Localize}
  end;
end;

procedure TIdHeaderList.ConvertToStdValues(ADest: TIdStrings);
var
  i: integer;
begin
  for i := 0 to Count - 1 do begin
    ADest.Add(Sys.ReplaceOnlyFirst(Strings[i], NameValueSeparator, '='));    {Do not Localize}
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
    while ( Index < Count ) and CharIsInSet(Get(Index),1,' '+#9) do    {Do not Localize}
    begin
      Delete( Index );
   end; //while
  end;
end;

procedure TIdHeaderList.Extract(const AName: string; ADest: TIdStrings);
var idx : Integer;
begin
  if not Assigned(ADest) then
    Exit;
  for idx := 0 to Count - 1 do
  begin
    if TextIsSame(AName, GetNameFromLine(idx)) then
    begin
      ADest.Add(GetValueFromLine(idx));
    end;
  end;
end;

procedure TIdHeaderList.FoldAndInsert(AString : String; Index: Integer);
var strs : TIdStringList;
    idx : Integer;
begin
  strs := FoldLine( AString );
  try
    idx :=  strs.Count - 1;
    Put(Index, strs [ idx ] );
    {We decrement by one because we put the last string into the HeaderList}
    Dec( idx );
    while ( idx > -1 ) do
    begin
      Insert(Index, strs [ idx ] );
      Dec( idx );
    end;
  finally
    Sys.FreeAndNil( strs );
  end;  //finally
end;

function TIdHeaderList.FoldLine(AString : string): TIdStringList;
var s : String;
begin
  Result := TIdStringList.Create;
  try
    {we specify a space so that starts a folded line}
    s := FoldWrapText(AString, EOL+' ', LWS+',', FFoldLinesLength);    {Do not Localize}
    while s <> '' do    {Do not Localize}
    begin
      Result.Add( Sys.TrimRight( Fetch( s, EOL ) ) );
    end; // while s <> '' do    {Do not Localize}
  finally
  end; //try..finally
end;

function TIdHeaderList.GetName(Index: Integer): string;
var
  P: Integer;
begin
  Result := Get( Index );
  P := IndyPos( FNameValueSeparator , Result );
  if P <> 0 then
  begin
    SetLength( Result, P - 1 );
  end  // if P <> 0 then
  else
  begin
    SetLength( Result, 0 );
  end;  // else if P <> 0 then
  Result := Result;
end;

function TIdHeaderList.GetNameFromLine(ALine: Integer): String;
var p : Integer;
begin
  Result := Get( ALine );
  if not FCaseSensitive then
  begin
    Result := Sys.UpperCase( Result );
  end; // if not FCaseSensitive then
  {We trim right to remove space to accomodate header errors such as

  Message-ID:<asdf@fdfs
  }
  P := IndyPos( Sys.TrimRight( FNameValueSeparator ), Result );
  Result := Copy( Result, 1, P - 1 );
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
        Result := Sys.Trim(Result) + ' ' + Sys.Trim(LFoldedLine); {Do not Localize}
      end;
    end;
  end else begin
    Result := ''; {Do not Localize}
  end;
  // User may be fetching an folded line diretly.
  Result := Sys.Trim(Result);
end;

function TIdHeaderList.IndexOfName(const AName: string): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 0 to Count - 1 do begin
    if TextIsSame(GetNameFromLine(i), AName) then begin
      Result := i;
      Break;
    end;
  end;
end;

procedure TIdHeaderList.SetValue(const Name, Value: string);
var
  I: Integer;
begin
  I := IndexOfName(Name);
  if Value <> '' then    {Do not Localize}
  begin
    if I < 0 then
    begin
      I := Add( '' );    {Do not Localize}
    end; //if I < 0 then
    if FFoldLines then
    begin
      DeleteFoldedLines( I );
      FoldAndInsert( Name + FNameValueSeparator + Value, I );
    end
    else
    begin
      Put( I, Name + FNameValueSeparator + Value );
    end;  //else..FFoldLines
  end //if Value <> '' then    {Do not Localize}
  else
  begin
    if I >= 0 then
    begin
      if FFoldLines then
      begin
        DeleteFoldedLines( I );
      end;
      Delete( I );
    end; //if I >= 0 then
  end;  //else .. if Value <> '' then    {Do not Localize}
end;

end.
