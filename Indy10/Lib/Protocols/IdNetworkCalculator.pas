{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11689: IdNetworkCalculator.pas 
{
{   Rev 1.4    10/26/2004 10:33:46 PM  JPMugaas
{ Updated refs.
}
{
{   Rev 1.3    2004.02.03 5:44:08 PM  czhower
{ Name changes
}
{
{   Rev 1.2    24/01/2004 19:27:30  CCostelloe
{ Cleaned up warnings
}
{
{   Rev 1.1    1/21/2004 2:20:26 PM  JPMugaas
{ InitComponent
}
{
{   Rev 1.0    11/13/2002 07:57:46 AM  JPMugaas
}
unit IdNetworkCalculator;

interface

uses
  Classes, IdBaseComponent, IdTStrings;

type

  TIpStruct = record
  case integer of
    0: (Byte4, Byte3, Byte2, Byte1: byte);
    1: (FullAddr: Longword);
  end;

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
    FDoubleWordValue: Longword;

    FAsString: String;
    FAsBinaryString: String;
    FByte3: Byte;
    FByte4: Byte;
    FByte2: Byte;
    FByte1: byte;
    function GetAddressType: TIdIPAddressType;
    procedure SetReadOnly(const Value: boolean);
    procedure SetOnChange(const Value: TNotifyEvent);
    function GetByteArray(Index: cardinal): boolean;
    procedure SetAsBinaryString(const Value: String);
    procedure SetAsDoubleWord(const Value: Longword);
    procedure SetAsString(const Value: String);
    procedure SetByteArray(Index: cardinal; const Value: boolean);
    procedure SetByte4(const Value: Byte);
    procedure SetByte1(const Value: byte);
    procedure SetByte3(const Value: Byte);
    procedure SetByte2(const Value: Byte);
    //
    property ReadOnly: boolean read FReadOnly write SetReadOnly default false;
  public
    procedure SetAll(One, Two, Three, Four: Byte); virtual;
    procedure Assign(Source: Tpersistent); override;
    //
    property ByteArray[Index: cardinal]: boolean read GetByteArray write SetByteArray;
    property AddressType: TIdIPAddressType read GetAddressType;
  published
    property Byte1: byte read FByte1 write SetByte1 stored false;
    property Byte2: Byte read FByte2 write SetByte2 stored false;
    property Byte3: Byte read FByte3 write SetByte3 stored false;
    property Byte4: Byte read FByte4 write SetByte4 stored false;
    property AsDoubleWord: Longword read FDoubleWordValue write SetAsDoubleWord stored false;
    property AsBinaryString: String read FAsBinaryString write SetAsBinaryString stored false;
    property AsString: String read FAsString write SetAsString;
    property OnChange: TNotifyEvent read FOnChange write SetOnChange;
  end;

  TIdNetworkCalculator = class(TIdBaseComponent)
  protected
    FListIP: TIdStrings;
    FNetworkMaskLength: cardinal;
    FNetworkMask: TIpProperty;
    FNetworkAddress: TIpProperty;
    FNetworkClass: TNetworkClass;
    FOnChange: TNotifyEvent;
    FOnGenIPList: TNotifyEvent;
    function GetNetworkClassAsString: String;
    function GetIsAddressRoutable: Boolean;
    procedure SetOnChange(const Value: TNotifyEvent);
    procedure SetOnGenIPList(const Value: TNotifyEvent);
    function GetListIP: TIdStrings;
    procedure SetNetworkAddress(const Value: TIpProperty);
    procedure SetNetworkMask(const Value: TIpProperty);
    procedure SetNetworkMaskLength(const Value: cardinal);
    procedure OnNetMaskChange(Sender: TObject);
    procedure OnNetAddressChange(Sender: TObject);
    procedure InitComponent; override;
  public
    function NumIP: integer;
    function StartIP: String;
    function EndIP: String;
    procedure FillIPList;
    destructor Destroy; override;
    //
    property ListIP: TIdStrings read GetListIP;
    property NetworkClass: TNetworkClass read FNetworkClass;
    property NetworkClassAsString: String read GetNetworkClassAsString;
    property IsAddressRoutable: Boolean read GetIsAddressRoutable;
  published
    function IsAddressInNetwork(Address: String): Boolean;
    property NetworkAddress: TIpProperty read FNetworkAddress write SetNetworkAddress;
    property NetworkMask: TIpProperty read FNetworkMask write SetNetworkMask;
    property NetworkMaskLength: cardinal read FNetworkMaskLength write SetNetworkMaskLength
     default ID_NC_MASK_LENGTH;
    property OnGenIPList: TNotifyEvent read FOnGenIPList write SetOnGenIPList;
    property OnChange: TNotifyEvent read FOnChange write SetOnChange;
  end;

implementation

uses
  IdException, IdGlobal, IdResourceStringsProtocols, IdSysUtils;

{ TIdNetworkCalculator }

function IP(Byte1, Byte2, Byte3, Byte4: byte): TIpStruct;
begin
  result.Byte1 := Byte1;
  result.Byte2 := Byte2;
  result.Byte3 := Byte3;
  result.Byte4 := Byte4;
end;

function StrToIP(const value: string): TIPStruct;
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
    cardBuffers[0] := Sys.StrToInt(strBuffers[0]);
    cardBuffers[1] := Sys.StrToInt(strBuffers[1]);
    cardBuffers[2] := Sys.StrToInt(strBuffers[2]);
    cardBuffers[3] := Sys.StrToInt(strBuffers[3]);
  except
    on e: exception do
      Raise EIdException.Create(Sys.Format( RSNETCALInvalidIPString, [Value]));
  end;
  // range check
  if not(cardBuffers[0] in [0..255]) then
      raise EIdException.Create(Sys.Format( RSNETCALInvalidIPString, [Value]));
  if not(cardBuffers[1] in [0..255]) then
      raise EIdException.Create(Sys.Format( RSNETCALInvalidIPString, [Value]));
  if not(cardBuffers[2] in [0..255]) then
      raise EIdException.Create(Sys.Format( RSNETCALInvalidIPString, [Value]));
  if not(cardBuffers[3] in [0..255]) then
      raise EIdException.Create(Sys.Format( RSNETCALInvalidIPString, [Value]));
  result := IP(cardBuffers[0], cardBuffers[1], cardBuffers[2], cardBuffers[3]);
end;

procedure TIdNetworkCalculator.InitComponent;
begin
  inherited;
  FNetworkMask := TIpProperty.Create;
  FNetworkAddress := TIpProperty.Create;

  FNetworkMask.OnChange := OnNetMaskChange;
  FNetworkAddress.OnChange := OnNetAddressChange;
  FListIP := TIdStringList.Create;
  FNetworkClass := ID_NETWORKCLASS;
  NetworkMaskLength := ID_NC_MASK_LENGTH;
end;

destructor TIdNetworkCalculator.Destroy;
begin
  FNetworkMask.Free;
  FNetworkAddress.Free;
  FListIP.Free;
  inherited;
end;

procedure TIdNetworkCalculator.FillIPList;
var
  i: Cardinal;
  BaseIP: TIpStruct;
begin
  if FListIP.Count = 0 then
  begin
    // prevent to start a long loop in the IDE (will lock delphi)
    if (csDesigning in ComponentState) and (NumIP > 1024) then
    begin
      FListIP.text := Sys.Format(RSNETCALConfirmLongIPList,[NumIP]);
    end
    else
    begin
      BaseIP.FullAddr := NetworkAddress.AsDoubleWord AND NetworkMask.AsDoubleWord;
      // preallocate the memory for the list
      FListIP.Capacity := NumIP;
      // Lock the list so we won't be "repainting" the whole time...    {Do not Localize}
      FListIP.BeginUpdate;
      try
        for i := 1 to (NumIP - 1) do
        begin
          Inc(BaseIP.FullAddr);
          FListIP.append(Sys.Format('%d.%d.%d.%d', [BaseIP.Byte1, BaseIP.Byte2, BaseIP.Byte3, BaseIP.Byte4]));    {Do not Localize}
        end;
      finally
        FListIP.EndUpdate;
      end;
    end;
  end;
end;

function TIdNetworkCalculator.GetListIP: TIdStrings;
begin
  FillIPList;
  result := FListIP;
end;

function TIdNetworkCalculator.IsAddressInNetwork(Address: String): Boolean;
var
  IPStruct: TIPStruct;
begin
  IPStruct := StrToIP(Address);
  result := (IPStruct.FullAddr AND NetworkMask.FDoubleWordValue) = (NetworkAddress.FDoubleWordValue AND NetworkMask.FDoubleWordValue);
end;

procedure TIdNetworkCalculator.OnNetAddressChange(Sender: TObject);
begin
  FListIP.Clear;
  // RFC 1365
  if IndyPos('0', NetworkAddress.AsBinaryString) = 1 then    {Do not Localize}
  begin
    fNetworkClass := ID_NET_CLASS_A;
  end;
  if IndyPos('10', NetworkAddress.AsBinaryString) = 1 then    {Do not Localize}
  begin
    fNetworkClass := ID_NET_CLASS_B;
  end;
  if IndyPos('110', NetworkAddress.AsBinaryString) = 1 then    {Do not Localize}
  begin
    fNetworkClass := ID_NET_CLASS_C;
  end;
  // Network class D is reserved for multicast
  if IndyPos('1110', NetworkAddress.AsBinaryString) = 1 then    {Do not Localize}
  begin
    fNetworkClass := ID_NET_CLASS_D;
  end;
  // network class E is reserved and shouldn't be used    {Do not Localize}
  if IndyPos('1111', NetworkAddress.AsBinaryString) = 1 then    {Do not Localize}
  begin
    fNetworkClass := ID_NET_CLASS_E;
  end;
  if assigned( FOnChange ) then
    FOnChange(Self);
end;

procedure TIdNetworkCalculator.OnNetMaskChange(Sender: TObject);
var
  sBuffer: string;
  InitialMaskLength: Cardinal;
begin
  FListIP.Clear;
  InitialMaskLength := FNetworkMaskLength;
  // A network mask MUST NOT contains holes.
  sBuffer := FNetworkMask.AsBinaryString;
  while (length(sBuffer) > 0) and (sBuffer[1] = '1') do    {Do not Localize}
  begin
    Delete(sBuffer, 1, 1);
  end;    { while }


  if IndyPos('1', sBuffer) > 0 then    {Do not Localize}
  begin
    NetworkMaskLength := InitialMaskLength;
    raise EIdexception.Create(RSNETCALCInvalidNetworkMask); //  'Invalid network mask'    {Do not Localize}
  end
  else
  begin
    // set the net mask length
    NetworkMaskLength := 32 - Length(sBuffer);
  end;
  if assigned( FOnChange ) then
    FOnChange(Self);
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

procedure TIdNetworkCalculator.SetOnGenIPList(const Value: TNotifyEvent);
begin
  FOnGenIPList := Value;
end;

procedure TIdNetworkCalculator.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

function TIdNetworkCalculator.GetNetworkClassAsString: String;
begin
  Case FNetworkClass of
    ID_NET_CLASS_A:
      result := 'A';    {Do not Localize}
    ID_NET_CLASS_B:
      result := 'B';    {Do not Localize}
    ID_NET_CLASS_C:
      result := 'C';    {Do not Localize}
    ID_NET_CLASS_D:
      result := 'D';    {Do not Localize}
    ID_NET_CLASS_E:
      result := 'E';    {Do not Localize}
  end; // case
end;

function TIdNetworkCalculator.GetIsAddressRoutable: Boolean;
begin
  // RFC
  result := (NetworkAddress.Byte1 = 10) or
            ((NetworkAddress.Byte1 = 172) and (NetworkAddress.Byte2 in [16..31])) or
            ((NetworkAddress.Byte1 = 192) and (NetworkAddress.Byte2 = 168));
end;

{ TIpProperty }

procedure TIpProperty.Assign(Source: Tpersistent);
begin
  if Source is TIpProperty then
  with source as TIpProperty do
  begin
    Self.SetAll(Byte1, Byte2, Byte3, Byte4);
  end;    { with }
  if assigned( FOnChange ) then
    FOnChange( Self );
  inherited;
end;

function TIpProperty.GetByteArray(Index: cardinal): boolean;
begin
  result := FByteArray[index]
end;

procedure TIpProperty.SetAll(One, Two, Three, Four: Byte);
var
  i: Integer;
  InitialIP, IpStruct: TIpStruct;
begin
  // Set the individual bytes
  InitialIP := IP(FByte1, FByte2, FByte3, FByte4);
  FByte1 := One;
  FByte2 := Two;
  FByte3 := Three;
  FByte4 := Four;
  // Set the DWord Value
  IpStruct.Byte1 := Byte1;
  IpStruct.Byte2 := Byte2;
  IpStruct.Byte3 := Byte3;
  IpStruct.Byte4 := Byte4;
  FDoubleWordValue := IpStruct.FullAddr;
  // Set the bits array and the binary string
  SetLength(FAsBinaryString, 32);
  // Second, fill the array
  for i := 1 to 32 do
  begin
    FByteArray[i - 1] := ((FDoubleWordValue shl (i-1)) shr 31) = 1;
    if FByteArray[i - 1] then
      FAsBinaryString[i] := '1'    {Do not Localize}
    else
      FAsBinaryString[i] := '0';    {Do not Localize}
  end;
  // Set the string
  FAsString := Sys.Format('%d.%d.%d.%d', [FByte1, FByte2, FByte3, FByte4]);    {Do not Localize}
  IpStruct := IP(FByte1, FByte2, FByte3, FByte4);
  if IpStruct.FullAddr <> InitialIP.FullAddr then
  begin
    if assigned( FOnChange ) then
      FOnChange( self );
  end;
end;

procedure TIpProperty.SetAsBinaryString(const Value: String);
var
  IPStruct: TIPStruct;
  i: Integer;
begin
  if ReadOnly then
    exit;
  if Length(Value) <> 32 then
    raise EIdException.Create(RSNETCALCInvalidValueLength) // 'Invalid value length: Should be 32.'    {Do not Localize}
  else
  begin
    if not TextIsSame( Value, FAsBinaryString) then
    begin
      IPStruct.FullAddr := 0;
      for i := 1 to 32 do
      begin
        if Value[i] <> '0' then    {Do not Localize}
          IPStruct.FullAddr := IPStruct.FullAddr + (1 shl (32 - i));
        SetAll(IPStruct.Byte1, IPStruct.Byte2, IPStruct.Byte3, IPStruct.Byte4);
     end;
    end;
  end;
end;

procedure TIpProperty.SetAsDoubleWord(const Value: Cardinal);
var
  IpStruct: TIpStruct;
begin
  if ReadOnly then
    exit;
  IpStruct.FullAddr := value;
  SetAll(IpStruct.Byte1, IpStruct.Byte2, IpStruct.Byte3, IpStruct.Byte4);
end;

procedure TIpProperty.SetAsString(const Value: String);
var
  IPStruct: TIPStruct;
begin
  if ReadOnly then
    exit;
  IPStruct := StrToIP(value);
  SetAll(IPStruct.Byte1, IPStruct.Byte2, IPStruct.Byte3, IPStruct.Byte4);
end;

procedure TIpProperty.SetByteArray(Index: cardinal; const Value: boolean);
var
  IPStruct: TIpStruct;
begin
  if ReadOnly then
    exit;
  if FByteArray[Index] <> value then
  begin
    FByteArray[Index] := Value;
    IPStruct.FullAddr := FDoubleWordValue;

    if Value then
      IPStruct.FullAddr := IPStruct.FullAddr + (1 shl index)
    else
      IPStruct.FullAddr := IPStruct.FullAddr - (1 shl index);
    SetAll(IPStruct.Byte1, IPStruct.Byte2, IPStruct.Byte3, IPStruct.Byte4);
  end;
end;

procedure TIpProperty.SetByte4(const Value: Byte);
begin
  if ReadOnly then
    exit;
  if FByte4 <> value then
  begin
    FByte4 := Value;
    SetAll(FByte1, FByte2, FByte3, FByte4);
  end;
end;

procedure TIpProperty.SetByte1(const Value: byte);
begin
  if FByte1 <> value then
  begin
    FByte1 := Value;
    SetAll(FByte1, FByte2, FByte3, FByte4);
  end;
end;

procedure TIpProperty.SetByte3(const Value: Byte);
begin
  if FByte3 <> value then
  begin
    FByte3 := Value;
    SetAll(FByte1, FByte2, FByte3, FByte4);
  end;
end;

procedure TIpProperty.SetByte2(const Value: Byte);
begin
  if ReadOnly then
    exit;
  if FByte2 <> value then
  begin
    FByte2 := Value;
    SetAll(FByte1, FByte2, FByte3, FByte4);
  end;
end;

procedure TIpProperty.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

procedure TIpProperty.SetReadOnly(const Value: boolean);
begin
  FReadOnly := Value;
end;

function TIdNetworkCalculator.EndIP: String;
var
  IP: TIpStruct;
begin
  IP.FullAddr := NetworkAddress.AsDoubleWord AND NetworkMask.AsDoubleWord;
  Inc(IP.FullAddr, NumIP - 1);
  result := Sys.Format('%d.%d.%d.%d', [IP.Byte1, IP.Byte2, IP.Byte3, IP.Byte4]);    {Do not Localize}
end;

function TIdNetworkCalculator.NumIP: integer;
begin
  NumIP := 1 shl (32 - NetworkMaskLength);
end;

function TIdNetworkCalculator.StartIP: String;
var
  IP: TIpStruct;
begin
  IP.FullAddr := NetworkAddress.AsDoubleWord AND NetworkMask.AsDoubleWord;
  result := Sys.Format('%d.%d.%d.%d', [IP.Byte1, IP.Byte2, IP.Byte3, IP.Byte4]);    {Do not Localize}
end;

function TIpProperty.GetAddressType: TIdIPAddressType;
// based on http://www.ora.com/reference/dictionary/terms/I/IP_Address.htm
begin
  Result := IPInternetHost;

  case FByte1 of
       {localhost or local network}
    0 : if AsDoubleWord = 0 then
        begin
          Result := IPLocalHost;
        end
        else
        begin
          Result := IPLocalNetwork;
        end;
    {Private network allocations}
    10 : Result := IPPrivateNetwork;
    172 : if Byte2 = 16 then
          begin
            Result := IPPrivateNetwork;
          end;
    192 : if Byte2 = 68 then
          begin
            Result := IPPrivateNetwork;
          end
          else
          begin
            if (Byte2 = 0) and (Byte3 = 0) then
            begin
              Result := IPReserved;
            end;
          end;
    {loopback}
    127 : Result := IPLoopback;
    255 : if AsDoubleWord = $FFFFFFFF then
          begin
            Result := IPGlobalBroadcast;
          end
          else
          begin
            Result := IPFutureUse;
          end;
    {Reserved}
    128 : if Byte2 = 0 then
          begin
            Result := IPReserved;
          end;
    191 : if (Byte2 = 255) and (Byte3 = 255) then
          begin
             Result := IPReserved;
          end;
    223 : if (Byte2 = 255) and (Byte3 = 255) then
          begin
            Result := IPReserved;
          end;
  end;
  {Multicast}
  if (Byte1 >= 224) and (Byte1 <= 239) then
  begin
    Result := IPMulticast;
  end;
  {Future Use}
  if (Byte1 >= 240) and (Byte1 <= 254) then
  begin
    Result := IPFutureUse;
  end;
end;

end.
