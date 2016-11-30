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
  IdFIPS,
  IdGlobal,
  IdHash, IdHashSHA, IdHMAC,
  IdException;

type
  TIdHMACSHA1 = class(TIdHMAC)
  protected
    procedure SetHashVars; override;
    function IsIntFAvail : Boolean; override;
    function InitIntFInst(const AKey : TIdBytes) : TIdHMACIntCtx; override;
    procedure InitHash; override;
  end;

  {$IFNDEF DOTNET}
  TIdHMACSHA224 = class(TIdHMAC)
  protected
    procedure SetHashVars; override;
    function IsIntFAvail : Boolean; override;
    function InitIntFInst(const AKey : TIdBytes) : TIdHMACIntCtx; override;
    procedure InitHash; override;
  end;
  {$ENDIF}

  TIdHMACSHA256 = class(TIdHMAC)
  protected
    procedure SetHashVars; override;
    function IsIntFAvail : Boolean; override;
    function InitIntFInst(const AKey : TIdBytes) : TIdHMACIntCtx; override;
    procedure InitHash; override;
  end;

  TIdHMACSHA384 = class(TIdHMAC)
  protected
    procedure SetHashVars; override;
    function IsIntFAvail : Boolean; override;
    function InitIntFInst(const AKey : TIdBytes) : TIdHMACIntCtx; override;
    procedure InitHash; override;
  end;

  TIdHMACSHA512 = class(TIdHMAC)
  protected
    procedure SetHashVars; override;
    function IsIntFAvail : Boolean; override;
    function InitIntFInst(const AKey : TIdBytes) : TIdHMACIntCtx; override;
    procedure InitHash; override;
  end;

  EIdHMACHashNotAvailable = class(EIdException)
  end;

implementation

uses
  SysUtils, IdResourceStringsProtocols;

{ TIdHMACSHA1 }

procedure TIdHMACSHA1.InitHash;
begin
  if not TIdHashSHA1.IsAvailable then
    raise EIdHMACHashNotAvailable.CreateFmt(RSHMACHashNotAvailable, ['SHA-1']);
  FHash := TIdHashSHA1.Create;
end;

function TIdHMACSHA1.InitIntFInst(const AKey: TIdBytes): TIdHMACIntCtx;
begin
  Result := GetHMACSHA1HashInst(AKey);
end;

function TIdHMACSHA1.IsIntFAvail: Boolean;
begin
   Result := inherited IsIntFAvail and IsHMACSHA1Avail;
end;

procedure TIdHMACSHA1.SetHashVars;
begin
  FHashSize := 20;
  FBlockSize := 64;
  FHashName := 'SHA1';
end;

{ TIdHMACSHA224 }

{$IFNDEF DOTNET}

procedure TIdHMACSHA224.InitHash;
begin
  if not TIdHashSHA224.IsAvailable then
    raise EIdHMACHashNotAvailable.CreateFmt(RSHMACHashNotAvailable, ['SHA-224']);
  FHash := TIdHashSHA224.Create;
end;

function TIdHMACSHA224.InitIntFInst(const AKey: TIdBytes): TIdHMACIntCtx;
begin
  Result := GetHMACSHA224HashInst(AKey);
end;

function TIdHMACSHA224.IsIntFAvail: Boolean;
begin
   Result := inherited IsIntFAvail and IsHMACSHA224Avail;
end;

procedure TIdHMACSHA224.SetHashVars;
begin
  FHashSize := 28;
  FBlockSize := 64;
  FHashName := 'SHA224';
end;

{$ENDIF}

{ TIdHMACSHA256 }

procedure TIdHMACSHA256.InitHash;
begin
  if not TIdHashSHA256.IsAvailable then
    raise EIdHMACHashNotAvailable.CreateFmt(RSHMACHashNotAvailable, ['SHA-256']);
  FHash := TIdHashSHA256.Create;
end;

function TIdHMACSHA256.InitIntFInst(const AKey: TIdBytes): TIdHMACIntCtx;
begin
  Result := GetHMACSHA256HashInst(AKey);
end;

function TIdHMACSHA256.IsIntFAvail: Boolean;
begin
   Result := inherited IsIntFAvail and IsHMACSHA256Avail;
end;

procedure TIdHMACSHA256.SetHashVars;
begin
  FHashSize := 32;
  FBlockSize := 64;
  FHashName := 'SHA256';
end;

{ TIdHMACSHA384 }

procedure TIdHMACSHA384.InitHash;
begin
  if not TIdHashSHA384.IsAvailable then
    raise EIdHMACHashNotAvailable.CreateFmt(RSHMACHashNotAvailable, ['SHA-384']);
  FHash := TIdHashSHA384.Create;
end;

function TIdHMACSHA384.InitIntFInst(const AKey: TIdBytes): TIdHMACIntCtx;
begin
  Result := GetHMACSHA384HashInst(AKey);
end;

function TIdHMACSHA384.IsIntFAvail: Boolean;
begin
   Result := inherited IsIntFAvail and IsHMACSHA384Avail;
end;

procedure TIdHMACSHA384.SetHashVars;
begin
  FHashSize := 48;
  FBlockSize := 128;
  FHashName := 'SHA384';
end;

{ TIdHMACSHA512 }

procedure TIdHMACSHA512.InitHash;
begin
  if not TIdHashSHA512.IsAvailable then
    raise EIdHMACHashNotAvailable.CreateFmt(RSHMACHashNotAvailable, ['SHA-512']);
  FHash := TIdHashSHA512.Create;
end;

function TIdHMACSHA512.InitIntFInst(const AKey: TIdBytes): TIdHMACIntCtx;
begin
  Result := GetHMACSHA512HashInst(AKey);
end;

function TIdHMACSHA512.IsIntFAvail: Boolean;
begin
   Result := inherited IsIntFAvail and IsHMACSHA512Avail;
end;

procedure TIdHMACSHA512.SetHashVars;
begin
  FHashSize := 64;
  FBlockSize := 128;
  FHashName := 'SHA512';
end;

end.
