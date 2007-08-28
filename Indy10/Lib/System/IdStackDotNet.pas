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
  Rev 1.8    10/26/2004 8:12:30 PM  JPMugaas
  Now uses TIdStrings and TIdStringList for portability.

  Rev 1.7    6/11/2004 8:28:56 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.6    5/14/2004 12:14:50 PM  BGooijen
  Fix for weird dotnet bug when querying the local binding

  Rev 1.5    4/18/04 2:45:54 PM  RLebeau
  Conversion support for Int64 values

  Rev 1.4    2004.03.07 11:45:26 AM  czhower
  Flushbuffer fix + other minor ones found

  Rev 1.3    3/6/2004 5:16:30 PM  JPMugaas
  Bug 67 fixes.  Do not write to const values.

  Rev 1.2    2/10/2004 7:33:26 PM  JPMugaas
  I had to move the wrapper exception here for DotNET stack because Borland's
  update 1 does not permit unlisted units from being put into a package.  That
  now would report an error and I didn't want to move IdExceptionCore into the
  System package.

  Rev 1.1    2/4/2004 8:48:30 AM  JPMugaas
  Should compile.

  Rev 1.0    2004.02.03 3:14:46 PM  czhower
  Move and updates

  Rev 1.32    2/1/2004 6:10:54 PM  JPMugaas
  GetSockOpt.

  Rev 1.31    2/1/2004 3:28:32 AM  JPMugaas
  Changed WSGetLocalAddress to GetLocalAddress and moved into IdStack since
  that will work the same in the DotNET as elsewhere.  This is required to
  reenable IPWatch.

  Rev 1.30    1/31/2004 1:12:54 PM  JPMugaas
  Minor stack changes required as DotNET does support getting all IP addresses
  just like the other stacks.

  Rev 1.29    2004.01.22 2:46:52 PM  czhower
  Warning fixed.

  Rev 1.28    12/4/2003 3:14:54 PM  BGooijen
  Added HostByAddress

  Rev 1.27    1/3/2004 12:22:14 AM  BGooijen
  Added function SupportsIPv6

  Rev 1.26    1/2/2004 4:24:08 PM  BGooijen
  This time both IPv4 and IPv6 work

  Rev 1.25    02/01/2004 15:58:00  HHariri
  fix for bind

  Rev 1.24    12/31/2003 9:52:00 PM  BGooijen
  Added IPv6 support

  Rev 1.23    10/28/2003 10:12:36 PM  BGooijen
  DotNet

  Rev 1.22    10/26/2003 10:31:16 PM  BGooijen
  oops, checked in debug version <g>, this is the right one

  Rev 1.21    10/26/2003 5:04:26 PM  BGooijen
  UDP Server and Client

  Rev 1.20    10/21/2003 11:03:50 PM  BGooijen
  More SendTo, ReceiveFrom

  Rev 1.19    10/21/2003 9:24:32 PM  BGooijen
  Started on SendTo, ReceiveFrom

  Rev 1.18    10/19/2003 5:21:30 PM  BGooijen
  SetSocketOption

  Rev 1.17    10/11/2003 4:16:40 PM  BGooijen
  Compiles again

  Rev 1.16    10/5/2003 9:55:28 PM  BGooijen
  TIdTCPServer works on D7 and DotNet now

  Rev 1.15    10/5/2003 3:10:42 PM  BGooijen
  forgot to clone the Sockets list in some Select methods, + added Listen and
  Accept

  Rev 1.14    10/5/2003 1:52:14 AM  BGooijen
  Added typecasts with network ordering calls, there are required for some
  reason

  Rev 1.13    10/4/2003 10:39:38 PM  BGooijen
  Renamed WSXXX functions in implementation section too

  Rev 1.12    04/10/2003 22:32:00  HHariri
  moving of WSNXXX method to IdStack and renaming of the DotNet ones

  Rev 1.11    04/10/2003 21:28:42  HHariri
  Netowkr ordering functions

  Rev 1.10    10/3/2003 11:02:02 PM  BGooijen
  fixed calls to Socket.Select

  Rev 1.9    10/3/2003 11:39:38 PM  GGrieve
  more work

  Rev 1.8    10/3/2003 12:09:32 AM  BGooijen
  DotNet

  Rev 1.7    10/2/2003 8:23:52 PM  BGooijen
  .net

  Rev 1.6    10/2/2003 8:08:52 PM  BGooijen
  .Connect works not in .net

  Rev 1.5    10/2/2003 7:31:20 PM  BGooijen
  .net

  Rev 1.4    10/2/2003 6:12:36 PM  GGrieve
  work in progress (hardly started)

  Rev 1.3    2003.10.01 9:11:24 PM  czhower
  .Net

  Rev 1.2    2003.10.01 5:05:18 PM  czhower
  .Net

  Rev 1.1    2003.10.01 1:12:40 AM  czhower
  .Net

  Rev 1.0    2003.09.30 10:35:40 AM  czhower
  Initial Checkin
}

unit IdStackDotNet;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal, IdStack, IdStackConsts,
  System.Collections,
   System.IO, System.Net, System.Net.Sockets;

type
  TIdSocketListDotNet = class(TIdSocketList)
  protected
    FSockets: ArrayList;
    function GetItem(AIndex: Integer): TIdStackSocketHandle; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure Add(AHandle: TIdStackSocketHandle); override;
    procedure Remove(AHandle: TIdStackSocketHandle); override;
    function Count: Integer; override;
    procedure Clear; override;
    function Clone: TIdSocketList; override;
    function Contains(AHandle: TIdStackSocketHandle): boolean; override;
    class function Select(AReadList: TIdSocketList; AWriteList: TIdSocketList;
      AExceptList: TIdSocketList; const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
    function SelectRead(const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
    function SelectReadList(var VSocketList: TIdSocketList;
      const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
  end;

  TIdStackDotNet = class(TIdStack)
  protected
    //Stuff for ICMPv6
    {$IFNDEF DOTNET1_1}
    procedure QueryRoute(s : TIdStackSocketHandle; const AIP: String;
      const APort: TIdPort; var VSource, VDest : TIdBytes);
    procedure WriteChecksumIPv6(s: TIdStackSocketHandle;
      var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
      const APort: TIdPort);
    {$ENDIF}
    function ReadHostName: string; override;
    function HostByName(const AHostName: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;
    procedure PopulateLocalAddresses; override;
    //internal IP Mutlicasting membership stuff
    procedure MembershipSockOpt(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String; const ASockOpt : TIdSocketOption;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
  public
    [ThreadStatic]
    LastSocketError: Integer; //static;
    constructor Create; override;
    destructor Destroy; override;
    procedure Bind(ASocket: TIdStackSocketHandle; const AIP: string; const APort: TIdPort;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure Connect(const ASocket: TIdStackSocketHandle; const AIP: string;
      const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure Disconnect(ASocket: TIdStackSocketHandle); override;
    procedure GetPeerName(ASocket: TIdStackSocketHandle; var VIP: string;
      var VPort: TIdPort; var VIPVersion: TIdIPVersion); override;
    procedure GetSocketName(ASocket: TIdStackSocketHandle; var VIP: string;
      var VPort: TIdPort; var VIPVersion: TIdIPVersion); override;
    function WSGetLastError: Integer; override;
    function  NewSocketHandle(const ASocketType: TIdSocketType;
      const AProtocol: TIdSocketProtocol;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION;
      const AOverlapped: Boolean = False) : TIdStackSocketHandle; override;
    // Result:
    // > 0: Number of bytes received
    //   0: Connection closed gracefully
    // Will raise exceptions in other cases
    function Receive(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes) : Integer; override;
    function Send(ASocket: TIdStackSocketHandle; const ABuffer: TIdBytes;
      const AOffset: Integer = 0; const ASize: Integer = -1): Integer; override;
    function IOControl(const s: TIdStackSocketHandle; const cmd: LongWord;
      var arg: LongWord): Integer; override;
    function ReceiveFrom(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes;
      var VIP: string; var VPort: TIdPort;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer; override;
    function ReceiveMsg(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes;
      APkt: TIdPacketInfo; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): LongWord; override;
    function SendTo(ASocket: TIdStackSocketHandle; const ABuffer: TIdBytes;
      const AOffset: Integer; const AIP: string; const APort: TIdPort;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer; override;
    function HostToNetwork(AValue: Word): Word; override;
    function NetworkToHost(AValue: Word): Word; override;
    function HostToNetwork(AValue: LongWord): LongWord; override;
    function NetworkToHost(AValue: LongWord): LongWord; override;
    function HostToNetwork(AValue: Int64): Int64; override;
    function NetworkToHost(AValue: Int64): Int64; override;
    function HostByAddress(const AAddress: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;
    procedure Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer);override;
    function Accept(ASocket: TIdStackSocketHandle; var VIP: string; var VPort: TIdPort;
      var VIPVersion: TIdIPVersion): TIdStackSocketHandle; override;
    procedure GetSocketOption(ASocket: TIdStackSocketHandle; ALevel: TIdSocketOptionLevel;
      AOptName: TIdSocketOption; out AOptVal: Integer); override;
    procedure SetSocketOption(ASocket: TIdStackSocketHandle; ALevel:TIdSocketOptionLevel;
      AOptName: TIdSocketOption; AOptVal: Integer); overload; override;
    function SupportsIPv6: Boolean; override;
    //multicast stuff Kudzu permitted me to add here.
    procedure SetMulticastTTL(AHandle: TIdStackSocketHandle; const AValue : Byte;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure SetLoopBack(AHandle: TIdStackSocketHandle; const AValue: Boolean;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure DropMulticastMembership(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure AddMulticastMembership(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure WriteChecksum(s : TIdStackSocketHandle; var VBuffer : TIdBytes;
      const AOffset : Integer; const AIP : String; const APort : TIdPort;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
  end;
 {$IFDEF DOTNET1_1}
  EIdNotSupportedInMicrosoftNET11 = class(EIdStackError);
 {$ENDIF}

var
 GDotNETStack : TIdStackDotNet = nil;

implementation

uses
  IdException;

const
  IdIPFamily : array[TIdIPVersion] of AddressFamily = (AddressFamily.InterNetwork, AddressFamily.InterNetworkV6);

{ TIdStackDotNet }

function BuildException(AStack: TIdStackDotNet; AException: System.Exception) : EIdException;
var
  LSocketError : System.Net.Sockets.SocketException;
begin
  if AException is System.Net.Sockets.SocketException then
  begin
    LSocketError := AException as System.Net.Sockets.SocketException;
    AStack.LastSocketError := LSocketError.ErrorCode;
    Result := EIdSocketError.CreateError(LSocketError.ErrorCode, LSocketError.Message)
  end else begin
    Result := EIdWrapperException.Create(AException.Message, AException);
  end;
end;

{ TIdStackDotNet }

constructor TIdStackDotNet.Create;
begin
  inherited Create;
  GDotNETStack := Self;
end;

destructor TIdStackDotNet.Destroy; 
begin
  GDotNETStack := nil;
  inherited Destroy;
end;

procedure TIdStackDotNet.Bind(ASocket: TIdStackSocketHandle; const AIP: string;
  const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LEndPoint : IPEndPoint;
  LIP: String;
begin
  try
    LIP := AIP;
    if LIP = '' then begin
      if AIPVersion = Id_IPv4 then begin
        LIP := '0.0.0.0'; {do not localize}
      end
      else if AIPVersion = Id_IPv6 then begin
        LIP := '::'; {do not localize}
      end;
    end;
    LEndPoint := IPEndPoint.Create(IPAddress.Parse(LIP), APort);
    ASocket.Bind(LEndPoint);
  except
    on e: Exception do begin
      raise BuildException(Self, e);
    end;
  end;
end;

procedure TIdStackDotNet.Connect(const ASocket: TIdStackSocketHandle; const AIP: string;
  const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LEndPoint : IPEndPoint;
begin
  try
    LEndPoint := IPEndPoint.Create(IPAddress.Parse(AIP), APort);
    ASocket.Connect(LEndPoint);
  except
    on e: Exception do begin
      raise BuildException(Self, e);
    end;
  end;
end;

procedure TIdStackDotNet.Disconnect(ASocket: TIdStackSocketHandle);
begin
  try
    ASocket.Close;
  except
    on e: Exception do begin
      raise BuildException(Self, e);
    end;
  end;
end;

procedure TIdStackDotNet.Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer);
begin
  try
    ASocket.Listen(ABackLog);
  except
    on e: Exception do begin
      raise BuildException(Self, e);
    end;
  end;
end;

function TIdStackDotNet.Accept(ASocket: TIdStackSocketHandle;
  var VIP: string; var VPort: TIdPort; var VIPVersion: TIdIPVersion): TIdStackSocketHandle;
var
  LEndPoint: IPEndPoint;
begin
  try
    Result := ASocket.Accept();
    LEndPoint := Result.RemoteEndPoint as IPEndPoint;

    if (Result.AddressFamily = AddressFamily.InterNetwork) or
       (Result.AddressFamily = AddressFamily.InterNetworkV6) then
    begin
      VIP := LEndPoint.Address.ToString();
      VPort := LEndPoint.Port;
      if Result.AddressFamily = AddressFamily.InterNetworkV6 then begin
        VIPVersion := Id_IPv6;
      end else begin
        VIPVersion := Id_IPv4;
      end;
    end else
    begin
      Result := Id_INVALID_SOCKET;
      IPVersionUnsupported;
    end;
  except
    on e: Exception do begin
      raise BuildException(Self, e);
    end;
  end;
end;

procedure TIdStackDotNet.GetPeerName(ASocket: TIdStackSocketHandle; var VIP: string;
  var VPort: TIdPort; var VIPVersion: TIdIPVersion);
var
  LEndPoint : IPEndPoint;
begin
  try
    if (ASocket.AddressFamily = AddressFamily.InterNetwork) or
       (ASocket.AddressFamily = AddressFamily.InterNetworkV6) then
    begin
      LEndPoint := ASocket.RemoteEndPoint as IPEndPoint;

      VIP := LEndPoint.Address.ToString;
      VPort := LEndPoint.Port;
      if ASocket.AddressFamily = AddressFamily.InterNetworkV6 then begin
        VIPVersion := Id_IPv6;
      end else begin
        VIPVersion := Id_IPv4;
      end;
    end else begin
      IPVersionUnsupported;
    end;
  except
    on e: Exception do begin
      raise BuildException(Self, e);
    end;
  end;
end;

procedure TIdStackDotNet.GetSocketName(ASocket: TIdStackSocketHandle; var VIP: string;
  var VPort: TIdPort; var VIPVersion: TIdIPVersion);
var
  LEndPoint : IPEndPoint;
begin
  try
    if (ASocket.AddressFamily = AddressFamily.InterNetwork) or
       (ASocket.AddressFamily = AddressFamily.InterNetworkV6) then
    begin
      LEndPoint := ASocket.LocalEndPoint as IPEndPoint;

      VIP := LEndPoint.Address.ToString;
      VPort := LEndPoint.Port;
      if ASocket.AddressFamily = AddressFamily.InterNetworkV6 then begin
        VIPVersion := Id_IPv6;
      end else begin
        VIPVersion := Id_IPv4;
      end;
    end else begin
      IPVersionUnsupported;
    end;
  except
    on e: Exception do begin
      raise BuildException(Self, e);
    end;
  end;
end;

function TIdStackDotNet.HostByName(const AHostName: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
var
  LIP: array of IPAddress;
  a: Integer;
begin
  try
    {
    [Warning] IdStackDotNet.pas(417): W1000 Symbol 'Resolve' is deprecated:
    'Resolve is obsoleted for this type, please use GetHostEntry instead.
    http://go.microsoft.com/fwlink/?linkid=14202'
    }
    {$IFDEF DOTNET2_OR_ABOVE}
    LIP := Dns.GetHostEntry(AHostName).AddressList;
    {$ENDIF}
    {$IFDEF DOTNET1_1}
    LIP := Dns.Resolve(AHostName).AddressList;
    {$ENDIF}
    for a := Low(LIP) to High(LIP) do begin
      if LIP[a].AddressFamily = IdIPFamily[AIPVersion] then begin
        Result := LIP[a].ToString;
        Exit;
      end;
    end;
    raise System.Net.Sockets.SocketException.Create(11001);
  except
    on e: Exception do begin
      raise BuildException(Self, e);
    end;
  end;
end;

function TIdStackDotNet.HostByAddress(const AAddress: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
begin
  try
    {$IFDEF DOTNET2_OR_ABOVE}
    Result := Dns.GetHostEntry(AAddress).HostName;
    {$ENDIF}
    {$IFDEF DOTNET1_1}
    Result := Dns.GetHostByAddress(AAddress).HostName;
    {$ENDIF}
  except
    on e: Exception do begin
      raise BuildException(Self, e);
    end;
  end;
end;

function TIdStackDotNet.WSGetLastError: Integer;
begin
  Result := LastSocketError;
end;

function TIdStackDotNet.NewSocketHandle(const ASocketType: TIdSocketType;
  const AProtocol: TIdSocketProtocol; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION;
  const AOverlapped: Boolean = False): TIdStackSocketHandle;
begin
  try
    Result := Socket.Create(IdIPFamily[AIPVersion], ASocketType, AProtocol);
  except
    on E: Exception do begin
      raise BuildException(Self, E);
    end;
  end;
end;

function TIdStackDotNet.ReadHostName: string;
begin
  try
    Result := System.Net.DNS.GetHostName;
  except
    on E: Exception do begin
      raise BuildException(Self, e);
    end;
  end;
end;

function TIdStackDotNet.Receive(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes): Integer;
begin
  try
    Result := ASocket.Receive(VBuffer, Length(VBuffer), SocketFlags.None);
  except
    on e: Exception do begin
      raise BuildException(Self, e);
    end;
  end;
end;

function TIdStackDotNet.Send(ASocket: TIdStackSocketHandle; const ABuffer: TIdBytes;
  const AOffset: Integer = 0; const ASize: Integer = -1): Integer;
begin
  Result := IndyLength(ABuffer, ASize, AOffset);
  if Result > 0 then begin
    try
      Result := ASocket.Send(ABuffer, AOffset, Result, SocketFlags.None);
    except
      on E: Exception do begin
        raise BuildException(Self, E);
      end;
    end;
  end;
end;

function TIdStackDotNet.ReceiveFrom(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes;
  var VIP: string; var VPort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer;
var
  LEndPoint : EndPoint;
begin
  Result := 0; // to make the compiler happy
  LEndPoint := IPEndPoint.Create(IPAddress.Any, 0);
  try
    try
      Result := ASocket.ReceiveFrom(VBuffer, SocketFlags.None, LEndPoint);
    except
      on e: Exception do begin
        raise BuildException(Self, e);
      end;
    end;
    VIP := IPEndPoint(LEndPoint).Address.ToString;
    VPort := IPEndPoint(LEndPoint).Port;
  finally
    LEndPoint.Free;
  end;
end;

function TIdStackDotNet.SendTo(ASocket: TIdStackSocketHandle; const ABuffer: TIdBytes;
  const AOffset: Integer; const AIP: string; const APort: TIdPort;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer;
var
  LEndPoint : EndPoint;
begin
  Result := IndyLength(ABuffer, -1, AOffset);
  if Result > 0 then
  begin
    LEndPoint := IPEndPoint.Create(IPAddress.Parse(AIP), APort);
    try
      try
        Result := ASocket.SendTo(ABuffer, AOffset, Result, SocketFlags.None, LEndPoint);
      except
        on e: Exception do begin
          raise BuildException(Self, e);
        end;
      end;
    finally
      LEndPoint.Free;
    end;
  end;
end;

//////////////////////////////////////////////////////////////

constructor TIdSocketListDotNet.Create;
begin
  inherited Create;
  FSockets := ArrayList.Create;
end;

destructor TIdSocketListDotNet.Destroy;
begin
  FSockets.Free;
  inherited Destroy;
end;

procedure TIdSocketListDotNet.Add(AHandle: TIdStackSocketHandle);
begin
  FSockets.Add(AHandle);
end;

procedure TIdSocketListDotNet.Clear;
begin
  FSockets.Clear;
end;

function TIdSocketListDotNet.Contains(AHandle: TIdStackSocketHandle): Boolean;
begin
  Result := FSockets.Contains(AHandle);
end;

function TIdSocketListDotNet.Count: Integer;
begin
  Result := FSockets.Count;
end;

function TIdSocketListDotNet.GetItem(AIndex: Integer): TIdStackSocketHandle;
begin
  Result := (FSockets.Item[AIndex]) as TIdStackSocketHandle;
end;

procedure TIdSocketListDotNet.Remove(AHandle: TIdStackSocketHandle);
begin
  FSockets.Remove(AHandle);
end;

const
  cMaxMSPerLoop = MaxInt div 1000; // max milliseconds per Socket.Select() call

function TIdSocketListDotNet.SelectRead(const ATimeout: Integer): Boolean;
var
  LTimeout: Integer;

  function DoSelect(const AInterval: Integer): Boolean;
  var
    LTemp: ArrayList;
  begin
    // DotNet updates this object on return, so we need to copy it each time we need it
    LTemp := ArrayList(FSockets.Clone);
    try
      Socket.Select(LTemp, nil, nil, AInterval);
      Result := LTemp.Count > 0;
    finally
      LTemp.Free;
    end;
  end;

begin
  Result := False;
  try
    // RLebeau 8/27/2007: the .NET docs say that -1 is supposed to
    // cause an infinite timeout, but it doesn't actually work!
    // So loop manually instead until Microsoft fixes it...
    if ATimeout = IdTimeoutInfinite then
    begin
      repeat
        Result := DoSelect(MaxInt);
      until Result;
    end else
    begin
      // RLebeau: Select() accepts a timeout in microseconds, not
      // milliseconds, so have to loop anyway to handle timeouts
      // that are greater then 35 minutes...
      LTimeout := ATimeout;
      while LTimeout >= cMaxMSPerLoop do
      begin
        Result := DoSelect(cMaxMSPerLoop * 1000);
        if Result then begin
          Exit;
        end;
        Dec(LTimeout, cMaxMSPerLoop);
      end;
      if (not Result) and (LTimeout > 0) then begin
        Result := DoSelect(LTimeout * 1000);
      end;
    end;
  except
    on e: ArgumentNullException do begin
      Result := False;
    end;
    on e: Exception do begin
      raise BuildException(GDotNETStack, e);
    end;
  end;
end;

function TIdSocketListDotNet.SelectReadList(var VSocketList: TIdSocketList;
  const ATimeout: Integer): Boolean;
var
  LTemp: ArrayList;
  LTimeout: Integer;

  function DoSelect(const AInterval: Integer; var VList: ArrayList): Boolean;
  var
    LTemp: ArrayList;
  begin
    // DotNet updates this object on return, so we need to copy it each time we need it
    LTemp := ArrayList(FSockets.Clone);
    try
      Socket.Select(LTemp, nil, nil, AInterval);
      Result := LTemp.Count > 0;
      if Result then
      begin
        VList := LTemp;
        LTemp := nil;
      end;
    finally
      LTemp.Free;
    end;
  end;

begin
  Result := False;
  try
    // RLebeau 8/27/2007: the .NET docs say that -1 is supposed to
    // cause an infinite timeout, but it doesn't actually work!
    // So loop manually instead until Microsoft fixes it...
    if ATimeout = IdTimeoutInfinite then
    begin
      repeat
        Result := DoSelect(MaxInt, LTemp);
      until Result;
    end else
    begin
      // RLebeau: Select() accepts a timeout in microseconds, not
      // milliseconds, so have to loop anyway to handle timeouts
      // that are greater then 35 minutes...
      LTimeout := ATimeout;
      while LTimeout >= cMaxMSPerLoop do
      begin
        Result := DoSelect(cMaxMSPerLoop * 1000, LTemp);
        if Result then begin
          Break;
        end;
        Dec(LTimeout, cMaxMSPerLoop);
      end;
      if (not Result) and (LTimeout > 0) then begin
        Result := DoSelect(LTimeout * 1000, LTemp);
      end;
    end;
    if Result then
    begin
      try
        if VSocketList = nil then begin
          VSocketList := TIdSocketList.CreateSocketList;
        end;
        TIdSocketListDotNet(VSocketList).FSockets.Free;
        TIdSocketListDotNet(VSocketList).FSockets := LTemp;
      except
        LTemp.Free;
        raise;
      end;
    end;
  except
    on e: ArgumentNullException do begin
      Result := False;
    end;
    on e: Exception do begin
      raise BuildException(GDotNETStack, e);
    end;
  end;
end;

class function TIdSocketListDotNet.Select(AReadList, AWriteList, AExceptList: TIdSocketList;
  const ATimeout: Integer): Boolean;
var
  LTimeout: Integer;
  LReadTemp, LWriteTemp, LExceptTemp: ArrayList;

  function DoSelect(var VReadList, VWriteList, VExceptList: ArrayList;
    const AInterval: Integer): Boolean;
  var
    LReadTemp: ArrayList;
    LWriteTemp: ArrayList;
    LExceptTemp: ArrayList;
  begin
    LReadTemp := nil;
    LWriteTemp := nil;
    LExceptTemp := nil;

    VReadList := nil;
    VWriteList := nil;
    VExceptList := nil;

    // DotNet updates these objects on return, so we need to copy them each time we need them
    if Assigned(AReadList) and Assigned(TIdSocketListDotNet(AReadList).FSockets) then begin
      LReadTemp := ArrayList(TIdSocketListDotNet(AReadList).FSockets.Clone);
    end;
    try
      if Assigned(AWriteList) and Assigned(TIdSocketListDotNet(AWriteList).FSockets) then begin
        LWriteTemp := ArrayList(TIdSocketListDotNet(AWriteList).FSockets.Clone);
      end;
      try
        if Assigned(AExceptList) and Assigned(TIdSocketListDotNet(AExceptList).FSockets) then begin
          LExceptTemp := ArrayList(TIdSocketListDotNet(AExceptList).FSockets.Clone);
        end;
        try
          Socket.Select(LReadTemp, LWriteTemp, LExceptTemp, AInterval);
          Result := (LReadTemp.Count > 0) or
                    (LWriteTemp.Count > 0) or
                    (LExceptTemp.Count > 0);
          if Result then
          begin
            VReadList := LReadTemp;
            LReadTemp:= nil;

            VWriteList := LWriteTemp;
            LWriteTemp:= nil;

            VExceptList := LExceptTemp;
            LExceptTemp:= nil;
          end;
        finally
          LExceptTemp.Free;
        end;
      finally
        LWriteTemp.Free;
      end;
    finally
      LReadTemp.Free;
    end;
  end;

begin
  Result := False;
  try
    // RLebeau 8/27/2007: the .NET docs say that -1 is supposed to
    // cause an infinite timeout, but it doesn't actually work!
    // So loop manually instead until Microsoft fixes it...
    if ATimeout = IdTimeoutInfinite then
    begin
      repeat
        Result := DoSelect(
          LReadTemp, LWriteTemp, LExceptTemp,
          MaxInt);
      until Result;
    end else
    begin
      // RLebeau: Select() accepts a timeout in microseconds, not
      // milliseconds, so have to loop anyway to handle timeouts
      // that are greater then 35 minutes...
      LTimeout := ATimeout;
      while LTimeout >= cMaxMSPerLoop do
      begin
        Result := DoSelect(
          LReadTemp, LWriteTemp, LExceptTemp,
          cMaxMSPerLoop * 1000);
        if Result then begin
          Break;
        end;
        Dec(LTimeout, cMaxMSPerLoop);
      end;
      if (not Result) and (LTimeout > 0) then
      begin
        Result := DoSelect(
          LReadTemp, LWriteTemp, LExceptTemp,
          LTimeout * 1000);
      end;
    end;
    // RLebeau: this method is meant to update the
    // source lists inlined regardless of the Result...
    if Assigned(AReadList) then
    begin
      TIdSocketListDotNet(AReadList).FSockets.Free;
      TIdSocketListDotNet(AReadList).FSockets := LReadTemp;
    end;
    if Assigned(AWriteList) then
    begin
      TIdSocketListDotNet(AWriteList).FSockets.Free;
      TIdSocketListDotNet(AWriteList).FSockets := LWriteTemp;
    end;
    if Assigned(AExceptList) then
    begin
      TIdSocketListDotNet(AExceptList).FSockets.Free;
      TIdSocketListDotNet(AExceptList).FSockets := LExceptTemp;
    end;
  except
    on e: ArgumentNullException do begin
      Result := False;
    end;
    on e: Exception do begin
      raise BuildException(GDotNETStack, e);
    end;
  end;
end;

function TIdSocketListDotNet.Clone: TIdSocketList;
begin
  Result := TIdSocketListDotNet.Create; //BGO: TODO: make prettier
  TIdSocketListDotNet(Result).FSockets.Free;
  TIdSocketListDotNet(Result).FSockets := ArrayList(FSockets.Clone);
end;

function TIdStackDotNet.HostToNetwork(AValue: Word): Word;
begin
  Result := Word(IPAddress.HostToNetworkOrder(SmallInt(AValue)));
end;

function TIdStackDotNet.HostToNetwork(AValue: LongWord): LongWord;
begin
  Result := LongWord(IPAddress.HostToNetworkOrder(integer(AValue)));
end;

function TIdStackDotNet.HostToNetwork(AValue: Int64): Int64;
begin
  Result := IPAddress.HostToNetworkOrder(AValue);
end;

function TIdStackDotNet.NetworkToHost(AValue: Word): Word;
begin
  Result := Word(IPAddress.NetworkToHostOrder(SmallInt(AValue)));
end;

function TIdStackDotNet.NetworkToHost(AValue: LongWord): LongWord;
begin
  Result := LongWord(IPAddress.NetworkToHostOrder(Integer(AValue)));
end;

function TIdStackDotNet.NetworkToHost(AValue: Int64): Int64;
begin
  Result := IPAddress.NetworkToHostOrder(AValue);
end;

procedure TIdStackDotNet.GetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption; out AOptVal: Integer);
var
  L : System.Object;
begin
  L := ASocket.GetSocketOption(ALevel, AoptName);
  AOptVal := Integer(L);
end;

procedure TIdStackDotNet.SetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption; AOptVal: Integer);
begin
  ASocket.SetSocketOption(ALevel, AOptName, AOptVal);
end;

function TIdStackDotNet.SupportsIPv6: Boolean;
begin
  {
  [Warning] IdStackDotNet.pas(734): W1000 Symbol 'SupportsIPv6' is deprecated:
  'SupportsIPv6 is obsoleted for this type, please use OSSupportsIPv6 instead.
  http://go.microsoft.com/fwlink/?linkid=14202'
  }
  {$IFDEF DOTNET2_OR_ABOVE}
  Result := Socket.OSSupportsIPv6;
  {$ENDIF}
  {$IFDEF DOTNET1_1}
  Result := Socket.SupportsIPv6;
  {$ENDIF}
end;

procedure TIdStackDotNet.PopulateLocalAddresses;
var
  {$IFDEF DOTNET1_1}
  LAddr : IPAddress;
  {$ENDIF}
  LHost : IPHostEntry;
  i : Integer;
begin
  {$IFDEF DOTNET2_OR_ABOVE}
  LHost := DNS.GetHostEntry(DNS.GetHostName);
  {$ENDIF}
  {$IFDEF DOTNET1_1}
  LAddr := IPAddress.Any;
  LHost := DNS.GetHostByAddress(LAddr);
  {$ENDIF}
  if Length(LHost.AddressList) > 0 then
  begin
    for i := Low(LHost.AddressList) to High(LHost.AddressList) do
    begin
      //This may be returning various types of addresses.
      if LHost.AddressList[i].AddressFamily = AddressFamily.InterNetwork then begin
        FLocalAddresses.Add(LHost.AddressList[i].ToString);
      end;
    end;
  end;
end;

procedure TIdStackDotNet.SetLoopBack(AHandle: TIdStackSocketHandle;
  const AValue: Boolean; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  //necessary because SetSocketOption only accepts an integer
  //see: http://groups-beta.google.com/group/microsoft.public.dotnet.languages.csharp/browse_thread/thread/6a35c6d9052cfc2b/f01fea11f9a24508?q=SetSocketOption+DotNET&rnum=2&hl=en#f01fea11f9a24508
  AHandle.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.MulticastLoopback, iif(AValue, 1, 0));
end;

procedure TIdStackDotNet.DropMulticastMembership(AHandle: TIdStackSocketHandle;
  const AGroupIP, ALocalIP: String; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  MembershipSockOpt(AHandle, AGroupIP, ALocalIP, SocketOptionName.DropMembership);
end;

procedure TIdStackDotNet.AddMulticastMembership(AHandle: TIdStackSocketHandle;
  const AGroupIP, ALocalIP: String; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  MembershipSockOpt(AHandle, AGroupIP, ALocalIP, SocketOptionName.AddMembership);
end;

procedure TIdStackDotNet.SetMulticastTTL(AHandle: TIdStackSocketHandle;
  const AValue: Byte; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  if AIPVersion = Id_IPv4 then begin
    AHandle.SetSocketOption(SocketOptionLevel.IP, SocketOptionName.MulticastTimeToLive, AValue);
  end else begin
    AHandle.SetSocketOption(SocketOptionLevel.IPv6, SocketOptionName.MulticastTimeToLive, AValue);
  end;
end;

procedure TIdStackDotNet.MembershipSockOpt(AHandle: TIdStackSocketHandle;
  const AGroupIP, ALocalIP: String; const ASockOpt: TIdSocketOption;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LM4 : MulticastOption;
  LM6 : IPv6MulticastOption;
  LGroupIP, LLocalIP : System.Net.IPAddress;
begin
  LGroupIP := IPAddress.Parse(AGroupIP);
  if LGroupIP.AddressFamily = AddressFamily.InterNetworkV6 then
  begin
    LM6  := IPv6MulticastOption.Create(LGroupIP);
    AHandle.SetSocketOption(SocketOptionLevel.IPv6, SocketOptionName.AddMembership, LM6);
  end else
  begin
    if ALocalIP.Length = 0 then begin
      LM4 := System.Net.Sockets.MulticastOption.Create(LGroupIP);
    end else
    begin
      LLocalIP := IPAddress.Parse(ALocalIP);
      LM4 := System.Net.Sockets.MulticastOption.Create(LGroupIP, LLocalIP);
    end;
    AHandle.SetSocketOption(SocketOptionLevel.IP, ASockOpt, LM4);
  end;
end;

function TIdStackDotNet.ReceiveMsg(ASocket: TIdStackSocketHandle;
  var VBuffer: TIdBytes; APkt: TIdPacketInfo;
  const AIPVersion: TIdIPVersion): LongWord;
var
  {$IFDEF DOTNET1_1}
  LIP : String;
  LPort : TIdPort;
  {$ELSE}
  LSF : SocketFlags;
  LRemEP : EndPoint;
  LPki : IPPacketInformation;
  {$ENDIF}
begin
  {$IFDEF DOTNET1_1}
  Result := ReceiveFrom(ASocket, VBuffer, LIP, LPort, AIPVersion);
  APkt.SourceIP := LIP;
  APkt.SourcePort := LPort;
  {$ELSE}
  LSF := SocketFlags.None;
  {
  The AddressFamily of the EndPoint used in ReceiveFrom needs to match the
   AddressFamily of the EndPoint used in SendTo.
   }
  case AIPVersion of
  Id_IPv4 :
    begin
      LRemEP := IPEndPoint.Create(IPAddress.Parse('0.0.0.0'),0);
    end;
  Id_IPv6 :
    begin
      LRemEP := IPEndPoint.Create(IPAddress.Parse('::0'),0);
    end;
  end;
  Result := ASocket.ReceiveMessageFrom(VBuffer, 0, Length(VBUffer), LSF, LRemEP, lpki);
  APkt.SourceIP := IPEndPoint(LRemEP).Address.ToString;
  APkt.SourcePort := IPEndPoint(LRemEP).Port;
  APkt.DestIP := LPki.Address.ToString;
  APkt.DestIF := LPki.&Interface;
  {$ENDIF}
end;

{$IFNDEF DOTNET1_1}
const
  SIO_ROUTING_INTERFACE_QUERY = 3355443220;

{
This extracts an IP address as a series of bytes from a TIdBytes that contains
one SockAddress structure.
}
procedure SockAddrToIPBytes(const ASockAddr : TIdBytes; var VIPAddr : TIdBytes);
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  case IdGlobal.BytesToWord(ASockAddr,0) of
    23 : //AddressFamily.InterNetworkV6 :
    begin
      //16 = size of SOCKADDR_IN6.sin6_addr
      SetLength(VIPAddr,16);
//    8 = offset of sin6_addr in SOCKADDR_IN6
//    sin6_family   : Smallint;         // AF_INET6
//    sin6_port     : u_short;          // Transport level port number
//    sin6_flowinfo : u_long;           // IPv6 flow information

      System.array.Copy(ASockAddr,8, VIPAddr, 0, 16);
    end;
    2 : //AddressFamily.InterNetwork :
    begin
      //size of sockaddr_in.sin_addr
      SetLength(VIPAddr,4);
//  4 = offset of  sockaddr_in.sin_addr
//  sin_family : u_short;
//  sin_port   : u_short;
      System.array.Copy(ASockAddr,4, VIPAddr, 0, 4);
    end;
  end;
end;

procedure TIdStackDotNet.QueryRoute(s : TIdStackSocketHandle; const AIP: String;
  const APort: TIdPort; var VSource, VDest : TIdBytes);
var
  LEP : IPEndPoint;
  LDestIF : SocketAddress;
  LIn, LOut : TBytes;
  i : Integer;
begin
  LEP := IPEndPoint.Create(IPAddress.Parse(AIP),APort);
  LDestIf := LEP.Serialize;
{
The first 2 bytes of the underlying buffer are reserved for the AddressFamily
enumerated value. When the SocketAddress is used to store a serialized
IPEndPoint, the third and fourth bytes are used to store port number
information. The next bytes are used to store the IP address. You can access any
information within this underlying byte buffer by referring to its index
position; the byte buffer uses zero-based indexing. You can also use the Family
and Size properties to get the AddressFamily value and the buffer size,
respectively. To view any of this information as a string, use the ToString
method.
}
  SetLength(LIn,LDestIf.Size);
  for i := 0 to LDestIf.Size - 1 do
  begin
    LIn[i] := LDestIf[i];
  end;
  SetLength(LOut,LDestIf.Size);
{
IMPORTANT!!!!

We can not do something like:

 s.IOControl( IOControlCode.RoutingInterfaceQuery, LIn, LOut);

 because to IOControlCode.RoutingInterfaceQuery has a value of -539371432
 and that is not correct.  I found that out the hard way.
}
  s.IOControl(LongInt(SIO_ROUTING_INTERFACE_QUERY),Lin,LOut);
  SockAddrToIPBytes(LOut,VSource);
  SockAddrToIPBytes(LIn,VDest);
end;

procedure TIdStackDotNet.WriteChecksumIPv6(s: TIdStackSocketHandle;
  var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
  const APort: TIdPort);
var 
  LSource : TIdBytes;
  LDest : TIdBytes;
  LTmp : TIdBytes;
  LIdx : Integer;
  LC : LongWord;
  LW : Word;
{
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                                                               |
   +                                                               +
   |                                                               |
   +                         Source Address                        +
   |                                                               |
   +                                                               +
   |                                                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                                                               |
   +                                                               +
   |                                                               |
   +                      Destination Address                      +
   |                                                               |
   +                                                               +
   |                                                               |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                   Upper-Layer Packet Length                   |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
   |                      zero                     |  Next Header  |
   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
}
begin

  QueryRoute(s, AIP, APort, LSource, LDest);
  SetLength(LTmp, Length(VBuffer)+40);
  System.&Array.Clear(LTmp,0,Length(LTmp));
  //16
  CopyTIdBytes(LSource, 0, LTmp, 0, 16);
  LIdx := 16;
  //32
  CopyTIdBytes(LDest, 0, LTmp,LIdx, 16);
  Inc(LIdx, 16);
  //use a word so you don't wind up using the wrong network byte order function
  LC := Length(VBuffer);
  CopyTIdLongWord(GStack.HostToNetwork(LC), LTmp, LIdx);
  Inc(LIdx, 4);
  //36
  //zero the next three bytes
  //done in the begging
  Inc(LIdx, 3);
  //next header (protocol type determines it
  LTmp[LIdx] := Ord(Id_IPPROTO_ICMPv6);
  Inc(LIdx);
  //zero our checksum feild for now
  VBuffer[2] := 0;
  VBuffer[3] := 0;
  //combine the two
  CopyTIdBytes(VBuffer, 0, LTmp, LIdx, Length(VBuffer));
  LW := CalcCheckSum(LTmp);

  CopyTIdWord(HostToLittleEndian(LW), VBuffer, AOffset);
end;
{$ENDIF}

procedure TIdStackDotNet.WriteChecksum(s: TIdStackSocketHandle;
  var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
  const APort: TIdPort; const AIPVersion: TIdIPVersion);
begin
  if AIPVersion = Id_IPv4 then begin
    CopyTIdWord(CalcCheckSum(VBuffer), VBuffer, AOffset);
  end else
  begin
    {$IFDEF DOTNET1_1}
    {This is a todo because to do a checksum for ICMPv6, you need to obtain
    the address for the IP the packet will come from (query the network interfaces).
    You then have to make a IPv6 pseudo header.  About the only other alternative is
    to have the kernel (or DotNET Framework) generate the checksum but we don't have
    an API for it.

    I'm not sure if we have an API for it at all.  Even if we did, would it be worth
    doing when you consider that Microsoft's NET Framework 1.1 does not support ICMPv6
    in its enumerations.}
    raise EIdNotSupportedInMicrosoftNET11.Create(RSNotSupportedInMicrosoftNET11);
    {$ELSE}
    WriteChecksumIPv6(s,VBuffer,AOffset,AIP,APort);
    {$ENDIF}
  end;
end;

function TIdStackDotNet.IOControl(const s: TIdStackSocketHandle;
  const cmd: LongWord; var arg: LongWord): Integer;
var
  LTmp : TIdBytes;
begin
  LTmp := ToBytes(arg);
  s.IOControl(cmd, ToBytes(arg), LTmp);
  arg := BytesToLongWord(LTmp);
  Result := 0;
end;

{$IFDEF DOTNET2_OR_ABOVE}
function ServeFile(ASocket: TIdStackSocketHandle; AFileName: string): Int64;
var
  LFile : FileInfo;
begin
  ASocket.SendFile(AFileName);
  LFile := System.IO.FileInfo.Create(AFileName);
  Result := LFile.Length;
end;
{$ENDIF}

initialization
  GSocketListClass := TIdSocketListDotNet;
  {$IFDEF DOTNET2_OR_ABOVE}
  GServeFileProc := ServeFile;
  {$ENDIF}
end.
