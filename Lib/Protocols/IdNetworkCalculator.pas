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
  Rev 1.4    10/26/2004 10:33:46 PM  JPMugaas
  Updated refs.

  Rev 1.3    2004.02.03 5:44:08 PM  czhower
  Name changes

  Rev 1.2    24/01/2004 19:27:30  CCostelloe
  Cleaned up warnings

  Rev 1.1    1/21/2004 2:20:26 PM  JPMugaas
  InitComponent

  Rev 1.0    11/13/2002 07:57:46 AM  JPMugaas
}

unit IdNetworkCalculator;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal,
  IdBaseComponent,
  IdStruct;
  
type
  TNetworkClass = (
    ID_NET_CLASS_A, ID_NET_CLASS_B, ID_NET_CLASS_C, ID_NET_CLASS_D, ID_NET_CLASS_E
    );

const
  ID_NC_MASK_LENGTH = 32;
  ID_NETWORKCLASS = ID_NET_CLASS_A;

type
  TIdIPAddressType = (IPLocalHost, IPLocalNetwork, IPReserved, IPInternetHost,
    IPPrivateNetwork, IPLoopback, IPMulticast, IPFutureUse, IPGlobalBroadcast);

  TIpProperty = class(TPersistent)
  protected
    FReadOnly: Boolean;
    FBitArray: array[0..31] of Boolean;
    FValue: array[0..3] of Byte;
    FOnChange: TNotifyEvent;
    function GetAddressType: TIdIPAddressType;
    function GetAsBinaryString: String;
    function GetAsDoubleWord: UInt32;
    function GetAsString: String;
    function GetBit(Index: Byte): Boolean;
    function GetByte(Index: Integer): Byte;
    procedure SetAsBinaryString(const Value: String);
    procedure SetAsDoubleWord(const Value: UInt32);
    procedure SetAsString(const Value: String);
    procedure SetBit(Index: Byte; const Value: Boolean);
    procedure SetByte(Index: Integer; const Value: Byte);
    //
    property IsReadOnly: Boolean read FReadOnly write FReadOnly default False;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    //
    procedure SetAll(One, Two, Three, Four: Byte); virtual;
    procedure Assign(Source: TPersistent); override;
    //
    property Bits[Index: Byte]: Boolean read GetBit write SetBit;
    property AddressType: TIdIPAddressType read GetAddressType;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  published
    property Byte1: Byte index 0 read GetByte write SetByte stored False;
    property Byte2: Byte index 1 read GetByte write SetByte stored False;
    property Byte3: Byte index 2 read GetByte write SetByte stored False;
    property Byte4: Byte index 3 read GetByte write SetByte stored False;
    property AsDoubleWord: UInt32 read GetAsDoubleWord write SetAsDoubleWord stored False;
    property AsBinaryString: String read GetAsBinaryString write SetAsBinaryString stored False;
    property AsString: String read GetAsString write SetAsString;
  end;

  TIdNetworkCalculator = class(TIdBaseComponent)
  protected
    FListIP: TStrings;
    FNetworkMaskLength: UInt32;
    FNetworkMask: TIpProperty;
    FNetworkAddress: TIpProperty;
    FNetworkClass: TNetworkClass;
    FOnChange: TNotifyEvent;
    FOnGenIPList: TNotifyEvent;
    procedure FillIPList;
    function GetNetworkClassAsString: String;
    function GetIsAddressRoutable: Boolean;
    function GetListIP: TStrings;
    procedure SetNetworkAddress(const Value: TIpProperty);
    procedure SetNetworkMask(const Value: TIpProperty);
    procedure SetNetworkMaskLength(const Value: UInt32);
    procedure NetMaskChanged(Sender: TObject);
    procedure NetAddressChanged(Sender: TObject);
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    function IsAddressInNetwork(const Address: String): Boolean;
    function NumIP: UInt32;
    function StartIP: String;
    function EndIP: String;
    //
    property ListIP: TStrings read GetListIP;
    property NetworkClass: TNetworkClass read FNetworkClass;
    property NetworkClassAsString: String read GetNetworkClassAsString;
    property IsAddressRoutable: Boolean read GetIsAddressRoutable;
  published
    property NetworkAddress: TIpProperty read FNetworkAddress write SetNetworkAddress;
    property NetworkMask: TIpProperty read FNetworkMask write SetNetworkMask;
    property NetworkMaskLength: UInt32 read FNetworkMaskLength write SetNetworkMaskLength
     default ID_NC_MASK_LENGTH;
    property OnGenIPList: TNotifyEvent read FOnGenIPList write FOnGenIPList;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

uses
  IdException, IdGlobalProtocols, IdResourceStringsProtocols, IdStack, SysUtils;

function MakeLongWordIP(const One, Two, Three, Four: Byte): UInt32;
begin
  Result := (UInt32(One) shl 24) or (UInt32(Two) shl 16) or (UInt32(Three) shl 8) or UInt32(Four);
end;

procedure BreakupLongWordIP(const Value: UInt32; var One, Two, Three, Four: Byte);
begin
  One := Byte((Value and $FF000000) shr 24);
  Two := Byte((Value and $00FF0000) shr 16);
  Three := Byte((Value and $0000FF00) shr 8);
  Four := Byte(Value and $000000FF);
end;

function StrToIP(const Value: string): UInt32;
var
  strBuffers: Array [0..3] of String;
  cardBuffers: Array[0..3] of UInt32;
  StrWork: String;
  I: Integer;
begin
  StrWork := Value;
  // Separate the strings
  strBuffers[0] := Fetch(StrWork, '.', True);    {Do not Localize}
  strBuffers[1] := Fetch(StrWork, '.', True);    {Do not Localize}
  strBuffers[2] := Fetch(StrWork, '.', True);    {Do not Localize}
  strBuffers[3] := StrWork;
  try
    for I := 0 to 3 do begin
      cardBuffers[I] := IndyStrToInt(strBuffers[I]);
    end;
  except
    IndyRaiseOuterException(EIdException.CreateFmt(RSNETCALInvalidIPString, [Value]));
  end;
  // range check
  for I := 0 to 3 do begin
    if not (cardBuffers[I] in [0..255]) then begin
      raise EIdException.CreateFmt(RSNETCALInvalidIPString, [Value]); // TODO: create a new Exception class for this
    end;
  end;
  Result := MakeLongWordIP(cardBuffers[0], cardBuffers[1], cardBuffers[2], cardBuffers[3]);
end;

{ TIdNetworkCalculator }

procedure TIdNetworkCalculator.InitComponent;
begin
  inherited InitComponent;
  FNetworkMask := TIpProperty.Create;
  FNetworkMask.OnChange := NetMaskChanged;
  FNetworkAddress := TIpProperty.Create;
  FNetworkAddress.OnChange := NetAddressChanged;
  FListIP := TStringList.Create;
  FNetworkClass := ID_NETWORKCLASS;
  NetworkMaskLength := ID_NC_MASK_LENGTH;
end;

destructor TIdNetworkCalculator.Destroy;
begin
  FreeAndNil(FNetworkMask);
  FreeAndNil(FNetworkAddress);
  FreeAndNil(FListIP);
  inherited Destroy;
end;

procedure TIdNetworkCalculator.FillIPList;
var
  i: UInt32;
  BaseIP: UInt32;
  LByte1, LByte2, LByte3, LByte4: Byte;
begin
  if FListIP.Count = 0 then
  begin
    // prevent to start a long loop in the IDE (will lock delphi)
    if IsDesignTime and (NumIP > 1024) then begin
      FListIP.text := IndyFormat(RSNETCALConfirmLongIPList, [NumIP]);
    end else
    begin
      BaseIP := NetworkAddress.AsDoubleWord and NetworkMask.AsDoubleWord;
      // Lock the list so we won't be "repainting" the whole time...    {Do not Localize}
      FListIP.BeginUpdate;
      try
        FListIP.Capacity := NumIP;
        for i := 1 to (NumIP - 1) do
        begin
          Inc(BaseIP);
          BreakupLongWordIP(BaseIP, LByte1, LByte2, LByte3, LByte4);
          FListIP.Append(IndyFormat('%d.%d.%d.%d', [LByte1, LByte2, LByte3, LByte4]));    {Do not Localize}
        end;
      finally
        FListIP.EndUpdate;
      end;
    end;
  end;
end;

function TIdNetworkCalculator.GetListIP: TStrings;
begin
  FillIPList;
  Result := FListIP;
end;

function TIdNetworkCalculator.IsAddressInNetwork(const Address: String): Boolean;
begin
  Result := (StrToIP(Address) and NetworkMask.AsDoubleWord) = (NetworkAddress.AsDoubleWord and NetworkMask.AsDoubleWord);
end;

procedure TIdNetworkCalculator.NetAddressChanged(Sender: TObject);
var
  sBuffer: String;
begin
  FListIP.Clear;
  sBuffer := NetworkAddress.AsBinaryString;
  // RFC 1365
  if TextStartsWith(sBuffer, '0') then begin   {Do not Localize}
    fNetworkClass := ID_NET_CLASS_A;
  end
  else if TextStartsWith(sBuffer, '10') then begin   {Do not Localize}
    fNetworkClass := ID_NET_CLASS_B;
  end
  else if TextStartsWith(sBuffer, '110') then begin   {Do not Localize}
    fNetworkClass := ID_NET_CLASS_C;
  end
  // Network class D is reserved for multicast
  else if TextStartsWith(sBuffer, '1110') then begin   {Do not Localize}
    fNetworkClass := ID_NET_CLASS_D;
  end
  // network class E is reserved and shouldn't be used    {Do not Localize}
  else {if TextStartsWith(sBuffer, '1111') then} begin   {Do not Localize}
    fNetworkClass := ID_NET_CLASS_E;
  end;
  if Assigned(FOnChange) then begin
    FOnChange(Self);
  end;
end;

procedure TIdNetworkCalculator.NetMaskChanged(Sender: TObject);
var
  sBuffer: string;
  InitialMaskLength: UInt32;
begin
  FListIP.Clear;
  InitialMaskLength := FNetworkMaskLength;
  // A network mask MUST NOT contains holes.
  sBuffer := FNetworkMask.AsBinaryString;
  while TextStartsWith(sBuffer, '1') do begin   {Do not Localize}
    Delete(sBuffer, 1, 1);
  end;
  if IndyPos('1', sBuffer) > 0 then    {Do not Localize}
  begin
    NetworkMaskLength := InitialMaskLength;
    raise EIdException.Create(RSNETCALCInvalidNetworkMask); // TODO: create a new Exception class for this
  end;
  // set the net mask length
  NetworkMaskLength := 32 - Length(sBuffer);
  if Assigned(FOnChange) then begin
    FOnChange(Self);
  end;
end;

procedure TIdNetworkCalculator.SetNetworkAddress(const Value: TIpProperty);
begin
  FNetworkAddress.Assign(Value);
end;

procedure TIdNetworkCalculator.SetNetworkMask(const Value: TIpProperty);
begin
  FNetworkMask.Assign(Value);
end;

procedure TIdNetworkCalculator.SetNetworkMaskLength(const Value: UInt32);
var
  LBuffer, LValue: UInt32;
begin
  if Value <= 32 then begin
    LValue := Value;
  end else begin
    LValue := 32;
  end;
  if FNetworkMaskLength <> LValue then
  begin
    FNetworkMaskLength := LValue;
    if Value > 0 then begin
      LBuffer := High(UInt32) shl (32 - LValue);
    end else begin
      LBuffer := 0;
    end;
    FNetworkMask.AsDoubleWord := LBuffer;
  end;
end;

function TIdNetworkCalculator.GetNetworkClassAsString: String;
const
  sClasses: array[TNetworkClass] of String = ('A', 'B', 'C', 'D','E'); {Do not Localize}
begin
  Result := sClasses[FNetworkClass];
end;

function TIdNetworkCalculator.GetIsAddressRoutable: Boolean;
begin
  // RFC 1918
  Result := not (
             (FNetworkAddress.Byte1 = 10) or
             ((FNetworkAddress.Byte1 = 172) and (FNetworkAddress.Byte2 in [16..31])) or
             ((FNetworkAddress.Byte1 = 192) and (FNetworkAddress.Byte2 = 168))
             );
end;

function TIdNetworkCalculator.EndIP: String;
var
  IP: UInt32;
  LByte1, LByte2, LByte3, LByte4: Byte;
begin
  IP := (NetworkAddress.AsDoubleWord and NetworkMask.AsDoubleWord) + (NumIP - 1);
  BreakupLongWordIP(IP, LByte1, LByte2, LByte3, LByte4);
  Result := IndyFormat('%d.%d.%d.%d', [LByte1, LByte2, LByte3, LByte4]);    {Do not Localize}
end;

function TIdNetworkCalculator.NumIP: UInt32;
begin
  Result := 1 shl (32 - NetworkMaskLength);
end;

function TIdNetworkCalculator.StartIP: String;
var
  IP: UInt32;
  LByte1, LByte2, LByte3, LByte4: Byte;
begin
  IP := NetworkAddress.AsDoubleWord and NetworkMask.AsDoubleWord;
  BreakupLongWordIP(IP, LByte1, LByte2, LByte3, LByte4);
  Result := IndyFormat('%d.%d.%d.%d', [LByte1, LByte2, LByte3, LByte4]);    {Do not Localize}
end;

{ TIpProperty }

constructor TIpProperty.Create;
begin
  inherited Create;
  FValue[0] := $0;
  FValue[1] := $0;
  FValue[2] := $0;
  FValue[3] := $0;
end;

destructor TIpProperty.Destroy;
begin
  inherited Destroy;
end;

procedure TIpProperty.Assign(Source: TPersistent);
var
  LSource: TIpProperty;
begin
  if Source is TIpProperty then
  begin
    LSource := TIpProperty(Source);
    SetAll(LSource.Byte1, LSource.Byte2, LSource.Byte3, LSource.Byte4);
  end else begin
    inherited Assign(Source);
  end;
end;

function TIpProperty.GetBit(Index: Byte): boolean;
begin
  Result := FBitArray[index];
end;

procedure TIpProperty.SetAll(One, Two, Three, Four: Byte);
var
  i, j: Integer;
begin
  if (FValue[0] <> One) or (FValue[1] <> Two) or (FValue[2] <> Three) or (FValue[3] <> Four) then
  begin
    FValue[0] := One;
    FValue[1] := Two;
    FValue[2] := Three;
    FValue[3] := Four;
    // set the binary array
    for i := 0 to 3 do begin
      for j := 0 to 7 do begin
        FBitArray[(8*i)+j] := (FValue[i] and (1 shl (7-j))) <> 0;
      end;
    end;
    if Assigned(FOnChange) then begin
      FOnChange(Self);
    end;
  end;
end;

function TIpProperty.GetAsBinaryString: String;
var
  i : Integer;
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB: TIdStringBuilder;
  {$ENDIF}
begin
  // get the binary string
  {$IFDEF STRING_IS_IMMUTABLE}
  LSB := TIdStringBuilder.Create(32);
  {$ELSE}
  SetLength(Result, 32);
  {$ENDIF}
  for i := 1 to 32 do
  begin
    if FBitArray[i-1] then begin
      {$IFDEF STRING_IS_IMMUTABLE}
      LSB.Append(Char('1'));    {Do not Localize}
      {$ELSE}
      Result[i] := '1';         {Do not Localize}
      {$ENDIF}
    end else begin
      {$IFDEF STRING_IS_IMMUTABLE}
      LSB.Append(Char('0'));    {Do not Localize}
      {$ELSE}
      Result[i] := '0';         {Do not Localize}
      {$ENDIF}
    end;
  end;
  {$IFDEF STRING_IS_IMMUTABLE}
  Result := LSB.ToString;
  {$ENDIF}
end;

function TIpProperty.GetAsDoubleWord: UInt32;
begin
  Result := MakeLongWordIP(FValue[0], FValue[1], FValue[2], FValue[3]);
end;

function TIpProperty.GetAsString: String;
begin
  // Set the string
  Result := IndyFormat('%d.%d.%d.%d', [FValue[0], FValue[1], FValue[2], FValue[3]]);    {Do not Localize}
end;

procedure TIpProperty.SetAsBinaryString(const Value: String);
var
  i: Integer;
  NewIP: UInt32;
begin
  if IsReadOnly then begin
    Exit;
  end;
  if Length(Value) <> 32 then begin
    raise EIdException.Create(RSNETCALCInvalidValueLength); // TODO: create a new Exception class for this
  end;
  if not TextIsSame(Value, AsBinaryString) then
  begin
    NewIP := 0;
    for i := 1 to 32 do
    begin
      if Value[i] <> '0' then begin    {Do not Localize}
        NewIP := NewIP or (1 shl (32 - i));
      end;
    end;
    SetAsDoubleWord(NewIP);
  end;
end;

function TIpProperty.GetByte(Index: Integer): Byte;
begin
  Result := FValue[Index];
end;

procedure TIpProperty.SetAsDoubleWord(const Value: UInt32);
var
  LByte1, LByte2, LByte3, LByte4: Byte;
begin
  if not IsReadOnly then
  begin
    BreakupLongWordIP(Value, LByte1, LByte2, LByte3, LByte4);
    SetAll(LByte1, LByte2, LByte3, LByte4);
  end;
end;

procedure TIpProperty.SetAsString(const Value: String);
begin
  SetAsDoubleWord(StrToIP(Value));
end;

procedure TIpProperty.SetBit(Index: Byte; const Value: Boolean);
var
  ByteIndex: Integer;
  BitValue: Byte;
begin
  if (not IsReadOnly) and (FBitArray[Index] <> Value) then
  begin
    FBitArray[Index] := Value;
    ByteIndex := Index div 8;
    BitValue := Byte(1 shl (7-(Index mod 8)));
    if Value then begin
      FValue[ByteIndex] := FValue[ByteIndex] or BitValue;
    end else begin
      FValue[ByteIndex] := FValue[ByteIndex] and not BitValue;
    end;
    if Assigned(OnChange) then begin
      OnChange(Self);
    end;
  end;
end;

procedure TIpProperty.SetByte(Index: Integer; const Value: Byte);
begin
  if (not IsReadOnly) and (GetByte(Index) <> Value) then
  begin
    case Index of
      0: SetAll(Value, Byte2, Byte3, Byte4);
      1: SetAll(Byte1, Value, Byte3, Byte4);
      2: SetAll(Byte1, Byte2, Value, Byte4);
      3: SetAll(Byte1, Byte2, Byte3, Value);
    end;
  end;
end;

function TIpProperty.GetAddressType: TIdIPAddressType;
// based on http://www.ora.com/reference/dictionary/terms/I/IP_Address.htm
begin
  Result := IPInternetHost;
  case Byte1 of
    {localhost or local network}
    0 : if AsDoubleWord = 0 then begin
          Result := IPLocalHost;
        end else begin
          Result := IPLocalNetwork;
        end;
    {Private network allocations}
    10 : Result := IPPrivateNetwork;
    172 : if Byte2 = 16 then begin
            Result := IPPrivateNetwork;
          end;
    192 : if Byte2 = 168 then begin
            Result := IPPrivateNetwork;
          end
          else if (Byte2 = 0) and (Byte3 = 0) then begin
            Result := IPReserved;
          end;
    {loopback}
    127 : Result := IPLoopback;
    255 : if AsDoubleWord = $FFFFFFFF then begin
            Result := IPGlobalBroadcast;
          end else begin
            Result := IPFutureUse;
          end;
    {Reserved}
    128 : if Byte2 = 0 then begin
            Result := IPReserved;
          end;
    191 : if (Byte2 = 255) and (Byte3 = 255) then begin
             Result := IPReserved;
          end;
    223 : if (Byte2 = 255) and (Byte3 = 255) then begin
            Result := IPReserved;
          end;
    {Multicast}
    224..239: Result := IPMulticast;
    {Future Use}
    240..254: Result := IPFutureUse;
  end;
end;

end.
