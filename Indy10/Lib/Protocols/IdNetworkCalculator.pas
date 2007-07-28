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
  TNetworkClass = (ID_NET_CLASS_A, ID_NET_CLASS_B, ID_NET_CLASS_C,
    ID_NET_CLASS_D, ID_NET_CLASS_E);

const
  ID_NC_MASK_LENGTH = 32;
  ID_NETWORKCLASS = ID_NET_CLASS_A;

type
  TIdIPAddressType = (IPLocalHost, IPLocalNetwork, IPReserved, IPInternetHost,
    IPPrivateNetwork, IPLoopback, IPMulticast, IPFutureUse, IPGlobalBroadcast);

  TIpProperty = Class(TPersistent)
  protected
    FReadOnly: boolean;
    FOnChange: TNotifyEvent;
    FByteArray: array[0..31] of boolean;
    FDoubleWordValue: LongWord;

    FAsString: String;
    FAsBinaryString: String;
    FByte3: Byte;
    FByte4: Byte;
    FByte2: Byte;
    FByte1: byte;
    function GetAddressType: TIdIPAddressType;
    function GetByteArray(Index: cardinal): boolean;
    procedure SetAsBinaryString(const Value: String);
    procedure SetAsDoubleWord(const Value: LongWord);
    procedure SetAsString(const Value: String);
    procedure SetByteArray(Index: cardinal; const Value: boolean);
    procedure SetByte4(const Value: Byte);
    procedure SetByte1(const Value: byte);
    procedure SetByte3(const Value: Byte);
    procedure SetByte2(const Value: Byte);
    //
    property ReadOnly: boolean read FReadOnly write FReadOnly default false;
  public
    procedure SetAll(One, Two, Three, Four: Byte); virtual;
    procedure Assign(Source: TPersistent); override;
    //
    property ByteArray[Index: cardinal]: boolean read GetByteArray write SetByteArray;
    property AddressType: TIdIPAddressType read GetAddressType;
  published
    property Byte1: byte read FByte1 write SetByte1 stored false;
    property Byte2: Byte read FByte2 write SetByte2 stored false;
    property Byte3: Byte read FByte3 write SetByte3 stored false;
    property Byte4: Byte read FByte4 write SetByte4 stored false;
    property AsDoubleWord: LongWord read FDoubleWordValue write SetAsDoubleWord stored false;
    property AsBinaryString: String read FAsBinaryString write SetAsBinaryString stored false;
    property AsString: String read FAsString write SetAsString;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

  TIdNetworkCalculator = class(TIdBaseComponent)
  protected
    FListIP: TStrings;
    FNetworkMaskLength: cardinal;
    FNetworkMask: TIpProperty;
    FNetworkAddress: TIpProperty;
    FNetworkClass: TNetworkClass;
    FOnChange: TNotifyEvent;
    FOnGenIPList: TNotifyEvent;
    function GetNetworkClassAsString: String;
    function GetIsAddressRoutable: Boolean;
    function GetListIP: TStrings;
    procedure SetNetworkAddress(const Value: TIpProperty);
    procedure SetNetworkMask(const Value: TIpProperty);
    procedure SetNetworkMaskLength(const Value: cardinal);
    procedure NetMaskChanged(Sender: TObject);
    procedure NetAddressChanged(Sender: TObject);
    procedure InitComponent; override;
  public
    function NumIP: integer;
    function StartIP: String;
    function EndIP: String;
    procedure FillIPList;
    destructor Destroy; override;
    //
    property ListIP: TStrings read GetListIP;
    property NetworkClass: TNetworkClass read FNetworkClass;
    property NetworkClassAsString: String read GetNetworkClassAsString;
    property IsAddressRoutable: Boolean read GetIsAddressRoutable;
  published
    function IsAddressInNetwork(const Address: String): Boolean;
    property NetworkAddress: TIpProperty read FNetworkAddress write SetNetworkAddress;
    property NetworkMask: TIpProperty read FNetworkMask write SetNetworkMask;
    property NetworkMaskLength: cardinal read FNetworkMaskLength write SetNetworkMaskLength
     default ID_NC_MASK_LENGTH;
    property OnGenIPList: TNotifyEvent read FOnGenIPList write FOnGenIPList;
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
  end;

implementation

uses
  IdException, IdGlobal, IdResourceStringsProtocols, IdStruct, SysUtils;

{ TIdNetworkCalculator }

procedure ToIP(Byte1, Byte2, Byte3, Byte4: Byte; AIP: TIdLongWord);
begin
  AIP.s_b1 := Byte1;
  AIP.s_b2 := Byte2;
  AIP.s_b3 := Byte3;
  AIP.s_b4 := Byte4;
end;

procedure StrToIP(const Value: string; AIP: TIdLongWord);
var
  strBuffers: Array [0..3] of String;
  cardBuffers: Array[0..3] of cardinal;
  StrWork: String;
begin
  StrWork := Value;
  // Separate the strings
  strBuffers[0] := Fetch(StrWork, '.', true);    {Do not Localize}
  strBuffers[1] := Fetch(StrWork, '.', true);    {Do not Localize}
  strBuffers[2] := Fetch(StrWork, '.', true);    {Do not Localize}
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
  AIP.s_b1 := cardBuffers[0];
  AIP.s_b2 := cardBuffers[1];
  AIP.s_b3 := cardBuffers[2];
  AIP.s_b4 := cardBuffers[3];
end;

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
  i: Cardinal;
  BaseIP: TIdLongWord;
begin
  if FListIP.Count = 0 then
  begin
    // prevent to start a long loop in the IDE (will lock delphi)
    if IsDesignTime and (NumIP > 1024) then begin
      FListIP.text := IndyFormat(RSNETCALConfirmLongIPList, [NumIP]);
    end else
    begin
      BaseIP := TIdLongWord.Create;
      try
        BaseIP.s_l := NetworkAddress.AsDoubleWord and NetworkMask.AsDoubleWord;
        // preallocate the memory for the list
        FListIP.Capacity := NumIP;
        // Lock the list so we won't be "repainting" the whole time...    {Do not Localize}
        FListIP.BeginUpdate;
        try
          for i := 1 to (NumIP - 1) do
          begin
            BaseIP.s_l := BaseIP.s_l + 1;
            FListIP.append(IndyFormat('%d.%d.%d.%d', [BaseIP.s_b1, BaseIP.s_b2, BaseIP.s_b3, BaseIP.s_b4]));    {Do not Localize}
          end;
        finally
          FListIP.EndUpdate;
        end;
      finally
        FreeAndNil(BaseIP);
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
var
  IP: TIdLongWord;
begin
  IP := TIdLongWord.Create;
  try
    StrToIP(Address, IP);
    Result := (IP.s_l and NetworkMask.AsDoubleWord) = (NetworkAddress.AsDoubleWord and NetworkMask.AsDoubleWord);
  finally
    FreeAndNil(IP);
  end;
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
  InitialMaskLength: Cardinal;
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

procedure TIdNetworkCalculator.SetNetworkMaskLength(const Value: cardinal);
var
  LBuffer: Cardinal;
begin
  FNetworkMaskLength := Value;
  if Value > 0 then begin
    LBuffer := High(Cardinal) shl (32 - Value);
  end else begin
    LBuffer := 0;
  end;
  FNetworkMask.AsDoubleWord := LBuffer;
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
  Result := (NetworkAddress.Byte1 = 10) or
            ((NetworkAddress.Byte1 = 172) and (NetworkAddress.Byte2 in [16..31])) or
            ((NetworkAddress.Byte1 = 192) and (NetworkAddress.Byte2 = 168));
end;

{ TIpProperty }

procedure TIpProperty.Assign(Source: TIdPersistent);
begin
  if Source is TIpProperty then
  begin
    with Source as TIpProperty do
    begin
      Self.SetAll(Byte1, Byte2, Byte3, Byte4);
    end;
  end else begin
    inherited Assign(Source);
  end;
end;

function TIpProperty.GetByteArray(Index: cardinal): boolean;
begin
  Result := FByteArray[index]
end;

procedure TIpProperty.SetAll(One, Two, Three, Four: Byte);
var
  i: Integer;
  InitialIP, NewIP: TIdLongWord;
begin
  NewIP := TIdLongWord.Create;
  try
    ToIP(One, Two, Three, Four, NewIP);
    InitialIP := TIdLongWord.Create;
    try
      ToIP(FByte1, FByte2, FByte3, FByte4, InitialIP);
      if NewIP.s_l = InitialIP.s_l then begin
        Exit;
      end;
    finally
      FreeAndNil(InitialIP);
    end;
    FDoubleWordValue := NewIP.s_l;
  finally
    FreeAndNil(NewIP);
  end;
  // Set the individual bytes
  FByte1 := One;
  FByte2 := Two;
  FByte3 := Three;
  FByte4 := Four;
  // Set the bits array and the binary string
  SetLength(FAsBinaryString, 32);
  // Second, fill the array
  for i := 1 to 32 do
  begin
    FByteArray[i - 1] := ((FDoubleWordValue shl (i-1)) shr 31) = 1;
    if FByteArray[i - 1] then begin
      FAsBinaryString[i] := '1'    {Do not Localize}
    end else begin
      FAsBinaryString[i] := '0';    {Do not Localize}
    end;
  end;
  // Set the string
  FAsString := IndyFormat('%d.%d.%d.%d', [FByte1, FByte2, FByte3, FByte4]);    {Do not Localize}
  if Assigned(FOnChange) then begin
    FOnChange(Self);
  end;
end;

procedure TIpProperty.SetAsBinaryString(const Value: String);
var
  NewIP: TIdLongWord;
  i: Integer;
begin
  if ReadOnly then begin
    Exit;
  end;
  if Length(Value) <> 32 then begin
    raise EIdException.Create(RSNETCALCInvalidValueLength) // 'Invalid value length: Should be 32.'    {Do not Localize}
  end;
  if not TextIsSame(Value, FAsBinaryString) then
  begin
    NewIP := TIdLongWord.Create;
    try
      NewIP.s_l := 0;
      for i := 1 to 32 do
      begin
        if Value[i] <> '0' then begin    {Do not Localize}
          NewIP.s_l := NewIP.s_l + (1 shl (32 - i));
        end;
        SetAll(NewIP.s_b1, NewIP.s_b2, NewIP.s_b3, NewIP.s_b4);
      end;
    finally
      FreeAndNil(NewIP);
    end;
  end;
end;

procedure TIpProperty.SetAsDoubleWord(const Value: LongWord);
var
  NewIP: TIdLongWord;
begin
  if ReadOnly then begin
    Exit;
  end;
  NewIP := TIdLongWord.Create;
  try
    NewIP.s_l := Value;
    SetAll(NewIP.s_b1, NewIP.s_b2, NewIP.s_b3, NewIP.s_b4);
  finally
    FreeAndNil(NewIP);
  end;
end;

procedure TIpProperty.SetAsString(const Value: String);
var
  NewIP: TIdLongWord;
begin
  if ReadOnly then begin
    Exit;
  end;
  NewIP := TIdLongWord.Create;
  try
    StrToIP(Value, NewIP);
    SetAll(NewIP.s_b1, NewIP.s_b2, NewIP.s_b3, NewIP.s_b4);
  finally
    FreeAndNil(NewIP);
  end;
end;

procedure TIpProperty.SetByteArray(Index: cardinal; const Value: Boolean);
var
  NewIP: TIdLongWord;
begin
  if ReadOnly then begin
    Exit;
  end;
  if FByteArray[Index] <> Value then
  begin
    FByteArray[Index] := Value;
    NewIP := TIdLongWord.Create;
    try
      NewIP.s_l := FDoubleWordValue;
      if Value then begin
        NewIP.s_l := NewIP.s_l + (1 shl index);
      end else begin
        NewIP.NewIP.s_l := NewIP.NewIP.s_l - (1 shl index);
      end;
      SetAll(NewIP.s_b1, NewIP.s_b2, NewIP.s_b3, NewIP.s_b4);
    end;
  end;
end;

procedure TIpProperty.SetByte4(const Value: Byte);
begin
  if ReadOnly then begin
    Exit;
  end;
  if FByte4 <> Value then
  begin
    FByte4 := Value;
    SetAll(FByte1, FByte2, FByte3, FByte4);
  end;
end;

procedure TIpProperty.SetByte1(const Value: byte);
begin
  if FByte1 <> Value then
  begin
    FByte1 := Value;
    SetAll(FByte1, FByte2, FByte3, FByte4);
  end;
end;

procedure TIpProperty.SetByte3(const Value: Byte);
begin
  if FByte3 <> Value then
  begin
    FByte3 := Value;
    SetAll(FByte1, FByte2, FByte3, FByte4);
  end;
end;

procedure TIpProperty.SetByte2(const Value: Byte);
begin
  if ReadOnly then begin
    Exit;
  end;
  if FByte2 <> Value then
  begin
    FByte2 := Value;
    SetAll(FByte1, FByte2, FByte3, FByte4);
  end;
end;

function TIdNetworkCalculator.EndIP: String;
var
  IP: TIdLongWord;
begin
  IP := TIdLongWord.Create;
  try
    IP.s_l := NetworkAddress.AsDoubleWord and NetworkMask.AsDoubleWord;
    IP.s_l := IP.s_l + (NumIP - 1);
    Result := IndyFormat('%d.%d.%d.%d', [IP.s_b1, IP.s_b2, IP.s_b3, IP.s_b4]);    {Do not Localize}
  finally
    FreeAndNil(IP);
  end;
end;

function TIdNetworkCalculator.NumIP: integer;
begin
  NumIP := 1 shl (32 - NetworkMaskLength);
end;

function TIdNetworkCalculator.StartIP: String;
var
  IP: TIdLongWord;
begin
  IP := TIdLongWord;
  try
    IP.s_l := NetworkAddress.AsDoubleWord and NetworkMask.AsDoubleWord;
    Result := IndyFormat('%d.%d.%d.%d', [IP.s_b1, IP.s_b2, IP.s_b3, IP.s_b4]);    {Do not Localize}
  finally
    FreeAndNil(IP);
  end;
end;

function TIpProperty.GetAddressType: TIdIPAddressType;
// based on http://www.ora.com/reference/dictionary/terms/I/IP_Address.htm
begin
  Result := IPInternetHost;

  case FByte1 of
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
    192 : if Byte2 = 68 then begin
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
  end;
  {Multicast}
  if (Byte1 >= 224) and (Byte1 <= 239) then begin
    Result := IPMulticast;
  end;
  {Future Use}
  if (Byte1 >= 240) and (Byte1 <= 254) then begin
    Result := IPFutureUse;
  end;
end;

end.
