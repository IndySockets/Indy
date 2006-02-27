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
  Rev 1.10    2/8/05 5:29:16 PM  RLebeau
  Updated GetHToNBytes() to use CopyTIdWord() instead of AppendBytes() for IPv6
  addresses.

  Rev 1.9    28.09.2004 20:54:32  Andreas Hausladen
  Removed unused functions that were moved to IdGlobal

    Rev 1.8    6/11/2004 8:48:20 AM  DSiders
  Added "Do not Localize" comments.

    Rev 1.7    5/19/2004 10:44:34 PM  DSiders
  Corrected spelling for TIdIPAddress.MakeAddressObject method.

  Rev 1.6    14/04/2004 17:35:38  HHariri
  Removed IP6 for BCB temporarily

  Rev 1.5    2/11/2004 5:10:40 AM  JPMugaas
  Moved IPv6 address definition to System package.

  Rev 1.4    2004.02.03 4:17:18 PM  czhower
  For unit name changes.

  Rev 1.3    2/2/2004 12:22:24 PM  JPMugaas
  Now uses IdGlobal IPVersion Type.  Added HToNBytes for things that need
  to export into NetworkOrder for structures used in protocols.

  Rev 1.2    1/3/2004 2:13:56 PM  JPMugaas
  Removed some empty function code that wasn't used.
  Added some value comparison functions.
  Added a function in the IPAddress object for comparing the value with another
  IP address.  Note that this comparison is useful as an IP address will take
  several forms (especially common with IPv6).
  Added a property for returning the IP address as a string which works for
  both IPv4 and IPv6 addresses.

  Rev 1.1    1/3/2004 1:03:14 PM  JPMugaas
  Removed Lo as it was not needed and is not safe in NET.

  Rev 1.0    1/1/2004 4:00:18 PM  JPMugaas
  An object for handling both IPv4 and IPv6 addresses.  This is a proposal with
  some old code for conversions.
}

unit IdIPAddress;

interface

uses
  IdGlobal,
  IdObjs,
  IdSys;

type
  TIdIPAddress = class(TIdBaseObject)
  protected
    FIPv4 : Cardinal;
    FIPv6 : TIdIPv6Address;
    FAddrType : TIdIPVersion;
    class function IPv4MakeCardInRange(const AInt : Int64; const A256Power : Integer) : Cardinal;
    //general conversion stuff
    class function IPv6ToIdIPv6Address(const AIPAddress : String; var VErr : Boolean) : TIdIPv6Address;
    class function IPv4ToCardinal(const AIPAddress : String; var VErr : Boolean) : Cardinal;
    class function MakeCanonicalIPv6Address(const AAddr: string): string;
    class function MakeCanonicalIPv4Address(const AAddr: string): string;
    //property as String Get methods
    function GetIPv4AsString : String;
    function GetIPv6AsString : String;
    function GetIPAddress : String;
  public
    constructor Create; virtual;
    class function MakeAddressObject(const AIP : String) : TIdIPAddress; overload;
    class function MakeAddressObject(const AIP : String; const AIPVersion: TIdIPVersion) : TIdIPAddress; overload;
    function CompareAddress(const AIP : String; var VErr : Boolean) : Integer;
    function HToNBytes: TIdBytes;
    property IPv4 : Cardinal read FIPv4 write FIPv4;
    property IPv4AsString : String read GetIPv4AsString;
    {$IFNDEF BCB}
    property IPv6 : TIdIPv6Address read FIPv6 write FIPv6;
    {$ENDIF}
    property IPv6AsString : String read GetIPv6AsString;
    property AddrType : TIdIPVersion read FAddrType write FAddrType;
    property IPAsString : String read GetIPAddress;
  end;

implementation
uses IdStack;

//The power constants are for processing IP addresses
//They are powers of 255.
const POWER_1 = $000000FF;
      POWER_2 = $0000FFFF;
      POWER_3 = $00FFFFFF;
      POWER_4 = $FFFFFFFF;

//IPv4 address conversion
//Much of this is based on http://www.pc-help.org/obscure.htm

function OctalToInt64(const AValue: string): Int64;
//swiped from:
//http://www.swissdelphicenter.ch/torry/showcode.php?id=711
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(AValue) do begin
    Result := Result * 8 + Sys.StrToInt(Copy(AValue, i, 1),0);
  end;
end;

function CompareWord(const AWord1, AWord2 : Word) : Integer;
{
AWord1 > AWord2	> 0
AWord1 < AWord2	< 0
AWord1 = AWord2	= 0
}
begin
  if AWord1 > AWord2 then begin
    Result := 1;
  end else if AWord1 < AWord2 then begin
    Result := -1;
  end else begin
    Result := 0;
  end;
end;

function CompareCardinal(const ACard1, ACard2 : Cardinal) : Integer;
{
ACard1 > ACard2	> 0
ACard1 < ACard2	< 0
ACard1 = ACard2	= 0
}
begin
  if ACard1 > ACard2 then begin
    Result := 1;
  end else if ACard1 < ACard2 then begin
    Result := -1;
  end else begin
    Result := 0;
  end;
end;

{ TIdIPAddress }

function TIdIPAddress.CompareAddress(const AIP: String; var VErr: Boolean): Integer;
var
  LIP2 : TIdIPAddress;
  i : Integer;
{
Note that the IP address in the object is S1.
S1 > S2	> 0
S1 < S2	< 0
S1 = S2	= 0
}
begin
  Result := 0;
  //LIP2 may be nil if the IP address is invalid
  LIP2 := MakeAddressObject(AIP);
  VErr := not Assigned(LIP2);
  if not VErr then begin
    try
      // we can't compare an IPv4 address with an IPv6 address
      VErr := FAddrType <> LIP2.FAddrType;
      if not VErr then begin
        if FAddrType = Id_IPv4 then begin
          Result := CompareCardinal(FIPv4, LIP2.FIPv4);
        end else begin
          for I := 0 to 7 do begin
            Result := CompareWord(FIPv6[i], LIP2.FIPv6[i]);
            if Result <> 0 then begin
              Break;
            end;
          end;
        end;
      end;
    finally
      Sys.FreeAndNil(LIP2);
    end;
  end;
end;

constructor TIdIPAddress.Create;
begin
  inherited Create;
  FAddrType := Id_IPv4;
  FIPv4 := 0; //'0.0.0.0'
end;

function TIdIPAddress.HToNBytes: TIdBytes;
var
  I : Integer;
begin
  if FAddrType = Id_IPv4 then begin
    Result := ToBytes(GStack.HostToNetwork(FIPv4));
  end else begin
    SetLength(Result, 16);
    for I := 0 to 7 do begin
      CopyTIdWord(GStack.HostToNetwork(FIPv6[i]), Result, 2*I);
    end;
  end;
end;

function TIdIPAddress.GetIPAddress: String;
begin
  if FAddrType = Id_IPv4 then begin
    Result := GetIPv4AsString;
  end else begin
    Result := GetIPv6AsString;
  end;
end;

function TIdIPAddress.GetIPv4AsString: String;
begin
  if FAddrType = Id_IPv4 then begin
    Result := Sys.IntToStr((FIPv4 shr 24) and $FF) + '.';
    Result := Result + Sys.IntToStr((FIPv4 shr 16) and $FF) + '.';
    Result := Result + Sys.IntToStr((FIPv4 shr 8) and $FF) + '.';
    Result := Result + Sys.IntToStr(FIPv4 and $FF);
  end else begin
    Result := '';
  end;
end;

function TIdIPAddress.GetIPv6AsString: String;
var
  I: Integer;
begin
  if FAddrType = Id_IPv6 then begin
    Result := Sys.IntToHex(FIPv6[0], 4);
    for i := 1 to 7 do begin
      Result := Result + ':' + Sys.IntToHex(FIPv6[i], 4);
    end;
  end else begin
    Result := '';
  end;
end;

class function TIdIPAddress.IPv4MakeCardInRange(const AInt: Int64; const A256Power: Integer): Cardinal;
begin
  case A256Power of
    4 : Result := (AInt and POWER_4);
    3 : Result := (AInt and POWER_3);
    2 : Result := (AInt and POWER_2);
  else
    Result := (AInt and POWER_1);
  end;
end;

class function TIdIPAddress.IPv4ToCardinal(const AIPAddress: String; var VErr: Boolean): Cardinal;
var
  LBuf, LBuf2 : String;
  L256Power : Integer;
  LParts : Integer; //how many parts should we process at a time
begin
  // S.G. 11/8/2003: Added overflow checking disabling and change multiplys by SHLs.
  // Locally disable overflow checking so we can safely use SHL and SHR
  {$ifopt Q+} // detect previous setting
  {$define _QPlusWasEnabled}
  {$Q-}
  {$endif}
  VErr := True;
  L256Power := 4;
  LBuf2 := AIPAddress;
  Result := 0;
  repeat
    LBuf := Fetch(LBuf2, '.');
    if LBuf = '' then begin
      Break;
    end;
    //We do things this way because we have to treat
    //IP address parts differently than a whole number
    //and sometimes, there can be missing periods.
    if (LBuf2 = '') and (L256Power > 1) then begin
      LParts := L256Power;
      Result := Result shl (L256Power SHL 3);
    end else begin
      LParts := 1;
      Result := Result shl 8;
    end;
    if TextStartsWith(LBuf, HEXPREFIX) then begin
      //this is a hexideciaml number
      if not IsHexidecimal(Copy(LBuf, 3, MaxInt)) then begin
        Exit;
      end;
      Result :=  Result + IPv4MakeCardInRange(Sys.StrToInt64(LBuf, 0), LParts);
    end else begin
      if not IsNumeric(LBuf) then begin
        Exit;
      end;
      if (LBuf[1] = '0') and IsOctal(LBuf) then begin
        //this is octal
        Result := Result + IPv4MakeCardInRange(OctalToInt64(LBuf), LParts);
      end else begin
        //this must be a decimal
        Result :=  Result + IPv4MakeCardInRange(Sys.StrToInt64(LBuf, 0), LParts);
      end;
    end;
    Dec(L256Power);
  until False;
  VErr := False;
  // Restore overflow checking
  {$ifdef _QPlusWasEnabled} // detect previous setting
  {$undef _QPlusWasEnabled}
  {$Q-}
  {$endif}
end;

class function TIdIPAddress.IPv6ToIdIPv6Address(const AIPAddress: String; var VErr: Boolean): TIdIPv6Address;
var
  LAddress: string;
  I: Integer;
begin
  LAddress := MakeCanonicalIPv6Address(AIPAddress);
  VErr := (LAddress = '');
  if not VErr then begin
    for I := 0 to 7 do begin
      Result[I] := Sys.StrToInt('$' + Fetch(LAddress, ':'), 0);
    end;
  end;
end;

class function TIdIPAddress.MakeAddressObject(const AIP: String): TIdIPAddress;
var
  LErr : Boolean;
begin
  Result := TIdIPAddress.Create;
  try
    Result.FIPv6 := Result.IPv6ToIdIPv6Address(AIP, LErr);
    if not LErr then begin
      Result.FAddrType := Id_IPv6;
      Exit;
    end;
    Result.FIPv4 := Result.IPv4ToCardinal(AIP, LErr);
    if not LErr then begin
      Result.FAddrType := Id_IPv4;
      Exit;
    end;
    //this is not a valid IP address
    Sys.FreeAndNil(Result);
  except
    Sys.FreeAndNil(Result);
    raise;
  end;
end;

class function TIdIPAddress.MakeAddressObject(const AIP: String; const AIPVersion: TIdIPVersion): TIdIPAddress;
var
  LErr : Boolean;
begin
  Result := TIdIPAddress.Create;
  try
    case AIPVersion of
      Id_IPV4:
        begin
          Result.FIPv4 := Result.IPv4ToCardinal(AIP, LErr);
          if not LErr then begin
            Result.FAddrType := Id_IPv4;
            Exit;
          end;
        end;
      Id_IPv6:
        begin
          Result.FIPv6 := Result.IPv6ToIdIPv6Address(AIP, LErr);
          if not LErr then begin
            Result.FAddrType := Id_IPv6;
            Exit;
          end
        end;
    end;
    //this is not a valid IP address
    Sys.FreeAndNil(Result);
  except
    Sys.FreeAndNil(Result);
    raise;
  end;
end;

class function TIdIPAddress.MakeCanonicalIPv4Address(const AAddr: string): string;
var
  LErr : Boolean;
  LIP : Cardinal;
begin
  LIP := IPv4ToDWord(AAddr, LErr);
  if not LErr then begin
    Result := MakeDWordIntoIPv4Address(LIP);
  end else begin
    Result := '';
  end;
end;

class function TIdIPAddress.MakeCanonicalIPv6Address(const AAddr: string): string;
// return an empty string if the address is invalid,
// for easy checking if its an address or not.
var
  p, i: integer;
  dots, colons: integer;
  colonpos: array[1..8] of integer;
  dotpos: array[1..3] of integer;
  LAddr: string;
  num: integer;
  haddoublecolon: boolean;
  fillzeros: integer;
begin
  Result := ''; // error
  LAddr := AAddr;
  if Length(LAddr) = 0 then begin
    Exit;
  end;
  if LAddr[1] = ':' then begin
    LAddr := '0' + LAddr;
  end;
  if LAddr[Length(LAddr)] = ':' then begin
    LAddr := LAddr + '0';
  end;
  dots := 0;
  colons := 0;
  for p := 1 to Length(LAddr) do begin
    case LAddr[p] of
      '.' :
        begin
          Inc(dots);
          if dots < 4 then begin
            dotpos[dots] := p;
          end else begin
            Exit; // error in address
          end;
        end;
      ':' :
        begin
          Inc(colons);
          if colons < 8 then begin
            colonpos[colons] := p;
          end else begin
            Exit; // error in address
          end;
        end;
      'a'..'f', 'A'..'F':
        begin
          if dots > 0 then begin
            Exit;
          end;
          // allow only decimal stuff within dotted portion, ignore otherwise
        end;
      '0'..'9':
        begin
          // do nothing
        end;
      else
        begin
          Exit; // error in address
        end;
    end;
  end;
  if not (dots in [0, 3]) then begin
    Exit; // you have to write 0 or 3 dots...
  end;
  if dots = 3 then begin
    if not (colons in [2..6]) then begin
      Exit; // must not have 7 colons if we have dots
    end;
    if colonpos[colons] > dotpos[1] then begin
      Exit; // x:x:x.x:x:x is not valid
    end;
  end else if not (colons in [2..7]) then begin
    Exit; // must at least have two colons
  end;

  // now start :-)
  num := Sys.StrToInt('$' + Copy(LAddr, 1, colonpos[1]-1), -1);
  if (num < 0) or (num > 65535) then begin
    Exit; // huh? odd number...
  end;
  Result := Sys.IntToHex(num, 1) + ':';

  haddoublecolon := False;
  for p := 2 to colons do begin
    if colonpos[p-1] = (colonpos[p]-1) then begin
      if haddoublecolon then begin
        Result := '';
        Exit; // only a single double-dot allowed!
      end;
      haddoublecolon := True;
      fillzeros := 8 - colons;
      if dots > 0 then begin
        Dec(fillzeros, 2);
      end;
      for i := 1 to fillzeros do begin
        Result := Result + '0:'; {do not localize}
      end;
    end else begin
      num := Sys.StrToInt('$' + Copy(LAddr, colonpos[p-1]+1, colonpos[p]-colonpos[p-1]-1), -1);
      if (num < 0) or (num > 65535) then begin
        Result := '';
        Exit; // huh? odd number...
      end;
      Result := Result + Sys.IntToHex(num, 1) + ':';
    end;
  end; // end of colon separated part

  if dots = 0 then begin
    num := Sys.StrToInt('$' + Copy(LAddr, colonpos[colons]+1, MaxInt), -1);
    if (num < 0) or (num > 65535) then begin
      Result := '';
      Exit; // huh? odd number...
    end;
    Result := Result + Sys.IntToHex(num, 1) + ':';
  end;

  if dots > 0 then begin
    num := Sys.StrToInt(Copy(LAddr, colonpos[colons]+1, dotpos[1]-colonpos[colons]-1), -1);
    if (num < 0) or (num > 255) then begin
      Result := '';
      Exit;
    end;
    Result := Result + Sys.IntToHex(num, 2);

    num := Sys.StrToInt(Copy(LAddr, dotpos[1]+1, dotpos[2]-dotpos[1]-1), -1);
    if (num < 0) or (num > 255) then begin
      Result := '';
      Exit;
    end;
    Result := Result + Sys.IntToHex(num, 2) + ':';

    num := Sys.StrToInt(Copy(LAddr, dotpos[2]+1, dotpos[3]-dotpos[2]-1), -1);
    if (num < 0) or (num > 255) then begin
      Result := '';
      Exit;
    end;
    Result := Result + Sys.IntToHex(num, 2);

    num := Sys.StrToInt(Copy(LAddr, dotpos[3]+1, 3), -1);
    if (num < 0) or (num > 255) then begin
      Result := '';
      Exit;
    end;
    Result := Result + Sys.IntToHex(num, 2) + ':';
  end;
  SetLength(Result, Length(Result)-1);
end;

end.
