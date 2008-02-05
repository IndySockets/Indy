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

{$i IdCompilerDefines.inc}

uses
  IdHash, IdHashSHA1, IdHMAC;

type
  TIdHMACSHA1 = class(TIdHMAC)
  protected
    procedure InitHash; override;
  end;

implementation

{ TIdHMACSHA1 }

procedure TIdHMACSHA1.InitHash;
begin
  inherited;
  FHash := TIdHashSHA1.Create;
  FHashSize := 20;
  FBlockSize := 64;
  FHashName := 'SHA1';
end;

initialization
  // RLebeau: why do this?
  TIdHMACSHA1.Create.Destroy;
end.
