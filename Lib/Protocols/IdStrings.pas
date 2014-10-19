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
  Rev 1.7    2/15/2005 9:25:00 AM  DSiders
  Modified StrHtmlEncode, StrHtmlDecode to ignore apostrophe character and
  entity (not defined for HTML 4).
  Added StrXHtmlEncode, StrXHtmlDecode.
  Added comments to describe various functions.

  Rev 1.6    7/30/2004 7:49:30 AM  JPMugaas
  Removed unneeded DotNET excludes.

  Rev 1.5    2004.02.03 5:44:26 PM  czhower
  Name changes

  Rev 1.4    2004.02.03 2:12:20 PM  czhower
  $I path change

  Rev 1.3    24/01/2004 19:30:28  CCostelloe
  Cleaned up warnings

  Rev 1.2    10/12/2003 2:01:48 PM  BGooijen
  Compiles in DotNet

  Rev 1.1    10/10/2003 11:06:54 PM  SPerry

  Rev 1.0    11/13/2002 08:02:02 AM  JPMugaas

  2000-03-27  Pete Mee
  - Added FindFirstOf, FindFirstNotOf,TrimAllOf functions.

  2002-01-03  Andrew P.Rybin
  - StrHTMLEnc/Dec,BinToHexStr,IsWhiteString
}

unit IdStrings;

interface

{$i IdCompilerDefines.inc}

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
  SysUtils,
  IdException,
  IdGlobal,
  IdGlobalProtocols;

function StrHtmlEncode (const AStr: String): String;
begin
  // TODO: use StringsReplace() instead
  {
  Result := StringsReplace(AStr,
    ['&',     '<',    '>',    '"'],      {do not localize
    ['&amp;', '&lt;', '&gt;', '&quot;']  {do not localize
  );
  }
  Result := ReplaceAll(AStr,   '&', '&amp;'); {do not localize}
  Result := ReplaceAll(Result, '<', '&lt;'); {do not localize}
  Result := ReplaceAll(Result, '>', '&gt;'); {do not localize}
  Result := ReplaceAll(Result, '"', '&quot;'); {do not localize}
end;

function StrHtmlDecode (const AStr: String): String;
begin
  // TODO: use StringsReplace() instead
  {
  Result := StringsReplace(AStr,
    ['&quot;', '&gt;', '&lt;', '&amp;'],  {do not localize
    ['"',      '>',    '<',    '&']       {do not localize
  );
  }
  Result := ReplaceAll(AStr,   '&quot;', '"'); {do not localize}
  Result := ReplaceAll(Result, '&gt;',   '>'); {do not localize}
  Result := ReplaceAll(Result, '&lt;',   '<'); {do not localize}
  Result := ReplaceAll(Result, '&amp;',  '&'); {do not localize}
end;

function StrXHtmlEncode(const ASource: String): String;
begin
  //TODO: use StringsReplace() instead
  {
  Result := StringsReplace(ASource,
    ['&',     '<',    '>',    '"',      ''''],     {do not localize
    ['&amp;', '&lt;', '&gt;', '&quot;', '&apos;']  {do not localize
  );
  }
  Result := ReplaceAll(ASource, '&',  '&amp;'); {do not localize}
  Result := ReplaceAll(Result,  '<',  '&lt;'); {do not localize}
  Result := ReplaceAll(Result,  '>',  '&gt;'); {do not localize}
  Result := ReplaceAll(Result,  '"',  '&quot;'); {do not localize}
  Result := ReplaceAll(Result,  '''', '&apos;'); {do not localize}
end;

function StrXHtmlDecode(const ASource: String): String;
begin
  // TODO: use StringsReplace() instead
  {
  Result := StringsReplace(ASource,
    ['&apos;', '&quot;', '&gt;', '&lt;', '&amp;'],  {do not localize
    ['''',     '"',      '>',    '<',    '&']       {do not localize
  );
  }
  Result := ReplaceAll(ASource, '&apos;', ''''); {do not localize}
  Result := ReplaceAll(Result,  '&quot;', '"'); {do not localize}
  Result := ReplaceAll(Result,  '&gt;',   '>'); {do not localize}
  Result := ReplaceAll(Result,  '&lt;',   '<'); {do not localize}
  Result := ReplaceAll(Result,  '&amp;',  '&'); {do not localize}
end;

// SP - 10/10/2003
function BinToHexStr(AData: Byte): String;
begin
  Result := IdHexDigits[AData shr 4] + IdHexDigits[AData and $F];
end;

function IsWhiteString(const AStr: String): Boolean;
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
      if not CharIsInSet(AStr, i, LWS) then
      begin
        Result := FALSE;
        Break;
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
