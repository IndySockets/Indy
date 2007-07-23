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
  public
    constructor Create; override;
  end;

implementation

{ TIdHMACSHA1 }

constructor TIdHMACSHA1.Create;
begin
  inherited Create;
  FHash := TIdHashSHA1.Create;
  FHashName := 'SHA1';
  FHashSize := 20;
  FBlockSize := 64;
end;


initialization
  TIdHMACSHA1.Create.Destroy;
end.
