unit IdHMAC;

interface

uses
  IdGlobal, IdObjs, IdSys, IdHash;

type
  TIdHMACKeyBuilder = class(TIdBaseObject)
  public
    class function Key(const ASize: Integer) : TIdBytes;
    class function IV(const ASize: Integer) : TIdBytes;
  end;

  TIdHMAC = class
  private
  protected
    FHashSize: Integer; // n bytes
    FBlockSize: Integer; // n bytes
    FKey: TIdBytes;
    FHash: TIdHash;
    FHashName: string;
    procedure InitHash; virtual; abstract;
    procedure InitKey;
    function InternalHashValue(const ABuffer: TIdBytes) : TIdBytes; virtual; abstract;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function HashValue(const ABuffer: TIdBytes) : TIdBytes;
    property HashSize: Integer read FHashSize;
    property BlockSize: Integer read FBlockSize;
    property HashName: string read FHashName;
    property Key: TIdBytes read FKey write FKey;
  end;

implementation

{ TIdHMACKeyBuilder }

class function TIdHMACKeyBuilder.Key(const ASize: Integer): TIdBytes;
var
  I: Integer;
begin
  SetLength(Result, ASize);
  for I := Low(Result) to High(Result) do
  begin
    Result[I] := Byte(Random(255));
  end;
end;

class function TIdHMACKeyBuilder.IV(const ASize: Integer): TIdBytes;
var
  I: Integer;
begin
  SetLength(Result, ASize);
  for I := Low(Result) to High(Result) do
  begin
    Result[I] := Byte(Random(255));
  end;
end;                     

{ TIdHMAC }

constructor TIdHMAC.Create;
begin
  inherited;
  SetLength(FKey, 0);
  InitHash;
end;

destructor TIdHMAC.Destroy;
begin
  Sys.FreeAndNil(FHash);
  inherited;
end;

function TIdHMAC.HashValue(const ABuffer: TIdBytes): TIdBytes;
const
  CInnerPad : Byte = $36;
  COuterPad : Byte = $5C;
var
  TempBuffer1: TIdBytes;
  TempBuffer2: TIdBytes;
  LKey: TIdBytes;
  I: Integer;
begin
  InitKey;
  LKey := Copy(FKey, 0, MaxInt);
  SetLength(LKey, FBlockSize);
  SetLength(TempBuffer1, FBlockSize + Length(ABuffer));
  for I := Low(LKey) to High(LKey) do
  begin
    TempBuffer1[I] := LKey[I] xor CInnerPad;
  end;
  CopyTIdBytes(ABuffer, 0, TempBuffer1, Length(LKey), Length(ABuffer));
  TempBuffer2 := InternalHashValue(TempBuffer1);
  SetLength(TempBuffer1, 0);
  SetLength(TempBuffer1, FBlockSize + FHashSize);
  for I := Low(LKey) to High(LKey) do
  begin
    TempBuffer1[I] := LKey[I] xor COuterPad;
  end;
  CopyTIdBytes(TempBuffer2, 0, TempBuffer1, Length(LKey), Length(TempBuffer2));
  Result := InternalHashValue(TempBuffer1);
  SetLength(TempBuffer1, 0);
  SetLength(TempBuffer2, 0);
  SetLength(LKey, 0);
end;

procedure TIdHMAC.InitKey;
begin
  if FKey = nil then
  begin
    TIdHMACKeyBuilder.Key(FHashSize);
  end
  else
  begin
    if Length(FKey) > FBlockSize then
    begin
      FKey := InternalHashValue(FKey);
    end;
  end;
end;

initialization
  Randomize;
end.
