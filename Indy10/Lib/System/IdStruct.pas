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

unit IdStruct;

interface

{$i IdCompilerDefines.inc}

uses
  IdGlobal;

type
  TIdStruct = class(TObject)
  protected
    function GetBytesLen: LongWord; virtual;
  public
    constructor Create; virtual;
    //done this way in case we also need to advance an index pointer
    //after a read or write
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : LongWord); virtual;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : LongWord);  virtual;
    property BytesLen: LongWord read GetBytesLen;
  end;

  TIdUnion = class(TIdStruct)
  protected
    FBuffer: TIdBytes;
    function GetBytesLen: LongWord; override;
    procedure SetBytesLen(const ABytesLen: Integer);
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : LongWord); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : LongWord);  override;
  end;

  TIdLongWord = class(TIdUnion)
  protected
    function Get_l: LongWord;
    function Gets_b1: Byte;
    function Gets_b2: Byte;
    function Gets_b3: Byte;
    function Gets_b4: Byte;
    function Gets_w1: Word;
    function Gets_w2: Word;
    procedure Set_l(const Value: LongWord);
    procedure Sets_b1(const Value: Byte);
    procedure Sets_b2(const Value: Byte);
    procedure Sets_b3(const Value: Byte);
    procedure Sets_b4(const Value: Byte);
    procedure SetS_w1(const Value: Word);
    procedure SetS_w2(const Value: Word);
  public
    constructor Create; override;
    property s_b1 : Byte read Gets_b1 write Sets_b1;
    property s_b2 : Byte read Gets_b2 write Sets_b2;
    property s_b3 : Byte read Gets_b3 write Sets_b3;
    property s_b4 : Byte read Gets_b4 write Sets_b4;
    property s_w1 : Word read Gets_w1 write SetS_w1;
    property s_w2 : Word read Gets_w2 write SetS_w2;
    property s_l  : LongWord read Get_l write Set_l;
  end;

implementation

{ TIdStruct }

constructor TIdStruct.Create;
begin
  inherited Create;
end;

function TIdStruct.GetBytesLen: LongWord;
begin
  Result := 0;
end;

procedure TIdStruct.ReadStruct(const ABytes: TIdBytes; var VIndex: LongWord);
begin
  Assert(LongWord(Length(ABytes)) >= VIndex + BytesLen, 'not enough bytes'); {do not localize}
end;

procedure TIdStruct.WriteStruct(var VBytes: TIdBytes; var VIndex: LongWord);
var
  Len: Integer;
begin
  Len := VIndex + BytesLen;
  if Length(VBytes) < Len then begin
    SetLength(VBytes, Len);
  end;
end;

{ TIdUnion }

function TIdUnion.GetBytesLen;
begin
  Result := Length(FBuffer);
end;

procedure TIdUnion.SetBytesLen(const ABytesLen: Integer);
begin
  SetLength(FBuffer, ABytesLen);
end;

procedure TIdUnion.ReadStruct(const ABytes: TIdBytes; var VIndex: LongWord);
begin
  inherited ReadStruct(ABytes, VIndex);
  CopyTIdBytes(ABytes, VIndex, FBuffer, 0, Length(FBuffer));
  Inc(VIndex, Length(FBuffer));
end;

procedure TIdUnion.WriteStruct(var VBytes: TIdBytes; var VIndex: LongWord);
begin
  inherited WriteStruct(VBytes, VIndex);
  CopyTIdBytes(FBuffer, 0, VBytes, VIndex, Length(FBuffer));
  Inc(VIndex, Length(FBuffer));
end;

{ TIdLongWord }

constructor TIdLongWord.Create;
begin
  inherited Create;
  SetBytesLen(4);
end;

function TIdLongWord.Gets_w1: Word;
begin
  Result := BytesToWord(FBuffer, 0);
end;

procedure TIdLongWord.SetS_w1(const Value: Word);
begin
  CopyTIdWord(Value, FBuffer, 0);
end;

function TIdLongWord.Gets_b1: Byte;
begin
  Result := FBuffer[0];
end;

procedure TIdLongWord.Sets_b1(const Value: Byte);
begin
  FBuffer[0] := Value;
end;

function TIdLongWord.Gets_b2: Byte;
begin
  Result := FBuffer[1];
end;

procedure TIdLongWord.Sets_b2(const Value: Byte);
begin
  FBuffer[1] := Value;
end;

function TIdLongWord.Gets_b3: Byte;
begin
  Result := FBuffer[2];
end;

procedure TIdLongWord.Sets_b3(const Value: Byte);
begin
   FBuffer[2] := Value;
end;

function TIdLongWord.Gets_b4: Byte;
begin
  Result := FBuffer[3];
end;

procedure TIdLongWord.Sets_b4(const Value: Byte);
begin
  FBuffer[3] := Value;
end;

function TIdLongWord.Get_l: LongWord;
begin
  Result := BytesToLongWord(FBuffer, 0);
end;

procedure TIdLongWord.Set_l(const Value: LongWord);
begin
  CopyTIdLongWord(Value, FBuffer, 0);
end;

function TIdLongWord.Gets_w2: Word;
begin
  Result := BytesToWord(FBuffer, 2);
end;

procedure TIdLongWord.SetS_w2(const Value: Word);
begin
  CopyTIdWord(Value, FBuffer, 2);
end;

end.
