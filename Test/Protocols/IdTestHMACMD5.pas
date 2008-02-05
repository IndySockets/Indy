unit IdTestHMACMD5;

//examples are from http://www.ietf.org/rfc/rfc2202.txt

interface

uses
  IdHMACMD5, IdObjs, IdTest, IdSys, IdGlobal;

type
  TIdTestHMACMD5 = class(TIdTest)
  private
    FHash: TIdHMACMD5;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  public
    function GenerateByteArray(AValue: Byte; ACount: Integer) : TIdBytes;
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

procedure TIdTestHMACMD5.SetUp;
begin
  inherited;
  FHash:=TIdHMACMD5.Create;
end;

procedure TIdTestHMACMD5.TearDown;
begin
  Sys.FreeAndNil(fhash);
  inherited;
end;

function TIdTestHMACMD5.GenerateByteArray(AValue: Byte;
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

// actual tests

procedure TIdTestHMACMD5.TestIETF1;
var
  LByteArray: TIdBytes;
begin
  FHash.Key := GenerateByteArray($0B, 16);
  LByteArray := ToBytes('Hi There');
  LByteArray := FHash.HashValue(LByteArray);
  Assert(Sys.LowerCase(ToHex(LByteArray)) = '9294727a3638bb1c13f48ef8158bfc9d');
end;

procedure TIdTestHMACMD5.TestIETF2;
var
  LByteArray: TIdBytes;
begin
  //FHash:=TIdHMACMD5.Create;
  FHash.Key := ToBytes('Jefe');
  LByteArray := ToBytes('what do ya want for nothing?');
  LByteArray := FHash.HashValue(LByteArray);
  Assert(Sys.LowerCase(ToHex(LByteArray)) = '750c783e6ab0b503eaa86e310a5db738');
  SetLength(LByteArray, 0);
  //Sys.FreeAndNil(FHash);
end;

procedure TIdTestHMACMD5.TestIETF3;
var
  LByteArray: TIdBytes;
begin
  FHash.Key := GenerateByteArray($aa, 16);
  LByteArray := GenerateByteArray($DD, 50);
  LByteArray := FHash.HashValue(LByteArray);
  Assert(Sys.LowerCase(ToHex(LByteArray)) = '56be34521d144c88dbb8c733f0e8b3f6');
end;

procedure TIdTestHMACMD5.TestIETF4;
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
  LByteArray := GenerateByteArray($CD, 50);
  LByteArray := FHash.HashValue(LByteArray);
  Assert(Sys.LowerCase(ToHex(LByteArray)) = '697eaf0aca3a3aea3a75164746ffaa79');
end;

procedure TIdTestHMACMD5.TestIETF5;
var
  LByteArray: TIdBytes;
begin
  FHash.Key := GenerateByteArray($0C, 16);

  LByteArray := ToBytes('Test With Truncation');
  LByteArray := FHash.HashValue(LByteArray);
  Assert(Sys.LowerCase(ToHex(LByteArray)) = '56461ef2342edc00f9bab995690efd4c');

  LByteArray := ToBytes('Test With Truncation');
  LByteArray := FHash.HashValue(LByteArray, 12);
  Assert(Sys.LowerCase(ToHex(LByteArray)) = '56461ef2342edc00f9bab995');
end;

procedure TIdTestHMACMD5.TestIETF6;
var
  LByteArray: TIdBytes;
begin
  FHash.Key := GenerateByteArray($AA, 80);
  LByteArray := ToBytes('Test Using Larger Than Block-Size Key - Hash Key First');
  LByteArray := FHash.HashValue(LByteArray);
  Assert(Sys.LowerCase(ToHex(LByteArray)) = '6b1ab7fe4bd7bf8f0b62e6ce61b9d0cd');
end;

procedure TIdTestHMACMD5.TestIETF7;
var
  LByteArray: TIdBytes;
begin
  FHash.Key := GenerateByteArray($AA, 80);
  LByteArray := ToBytes('Test Using Larger Than Block-Size Key and Larger Than One Block-Size Data');
  LByteArray := FHash.HashValue(LByteArray);
  Assert(Sys.LowerCase(ToHex(LByteArray)) = '6f630fad67cda0ee1fb1f562db3aa53e');
end;

initialization
  TIdTest.RegisterTest(TIdTestHMACMD5);
end.
