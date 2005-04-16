{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11765: IdStrings.pas
{
    Rev 1.7    2/15/2005 9:25:00 AM  DSiders
  Modified StrHtmlEncode, StrHtmlDecode to ignore apostrophe character and
  entity (not defined for HTML 4).
  Added StrXHtmlEncode, StrXHtmlDecode.
  Added comments to describe various functions.
}
{
{   Rev 1.6    7/30/2004 7:49:30 AM  JPMugaas
{ Removed unneeded DotNET excludes.
}
{
{   Rev 1.5    2004.02.03 5:44:26 PM  czhower
{ Name changes
}
{
{   Rev 1.4    2004.02.03 2:12:20 PM  czhower
{ $I path change
}
{
{   Rev 1.3    24/01/2004 19:30:28  CCostelloe
{ Cleaned up warnings
}
{
{   Rev 1.2    10/12/2003 2:01:48 PM  BGooijen
{ Compiles in DotNet
}
{
{   Rev 1.1    10/10/2003 11:06:54 PM  SPerry
{ -
}
{
{   Rev 1.0    11/13/2002 08:02:02 AM  JPMugaas
}
unit IdStrings;

interface

uses
  Classes;

{
  2000-03-27  Pete Mee
  - Added FindFirstOf, FindFirstNotOf,TrimAllOf functions.
  2002-01-03  Andrew P.Rybin
  - StrHTMLEnc/Dec,BinToHexStr,IsWhiteString
}

function  FindFirstOf(AFind, AText: String): Integer;
function  FindFirstNotOf(AFind, AText : String) : Integer;
function  TrimAllOf(ATrim, AText : String) : String;

{
  IsWhiteString
  Returns TRUE when AStr contains only whitespace characters
  TAB (decimal 9), SPACE (decimal 32), or an empty string.
}
function  IsWhiteString(const AStr: String): Boolean;

{
  BinToHexStr
  converts the byte value in AData to its representation as
  a 2-byte hexadecimal value without the '$' prefix.
  For instance: 'FF', 'FE', or '0A'
}
function  BinToHexStr(AData: Byte): String;

{
  Encode and decode characters representing pre-defined character
  entities for HTML 4.
  handles &<>" characters
}
function  StrHtmlEncode (const AStr: String): String;
function  StrHtmlDecode (const AStr: String): String;

{
  Encode and decode characters representing pre-defined character
  entities for XHTML, XML.
  handles &<>"' characters
}
function StrXHtmlEncode(const ASource: String): String;
function StrXHtmlDecode(const ASource: String): String;

{
  SplitString splits a string into left and right parts,
  i.e. SplitString('Namespace:tag', ':'..) will return 'Namespace' and 'tag'
}
procedure SplitString(const AStr, AToken: String; var VLeft, VRight: String);

{
  CommaAdd
  Appends AStr2 to the right of AStr1 and returns the result.
  If there is any content in AStr1, a comma will be appended
  prior to the value of AStr2.
}
function CommaAdd(Const AStr1, AStr2:String):string;

implementation

uses
  IdGlobal,
  IdGlobalProtocols,
  SysUtils;

function StrHtmlEncode (const AStr: String): String;
begin
  Result := StringReplace(AStr,   '&', '&amp;',  [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result, '<', '&lt;',   [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result, '>', '&gt;',   [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result, '"', '&quot;', [rfReplaceAll]); {do not localize}
end;

function StrHtmlDecode (const AStr: String): String;
begin
  Result := StringReplace(AStr,   '&quot;', '"', [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result, '&gt;',   '>', [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result, '&lt;',   '<', [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result, '&amp;',  '&', [rfReplaceAll]); {do not localize}
end;

function StrXHtmlEncode(const ASource: String): String;
begin
  Result := StringReplace(ASource, '&',  '&amp;',  [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result,  '<',  '&lt;',   [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result,  '>',  '&gt;',   [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result,  '"',  '&quot;', [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result,  '''', '&apos;', [rfReplaceAll]); {do not localize}
end;

function StrXHtmlDecode(const ASource: String): String;
begin
  Result := StringReplace(ASource, '&apos;', '''', [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result,  '&quot;', '"',  [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result,  '&gt;',   '>',  [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result,  '&lt;',   '<',  [rfReplaceAll]); {do not localize}
  Result := StringReplace(Result,  '&amp;',  '&',  [rfReplaceAll]); {do not localize}
end;

function FindFirstOf(AFind, AText: string): Integer;
var
  nCount, nPos: Integer;
begin
  Result := 0;

  for nCount := 1 to Length(AFind) do
  begin
    nPos := IndyPos(AFind[nCount], AText);
    if nPos > 0 then
    begin
      if Result = 0 then
      begin
        Result := nPos;
      end
      else if Result > nPos then
      begin
        Result := nPos;
      end;
    end;
  end;
end;

function FindFirstNotOf(AFind, AText : String) : Integer;
var
  i : Integer;
begin
  Result := 0;

  if length(AFind) = 0 then
  begin
    Result := 1;
    exit;
  end;

  if length(AText) = 0 then
  begin
    exit;
  end;

  for i := 1 to length(AText) do
  begin
    if IndyPos(AText[i], AFind) = 0 then
    begin
      Result := i;
      exit;
    end;
  end;
end;

function TrimAllOf(ATrim, AText : String) : String;
begin
  while Length(AText) > 0 do
  begin
    if Pos(AText[1], ATrim) > 0 then
    begin
      IdDelete(AText, 1, 1);
    end
    else break;
  end;
  while Length(AText) > 0 do
  begin
    if Pos(AText[length(AText)], ATrim) > 0 then
    begin
      IdDelete(AText, Length(AText), 1);
    end
    else break;
  end;
  Result := AText;
end;

// SP - 10/10/2003
function BinToHexStr(AData: Byte): String;
begin
  Result := IdHexDigits[AData shr 4] + IdHexDigits[AData and $F];
end;

function IsWhiteString(const AStr: String): Boolean;
const
  WhiteSet = [TAB, CHAR32];    {do not localize}
var
  i: Integer;
  LLen: Integer;
begin
  Result := True;
  LLen := Length(AStr);

  if LLen > 0 then
  begin
    for i := 1 to LLen do
    begin
      if not CharIsInSet(AStr, i, WhiteSet) then
      begin
        Result := FALSE;
        break;
      end;
    end;
  end;
end;

procedure SplitString(const AStr, AToken: String; var VLeft, VRight: String);
var
  i: Integer;
  LLocalStr: String;
begin
  { It is possible that VLeft or VRight may be the same variable as AStr.
   So we copy it first }
  LLocalStr := AStr;
  i := Pos(AToken, LLocalStr);
  if i = 0 then
  begin
    VLeft := LLocalStr;
    VRight := '';
  end
  else
  begin
    VLeft := Copy(LLocalStr, 1, i - 1);
    VRight := Copy(LLocalStr, i + Length(AToken), Length(LLocalStr));
  end;
end;

function CommaAdd(Const AStr1, AStr2:String):string;
begin
  if AStr1 = '' then
    result := AStr2
  else
    result := AStr1 + ',' + AStr2;
end;

end.
