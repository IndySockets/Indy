{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log: }

unit IdStruct;

interface

uses IdGlobal;

type

  TIdStruct = class(TObject)
  public
    constructor create; virtual;
    //done this way in case we also need to advance an index pointer
    //after a read or write
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); virtual;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer);  virtual;
  end;

  TIdUnion = class(TIdStruct)
  protected
    FBuffer : TIdBytes;
    FBytesLen : Integer;//set this in a descendant's create
  public
    constructor create; override;
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer);  override;
    property BytesLen : Integer read FBytesLen;
  end;

  TIdLongWord =class(TIdUnion)
  protected
    function Get_l: Cardinal;
    function Gets_b1: Byte;
    function Gets_b2: Byte;
    function Gets_b3: Byte;
    function Gets_b4: Byte;
    function Gets_w1: word;
    function Gets_w2: word;
    procedure Set_l(const Value: Cardinal);
    procedure Sets_b1(const Value: Byte);
    procedure Sets_b2(const Value: Byte);
    procedure Sets_b3(const Value: Byte);
    procedure Sets_b4(const Value: Byte);
    procedure SetS_w1(const Value: word);
    procedure SetS_w2(const Value: word);
  public
    constructor create; override;
    property s_b1 : Byte read Gets_b1 write Sets_b1;
    property s_b2 : Byte read Gets_b2 write Sets_b2;
    property s_b3 : Byte read Gets_b3 write Sets_b3;
    property s_b4 : Byte read Gets_b4 write Sets_b4;
    property s_w1 : word read Gets_w1 write SetS_w1;
    property s_w2 : word read Gets_w2 write SetS_w2;
    property s_l  : Cardinal read Get_l write Set_l;
  end;

implementation

{ TIdStruct }

constructor TIdStruct.create;
begin
  inherited Create;
end;

procedure TIdStruct.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin

end;

procedure TIdStruct.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin

end;

{ TIdUnion }

constructor TIdUnion.create;
begin
  inherited Create;
end;

procedure TIdUnion.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited;
  Assert(Length(ABytes)>VIndex+FBytesLen-1,'not enough bytes');
  CopyTIdBytes(ABytes,VIndex,FBuffer,0,FBytesLen);
  Inc(VIndex,FBytesLen);
end;

procedure TIdUnion.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited;
  if Length(FBuffer)<VIndex+FBytesLen then
  begin
    SetLength(FBuffer,Length(VBytes)+FBytesLen);
  end;
  CopyTIdBytes(FBuffer,0,VBytes,VIndex,FBytesLen);
  Inc(VIndex,FBytesLen);
end;

{ TIdLongWord }

function TIdLongWord.Gets_w1: word;
begin
  Result := BytesToWord(FBuffer,0);
end;

procedure TIdLongWord.SetS_w1(const Value: word);
begin
  CopyTIdWord(Value,FBuffer,0);
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
 FBuffer[3] :=  Value;
end;

function TIdLongWord.Get_l: Cardinal;
begin
  result := BytesToCardinal(FBuffer,0);
end;

procedure TIdLongWord.Set_l(const Value: Cardinal);
begin
  CopyTIdCardinal(Value,FBuffer,0);
end;

function TIdLongWord.Gets_w2: word;
begin
   Result := BytesToWord(FBuffer,2);
end;

procedure TIdLongWord.SetS_w2(const Value: word);
begin
  CopyTIdWord(Value,FBuffer,2);
end;

constructor TIdLongWord.create;
begin
  inherited;
   FBytesLen := 4;
   SetLength(FBuffer,FBytesLen);
end;

end.
