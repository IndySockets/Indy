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
  Rev 1.0    15/04/2005 7:25:02 AM  GGrieve
  first ported to INdy
}

unit IdASN1Coder;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  Contnrs;

type

  TIdASN1IdentifierType = (aitUnknown, aitSequence, aitBoolean, aitInteger, aitEnum, aitString, aitOID, aitReal);

  TIdASN1IdentifierClass = (aicUniversal, aicApplication, aicContextSpecific, aicPrivate);

  TIdASN1Identifier = record
    Position : Integer;
    IdClass : TIdASN1IdentifierClass;
    Constructed : Boolean;
    TagValue : Integer;
    TagType : TIdASN1IdentifierType;
    ContentLength : integer;
  end;

  TIdASN1Sequence = Class
    Private
      FIdClass : TIdASN1IdentifierClass;
      FTag : Integer;
      FContents : String;
    Public
      Property IdClass : TIdASN1IdentifierClass Read FIdClass Write FIdClass;
      Property Tag : integer Read FTag Write FTag;
      Property Contents : String Read FContents Write FContents;
  End;

  TIdASN1Sequences = Class(TObjectList)
    Private
      Function GetElement(Const iIndex : Integer) : TIdASN1Sequence;
      function GetLast: TIdASN1Sequence;
    Public
      Property LastElement : TIdASN1Sequence read GetLast;
      procedure Pop;
      Property Elements[Const iIndex : Integer] : TIdASN1Sequence Read GetElement; Default;
  End;

  TIdASN1Encoder = class
  private
    FSequences : TIdASN1Sequences;
    FReadyToWrite : Boolean;
    function FormatEncoding(aClass : TIdASN1IdentifierClass; bConstructed : Boolean; iTag : integer; const sContent : String) : String;
    procedure AddEncoding(const sContent : String);

    procedure WriteInt(iTag : integer; iValue : integer);
    function EncodeLength(iLen : Integer):String;
  protected
    // must call this as an outer wrapper
    Procedure StartWriting;
    Procedure StopWriting;

    // sequences
    procedure StartSequence; overload;
    procedure StartSequence(iTag : Integer); overload;
    procedure StartSequence(aClass : TIdASN1IdentifierClass; iTag : Integer); overload;
    procedure StopSequence;

    // primitives
    procedure WriteBoolean(bValue : Boolean);
    procedure WriteInteger(iValue : Integer);
    procedure WriteEnum(iValue : Integer);
    procedure WriteString(sValue : String); overload;
    procedure WriteString(iTag : integer; sValue : String); overload;
  public
    Constructor Create;
    destructor Destroy; override;

    procedure WriteToStream(Stream : TStream);
  end;

  TIntegerList = class (TList)
  private
    function GetValue(iIndex: integer): Integer;
    procedure SetValue(Index: integer; const Value: Integer);
  public
    procedure AddInt(value : integer);
    procedure InsertInt(Index, Value : integer);
    property Value[iIndex : integer]:Integer read GetValue write SetValue; default;
  end;

  TIdASN1Decoder = class
  private
    FLengths : TIntegerList;
    FPosition : Integer;
    FNextHeader : TIdASN1Identifier;
    FNextHeaderUsed : Boolean;
    FStream: TStream;
    function ReadHeader : TIdASN1Identifier; // -1 in length means that no definite length was specified
    function DescribeIdentifier(const aId : TIdASN1Identifier) : String;
    Function ReadByte : Byte;
    function ReadChar : Char;
    function ReadContentLength : Integer;
  protected
    procedure Check(bCondition : Boolean; const sMethod, sMessage : String); overload; virtual;

    // must call this as an outer wrapper
    Procedure StartReading;
    Procedure StopReading;

    // sequences and choices
    procedure ReadSequenceBegin;
    function SequenceEnded : Boolean;
    procedure ReadSequenceEnd;
    function NextTag : integer;
    function NextTagType : TIdASN1IdentifierType;

    // primitives
    function ReadBoolean : Boolean;
    Function ReadInteger : Integer;
    function ReadEnum : Integer;
    Function ReadString : String;

  public
    Constructor Create;
    destructor Destroy; override;
    property Stream : TStream read FStream write FStream;
  end;


const
  NAMES_ASN1IDENTIFIERTYPE : array [TIdASN1IdentifierType] of String = ('Unknown', 'Sequence', 'Boolean', 'Integer', 'Enum', 'String', 'OID', 'Real');
  TAGS_ASN1IDENTIFIERTYPE : array [TIdASN1IdentifierType] of Integer = (0, $10, $01, $02, $0A, $04, $06, 0 {?});
  NAMES_ASN1IDENTIFIERCLASS : array [TIdASN1IdentifierClass] of String = ('Universal', 'Application', 'ContextSpecific', 'Private');

function ToIdentifierType(iTag : integer) : TIdASN1IdentifierType;

implementation

uses
  IdGlobal, IdException, SysUtils;

function ToIdentifierType(iTag : integer) : TIdASN1IdentifierType;
begin
  case iTag of
    $10 : result := aitSequence;
    $01 : result := aitBoolean;
    $02 : result := aitInteger;
    $04 : result := aitString;
    $06 : result := aitOID;
    $0A : result := aitEnum;
  else
    result := aitUnknown;
  end;
end;


{ TIdASN1Encoder }

constructor TIdASN1Encoder.Create;
begin
  inherited Create;
  FSequences := TIdASN1Sequences.create;
end;

destructor TIdASN1Encoder.Destroy;
begin
  FSequences.Free;
  inherited Destroy;
end;

procedure TIdASN1Encoder.WriteToStream(Stream : TStream);
begin
  Assert(FReadyToWrite, 'not ready to write');
  if Length(FSequences[0].Contents) <> 0 then
    WriteStringToStream(Stream, FSequences[0].Contents, IndyTextEncoding_8Bit);
end;

procedure TIdASN1Encoder.StartWriting;
begin
  FSequences.Clear;
  StartSequence(aicUniversal, 0);
end;

procedure TIdASN1Encoder.StopWriting;
begin
  assert(FSequences.Count = 1, 'Writing left an open Sequence');
  FReadyToWrite := true;
// todo - actually commit to stream  Produce(Fsequences[0].Contents);
end;

procedure TIdASN1Encoder.StartSequence(aClass: TIdASN1IdentifierClass; iTag: Integer);
var
  oSequence : TIdASN1Sequence;
begin
  oSequence := TIdASN1Sequence.create;
  try
    oSequence.IdClass := aClass;
    oSequence.Tag := iTag;
    oSequence.Contents := '';
    FSequences.add(oSequence);
  except
    oSequence.Free;
    raise;
  end;
end;

procedure TIdASN1Encoder.StartSequence(iTag: Integer);
begin
  if iTag = -1 then
    StartSequence(aicUniversal, TAGS_ASN1IDENTIFIERTYPE[aitSequence])
  else
    StartSequence(aicApplication, iTag);
end;

procedure TIdASN1Encoder.StartSequence;
begin
  StartSequence(aicUniversal, TAGS_ASN1IDENTIFIERTYPE[aitSequence]);
end;

procedure TIdASN1Encoder.StopSequence;
var
  sSequence : String;
begin
  sSequence := FormatEncoding(FSequences.LastElement.IdClass, true, FSequences.LastElement.Tag, FSequences.LastElement.Contents);
  FSequences.Pop;
  AddEncoding(sSequence);
end;


procedure TIdASN1Encoder.WriteBoolean(bValue: Boolean);
begin
  // RLebeau 1/7/09: using Char() for #128-#255 because in D2009, the compiler
  // may change characters >= #128 from their Ansi codepage value to their true
  // Unicode codepoint value, depending on the codepage used for the source code.
  // For instance, #128 may become #$20AC...
  if bValue then
    AddEncoding(FormatEncoding(aicUniversal, False, TAGS_ASN1IDENTIFIERTYPE[aitBoolean], Char($FF)))
  else
    AddEncoding(FormatEncoding(aicUniversal, False, TAGS_ASN1IDENTIFIERTYPE[aitBoolean], #$00));
end;

procedure TIdASN1Encoder.WriteEnum(iValue: Integer);
begin
  WriteInt(TAGS_ASN1IDENTIFIERTYPE[aitEnum], iValue);
end;

procedure TIdASN1Encoder.WriteInteger(iValue: Integer);
begin
  WriteInt(TAGS_ASN1IDENTIFIERTYPE[aitInteger], iValue);
end;

procedure TIdASN1Encoder.WriteInt(iTag, iValue: integer);
var
  sValue : String;
  x, y: Cardinal;
  bNeg: Boolean;
begin
  bNeg := iValue < 0;
  x := Abs(iValue);
  if bNeg then
    x := not (x - 1);
  sValue := '';  {Do not Localize}
  repeat
    y := x mod 256;
    x := x div 256;
    sValue := Char(y) + sValue;
  until x = 0;
  if (not bNeg) and (sValue[1] > #$7F) then
    sValue := #0 + sValue;

  AddEncoding(FormatEncoding(aicUniversal, False, iTag, sValue))
end;

procedure TIdASN1Encoder.WriteString(sValue: String);
begin
  AddEncoding(FormatEncoding(aicUniversal, False, TAGS_ASN1IDENTIFIERTYPE[aitString], sValue))
end;

procedure TIdASN1Encoder.WriteString(iTag : integer; sValue: String);
begin
  AddEncoding(FormatEncoding(aicContextSpecific, False, iTag, sValue))
end;

procedure TIdASN1Encoder.AddEncoding(const sContent: String);
begin
  FSequences.LastElement.Contents := FSequences.LastElement.Contents + sContent;
end;

function TIdASN1Encoder.FormatEncoding(aClass: TIdASN1IdentifierClass; bConstructed : Boolean; iTag: integer; const sContent: String): String;
begin
  if bConstructed then
    result := chr((ord(aClass) shl 6) or $20 or iTag) + EncodeLength(length(sContent)) + sContent
  else
    result := chr((ord(aClass) shl 6) or iTag) + EncodeLength(length(sContent)) + sContent;
end;

function TIdASN1Encoder.EncodeLength(iLen: Integer): String;
var
  x, y: Integer;
begin
  if iLen < $80 then
    Result := Char(iLen)
  else
  begin
    x := iLen;
    Result := '';
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

{ TIdASN1Sequences }

function TIdASN1Sequences.GetElement(const iIndex: Integer): TIdASN1Sequence;
begin
  result := TIdASN1Sequence(items[iIndex]);
end;

function TIdASN1Sequences.GetLast: TIdASN1Sequence;
begin
  if Count = 0 then
    result := nil
  else
    result := GetElement(Count - 1);
end;

procedure TIdASN1Sequences.Pop;
begin
  if Count > 0 then
    Delete(Count-1);
end;

{ TIdASN1Decoder }

Constructor TIdASN1Decoder.Create;
begin
  inherited Create;
  FLengths := TIntegerList.create;
end;

destructor TIdASN1Decoder.Destroy;
begin
  FLengths.Free;
  Inherited  Destroy;
end;

procedure TIdASN1Decoder.Check(bCondition: Boolean; const sMethod, sMessage: String);
begin
  if not bCondition then
    raise EIdException.create(sMessage); // TODO: create a new Exception class for this
end;

Procedure TIdASN1Decoder.StartReading;
begin
  FLengths.Clear;
  FLengths.AddInt(-1);
  FNextHeaderUsed := False;
  FPosition := 0;
end;

Procedure TIdASN1Decoder.StopReading;
begin
  Check(FLengths.Count = 1, 'StopReading', 'Reading was incomplete');
  FLengths.Clear;
end;

function TIdASN1Decoder.DescribeIdentifier(const aId : TIdASN1Identifier) : String;
begin
  result := '[Pos '+IntToStr(aId.Position)+', Type '+NAMES_ASN1IDENTIFIERTYPE[aId.TagType]+', '+
             'Tag '+IntToStr(aId.TagValue)+', Class '+NAMES_ASN1IDENTIFIERCLASS[aId.IdClass]+']';
end;

Function TIdASN1Decoder.ReadByte : Byte;
begin
  Check(FLengths[0] <> 0, 'ReadByte', 'Attempt to read past end of Sequence');
  Stream.Read(result, 1);
  inc(FPosition);
  FLengths[0] := FLengths[0] - 1;
end;

function TIdASN1Decoder.ReadChar : Char;
begin
  result := Chr(readByte);
end;

function TIdASN1Decoder.ReadContentLength: Integer;
var
  iNext : Byte;
  iLoop: Integer;
begin
  iNext := ReadByte;
  if iNext < $80 then
    Result := iNext
  else
  begin
    Result := 0;
    iNext := iNext and $7F;
    if iNext = 0 then
      raise EIdException.create('Indefinite lengths are not yet handled'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
    for iLoop := 1 to iNext do
    begin
      Result := Result * 256;
      iNext := ReadByte;
      Result := Result + iNext;
    end;
  end;
end;

function TIdASN1Decoder.ReadHeader : TIdASN1Identifier;
var
  iNext : Byte;
begin
  if FNextHeaderUsed then
    begin
    result := FNextHeader;
    FNextHeaderUsed := False;
    end
  else
    begin
    FillChar(result, sizeof(TIdASN1Identifier), #0);
    result.Position := FPosition;
    iNext := ReadByte;
    result.Constructed := iNext and $20 > 0;
    result.IdClass := TIdASN1IdentifierClass(iNext shr 6);
    if iNext and $1F = $1F then
      begin
      raise EIdException.create('Todo'); {do not localize} // TODO: add a resource string, and create a new Exception class for this
      end
    else
      result.TagValue := iNext and $1F;
    result.TagType := ToIdentifierType(result.TagValue);
    result.ContentLength := ReadContentLength;
    end;
end;

function TIdASN1Decoder.NextTag: integer;
begin
  if not FNextHeaderUsed then
    begin
    FNextHeader := ReadHeader;
    FNextHeaderUsed := true;
    end;
  result := FNextHeader.TagValue;
end;

function TIdASN1Decoder.NextTagType: TIdASN1IdentifierType;
begin
  if not FNextHeaderUsed then
    begin
    FNextHeader := ReadHeader;
    FNextHeaderUsed := true;
    end;
  result := FNextHeader.TagType;
end;

function TIdASN1Decoder.ReadBoolean : Boolean;
var
  aId : TIdASN1Identifier;
begin
  aId := ReadHeader;
  Check((aId.IdClass = aicApplication) or (aId.TagType = aitBoolean), 'ReadBoolean', 'Found '+DescribeIdentifier(aId)+' expecting a Boolean');
  Check(aId.ContentLength = 1, 'ReadBoolean', 'Boolean Length should be 1');
  result := ReadByte <> 0;
end;

Function TIdASN1Decoder.ReadInteger : Integer;
var
  aId : TIdASN1Identifier;
  iVal : Integer;
  iNext : Byte;
  bNeg : Boolean;
  iLoop : integer;
begin
  aId := ReadHeader;
  Check((aId.IdClass = aicApplication) or (aId.TagType = aitInteger), 'ReadInteger', 'Found '+DescribeIdentifier(aId)+' expecting an Integer');
  Check(aId.ContentLength >= 1, 'ReadInteger', 'Boolean Length should not be 0');

  iVal := 0;
  bNeg := False;
  for iLoop := 1 to aId.ContentLength do
  begin
    iNext := ReadByte;
    if (iLoop = 1) and (iNext > $7F) then
      bNeg := True;
    if bNeg then
      iNext := not iNext;
    iVal := iVal * 256 + iNext;
  end;
  if bNeg then
    iVal := -(iVal + 1);

  Result := iVal;
end;

function TIdASN1Decoder.ReadEnum : Integer;
var
  aId : TIdASN1Identifier;
  iVal : Integer;
  iNext : Byte;
  bNeg : Boolean;
  iLoop : integer;
begin
  aId := ReadHeader;
  Check((aId.IdClass = aicApplication) or (aId.TagType = aitEnum), 'ReadEnum', 'Found '+DescribeIdentifier(aId)+' expecting an Enum');
  Check(aId.ContentLength >= 1, 'ReadEnum', 'Boolean Length should not be 0');

  iVal := 0;
  bNeg := False;
  for iLoop := 1 to aId.ContentLength do
  begin
    iNext := ReadByte;
    if (iLoop = 1) and (iNext > $7F) then
      bNeg := True;
    if bNeg then
      iNext := not iNext;
    iVal := iVal * 256 + iNext;
  end;
  if bNeg then
    iVal := -(iVal + 1);

  Result := iVal;
end;

Function TIdASN1Decoder.ReadString : String;
var
  aId : TIdASN1Identifier;
  iLoop : integer;
begin
  aId := ReadHeader;
  Check((aId.IdClass = aicApplication) or (aId.TagType in [aitUnknown, aitString]), 'ReadString', 'Found '+DescribeIdentifier(aId)+' expecting a String');
  SetLength(result, aId.ContentLength);
  for iLoop := 1 to aId.ContentLength do
    result[iLoop] := ReadChar;
end;


procedure TIdASN1Decoder.ReadSequenceBegin;
var
  aId : TIdASN1Identifier;
begin
  aId := ReadHeader;
  Check((aId.IdClass = aicApplication) or (aId.TagType in [aitUnknown, aitSequence]), 'ReadSequenceBegin', 'Found '+DescribeIdentifier(aId)+' expecting a Sequence');
  FLengths[0] := FLengths[0] - aId.ContentLength;
  FLengths.InsertInt(0, aId.ContentLength);
end;

function TIdASN1Decoder.SequenceEnded: Boolean;
begin
  Check(FLengths.Count > 1, 'SequenceEnded', 'Not in a Sequence');
  result := FLengths[0] <= 0;
end;

procedure TIdASN1Decoder.ReadSequenceEnd;
begin
  Check(SequenceEnded, 'ReadSequenceEnd', 'Sequence has not ended');
  FLengths.Delete(0);
end;

{ TIntegerList }

procedure TIntegerList.AddInt(value: integer);
begin
  Add(pointer(value));
end;

function TIntegerList.GetValue(iIndex: integer): Integer;
begin
  result := integer(items[iIndex]);
end;

procedure TIntegerList.InsertInt(Index, Value: integer);
begin
  insert(Index, pointer(value));
end;

procedure TIntegerList.SetValue(Index: integer; const Value: Integer);
begin
  items[Index] := pointer(value);
end;

end.



