unit IdTestHMACSHA1;

interface

uses
  IdHMACSHA1, IdSys, IdObjs, IdGlobal;

type
  TIdTestHMACSHA1 = class(TIdPersistent)
  private
    FHash: TIdHMACSHA1;
    function GenerateByteArray(AValue: Byte; ACount: Integer) : TIdBytes;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  published
    procedure TestIETF1;
    procedure TestIETF2;
    procedure TestIETF3;
    procedure TestIETF4;
    procedure TestIETF5;
    procedure TestIETF6;
    procedure TestIETF7;
  end;

implementation

{ TIdTestHMACSHA1 }

constructor TIdTestHMACSHA1.Create;
begin
  inherited;
  FHash := TIdHMACSHA1.Create;
end;

destructor TIdTestHMACSHA1.Destroy;
begin
  Sys.FreeAndNil(FHash);
  inherited;
end;

function TIdTestHMACSHA1.GenerateByteArray(AValue: Byte;
  ACount: Integer): TIdBytes;
var
  I: Integer;
  TempBuffer: TIdBytes;
begin
  SetLength(TempBuffer, ACount);
  for I := 0 to ACount - 1 do
  begin
    TempBuffer[I] := AValue;
  end;
  Result := TempBuffer;
  SetLength(TempBuffer, 0);
end;

procedure TIdTestHMACSHA1.TestIETF2;
begin
  FHash.Key := ToBytes('Jefe');
  Assert(Sys.LowerCase(ToHex(FHash.HashValue(ToBytes('what do ya want for nothing?')))) = 'effcdf6ae5eb2fa2d27416d5f184df9c259a7c79');
end;

procedure TIdTestHMACSHA1.TestIETF3;
var
  TempBuf: TIdBytes;
begin
  FHash.Key := GenerateByteArray($AA, 20);
  TempBuf := GenerateByteArray($DD, 50);
  Assert(Sys.LowerCase(ToHex(FHash.HashValue(TempBuf))) = '125d7342b9ac11cd91a39af48aa17b4f63f175d3');
end;

procedure TIdTestHMACSHA1.TestIETF1;
begin
  FHash.Key := GenerateByteArray($0B, 20);
  Assert(Sys.LowerCase(ToHex(FHash.HashValue(ToBytes('Hi There')))) = 'b617318655057264e28bc0b6fb378c8ef146be00');
end;

procedure TIdTestHMACSHA1.TestIETF6;
begin
  FHash.Key := GenerateByteArray($AA, 80);
  Assert(Sys.LowerCase(ToHex(FHash.HashValue(ToBytes('Test Using Larger Than Block-Size Key - Hash Key First')))) = 'aa4ae5e15272d00e95705637ce8a3b55ed402112');
end;

procedure TIdTestHMACSHA1.TestIETF7;
var
  FData: TIdBytes;
begin
  FHash.Key := GenerateByteArray($AA, 80);
  FData := ToBytes('Test Using Larger Than Block-Size Key and Larger Than One Block-Size Data');
  Assert(Sys.LowerCase(ToHex(FHash.HashValue(FData))) = 'e8e99d0f45237d786d6bbaa7965c7808bbff1a91');

end;

procedure TIdTestHMACSHA1.TestIETF4;
var
  LByteArray: TIdBytes;
begin
  SetLength(LByteArray, 25);
  LByteArray[0] := $01;
  LByteArray[1] := $02;
  LByteArray[2] := $03;
  LByteArray[3] := $04;
  LByteArray[4] := $05;
  LByteArray[5] := $06;
  LByteArray[6] := $07;
  LByteArray[7] := $08;
  LByteArray[8] := $09;
  LByteArray[9] := $0A;
  LByteArray[10] := $0B;
  LByteArray[11] := $0C;
  LByteArray[12] := $0D;
  LByteArray[13] := $0E;
  LByteArray[14] := $0F;
  LByteArray[15] := $10;
  LByteArray[16] := $11;
  LByteArray[17] := $12;
  LByteArray[18] := $13;
  LByteArray[19] := $14;
  LByteArray[20] := $15;
  LByteArray[21] := $16;
  LByteArray[22] := $17;
  LByteArray[23] := $18;
  LByteArray[24] := $19;
  FHash.Key := LByteArray;
  Assert(Sys.LowerCase(ToHex(FHash.HashValue(GenerateByteArray($CD, 50)))) = '4c9007f4026250c6bc8414f9bf50c86c2d7235da');
end;

procedure TIdTestHMACSHA1.TestIETF5;
var
  LByteArray: TIdBytes;
begin
  FHash.Key := GenerateByteArray($0C, 20);
  LByteArray := ToBytes('Test With Truncation');
  LByteArray := FHash.HashValue(LByteArray);
  Assert(Sys.LowerCase(ToHex(LByteArray)) = '4c1a03424b55e07fe7f27be1d58bb9324a9a5a04');
  LByteArray := ToBytes('Test With Truncation');
  LByteArray := FHash.HashValue(LByteArray, 12);
  Assert(Sys.LowerCase(ToHex(LByteArray)) = '4c1a03424b55e07fe7f27be1');
end;

end.
