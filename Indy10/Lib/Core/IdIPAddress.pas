{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  52330: IdIPAddress.pas
{
{   Rev 1.10    2/8/05 5:29:16 PM  RLebeau
{ Updated GetHToNBytes() to use CopyTIdWord() instead of AppendBytes() for IPv6
{ addresses.
}
{
{   Rev 1.9    28.09.2004 20:54:32  Andreas Hausladen
{ Removed unused functions that were moved to IdGlobal
}
{
    Rev 1.8    6/11/2004 8:48:20 AM  DSiders
  Added "Do not Localize" comments.
}
{
    Rev 1.7    5/19/2004 10:44:34 PM  DSiders
  Corrected spelling for TIdIPAddress.MakeAddressObject method.
}
{
{   Rev 1.6    14/04/2004 17:35:38  HHariri
{ Removed IP6 for BCB temporarily
}
{
{   Rev 1.5    2/11/2004 5:10:40 AM  JPMugaas
{ Moved IPv6 address definition to System package.
}
{
{   Rev 1.4    2004.02.03 4:17:18 PM  czhower
{ For unit name changes.
}
{
{   Rev 1.3    2/2/2004 12:22:24 PM  JPMugaas
{ Now uses IdGlobal IPVersion Type.  Added HToNBytes for things that need
{ to export into NetworkOrder for structures used in protocols.
}
{
{   Rev 1.2    1/3/2004 2:13:56 PM  JPMugaas
{ Removed some empty function code that wasn't used.
{ Added some value comparison functions.
{ Added a function in the IPAddress object for comparing the value with another
{ IP address.  Note that this comparison is useful as an IP address will take
{ several forms (especially common with IPv6).
{ Added a property for returning the IP address as a string which works for
{ both IPv4 and IPv6 addresses.
}
{
{   Rev 1.1    1/3/2004 1:03:14 PM  JPMugaas
{ Removed Lo as it was not needed and is not safe in NET.
}
{
{   Rev 1.0    1/1/2004 4:00:18 PM  JPMugaas
{ An object for handling both IPv4 and IPv6 addresses.  This is a proposal with
{ some old code for conversions.
}
unit IdIPAddress;

interface

uses
  Classes,
  IdGlobal;

type
  TIdIPAddress = class(TObject)
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
    function GetHToNBytes: TIdBytes;
  public
    constructor Create; virtual;
    class function MakeAddressObject(const AIP : String) : TIdIPAddress;
    function CompareAddress(const AIP : String; var Err : Boolean) : Integer;
    property IPv4 : Cardinal read FIPv4 write FIPv4;
    property IPv4AsString : String read GetIPv4AsString;
    {$IFNDEF BCB}
    property IPv6 : TIdIPv6Address read FIPv6 write FIPv6;
    {$ENDIF}
    property IPv6AsString : String read GetIPv6AsString;
    property AddrType : TIdIPVersion read FAddrType write FAddrType;
    property IPAsString : String read GetIPAddress;
    property HToNBytes : TIdBytes read GetHToNBytes;
  end;

implementation
uses SysUtils, IdStack;

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
  for i := 1 to Length(AValue) do
  begin
    Result := Result * 8 + StrToInt(Copy(AValue, i, 1));
  end;
end;

function CompareWord(const AWord1, AWord2 : Word) : Integer;
{
AWord1 > AWord2	> 0
AWord1 < AWord2	< 0
AWord1 = AWord2	= 0
}
begin
  Result := 0;
  if AWord1 > AWord2 then
  begin
    Result := 1;
  end
  else
  begin
    if AWord1 < AWord2 then
    begin
      Result := -1;
    end;
  end;
end;

function CompareCardinal(const ACard1, ACard2 : Cardinal) : Integer;
{
ACard1 > ACard2	> 0
ACard1 < ACard2	< 0
ACard1 = ACard2	= 0
}
begin
  Result := 0;
  if ACard1 > ACard2 then
  begin
    Result := 1;
  end
  else
  begin
    if ACard1 < ACard2 then
    begin
      Result := -1;
    end;
  end;
end;

{ TIdIPAddress }

function TIdIPAddress.CompareAddress(const AIP: String;
  var Err: Boolean): Integer;
var LIP2 : TIdIPAddress;
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
  Err := not Assigned(LIP2);
  if not Err then
  begin
    try
      //we can't compare an IPv4 address with an IPv6 address
      Err := FAddrType <> LIP2.FAddrType;
      if not Err then
      begin
        if FAddrType = Id_IPv4 then
        begin
          Result := CompareCardinal(FIPv4,LIP2.FIPv4);
        end
        else
        begin
          for i := 0 to 7 do
          begin
            Result := CompareWord(FIPv6[i],LIP2.FIPv6[i]);
            if Result <> 0 then
            begin
              Break;
            end;
          end;
        end;
      end;
    finally
      FreeAndNil(LIP2);
    end;
  end;
end;

constructor TIdIPAddress.Create;
begin
  inherited Create;
  FAddrType := Id_IPv4;
  FIPv4 := 0; //'0.0.0.0'
end;

function TIdIPAddress.GetHToNBytes: TIdBytes;
var
  i : Integer;
begin
  SetLength(Result, 0);
  case Self.FAddrType of
    Id_IPv4 :
    begin
      Result := ToBytes(GStack.HostToNetwork(FIPv4));
    end;
    Id_IPv6 :
    begin
      SetLength(Result, 16);
      for i := 0 to 7 do begin
        CopyTIdWord(GStack.HostToNetwork(FIPv6[i]), Result, 2*i);
      end;
    end;
  end;
end;

function TIdIPAddress.GetIPAddress: String;
begin
  if FAddrType = Id_IPv4 then
  begin
    Result := GetIPv4AsString;
  end
  else
  begin
    Result := GetIPv6AsString;
  end;
end;

function TIdIPAddress.GetIPv4AsString: String;
begin
  Result := '';
  if FAddrType = Id_IPv4 then
  begin
    Result := IntToStr((FIPv4 shr 24) and $FF)+'.';
    Result := Result + IntToStr((FIPv4 shr 16) and $FF)+'.';
    Result := Result + IntToStr((FIPv4 shr 8) and $FF)+'.';
    Result := Result + IntToStr(FIPv4 and $FF);
  end;
end;

function TIdIPAddress.GetIPv6AsString: String;
var i:integer;
begin
  Result := '';
  if FAddrType = Id_IPv6 then
  begin
    Result := IntToHex(FIPv6[0], 4);
    for i := 1 to 7 do begin
      Result := Result + ':' + IntToHex(FIPv6[i], 4);
    end;
  end;
end;

class function TIdIPAddress.IPv4MakeCardInRange(const AInt: Int64;
  const A256Power: Integer): Cardinal;
begin
  case A256Power of
    4 : Result := (AInt and POWER_4);
    3 : Result := (AInt and POWER_3);
    2 : Result := (AInt and POWER_2);
  else
    Result := (AInt and POWER_1);
  end;
end;

class function TIdIPAddress.IPv4ToCardinal(const AIPAddress: String;
  var VErr: Boolean): Cardinal;
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
    LBuf := Fetch(LBuf2,'.');
    if LBuf = '' then
    begin
      break;
    end;
    //We do things this way because we have to treat
    //IP address parts differently than a whole number
    //and sometimes, there can be missing periods.
    if (LBuf2='') and (L256Power > 1) then
    begin
      LParts := L256Power;
      Result := Result shl (L256Power SHL 3);
    end
    else
    begin
      LParts := 1;
      result := result SHL 8;
    end;
    if (Copy(LBuf,1,2)=HEXPREFIX) then
    begin
      //this is a hexideciaml number
      if IsHexidecimal(Copy(LBuf,3,MaxInt))=False then
      begin
        Exit;
      end
      else
      begin
        Result :=  Result + IPv4MakeCardInRange(StrToInt64Def(LBuf,0), LParts);
      end;
    end
    else
    begin
      if IsNumeric(LBuf) then
      begin
        if (LBuf[1]='0') and IsOctal(LBuf) then
        begin
          //this is octal
          Result := Result + IPv4MakeCardInRange(OctalToInt64(LBuf),LParts);
        end
        else
        begin
          //this must be a decimal
          Result :=  Result + IPv4MakeCardInRange(StrToInt64Def(LBuf,0), LParts);
        end;
      end
      else
      begin
        //There was an error meaning an invalid IP address
        Exit;
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

class function TIdIPAddress.IPv6ToIdIPv6Address(const AIPAddress: String;
  var VErr: Boolean): TIdIPv6Address;
var
  LAddress:string;
  i:integer;
begin
  LAddress := MakeCanonicalIPv6Address(AIPAddress);
  VErr := (LAddress='');
  if not VErr then begin
    for i := 0 to 7 do begin
      Result[i]:=StrToInt('$'+fetch(LAddress,':'));
    end;
  end;
end;

class function TIdIPAddress.MakeAddressObject(
  const AIP: String): TIdIPAddress;
var LErr : Boolean;
begin
  Result := TIdIPAddress.Create;
  Result.FIPv6 := Result.IPv6ToIdIPv6Address(AIP,LErr);
  if LErr then
  begin
    Result.FIPv4 := Result.IPv4ToCardinal(AIP,LErr);
    if LErr then
    begin
      //this is not a valid IPv4 address
      FreeAndNil(Result);
    end
    else
    begin
      Result.FAddrType := Id_IPv4;
    end;
  end
  else
  begin
    Result.FAddrType := Id_IPv6;
  end;
end;

class function TIdIPAddress.MakeCanonicalIPv4Address(
  const AAddr: string): string;
var LErr : Boolean;
  LIP : Cardinal;
begin
  LIP := IPv4ToDWord(AAddr,LErr);
  if LErr then
  begin
    Result := '';
  end
  else
  begin
    Result := MakeDWordIntoIPv4Address(LIP);
  end;
end;

class function TIdIPAddress.MakeCanonicalIPv6Address(
  const AAddr: string): string;
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
  if Length(LAddr) = 0 then exit;

  if LAddr[1] = ':' then begin
    LAddr := '0'+LAddr;
  end;
  if LAddr[Length(LAddr)] = ':' then begin
    LAddr := LAddr + '0';
  end;
  dots := 0;
  colons := 0;
  for p := 1 to Length(LAddr) do begin
    case LAddr[p] of
      '.' : begin
              inc(dots);
              if dots < 4 then begin
                dotpos[dots] := p;
              end else begin
                exit; // error in address
              end;
            end;
      ':' : begin
              inc(colons);
              if colons < 8 then begin
                colonpos[colons] := p;
              end else begin
                exit; // error in address
              end;
            end;
      'a'..'f',
      'A'..'F': if dots>0 then exit;
        // allow only decimal stuff within dotted portion, ignore otherwise
      '0'..'9': ; // do nothing
      else exit; // error in address
    end; // case
  end; // for
  if not (dots in [0,3]) then begin
    exit; // you have to write 0 or 3 dots...
  end;
  if dots = 3 then begin
    if not (colons in [2..6]) then begin
      exit; // must not have 7 colons if we have dots
    end;
    if colonpos[colons] > dotpos[1] then begin
      exit; // x:x:x.x:x:x is not valid
    end;
  end else begin
    if not (colons in [2..7]) then begin
      exit; // must at least have two colons
    end;
  end;

  // now start :-)
  num := StrToIntDef('$'+Copy(LAddr, 1, colonpos[1]-1), -1);
  if (num<0) or (num>65535) then begin
    exit; // huh? odd number...
  end;
  Result := IntToHex(num,1)+':';

  haddoublecolon := false;
  for p := 2 to colons do begin
    if colonpos[p-1] = colonpos[p]-1 then begin
      if haddoublecolon then begin
        Result := '';
        exit; // only a single double-dot allowed!
      end;
      haddoublecolon := true;
      fillzeros := 8 - colons;
      if dots>0 then dec(fillzeros,2);
      for i := 1 to fillzeros do begin
        Result := Result + '0:'; {do not localize}
      end;
    end else begin
      num := StrToIntDef('$'+Copy(LAddr, colonpos[p-1]+1, colonpos[p]-colonpos[p-1]-1), -1);
      if (num<0) or (num>65535) then begin
        Result := '';
        exit; // huh? odd number...
      end;
      Result := Result + IntToHex(num,1)+':';
    end;
  end; // end of colon separated part

  if dots = 0 then begin
    num := StrToIntDef('$'+Copy(LAddr, colonpos[colons]+1, MaxInt), -1);
    if (num<0) or (num>65535) then begin
      Result := '';
      exit; // huh? odd number...
    end;
    Result := Result + IntToHex(num,1)+':';
  end;

  if dots > 0 then begin
    num := StrToIntDef(Copy(LAddr, colonpos[colons]+1, dotpos[1]-colonpos[colons]-1),-1);
    if (num < 0) or (num>255) then begin
      Result := '';
      exit;
    end;
    Result := Result + IntToHex(num, 2);
    num := StrToIntDef(Copy(LAddr, dotpos[1]+1, dotpos[2]-dotpos[1]-1),-1);
    if (num < 0) or (num>255) then begin
      Result := '';
      exit;
    end;
    Result := Result + IntToHex(num, 2)+':';

    num := StrToIntDef(Copy(LAddr, dotpos[2]+1, dotpos[3]-dotpos[2]-1),-1);
    if (num < 0) or (num>255) then begin
      Result := '';
      exit;
    end;
    Result := Result + IntToHex(num, 2);
    num := StrToIntDef(Copy(LAddr, dotpos[3]+1, 3), -1);
    if (num < 0) or (num>255) then begin
      Result := '';
      exit;
    end;
    Result := Result + IntToHex(num, 2)+':';
  end;
  SetLength(Result, Length(Result)-1);
end;

end.
