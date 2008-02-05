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
  HMAC specification on the NIST website
  http://csrc.nist.gov/publications/fips/fips198/fips-198a.pdf
}

unit IdHMAC;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal, IdHash;

type
  TIdHMACKeyBuilder = class(TObject)
  public
    class function Key(const ASize: Integer) : TIdBytes;
    class function IV(const ASize: Integer) : TIdBytes;
  end;

  TIdHMAC = class
  protected
    FHashSize: Integer; // n bytes
    FBlockSize: Integer; // n bytes
    FKey: TIdBytes;
    FHash: TIdHash;
    FHashName: string;
    procedure InitHash; virtual; abstract;
    procedure InitKey;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    function HashValue(const ABuffer: TIdBytes; const ATruncateTo: Integer = -1) : TIdBytes; // for now, supply in bytes
    property HashSize: Integer read FHashSize;
    property BlockSize: Integer read FBlockSize;
    property HashName: string read FHashName;
    property Key: TIdBytes read FKey write FKey;
  end;

implementation

uses
  SysUtils;

{ TIdHMACKeyBuilder }

class function TIdHMACKeyBuilder.Key(const ASize: Integer): TIdBytes;
var
  I: Integer;
begin
  SetLength(Result, ASize);
  for I := Low(Result) to High(Result) do begin
    Result[I] := Byte(Random(255));
  end;
end;

class function TIdHMACKeyBuilder.IV(const ASize: Integer): TIdBytes;
var
  I: Integer;
begin
  SetLength(Result, ASize);
  for I := Low(Result) to High(Result) do begin
    Result[I] := Byte(Random(255));
  end;
end;

{ TIdHMAC }

constructor TIdHMAC.Create;
begin
  inherited Create;
  SetLength(FKey, 0);
  InitHash;
end;

destructor TIdHMAC.Destroy;
begin
  FreeAndNil(FHash);
  inherited Destroy;
end;

function TIdHMAC.HashValue(const ABuffer: TIdBytes; const ATruncateTo: Integer = -1): TIdBytes;
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
  TempBuffer2 := FHash.HashBytes(TempBuffer1);
  SetLength(TempBuffer1, 0);
  SetLength(TempBuffer1, FBlockSize + FHashSize);
  for I := Low(LKey) to High(LKey) do
  begin
    TempBuffer1[I] := LKey[I] xor COuterPad;
  end;
  CopyTIdBytes(TempBuffer2, 0, TempBuffer1, Length(LKey), Length(TempBuffer2));
  Result := FHash.HashBytes(TempBuffer1);
  SetLength(TempBuffer1, 0);
  SetLength(TempBuffer2, 0);
  SetLength(LKey, 0);
  if ATruncateTo > -1 then
  begin
    SetLength(Result, ATruncateTo);
  end;
end;

procedure TIdHMAC.InitKey;
begin
  if FKey = nil then begin
    TIdHMACKeyBuilder.Key(FHashSize);
  end
  else if Length(FKey) > FBlockSize then
  begin
    FKey := FHash.HashBytes(FKey);
  end;
end;

initialization
  Randomize;

end.
