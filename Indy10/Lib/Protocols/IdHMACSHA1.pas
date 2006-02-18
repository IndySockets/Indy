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

unit IdHMACSHA1;

interface

uses
  IdHash, IdHashSHA1, IdHMAC, IdGlobal, IdObjs, IdSys;

type
  TIdHMACSHA1 = class(TIdHMAC)
  private
    FHashSHA1: TIdHashSHA1;
  protected
    procedure InitHash; override;
    function InternalHashValue(const ABuffer: TIdBytes) : TIdBytes; override;
  end;

implementation

{ TIdHMACSHA1 }

procedure TIdHMACSHA1.InitHash;
begin
  inherited;
  FHashSHA1 := TIdHashSHA1.Create;
  FHash := FHashSHA1;
  FHashSize := 20;
  FBlockSize := 64;
  FHashName := 'SHA1';
end;


function TIdHMACSHA1.InternalHashValue(const ABuffer: TIdBytes): TIdBytes;
var
  TempStream: TIdMemoryStream;
  TempResult: T5x4LongWordRecord;
  TempBuff: TIdBytes;
begin
  TempStream := TIdMemoryStream.Create;
  try
    WriteTIdBytesToStream(TempStream, ABuffer);
    TempStream.Position := 0;
    TempResult := FHashSHA1.HashValue(TempStream);
    SetLength(TempBuff, 4);
    SetLength(Result, FHashSize);
    TempBuff := ToBytes(TempResult[0]);
    CopyTIdBytes(TempBuff, 0, Result, 0, 4);
    TempBuff := ToBytes(TempResult[1]);
    CopyTIdBytes(TempBuff, 0, Result, 4, 4);
    TempBuff := ToBytes(TempResult[2]);
    CopyTIdBytes(TempBuff, 0, Result, 8, 4);
    TempBuff := ToBytes(TempResult[3]);
    CopyTIdBytes(TempBuff, 0, Result, 12, 4);
    TempBuff := ToBytes(TempResult[4]);
    CopyTIdBytes(TempBuff, 0, Result, 16, 4);
  finally
    Sys.FreeAndNil(TempStream);
  end;
end;

initialization
  TIdHMACSHA1.Create.Destroy;
end.
