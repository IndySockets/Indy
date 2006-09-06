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
begin
  TempStream := TIdMemoryStream.Create;
  try
    WriteTIdBytesToStream(TempStream, ABuffer);
    TempStream.Position := 0;
    Result := FHashSHA1.HashValue(TempStream);
  finally
    Sys.FreeAndNil(TempStream);
  end;
end;

initialization
  TIdHMACSHA1.Create.Destroy;
end.
