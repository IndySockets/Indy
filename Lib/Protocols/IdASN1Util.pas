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
  Rev 1.2    3/3/2005 9:13:36 AM  JPMugaas
  Should work in DotNET.

  Rev 1.1    02/03/2005 00:09:14  CCostelloe
  Bug fix (high bit treated as sign instead of MSB)

  Rev 1.0    11/14/2002 02:12:30 PM  JPMugaas
}

unit IdASN1Util;

// REVIEW: Licensing problem
// 1) Is this only used by SNMP? If so it should be merged there.
// 2) MPL conflicts with Indy's BSD. We need permission to distribute under BSD as well.
// 3) A comment needs to be added that Indy has permission to use this

{
|==============================================================================|
| Project : Delphree - Synapse                                   | 001.003.004 |
|==============================================================================|
| Content: support for ASN.1 coding and decoding                               |
|==============================================================================|
| The contents of this file are subject to the Mozilla Public License Ver. 1.1 |
| (the "License"); you may not use this file except in compliance with the     |
| License. You may obtain a copy of the License at http://www.mozilla.org/MPL/ |
|                                                                              |
| Software distributed under the License is distributed on an "AS IS" basis,   |
| WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License for |
| the specific language governing rights and limitations under the License.    |
|==============================================================================|
| The Original Code is Synapse Delphi Library.                                 |
|==============================================================================|
| The Initial Developer of the Original Code is Lukas Gebauer (Czech Republic).|
| Portions created by Lukas Gebauer are Copyright (c) 1999,2000,2001.          |
| Portions created by Hernan Sanchez are Copyright (c) 2000.                   |
| All Rights Reserved.                                                         |
|==============================================================================|
| Contributor(s):                                                              |
|   Hernan Sanchez (hernan.sanchez@iname.com)                                  |
|==============================================================================|
| History: see HISTORY.HTM from distribution package                           |
|          (Found at URL: http://www.ararat.cz/synapse/)                       |
|==============================================================================|
}

{$i IdOverflowCheckingOff.inc}
{$WEAKPACKAGEUNIT ON}

interface
{$i IdCompilerDefines.inc}

uses
  {$IFNDEF HAS_UInt32}
  IdGlobal,
  {$ENDIF}
  SysUtils;

const
  ASN1_INT = $02;
  ASN1_OCTSTR = $04;
  ASN1_NULL = $05;
  ASN1_OBJID = $06;
  ASN1_SEQ = $30;
  ASN1_IPADDR = $40;
  ASN1_COUNTER = $41;
  ASN1_GAUGE = $42;
  ASN1_TIMETICKS = $43;
  ASN1_OPAQUE = $44;
  ASN1_APP_COUNTER64 = $46;
  // TODO: float, double, int64, uint64

function ASNEncOIDItem(Value: UInt32): string;
function ASNDecOIDItem(var Start: Integer; const Buffer: string): UInt32;
function ASNEncLen(Len: Integer): string;
function ASNDecLen(var Start: Integer; const Buffer: string): Integer;
function ASNEncInt(Value: Integer): string;
function ASNEncUInt(Value: Integer): string;
function ASNObject(const Data: string; ASNType: Integer): string;
function ASNItem(var Start: Integer; const Buffer: string;
  var ValueType: Integer): string;
function MibToId(Mib: string): string;
function IdToMib(const Id: string): string;
function IntMibToStr(const Value: string): string;

implementation

{$IFDEF HAS_UInt32}
uses
  IdGlobal;
{$ENDIF}

{==============================================================================}
function ASNEncOIDItem(Value: UInt32): string;
var
  x, xm: UInt32;
  b: Boolean;
begin
  x := Value;
  b := False;
  Result := '';  {Do not Localize}
  repeat
    xm := x mod 128;
    x := x div 128;
    if b then
      xm := xm or $80;
    if x > 0 then
      b := True;
    Result := Char(xm) + Result;
  until x = 0;
end;

{==============================================================================}
function ASNDecOIDItem(var Start: Integer; const Buffer: string): UInt32;
var
  x: UInt32;
  b: Boolean;
begin
  Result := 0;
  repeat
    Result := Result * 128;
    x := Ord(Buffer[Start]);
    Inc(Start);
    b := x > $7F;
    x := x and $7F;
    Result := Result + x;
  until not b;
end;

{==============================================================================}
function ASNEncLen(Len: Integer): string;
var
  x, y: Integer;
begin
  if Len < $80 then
    Result := Char(Len)
  else
  begin
    x := Len;
    Result := ''; {Do not Localize}
    repeat
      y := x mod 256;
      x := x div 256;
      Result := Char(y) + Result;
    until x = 0;
    y := Length(Result);
    y := y or $80;
    Result := Char(y) + Result;
  end;
end;

{==============================================================================}
function ASNDecLen(var Start: Integer; const Buffer: string): Integer;
var
  x, n: Integer;
begin
  x := Ord(Buffer[Start]);
  Inc(Start);
  if x < $80 then
    Result := x
  else
  begin
    Result := 0;
    x := x and $7F;
    for n := 1 to x do
    begin
      Result := Result * 256;
      x := Ord(Buffer[Start]);
      Inc(Start);
      Result := Result + x;
    end;
  end;
end;

{==============================================================================}
function ASNEncInt(Value: Integer): string;
var
  x, y: UInt32;
  neg: Boolean;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ENDIF}
begin
  neg := Value < 0;
  x := Abs(Value);
  if neg then begin
    x := not (x - 1);
  end;
  Result := '';  {Do not Localize}
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create;
  {$ENDIF}
  repeat
    y := x mod 256;
    x := x div 256;
    {$IFDEF STRING_IS_IMMUTABLE}
    LSB.Insert(0, Char(y));
    {$ELSE}
    Result := Char(y) + Result;
    {$ENDIF}
  until x = 0;
  if (not neg) then
  begin
    {$IFDEF STRING_IS_IMMUTABLE}
    if (LSB[0] > #$7F) then begin
      LSB.Insert(0, #0);
    end;
    {$ELSE}
    if (Result[1] > #$7F) then begin
      Result := #0 + Result;
    end;
    {$ENDIF}
  end;
  {$IFDEF STRING_IS_IMMUTABLE}
  Result := LSB.ToString;
  {$ENDIF}
end;

{==============================================================================}
function ASNEncUInt(Value: Integer): string;
var
  x, y: Integer;
  neg: Boolean;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ENDIF}
begin
  neg := Value < 0;
  x := Value;
  if neg then begin
    x := x and $7FFFFFFF;
  end;
  Result := '';     {Do not Localize}
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create;
  {$ENDIF}
  repeat
    y := x mod 256;
    x := x div 256;
    {$IFDEF STRING_IS_IMMUTABLE}
    LSB.Insert(0, Char(y));
    {$ELSE}
    Result := Char(y) + Result;
    {$ENDIF}
  until x = 0;
  if neg then begin
    {$IFDEF STRING_IS_IMMUTABLE}
    LSB[0] := Char(Ord(LSB[0]) or $80);
    {$ELSE}
    Result[1] := Char(Ord(Result[1]) or $80);
    {$ENDIF}
  end;
  {$IFDEF STRING_IS_IMMUTABLE}
  Result := LSB.ToString;
  {$ENDIF}
end;

{==============================================================================}
function ASNObject(const Data: string; ASNType: Integer): string;
begin
  Result := Char(ASNType) + ASNEncLen(Length(Data)) + Data;
end;

{==============================================================================}
function ASNItem(var Start: Integer; const Buffer: string;
  var ValueType: Integer): string;
var
  ASNType: Integer;
  ASNSize: Integer;
  y, n: Integer;
  x: byte;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ELSE}
  s: string;
  {$ENDIF}
  neg: Boolean;
  l: Integer;
  z: Int64;

begin
  Result := '';              {Do not Localize}
  ValueType := ASN1_NULL;
  l := Length(Buffer);
  if l < (Start + 1) then begin
    Exit;
  end;
  ASNType := Ord(Buffer[Start]);
  ValueType := ASNType;
  Inc(Start);
  ASNSize := ASNDecLen(Start, Buffer);
  if (Start + ASNSize - 1) > l then begin
    Exit;
  end;
  if (ASNType and $20) > 0 then begin
    Result := '$' + IntToHex(ASNType, 2)     {Do not Localize}
  end else
  begin
    case ASNType of
      ASN1_INT:
        begin
          y := 0;
          neg := False;
          for n := 1 to ASNSize do
          begin
            x := Ord(Buffer[Start]);
            if (n = 1) and (x > $7F) then begin
              neg := True;
            end;
            if neg then begin
              x := not x;
            end;
            y := y * 256 + x;
            Inc(Start);
          end;
          if neg then begin
            y := -(y + 1);
          end;
          Result := IntToStr(y);
        end;
      ASN1_COUNTER, ASN1_GAUGE, ASN1_TIMETICKS,  //Typically a 32-bit _unsigned_ number
      ASN1_APP_COUNTER64:
      // TODO: int64, uint64
        begin
          z := 0;
          for n := 1 to ASNSize do begin
            x := Ord(Buffer[Start]);     //get the byte
            y := x;                      //promote to an integer
            z := (z * 256) + y;          //now accumulate value
            Inc(Start);
          end;
          Result := IntToStr(z);
        end;
      // TODO: float, double
      ASN1_OCTSTR, ASN1_OPAQUE:
        begin
          {$IFDEF STRING_IS_IMMUTABLE}
          LSB := TIdStringBuilder.Create(ASNSize);
          {$ELSE}
          SetLength(s, ASNSize);
          {$ENDIF}
          for n := 1 to ASNSize do
          begin
            {$IFDEF STRING_IS_IMMUTABLE}
            LSB.Append(Char(Buffer[Start]));
            {$ELSE}
            s[n] := Char(Buffer[Start]);
            {$ENDIF}
            Inc(Start);
          end;
          {$IFDEF STRING_IS_IMMUTABLE}
          Result := LSB.ToString;
          {$ELSE}
          Result := s;
          {$ENDIF}
        end;
      ASN1_OBJID:
        begin
          {$IFDEF STRING_IS_IMMUTABLE}
          LSB := TIdStringBuilder.Create(ASNSize);
          {$ELSE}
          SetLength(s, ASNSize);
          {$ENDIF}
          for n := 1 to ASNSize do
          begin
            {$IFDEF STRING_IS_IMMUTABLE}
            LSB.Append(Char(Buffer[Start]));
            {$ELSE}
            s[n] := Char(Buffer[Start]);
            {$ENDIF}
            Inc(Start);
          end;
          Result := IdToMib(
            {$IFDEF STRING_IS_IMMUTABLE}
            LSB.ToString
            {$ELSE}
            s
            {$ENDIF}
          );
        end;
      ASN1_IPADDR:
        begin
          {$IFDEF STRING_IS_IMMUTABLE}
          LSB := TIdStringBuilder.Create(15);
          {$ELSE}
          s := '';               {Do not Localize}
          {$ENDIF}
          for n := 1 to ASNSize do
          begin
            if (n <> 1) then begin
              {$IFDEF STRING_IS_IMMUTABLE}
              LSB.Append('.');   {Do not Localize}
              {$ELSE}
              s := s + '.';      {Do not Localize}
              {$ENDIF}
            end;
            y := Ord(Buffer[Start]);
            Inc(Start);
            {$IFDEF STRING_IS_IMMUTABLE}
            LSB.Append(y);
            {$ELSE}
            s := s + IntToStr(y);
            {$ENDIF}
          end;
          {$IFDEF STRING_IS_IMMUTABLE}
          Result := LSB.ToString;
          {$ELSE}
          Result := s;
          {$ENDIF}
        end;
      ASN1_NULL:
        begin
          Result := '';
          Inc(Start, ASNSize);
        end;
    else // unknown
      begin
        {$IFDEF STRING_IS_IMMUTABLE}
        LSB := TIdStringBuilder.Create(ASNSize);
        {$ELSE}
        SetLength(s, ASNSize);
        {$ENDIF}
        for n := 1 to ASNSize do
        begin
          {$IFDEF STRING_IS_IMMUTABLE}
          LSB.Append(Char(Buffer[Start]));
          {$ELSE}
          s[n] := Char(Buffer[Start]);
          {$ENDIF}
          Inc(Start);
        end;
        {$IFDEF STRING_IS_IMMUTABLE}
        Result := LSB.ToString;
        {$ELSE}
        Result := s;
        {$ENDIF}
      end;
    end;
  end;
end;

{==============================================================================}
function MibToId(Mib: string): string;
var
  x: UInt32;

  function WalkInt(var s: string): UInt32;
  var
    lx: Integer;
    t: string;
  begin
    lx := Pos('.', s);      {Do not Localize}
    if lx < 1 then
    begin
      t := s;
      s := '';        {Do not Localize}
    end
    else
    begin
      t := Copy(s, 1, lx - 1);
      s := Copy(s, lx + 1, MaxInt);
    end;
    // TODO: verify the returned value is in the range of UInt32!
    Result := IndyStrToInt64(t, 0);
  end;

begin
  Result := '';            {Do not Localize}
  x := WalkInt(Mib);
  x := x * 40 + WalkInt(Mib);
  Result := ASNEncOIDItem(x);
  while Mib <> '' do            {Do not Localize}
  begin
    x := WalkInt(Mib);
    Result := Result + ASNEncOIDItem(x);
  end;
end;

{==============================================================================}

{$IFNDEF HAS_UIntToStr}
function UIntToStr(AValue: UInt32): string;
{$IFDEF USE_INLINE}inline;{$ENDIF}
begin
  Result := SysUtils.IntToStr(Int64(AValue));
end;
{$ENDIF}

function IdToMib(const Id: string): string;
var
  x, y: UInt32;
  n: Integer;
begin
  Result := '';              {Do not Localize}
  n := 1;
  while Length(Id) + 1 > n do
  begin
    x := ASNDecOIDItem(n, Id);
    if (n - 1) = 1 then
    begin
      y := x div 40;
      x := x mod 40;
      Result := UIntToStr(y);
    end;
    Result := Result + '.' + UIntToStr(x);    {Do not Localize}
  end;
end;

{==============================================================================}
function IntMibToStr(const Value: string): string;
var
  n, y: Integer;
begin
  y := 0;
  for n := 1 to Length(Value) - 1 do begin
    y := y * 256 + Ord(Value[n]);
  end;
  Result := IntToStr(y);
end;

{==============================================================================}

end.
