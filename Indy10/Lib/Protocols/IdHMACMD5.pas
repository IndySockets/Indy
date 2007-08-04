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

unit IdHMACMD5;

interface

{$i IdCompilerDefines.inc}

uses
  IdHash, IdHashMessageDigest, IdHMAC;

type
  TIdHMACMD5 = class(TIdHMAC)
  protected
    procedure InitHash; override;
  end;

implementation

{ TIdHMACMD5 }

procedure TIdHMACMD5.InitHash;
begin
  FHashName := 'MD5';
  FHashSize := 16;
  FBlockSize := 64;
  FHash := TIdHashMessageDigest5.Create;
end;

end.
