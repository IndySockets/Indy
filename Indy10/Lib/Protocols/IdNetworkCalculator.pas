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
  IdBaseComponent;
  
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
    FByteArray: array[0..31] of Boolean;
    FValue: TIdLongWord;
    FOnChange: TNotifyEvent;
    function GetAddressType: TIdIPAddressType;
    function GetAsBinaryString: String;
    function GetAsDoubleWord: LongWord;
    function GetAsString: String;
    function GetByteArray(Index: Byte): Boolean;
    function GetByte(Index: Byte): Byte;
    procedure SetAsBinaryString(const Value: String);
    procedure SetAsDoubleWord(const Value: LongWord);
    procedure SetAsString(const Value: String);
    procedure SetByteArray(Index: Byte; const Value: Boolean);
    procedure SetByte(Index: Byte; const Value: Byte);
    //
    property ReadOnly: Boolean read FReadOnly write FReadOnly default False;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    //
    procedure SetAll(One, Two, Three, Four: Byte); virtual;
    procedure Assign(Source: TPersistent); override;
    //
    property ByteArray[Index: Byte]: Boolean read GetByteArray write SetByteArray;
    property AddressType: TIdIPAddressType read GetAddressType;
  published
    property Byte1: Byte read GetByte write SetByte index 0 stored False;
    property Byte2: Byte read GetByte write SetByte index 1 stored False;
    property Byte3: Byte read GetByte write SetByte index 2 stored False;
    property Byte4: Byte read GetByte write SetByte index 3 stored False;
    property AsDoubleWord: LongWord read GetAsDoubleWord write SetAsDoubleWord stored False;
    property AsBinaryString: String read GetAsBinaryString write SetAsBinaryString stored False;
    property AsString: String read GetAsString write SetAsString;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TIdNetworkCalculator = class(TIdBaseComponent)
  protected
    FListIP: TStrings;
    FNetworkMaskLength: LongWord;
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
    procedure SetNetworkMaskLength(const Value: LongWord);
    procedure NetMaskChanged(Sender: TObject);
    procedure NetAddressChanged(Sender: TObject);
    procedure InitComponent; override;
  public
    destructor Destroy; override;
    function IsAddressInNetwork(const Address: String): Boolean;
    function NumIP: Integer;
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
    property NetworkMaskLength: LongWord read FNetworkMaskLength write SetNetworkMaskLength
     default ID_NC_MASK_LENGTH;
    property OnGenIPList: TNotifyEvent read FOnGenIPList write FOnGenIPList;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

uses
  IdException, IdGlobal, IdResourceStringsProtocols, SysUtils;

type
  TIdLongWordIP = class(TIdLongWord)
  protected
    function GetByte(Index: Byte): Byte;
    procedure SetByte(Index: Byte; const Value: Byte);
  public
    property ByteValue[Index: Byte] read GetByte write SetByte;
  end;

function TIdLongWordIP.GetByte(Index: Byte): Byte;
begin
  Result := FBuffer[Index];
end;

procedure TIdLongWordIP.SetByte(Index: Byte; const Value: Byte);
begin
  FBuffer[Index] := Value;
end;

function StrToIP(const Value: string): LongWord;
var
  strBuffers: Array [0..3] of String;
  cardBuffers: Array[0..3] of LongWord;
  StrWork: String;
begin
  StrWork := Value;
  // Separate the strings
  strBuffers[0] := Fetch(StrWork, '.', True);    {Do not Localize}
  strBuffers[1] := Fetch(StrWork, '.', True);    {Do not Localize}
  strBuffers[2] := Fetch(StrWork, '.', True);    {Do not Localize}
  strBuffers[3] := StrWork;
  try
    cardBuffers[0] := IndyStrToInt(strBuffers[0]);
    cardBuffers[1] := IndyStrToInt(strBuffers[1]);
    cardBuffers[2] := IndyStrToInt(strBuffers[2]);
    cardBuffers[3] := IndyStrToInt(strBuffers[3]);
  except
    on E: exception do begin
      raise EIdException.CreateFmt(RSNETCALInvalidIPString, [Value]);
    end;
  end;
  // range check
  if not(cardBuffers[0] in [0..255]) then begin
    raise EIdException.CreateFmt(RSNETCALInvalidIPString, [Value]);
  end;
  if not(cardBuffers[1] in [0..255]) then begin
    raise EIdException.CreateFmt(RSNETCALInvalidIPString, [Value]);
  end;
  if not(cardBuffers[2] in [0..255]) then begin
    raise EIdException.CreateFmt(RSNETCALInvalidIPString, [Value]);
  end;
  if not(cardBuffers[3] in [0..255]) then begin
    raise EIdException.CreateFmt(RSNETCALInvalidIPString, [Value]);
  end;
  Result := OrdFourByteToLongWord(cardBuffers[0], cardBuffers[1], cardBuffers[2], cardBuffers[3]);
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
  i: LongWord;
  BaseIP: LongWord;
  IPBytes: TIdBytes;
begin
  if FListIP.Count = 0 then
  begin
    // prevent to start a long loop in the IDE (will lock delphi)
    if IsDesignTime and (NumIP > 1024) then begin
      FListIP.text := IndyFormat(RSNETCALConfirmLongIPList, [NumIP]);
    end else
    begin
      BaseIP := NetworkAddress.AsDoubleWord and NetworkMask.AsDoubleWord;
      // preallocate the memory for the list
      SetLength(IPBytes, 4);
      FListIP.Capacity := NumIP;
      // Lock the list so we won't be "repainting" the whole time...    {Do not Localize}
      FListIP.BeginUpdate;
      try
        for i := 1 to (NumIP - 1) do
        begin
          Inc(BaseIP);
          ToBytesF(IPBytes, BaseIP);
          FListIP.append(IndyFormat('%d.%d.%d.%d', [IPBytes[0], IPBytes[1], IPBytes[2], IPBytes[3]]));    {Do not Localize}
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
  end;
  if TextStartsWith(sBuffer, '10') then begin   {Do not Localize}
    fNetworkClass := ID_NET_CLASS_B;
  end;
  if TextStartsWith(sBuffer, '110') then begin   {Do not Localize}
    fNetworkClass := ID_NET_CLASS_C;
  end;
  // Network class D is reserved for multicast
  if TextStartsWith(sBuffer, '1110', s) then begin   {Do not Localize}
    fNetworkClass := ID_NET_CLASS_D;
  end;
  // network class E is reserved and shouldn't be used    {Do not Localize}
  if TextStartsWith(sBuffer, '1111') then begin   {Do not Localize}
    fNetworkClass := ID_NET_CLASS_E;
  end;
  if Assigned(FOnChange) then begin
    FOnChange(Self);
  end;
end;

procedure TIdNetworkCalculator.NetMaskChanged(Sender: TObject);
var
  sBuffer: string;
  InitialMaskLength: LongWord;
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
    raise EIdexception.Create(RSNETCALCInvalidNetworkMask); //  'Invalid network mask'    {Do not Localize}
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

procedure TIdNetworkCalculator.SetNetworkMaskLength(const Value: LongWord);
var
  LBuffer: LongWord;
begin
  if FNetworkMaskLength <> Value then
  begin
    FNetworkMaskLength := Value;
    if Value > 0 then begin
      LBuffer := High(LongWord) shl (32 - Value);
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
  // RFC
  with NetworkAddress do
  begin
    Result := (Byte1 = 10) or
             ((Byte1 = 172) and (Byte2 in [16..31])) or
             ((Byte1 = 192) and (Byte2 = 168));
  end;
end;

function TIdNetworkCalculator.EndIP: String;
var
  IP: LongWord;
  Byte1, Byte2, Byte3, Byte4: Byte;
begin
  IP := (NetworkAddress.AsDoubleWord and NetworkMask.AsDoubleWord) + (NumIP - 1);
  LongWordToOrdFourByte(IP, Byte1, Byte2, Byte3, Byte4);
  Result := IndyFormat('%d.%d.%d.%d', [Byte1, Byte2, Byte3, Byte4]);    {Do not Localize}
end;

function TIdNetworkCalculator.NumIP: integer;
begin
  NumIP := 1 shl (32 - NetworkMaskLength);
end;

function TIdNetworkCalculator.StartIP: String;
var
  IP: LongWord;
  Byte1, Byte2, Byte3, Byte4: Byte;
begin
  IP := NetworkAddress.AsDoubleWord and NetworkMask.AsDoubleWord;
  LongWordToOrdFourByte(IP, Byte1, Byte2, Byte3, Byte4);
  Result := IndyFormat('%d.%d.%d.%d', [Byte1, Byte2, Byte3, Byte4]);    {Do not Localize}
end;

{ TIpProperty }

constructor TIpProperty.Create;
begin
  inherited Create;
  FValue := TIdLongWordIP.Create;
end;

destructor TIpProperty.Destroy;
begin
  FreeAndNil(FValue);
  inherited Destroy;
end;

procedure TIpProperty.Assign(Source: TIdPersistent);
begin
  if Source is TIpProperty then
  begin
    with Source as TIpProperty do begin
      Self.SetAll(Byte1, Byte2, Byte3, Byte4);
    end;
  end else begin
    inherited Assign(Source);
  end;
end;

function TIpProperty.GetByteArray(Index: Byte): boolean;
begin
  Result := FByteArray[index];
end;

procedure TIpProperty.SetAll(One, Two, Three, Four: Byte);
var
  i: Integer;
  NewIP: LongWord;
begin
  NewIP := OrdFourByteToLongWord(One, Two, Three, Four);
  if NewIP <> FValue.s_l then
  begin
    FValue.s_l := NewIP;
    // set the binary array
    for i := 0 to 31 do begin
      FByteArray[i] := ((NewIP shl i) shr 31) = 1;
    end;
    if Assigned(FOnChange) then begin
      FOnChange(Self);
    end;
  end;
end;

function TIpProperty.GetAsBinaryString: String;
begin
  // get the binary string
  SetLength(Result, 32);
  for i := 1 to 32 do
  begin
    if FByteArray[i - 1] then begin
      Result[i] := '1'    {Do not Localize}
    end else begin
      Result[i] := '0';    {Do not Localize}
    end;
  end;
end;

function TIpProperty.GetAsDoubleWord: LongWord;
begin
  Result := FValue.s_l;
end;

function TIpProperty.GetAsString: String;
begin
  // Set the string
  Result := IndyFormat('%d.%d.%d.%d', [FValue.s_b1, FValue.s_b2, FValue.s_b3, FValue.s_b4]);    {Do not Localize}
end;

procedure TIpProperty.SetAsBinaryString(const Value: String);
var
  i: Integer;
  NewIP: LongWord;
begin
  if ReadOnly then begin
    Exit;
  end;
  if Length(Value) <> 32 then begin
    raise EIdException.Create(RSNETCALCInvalidValueLength) // 'Invalid value length: Should be 32.'    {Do not Localize}
  end;
  if not TextIsSame(Value, AsBinaryString) then
  begin
    NewIP := 0;
    for i := 1 to 32 do
    begin
      if Value[i] <> '0' then begin    {Do not Localize}
        Inc(NewIP, 1 shl (32 - i));
      end;
    end;
    SetAsDoubleWord(NewIP);
  end;
end;

function TIpProperty.GetByte(Index: Byte): Byte;
begin
  Result := FValue.ByteValue[Index];
end;

procedure TIpProperty.SetAsDoubleWord(const Value: LongWord);
var
  Byte1, Byte2, Byte3, Byte4: Byte;
begin
  if not ReadOnly then
  begin
    LongWordToOrdFourByte(Value, Byte1, Byte2, Byte3, Byte4);
    SetAll(Byte1, Byte2, Byte3, Byte4);
  end;
end;

procedure TIpProperty.SetAsString(const Value: String);
begin
  SetAsDoubleWord(StrToIP(Value));
end;

procedure TIpProperty.SetByteArray(Index: Byte; const Value: Boolean);
var
  NewIP: LongWord;
begin
  if (not ReadOnly) and (FByteArray[Index] <> Value) then
  begin
    FByteArray[Index] := Value;
    NewIP := FValue.s_l;
    if Value then begin
      NewIP := NewIP + (1 shl index);
    end else begin
      NewIP := NewIP - (1 shl index);
    end;
    SetAsDoubleWord(NewIP);
  end;
end;

procedure TIpProperty.SetByte(Index: Byte; const Value: Byte);
begin
  if (not ReadOnly) and (GetByte(Index) <> Value) then
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
