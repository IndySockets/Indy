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
{   Rev 1.8    10/26/2004 8:20:04 PM  JPMugaas
{ Fixed some oversights with conversion.  OOPS!!!
}
{
{   Rev 1.7    07/06/2004 21:31:24  CCostelloe
{ Kylix 3 changes
}
{
{   Rev 1.6    4/18/04 10:43:24 PM  RLebeau
{ Fixed syntax error
}
{
{   Rev 1.5    4/18/04 10:29:58 PM  RLebeau
{ Renamed Int64Parts structure to TIdInt64Parts
}
{
{   Rev 1.4    4/18/04 2:47:46 PM  RLebeau
{ Conversion support for Int64 values
}
{
{   Rev 1.3    2004.03.07 11:45:28 AM  czhower
{ Flushbuffer fix + other minor ones found
}
{
{   Rev 1.2    3/6/2004 5:16:34 PM  JPMugaas
{ Bug 67 fixes.  Do not write to const values.
}
{
{   Rev 1.1    3/6/2004 4:23:52 PM  JPMugaas
{ Error #62 fix.  This seems to work in my tests.
}
{
{   Rev 1.0    2004.02.03 3:14:48 PM  czhower
{ Move and updates
}
{
{   Rev 1.33    2/1/2004 6:10:56 PM  JPMugaas
{ GetSockOpt.
}
{
{   Rev 1.32    2/1/2004 3:28:36 AM  JPMugaas
{ Changed WSGetLocalAddress to GetLocalAddress and moved into IdStack since
{ that will work the same in the DotNET as elsewhere.  This is required to
{ reenable IPWatch.
}
{
{   Rev 1.31    1/31/2004 1:12:48 PM  JPMugaas
{ Minor stack changes required as DotNET does support getting all IP addresses
{ just like the other stacks.
}
{
{   Rev 1.30    12/4/2003 3:14:52 PM  BGooijen
{ Added HostByAddress
}
{
{   Rev 1.29    1/3/2004 12:38:56 AM  BGooijen
{ Added function SupportsIPv6
}
{
{   Rev 1.28    12/31/2003 9:52:02 PM  BGooijen
{ Added IPv6 support
}
{
{   Rev 1.27    10/26/2003 05:33:14 PM  JPMugaas
{ LocalAddresses should work.
}
{
{   Rev 1.26    10/26/2003 5:04:28 PM  BGooijen
{ UDP Server and Client
}
{
{   Rev 1.25    10/26/2003 09:10:26 AM  JPMugaas
{ Calls necessary for IPMulticasting.
}
{
{   Rev 1.24    10/22/2003 04:40:52 PM  JPMugaas
{ Should compile with some restored functionality.  Still not finished.
}
{
{   Rev 1.23    10/21/2003 11:04:20 PM  BGooijen
{ Fixed name collision
}
{
{   Rev 1.22    10/21/2003 01:20:02 PM  JPMugaas
{ Restore GWindowsStack because it was needed by SuperCore.
}
{
{   Rev 1.21    10/21/2003 06:24:28 AM  JPMugaas
{ BSD Stack now have a global variable for refercing by platform specific
{ things.  Removed corresponding var from Windows stack.
}
{
{   Rev 1.20    10/19/2003 5:21:32 PM  BGooijen
{ SetSocketOption
}
{
{   Rev 1.19    2003.10.11 5:51:16 PM  czhower
{ -VCL fixes for servers
{ -Chain suport for servers (Super core)
{ -Scheduler upgrades
{ -Full yarn support
}
{
{   Rev 1.18    2003.10.02 8:01:08 PM  czhower
{ .Net
}
{
{   Rev 1.17    2003.10.02 12:44:44 PM  czhower
{ Fix for Bind, Connect
}
{
{   Rev 1.16    2003.10.02 10:16:32 AM  czhower
{ .Net
}
{
{   Rev 1.15    2003.10.01 9:11:26 PM  czhower
{ .Net
}
{
{   Rev 1.14    2003.10.01 12:30:08 PM  czhower
{ .Net
}
{
{   Rev 1.12    10/1/2003 12:14:12 AM  BGooijen
{ DotNet: removing CheckForSocketError
}
{
{   Rev 1.11    2003.10.01 1:12:40 AM  czhower
{ .Net
}
{
{   Rev 1.10    2003.09.30 1:23:04 PM  czhower
{ Stack split for DotNet
}
{
{   Rev 1.9    9/8/2003 02:13:10 PM  JPMugaas
{ SupportsIP6 function added for determining if IPv6 is installed on a system.
}
{
{   Rev 1.8    2003.07.14 1:57:24 PM  czhower
{ -First set of IOCP fixes.
{ -Fixed a threadsafe problem with the stack class.
}
{
{   Rev 1.7    7/1/2003 05:20:44 PM  JPMugaas
{ Minor optimizations.  Illiminated some unnecessary string operations.
}
{
{   Rev 1.5    7/1/2003 03:39:58 PM  JPMugaas
{ Started numeric IP function API calls for more efficiency.
}
{
{   Rev 1.4    7/1/2003 12:46:06 AM  JPMugaas
{ Preliminary stack functions taking an IP address numerical structure instead
{ of a string.
}
{
    Rev 1.3    5/19/2003 6:00:28 PM  BGooijen
  TIdStackWindows.WSGetHostByAddr raised an ERangeError when the last number in
  the ip>127
}
{
    Rev 1.2    5/10/2003 4:01:28 PM  BGooijen
}
{
{   Rev 1.1    2003.05.09 10:59:28 PM  czhower
}
{
{   Rev 1.0    11/13/2002 08:59:38 AM  JPMugaas
}
unit IdStackWindows;

interface

uses
  Classes,
  IdGlobal, IdException, IdStackBSDBase, IdStackConsts, IdWinsock2, IdStack, IdObjs,
  SyncObjs, IdSys,
  SysUtils, // Legal because this is a Windows only unit already
  Windows;

type
  EIdIPv6Unavailable = class(EIdException);

  TIdSocketListWindows = class(TIdSocketList)
  protected
    FFDSet: TFDSet;
    //
    class function FDSelect(AReadSet: PFDSet; AWriteSet: PFDSet; AExceptSet: PFDSet;
     const ATimeout: Integer = IdTimeoutInfinite): Boolean;
    function GetItem(AIndex: Integer): TIdStackSocketHandle; override;
  public
    procedure Add(AHandle: TIdStackSocketHandle); override;
    procedure Remove(AHandle: TIdStackSocketHandle); override;
    function Count: Integer; override;
    procedure Clear; override;
    function Clone: TIdSocketList; override;
    function Contains(AHandle: TIdStackSocketHandle): boolean; override;
    procedure GetFDSet(var VSet: TFDSet);
    procedure SetFDSet(var VSet: TFDSet);
    class function Select(AReadList: TIdSocketList; AWriteList: TIdSocketList;
     AExceptList: TIdSocketList; const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
    function SelectRead(const ATimeout: Integer = IdTimeoutInfinite): Boolean;
     override;
    function SelectReadList(var VSocketList: TIdSocketList;
     const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
  end;

  TIdStackWindows = class(TIdStackBSDBase)
  protected
     procedure WSQuerryIPv6Route(ASocket: TIdStackSocketHandle;
       const AIP: String;
       const APort : Word;
       var VSource;
       var VDest);
    procedure WriteChecksumIPv6(s : TIdStackSocketHandle;
      var VBuffer : TIdBytes;
      const AOffset : Integer;
      const AIP : String;
      const APort : Integer);
    function HostByName(const AHostName: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;
    procedure PopulateLocalAddresses; override;
    function ReadHostName: string; override;
    function WSCloseSocket(ASocket: TIdStackSocketHandle): Integer; override;
    function GetLocalAddress: string; override;
    function GetLocalAddresses: TIdStrings; override;
    function WSRecv(ASocket: TIdStackSocketHandle; var ABuffer;
      const ABufferLength, AFlags: Integer): Integer; override;
    function WSSend(ASocket: TIdStackSocketHandle; const ABuffer;
      const ABufferLength, AFlags: Integer): Integer; override;
    function WSShutdown(ASocket: TIdStackSocketHandle; AHow: Integer): Integer; override;
  public
    function Accept(ASocket: TIdStackSocketHandle; var VIP: string;
             var VPort: Integer; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION
             ): TIdStackSocketHandle; override;
    function HostToNetwork(AValue: Word): Word; override;
    function HostToNetwork(AValue: LongWord): LongWord; override;
    function HostToNetwork(AValue: Int64): Int64; override;
    procedure Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer);
              override;
    function NetworkToHost(AValue: Word): Word; override;
    function NetworkToHost(AValue: LongWord): LongWord; override;
    function NetworkToHost(AValue: Int64): Int64; override;
    procedure SetBlocking(ASocket: TIdStackSocketHandle;
              const ABlocking: Boolean); override;
    function WouldBlock(const AResult: Integer): Boolean; override;
    //

    function HostByAddress(const AAddress: string;
              const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;

    function WSGetServByName(const AServiceName: string): Integer; override;
    function WSGetServByPort(const APortNumber: Integer): TIdStrings; override;

    function RecvFrom(const ASocket: TIdStackSocketHandle; var VBuffer;
     const ALength, AFlags: Integer; var VIP: string; var VPort: Integer;
     AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer; override;
   function ReceiveMsg(ASocket: TIdStackSocketHandle;
     var VBuffer: TIdBytes;
     APkt :  TIdPacketInfo;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Cardinal; override;

    procedure WSSendTo(ASocket: TIdStackSocketHandle; const ABuffer;
     const ABufferLength, AFlags: Integer; const AIP: string; const APort: integer; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;

    function WSSocket(AFamily, AStruct, AProtocol: Integer;
     const AOverlapped: Boolean = False): TIdStackSocketHandle; override;
    function WSTranslateSocketErrorMsg(const AErr: integer): string; override;
    function WSGetLastError: Integer; override;
    procedure WSGetSockOpt(ASocket: TIdStackSocketHandle; Alevel, AOptname: Integer; AOptval: PChar; var AOptlen: Integer); override;
    //
    procedure Bind(ASocket: TIdStackSocketHandle; const AIP: string;
     const APort: Integer; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure Connect(const ASocket: TIdStackSocketHandle; const AIP: string;
     const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    constructor Create; override;
    destructor Destroy; override;
    procedure Disconnect(ASocket: TIdStackSocketHandle); override;
    procedure GetPeerName(ASocket: TIdStackSocketHandle; var VIP: string;
     var VPort: Integer); override;
    procedure GetSocketName(ASocket: TIdStackSocketHandle; var VIP: string;
     var VPort: TIdPort); override;
    procedure GetSocketOption(ASocket: TIdStackSocketHandle;
      ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption;
      out AOptVal: Integer); override;
    procedure SetSocketOption(ASocket: TIdStackSocketHandle;
      ALevel: TIdSocketProtocol; AOptName: TIdSocketOption;
      AOptVal: Integer); overload; override;
    procedure SetSocketOption( const ASocket: TIdStackSocketHandle; const Alevel, Aoptname: Integer; Aoptval: PChar; const Aoptlen: Integer ); overload; override;
    function IOControl(const s:  TIdStackSocketHandle; const cmd: cardinal; var arg: cardinal ): Integer; override;
    function SupportsIPv6:boolean; override;
    function CheckIPVersionSupport(const AIPVersion: TIdIPVersion): boolean; override;
    procedure WriteChecksum(s : TIdStackSocketHandle;
       var VBuffer : TIdBytes;
      const AOffset : Integer;
      const AIP : String;
      const APort : Integer;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
  end;

  TLinger = record
	  l_onoff: Word;
	  l_linger: Word;
  end;

  TIdLinger = TLinger;

var
//This is for the Win32-only package (SuperCore)
  GWindowsStack : TIdStackWindows;

implementation

uses
  IdResourceStrings, IdWship6;

var
  GStarted: Boolean = False;

constructor TIdStackWindows.Create;
var
  LData: TWSAData;
begin
  inherited Create;
  if not GStarted then begin
    if WSAStartup($202, LData) = SOCKET_ERROR then begin
      raise EIdStackInitializationFailed.Create(RSWinsockInitializationError);
    end;
    GStarted := True;
  end;
  GWindowsStack := Self;
end;

destructor TIdStackWindows.Destroy;
begin
  //DLL Unloading and Cleanup is done at finalization
  inherited Destroy;
end;

function TIdStackWindows.Accept(ASocket: TIdStackSocketHandle;
  var VIP: string; var VPort: Integer;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): TIdStackSocketHandle;
var
  i: Integer;
  LAddr: TSockAddrIn;
begin
  i := SizeOf(LAddr);
  Result := IdWinsock2.Accept(ASocket, Pointer(@LAddr), @i);
  VIP := TranslateTInAddrToString(LAddr.sin_addr,Id_IPv4); //BGO FIX
  VPort := NToHs(LAddr.sin_port);
end;

procedure TIdStackWindows.Bind(ASocket: TIdStackSocketHandle;
  const AIP: string; const APort: Integer;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LAddr: TSockAddrIn;
  Addr6: TSockAddrIn6;
begin
  case AIPVersion of
    Id_IPv4: begin
      LAddr.sin_family := Id_PF_INET4;
      if AIP = '' then begin
        LAddr.sin_addr.s_addr := INADDR_ANY;
      end else begin
        TranslateStringToTInAddr(AIP, LAddr.sin_addr, Id_IPv4);
      end;
      LAddr.sin_port := HToNS(APort);
      CheckForSocketError(IdWinsock2.Bind(ASocket, @LAddr, SizeOf(LAddr)));
    end;
    Id_IPv6: begin
      Addr6.sin6_family := Id_PF_INET6;
      Addr6.sin6_scope_id := 0;
      Addr6.sin6_flowinfo := 0;
      if length(AIP) = 0 then begin
        FillChar(Addr6.sin6_addr, 16, 0);
      end else begin
        TranslateStringToTInAddr(AIP, Addr6.sin6_addr, Id_IPv6);
      end;
      Addr6.sin6_port := HToNs(APort);
      CheckForSocketError(IdWinsock2.Bind(ASocket, psockaddr(@addr6), SizeOf(Addr6)));
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackWindows.WSCloseSocket(ASocket: TIdStackSocketHandle): Integer;
begin
  result := CloseSocket(ASocket);
end;

function TIdStackWindows.HostByAddress(const AAddress: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
var
  Host: PHostEnt;
  LAddr: u_long;

  Hints:TAddrInfo;
  AddrInfo:pAddrInfo;
  RetVal:integer;
begin
  case AIPVersion of
    Id_IPv4: begin
      LAddr := inet_addr(PChar(AAddress));
      Host := GetHostByAddr(@LAddr, SizeOf(LAddr), AF_INET);
      if Host = nil then begin
        CheckForSocketError(SOCKET_ERROR);
      end else begin
        result := Host^.h_name;
      end;
    end;
    Id_IPv6: begin
      if not IdIPv6Available then raise EIdIPv6Unavailable.Create(RSIPv6Unavailable);
      FillChar(Hints,sizeof(Hints), 0);
      Hints.ai_family := IdIPFamily[AIPVersion];
      Hints.ai_socktype := Integer(SOCK_STREAM);
      Hints.ai_flags := AI_CANONNAME;
      AddrInfo:=nil;
      RetVal := getaddrinfo(pchar(AAddress), nil, @Hints, @AddrInfo);
      try
        if RetVal<>0 then
          RaiseSocketError(gaiErrorToWsaError(RetVal))
        else begin
          setlength(result,NI_MAXHOST);
          getnameinfo(AddrInfo.ai_addr,AddrInfo.ai_addrlen,pointer(result),NI_MAXHOST, nil,0,NI_NAMEREQD);
          result:=pchar(result);
        end;
      finally
        FreeAddrInfo(AddrInfo);
      end;
    end else begin
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackWindows.ReadHostName: string;
begin
  SetLength(result, 250);
  GetHostName(PChar(result), Length(result));
  Result := String(PChar(result));
end;

procedure TIdStackWindows.Listen(ASocket: TIdStackSocketHandle;
  ABackLog: Integer);
begin
  CheckForSocketError(IdWinsock2.Listen(ASocket, ABacklog));
end;

function TIdStackWindows.WSRecv(ASocket: TIdStackSocketHandle; var ABuffer;
  const ABufferLength, AFlags: Integer) : Integer;
begin
  Result := Recv(ASocket, ABuffer, ABufferLength, AFlags);
end;

function TIdStackWindows.RecvFrom(const ASocket: TIdStackSocketHandle;
  var VBuffer; const ALength, AFlags: Integer; var VIP: string;
  var VPort: Integer; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION ): Integer;
var
  iSize: integer;
  Addr4: TSockAddrIn;
  Addr6: TSockAddrIn6;
begin
  case AIPVersion of
    Id_IPv4: begin
      iSize := SizeOf(Addr4);
      Result := IdWinsock2.RecvFrom(ASocket, VBuffer, ALength, AFlags, @Addr4, @iSize);
      VIP :=  TranslateTInAddrToString(Addr4.sin_addr,Id_IPv4);
      VPort := NToHs(Addr4.sin_port);
    end;
    Id_IPv6: begin
      iSize := SizeOf(Addr6);
      Result := IdWinsock2.RecvFrom(ASocket, VBuffer, ALength, AFlags, PSockAddr(@Addr6), @iSize);
      VIP := TranslateTInAddrToString(Addr6.sin6_addr, Id_IPv6);
      VPort := NToHs(Addr6.sin6_port);
    end;
    else begin
      Result := 0; // avoid warning
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackWindows.WSSend(ASocket: TIdStackSocketHandle;
  const ABuffer; const ABufferLength, AFlags: Integer): Integer;
begin
  Result := CheckForSocketError(IdWinsock2.Send(ASocket, ABuffer, ABufferLength
   , AFlags));
end;

procedure TIdStackWindows.WSSendTo(ASocket: TIdStackSocketHandle;
  const ABuffer; const ABufferLength, AFlags: Integer; const AIP: string;
  const APort: integer; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  Addr4: TSockAddrIn;
  Addr6: TSockAddrIn6;
  LBytesOut: integer;
begin
  case AIPVersion of
    Id_IPv4: begin
      FillChar(Addr4, SizeOf(Addr4), 0);
      with Addr4 do begin
        sin_family := Id_PF_INET4;
       TranslateStringToTInAddr(AIP, sin_addr, Id_IPv4);
        sin_port := HToNs(APort);
      end;
      LBytesOut := IdWinsock2.SendTo(ASocket, ABuffer, ABufferLength, AFlags, @Addr4, SizeOf(Addr4));
    end;
    Id_IPv6: begin
      FillChar(Addr6, SizeOf(Addr6), 0);
      with Addr6 do
      begin
        sin6_family := Id_PF_INET6;
        TranslateStringToTInAddr(AIP, sin6_addr, Id_IPv6);
        sin6_port := HToNs(APort);
      end;
      LBytesOut := IdWinsock2.SendTo(ASocket, ABuffer, ABufferLength, AFlags, PSockAddr(@Addr6), SizeOf(Addr6));
    end;
    else begin
      LBytesOut := 0; // avoid warning
      IPVersionUnsupported;
    end;
  end;
  if LBytesOut = Id_SOCKET_ERROR then begin
    if WSGetLastError() = Id_WSAEMSGSIZE then begin
      raise EIdPackageSizeTooBig.Create(RSPackageSizeTooBig);
    end else begin
      RaiseLastSocketError;
    end;
  end else if LBytesOut <> ABufferLength then begin
    raise EIdNotAllBytesSent.Create(RSNotAllBytesSent);
  end;
end;

procedure TIdStackWindows.SetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel:TIdSocketProtocol; AOptName: TIdSocketOption; AOptVal: Integer);
begin
  CheckForSocketError(SetSockOpt(ASocket, ALevel, AOptName, PChar(@AOptVal), SizeOf(AOptVal)));
end;

function TIdStackWindows.GetLocalAddresses: TIdStrings;
begin
  if FLocalAddresses = nil then
  begin
    FLocalAddresses := TIdStringList.Create;
  end;
  PopulateLocalAddresses;
  Result := FLocalAddresses;
end;

function TIdStackWindows.WSGetLastError: Integer;
begin
  result := WSAGetLastError;
end;

function TIdStackWindows.WSSocket(AFamily, AStruct, AProtocol: Integer;
 const AOverlapped: Boolean = False): TIdStackSocketHandle;
begin
  if AOverlapped then begin
    Result := WSASocket(AFamily, AStruct, AProtocol,nil,0,WSA_FLAG_OVERLAPPED);
  end else begin
    Result := IdWinsock2.Socket(AFamily, AStruct, AProtocol);
  end;
end;

function TIdStackWindows.WSGetServByName(const AServiceName: string): Integer;
var
  ps: PServEnt;
begin
  ps := GetServByName(PChar(AServiceName), nil);
  if ps <> nil then begin
    Result := Ntohs(ps^.s_port);
  end else begin
    try
      Result := Sys.StrToInt(AServiceName);
    except
      on EConvertError do begin
        raise EIdInvalidServiceName.CreateFmt(RSInvalidServiceName, [AServiceName]);
      end;
    end;
  end;
end;

function TIdStackWindows.WSGetServByPort(
  const APortNumber: Integer): TIdStrings;
var
  ps: PServEnt;
  i: integer;
  p: array of PChar;
begin
  Result := TIdStringList.Create;
  p := nil;
  try
    ps := GetServByPort(HToNs(APortNumber), nil);
    if ps <> nil then
    begin
      Result.Add(ps^.s_name);
      i := 0;
      p := pointer(ps^.s_aliases);
      while p[i] <> nil do
      begin
        Result.Add(PChar(p[i]));
        inc(i);
      end;
    end;
  except
    Sys.FreeAndNil(Result);
  end;
end;

function TIdStackWindows.HostToNetwork(AValue: Word): Word;
begin
  Result := HToNs(AValue);
end;

function TIdStackWindows.NetworkToHost(AValue: Word): Word;
begin
  Result := NToHs(AValue);
end;

function TIdStackWindows.HostToNetwork(AValue: LongWord): LongWord;
begin
  Result := HToNL(AValue);
end;

function TIdStackWindows.NetworkToHost(AValue: LongWord): LongWord;
begin
  Result := NToHL(AValue);
end;

function TIdStackWindows.HostToNetwork(AValue: Int64): Int64;
var
  LParts: TIdInt64Parts;
  L: LongWord;
begin
  LParts.QuadPart := AValue;
  L := HToNL(LParts.HighPart);
  LParts.HighPart := HToNL(LParts.LowPart);
  LParts.LowPart := L;
  Result := LParts.QuadPart;
end;

function TIdStackWindows.NetworkToHost(AValue: Int64): Int64;
var
  LParts: TIdInt64Parts;
  L: LongWord;
begin
  LParts.QuadPart := AValue;
  L := NToHL(LParts.HighPart);
  LParts.HighPart := NToHL(LParts.LowPart);
  LParts.LowPart := L;
  Result := LParts.QuadPart;
end;

procedure TIdStackWindows.PopulateLocalAddresses;
type
  TaPInAddr = Array[0..250] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  i: integer;
  AHost: PHostEnt;
  PAdrPtr: PaPInAddr;
begin
  FLocalAddresses.Clear ;
  AHost := GetHostByName(PChar(HostName));
  if AHost = nil then begin
    CheckForSocketError(SOCKET_ERROR);
  end else begin
    PAdrPtr := PAPInAddr(AHost^.h_address_list);
    i := 0;
    while PAdrPtr^[i] <> nil do begin

      FLocalAddresses.Add(TranslateTInAddrToString(PAdrPtr^[I]^,Id_IPv4)); //BGO FIX
      Inc(I);
    end;
  end;
end;

function TIdStackWindows.GetLocalAddress: string;
begin
  Result := LocalAddresses[0];
end;

{ TIdStackVersionWinsock }

function ServeFile(ASocket: TIdStackSocketHandle; AFileName: string): cardinal;
var
  LFileHandle: THandle;
begin
  result := 0;
  LFileHandle := CreateFile(PChar(AFileName), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING
   , FILE_ATTRIBUTE_NORMAL or FILE_FLAG_SEQUENTIAL_SCAN, 0); try
    if TransmitFile(ASocket, LFileHandle, 0, 0, nil, nil, 0) then begin
      result := getFileSize(LFileHandle, nil);
    end;
  finally CloseHandle(LFileHandle); end;
end;

function TIdStackWindows.WSShutdown(ASocket: TIdStackSocketHandle; AHow: Integer): Integer;
begin
  result := Shutdown(ASocket, AHow);
end;

procedure TIdStackWindows.GetSocketName(ASocket: TIdStackSocketHandle;
 var VIP: string; var VPort: Integer);
var
  i: Integer;
  LAddr: TSockAddrIn6;
begin
  i := SizeOf(LAddr);
  CheckForSocketError(GetSockName(ASocket, PSockAddr(Pointer(@LAddr)), i));
  case LAddr.sin6_family of
    Id_PF_INET4: begin
      VIP := TranslateTInAddrToString(TSockAddr(Pointer(@LAddr)^).sin_addr,Id_IPv4);
      VPort := Ntohs(TSockAddr(Pointer(@LAddr)^).sin_port);
    end;
    Id_PF_INET6: begin
      VIP := TranslateTInAddrToString(LAddr.sin6_addr, Id_IPv6);
      VPort := Ntohs(LAddr.sin6_port);
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackWindows.WSGetSockOpt(ASocket: TIdStackSocketHandle; Alevel, AOptname: Integer; AOptval: PChar; var AOptlen: Integer);
begin
  CheckForSocketError(GetSockOpt(ASocket, ALevel, AOptname, AOptval, AOptlen));
end;

{ TIdSocketListWindows }

procedure TIdSocketListWindows.Add(AHandle: TIdStackSocketHandle);
begin
  Lock; try
    if FFDSet.fd_count >= FD_SETSIZE then begin
      raise EIdStackSetSizeExceeded.Create(RSSetSizeExceeded);
    end;
    FFDSet.fd_array[FFDSet.fd_count] := AHandle;
    Inc(FFDSet.fd_count);
  finally Unlock; end;
end;

procedure TIdSocketListWindows.Clear;
begin
  Lock; try
    fd_zero(FFDSet);
  finally Unlock; end;
end;

function TIdSocketListWindows.Contains(AHandle: TIdStackSocketHandle): Boolean;
begin
  Lock; try
    Result := fd_isset(AHandle, FFDSet);
  finally Unlock; end;
end;

function TIdSocketListWindows.Count: Integer;
begin
  Lock; try
    Result := FFDSet.fd_count;
  finally Unlock; end;
end;

function TIdSocketListWindows.GetItem(AIndex: Integer): TIdStackSocketHandle;
begin
  Result := 0;
  Lock; try
    if (AIndex >= 0) and (AIndex < FFDSet.fd_count) then begin
      Result := FFDSet.fd_array[AIndex];
    end else begin
      raise EIdStackSetSizeExceeded.Create(RSSetSizeExceeded);
    end;
  finally Unlock; end;
end;

procedure TIdSocketListWindows.Remove(AHandle: TIdStackSocketHandle);
var
  i: Integer;
begin
  Lock; try
    for i:= 0 to FFDSet.fd_count - 1 do begin
      if FFDSet.fd_array[i] = AHandle then begin
        dec(FFDSet.fd_count);
        FFDSet.fd_array[i] := FFDSet.fd_array[FFDSet.fd_count];
        FFDSet.fd_array[FFDSet.fd_count] := 0; //extra purity
        Break;
      end;//if found
    end;
  finally Unlock; end;
end;

function TIdStackWindows.WSTranslateSocketErrorMsg(const AErr: integer): string;
begin
  case AErr of
    wsahost_not_found: Result := RSStackHOST_NOT_FOUND;
  else
    Result :=  inherited WSTranslateSocketErrorMsg(AErr);
    EXIT;
  end;
  Result := Sys.Format(RSStackError, [AErr, Result]);
end;

function TIdSocketListWindows.SelectRead(const ATimeout: Integer): Boolean;
var
  LSet: TFDSet;
begin
  // Windows updates this structure on return, so we need to copy it each time we need it
  GetFDSet(LSet);
  FDSelect(@LSet, nil, nil, ATimeout);
  Result := LSet.fd_count > 0;
end;

class function TIdSocketListWindows.FDSelect(AReadSet, AWriteSet,
 AExceptSet: PFDSet; const ATimeout: Integer): Boolean;
var
  LResult: Integer;
  LTime: TTimeVal;
begin
  if ATimeout = IdTimeoutInfinite then begin
    LResult := IdWinsock2.Select(0, AReadSet, AWriteSet, AExceptSet, nil);
  end else begin
    LTime.tv_sec := ATimeout div 1000;
    LTime.tv_usec := (ATimeout mod 1000) * 1000;
    LResult := IdWinsock2.Select(0, AReadSet, AWriteSet, AExceptSet, @LTime);
  end;
  //TODO: Remove this cast
  Result := (GStack as TIdStackBSDBase).CheckForSocketError(LResult) > 0;
end;

function TIdSocketListWindows.SelectReadList(var VSocketList: TIdSocketList; const ATimeout: Integer): Boolean;
var
  LSet: TFDSet;
begin
  // Windows updates this structure on return, so we need to copy it each time we need it
  GetFDSet(LSet);
  FDSelect(@LSet, nil, nil, ATimeout);
  Result := LSet.fd_count > 0;
  if Result then begin
    if VSocketList = nil then begin
      VSocketList := TIdSocketList.CreateSocketList;
    end;
    TIdSocketListWindows(VSocketList).SetFDSet(LSet);
  end;
end;

class function TIdSocketListWindows.Select(AReadList, AWriteList,
 AExceptList: TIdSocketList; const ATimeout: Integer): Boolean;
var
  LReadSet: TFDSet;
  LWriteSet: TFDSet;
  LExceptSet: TFDSet;
  LPReadSet: PFDSet;
  LPWriteSet: PFDSet;
  LPExceptSet: PFDSet;

  procedure ReadSet(AList: TIdSocketList; var ASet: TFDSet; var APSet: PFDSet);
  begin
    if AList <> nil then begin
      TIdSocketListWindows(AList).GetFDSet(ASet);
      APSet := @ASet;
    end else begin
      APSet := nil;
    end;
  end;

begin
  ReadSet(AReadList, LReadSet, LPReadSet);
  ReadSet(AWriteList, LWriteSet, LPWriteSet);
  ReadSet(AExceptList, LExceptSet, LPExceptSet);
  //
  Result := FDSelect(LPReadSet, LPWriteSet, LPExceptSet, ATimeout);
  //
  if AReadList <> nil then begin
    TIdSocketListWindows(AReadList).SetFDSet(LReadSet);
  end;
  if AWriteList <> nil then begin
    TIdSocketListWindows(AWriteList).SetFDSet(LWriteSet);
  end;
  if AExceptList <> nil then begin
    TIdSocketListWindows(AExceptList).SetFDSet(LExceptSet);
  end;
end;

procedure TIdSocketListWindows.SetFDSet(var VSet: TFDSet);
begin
  Lock; try
    FFDSet := VSet;
  finally Unlock; end;
end;

procedure TIdSocketListWindows.GetFDSet(var VSet: TFDSet);
begin
  Lock; try
    VSet := FFDSet;
  finally Unlock; end;
end;

procedure TIdStackWindows.SetBlocking(ASocket: TIdStackSocketHandle;
 const ABlocking: Boolean);
var
  LValue: Cardinal;
begin
  LValue := Cardinal(not ABlocking);
  CheckForSocketError(ioctlsocket(ASocket, FIONBIO, LValue));
end;

function TIdSocketListWindows.Clone: TIdSocketList;
begin
  Result := TIdSocketListWindows.Create;
  Lock; try
    TIdSocketListWindows(Result).SetFDSet(FFDSet);
  finally Unlock; end;
end;

function TIdStackWindows.WouldBlock(const AResult: Integer): Boolean;
begin
  Result := CheckForSocketError(AResult, [WSAEWOULDBLOCK]) <> 0;
end;

function TIdStackWindows.HostByName(const AHostName: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
var
  LPa: PChar;
  LSa: TInAddr;
  LHost: PHostEnt;

  Hints:TAddrInfo;
  AddrInfo:pAddrInfo;
  RetVal:integer;
begin
  case AIPVersion of
    Id_IPv4: begin
      LHost := IdWinsock2.GetHostByName(PChar(AHostName));
      if LHost = nil then begin
        RaiseLastSocketError;
      end else begin
        LPa := LHost^.h_address_list^;
        LSa.S_un_b.s_b1 := Ord(LPa[0]);
        LSa.S_un_b.s_b2 := Ord(LPa[1]);
        LSa.S_un_b.s_b3 := Ord(LPa[2]);
        LSa.S_un_b.s_b4 := Ord(LPa[3]);
        Result := TranslateTInAddrToString(LSa,Id_IPv4);
      end;
    end;
    Id_IPv6: begin
      if not IdIPv6Available then raise EIdIPv6Unavailable.Create(RSIPv6Unavailable);
      ZeroMemory(@Hints,sizeof(Hints));
      Hints.ai_family := Id_PF_INET6;
      Hints.ai_socktype := SOCK_STREAM;
      AddrInfo:=nil;
      RetVal := getaddrinfo(pchar(AHostName), nil, @Hints, @AddrInfo);
      try
        if RetVal<>0 then
          RaiseSocketError(gaiErrorToWsaError(RetVal))
        else
          result:=TranslateTInAddrToString(AddrInfo^.ai_addr^.sin_zero,Id_IPv6);
      finally
        freeaddrinfo(AddrInfo);
      end;
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackWindows.Connect(const ASocket: TIdStackSocketHandle;
 const AIP: string; const APort: TIdPort;
 const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LAddr: TSockAddrIn;
  Addr6: TSockAddrIn6;
begin
  case AIPVersion of
    Id_IPv4: begin
      LAddr.sin_family := Id_PF_INET4;
      TranslateStringToTInAddr(AIP, LAddr.sin_addr, Id_IPv4);
      LAddr.sin_port := HToNS(APort);
      CheckForSocketError(IdWinsock2.Connect(ASocket, @LAddr, SizeOf(LAddr)));
    end;
    Id_IPv6: begin
      Addr6.sin6_flowinfo:=0;
      Addr6.sin6_scope_id:=0;
      Addr6.sin6_family := Id_PF_INET6;
      TranslateStringToTInAddr(AIP, Addr6.sin6_addr, Id_IPv6);
      Addr6.sin6_port := HToNs(APort);
      CheckForSocketError(IdWinsock2.Connect(ASocket, psockaddr(@Addr6), SizeOf(Addr6)));
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackWindows.GetPeerName(ASocket: TIdStackSocketHandle;
 var VIP: string; var VPort: Integer);
var
  i: Integer;
  LAddr: TSockAddrIn6;
begin
  i := SizeOf(LAddr);
  CheckForSocketError(IdWinsock2.GetPeerName(ASocket, PSockAddr(Pointer(@LAddr)), i));

  case LAddr.sin6_family of
    Id_PF_INET4: begin
      VIP := TranslateTInAddrToString(TSockAddr(Pointer(@LAddr)^).sin_addr,Id_IPv4);
      VPort := Ntohs(TSockAddr(Pointer(@LAddr)^).sin_port);
    end;
    Id_PF_INET6: begin
      VIP := TranslateTInAddrToString(LAddr.sin6_addr, Id_IPv6);
      VPort := Ntohs(LAddr.sin6_port);
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackWindows.Disconnect(ASocket: TIdStackSocketHandle);
begin
  // Windows uses Id_SD_Send, Linux should use Id_SD_Both
  WSShutdown(ASocket, Id_SD_Send);
  // SO_LINGER is false - socket may take a little while to actually close after this
  WSCloseSocket(ASocket);
end;

procedure TIdStackWindows.SetSocketOption(
  const ASocket: TIdStackSocketHandle; const Alevel, Aoptname: Integer;
  Aoptval: PChar; const Aoptlen: Integer);
begin
  CheckForSocketError( setsockopt(ASocket,ALevel,Aoptname,Aoptval,Aoptlen ));
end;

procedure TIdStackWindows.GetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption;
  out AOptVal: Integer);
var LP : PAnsiChar;
  LLen : Integer;
  LBuf : Integer;
begin
  LP := Addr(LBuf);
  LLen := SizeOf(Integer);
  WSGetSockOpt(ASocket,ALevel,AOptName,LP,LLen);
  AOptVal := LBuf;
end;

function TIdStackWindows.SupportsIPv6:boolean; 
{
based on
http://groups.google.com/groups?q=Winsock2+Delphi+protocol&hl=en&lr=&ie=UTF-8&oe=utf-8&selm=3cebe697_2%40dnews&rnum=9
}
var LLen : Cardinal;
  LPInfo, LPCurPtr : LPWSAProtocol_Info;
  LCount : Integer;
  i : Integer;
begin
  Result := False;
  LLen:=0;
  IdWinsock2.WSAEnumProtocols(nil,nil,LLen);
  GetMem(LPInfo,LLen);
  try
    LCount := IdWinsock2.WSAEnumProtocols(nil,LPInfo,LLen);
    if LCount <> SOCKET_ERROR then
    begin
      LPCurPtr := LPInfo;
      for i := 0 to LCount-1 do
      begin
        Result := (LPCurPtr^.iAddressFamily=PF_INET6);
        if Result then
        begin
          Break;
        end;
        Inc(LPCurPtr);
      end;
    end;
  finally
    FreeMem(LPInfo);
  end;
end;

function TIdStackWindows.IOControl(const s: TIdStackSocketHandle;
  const cmd: cardinal; var arg: cardinal): Integer;
begin
  Result := IdWinsock2.ioctlsocket(s,cmd,arg);
end;

procedure TIdStackWindows.WSQuerryIPv6Route(ASocket: TIdStackSocketHandle;
  const AIP: String;
  const APort : Word;
  var VSource;
  var VDest);
var
  Llocalif : SOCKADDR_STORAGE;
  LPLocalIP : PSOCKADDR_IN6;
  LAddr6:TSockAddrIn6;
  Bytes : Cardinal;

begin
  if not IdIPv6Available then
  begin
    raise EIdIPv6Unavailable.Create(RSIPv6Unavailable);
  end;
  //make our LAddrInfo structure
  FillChar(LAddr6, SizeOf(LAddr6), 0);
  LAddr6.sin6_family := AF_INET6;
  TranslateStringToTInAddr(AIP, LAddr6.sin6_addr, Id_IPv6);
  Move(LAddr6.sin6_addr, VDest,SizeOf(in6_addr));
  LAddr6.sin6_port := HToNs(APort);
  LPLocalIP := PSockAddr_in6(@Llocalif);
  // Find out which local interface for the destination
  CheckForSocketError( WSAIoctl(ASocket, SIO_ROUTING_INTERFACE_QUERY,
    @LAddr6, Cardinal(SizeOf(TSockAddrIn6) ), @Llocalif,
    Cardinal(sizeof(Llocalif)), @bytes, nil, nil));
  Move( LPLocalIP^.sin6_addr ,VSource,SizeOf(in6_addr));
end;

procedure TIdStackWindows.WriteChecksum(s: TIdStackSocketHandle;
  var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
  const APort: Integer; const AIPVersion: TIdIPVersion);
begin
  case AIPVersion of
    Id_IPv4 : CopyTIdWord(CalcCheckSum(VBuffer),VBuffer,AOffset);
    Id_IPv6 : WriteChecksumIPv6(s,VBuffer, AOffset, AIP, APort);
  else
    IPVersionUnsupported;
  end;
end;

procedure TIdStackWindows.WriteChecksumIPv6(s: TIdStackSocketHandle;
  var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
  const APort: Integer);
var 
  LSource : TIdIn6Addr;
  LDest : TIdIn6Addr;
  LTmp : TIdBytes;
  LIdx : Integer;
  LC : Cardinal;
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

  GWindowsStack.WSQuerryIPv6Route(s,AIP,APort,LSource,LDest);
  SetLength(LTmp,Length(VBuffer)+40);

  //16
   Move(LSource,LTmp[0],SizeOf(LSource));
  LIdx := SizeOf(LSource);
  //32
  Move(LDest,LTmp[LIdx],SizeOf(LDest));
  LIdx := LIdx+SizeOf(LDest);
  //use a word so you don't wind up using the wrong network byte order function
  LC := Length(VBuffer);
  CopyTIdCardinal(GStack.HostToNetwork(LC),LTmp,LIdx);
  Inc(LIdx,4);
  //36
  //zero the next three bytes
  FillChar(LTmp[LIdx],3,0);
  Inc(LIdx,3);
  //next header (protocol type determines it
  LTmp[LIdx] := Id_IPPROTO_ICMPV6; // Id_IPPROTO_ICMP6;
  Inc(LIdx);
  //zero our checksum feild for now
  VBuffer[2] := 0;
  VBuffer[3] := 0;
  //combine the two
  CopyTIdBytes(VBuffer,0,LTmp,LIdx,Length(VBuffer));
  LW := CalcCheckSum(LTmp);

  CopyTIdWord(LW,VBuffer,AOffset);
end;

function TIdStackWindows.ReceiveMsg(ASocket: TIdStackSocketHandle; var VBuffer : TIdBytes;
  APkt: TIdPacketInfo;
  const AIPVersion: TIdIPVersion): Cardinal;
type
  PByte = ^Byte;
var
  LIP : String;
  LPort : Integer;
  LSize: Cardinal;
  LAddr4: TSockAddrIn;
  LAddr6: TSockAddrIn6;
  LMsg : TWSAMSG;
  LMsgBuf : TWSABUF;
  LControl : TIdBytes;
  LCurCmsg : LPWSACMSGHDR;   //for iterating through the control buffer
  LCurPt : Pin_pktinfo;
  LCurPt6 : Pin6_pktinfo;
  LByte : PByte;
  LDummy, LDummy2 : Cardinal;
begin
  //This runs only on WIndowsXP or later
 if (Win32MajorVersion>4) and (Win32MinorVersion > 0) then
 begin
   //we call the macro twice because we specified two possible structures.
   //Id_IPV6_HOPLIMIT and Id_IPV6_PKTINFO
   LSize := WSA_CMSG_LEN(WSA_CMSG_LEN(Length(VBuffer)));
   SetLength( LControl,LSize);

    LMsgBuf.len := Length(VBuffer); // Length(VMsgData);
    LMsgBuf.buf := @VBuffer[0]; // @VMsgData[0];

    FillChar(LMsg,SizeOf(LMsg),0);

    LMsg.lpBuffers := @LMsgBuf;
    LMsg.dwBufferCount := 1;

    LMsg.Control.Len := LSize;
    LMsg.Control.buf := @LControl[0];


    case AIPVersion of
      Id_IPv4: begin
        LMsg.name :=  @LAddr4;
        LMsg.namelen := SizeOf(LAddr4);

        GWindowsStack.CheckForSocketError(WSARecvMsg(ASocket,@LMsg,Result,nil,nil));
        APkt.SourceIP :=  TranslateTInAddrToString(LAddr4.sin_addr,Id_IPv4);

        APkt.SourcePort := NToHs(LAddr4.sin_port);
      end;
      Id_IPv6: begin
        LMsg.name := PSOCKADDR( @LAddr6);
        LMsg.namelen := SizeOf(LAddr6);

        CheckForSocketError( IdWinsock2.WSARecvMsg(ASocket,@LMsg,Result,@LDummy,LPwsaoverlapped_COMPLETION_ROUTINE(@LDummy2)));
        APkt.SourceIP := TranslateTInAddrToString(LAddr6.sin6_addr, Id_IPv6);

        APkt.SourcePort := NToHs(LAddr6.sin6_port);
      end;
      else begin
        Result := 0; // avoid warning
        IPVersionUnsupported;
      end;
    end;
    LCurCmsg := nil;
    repeat
      LCurCmsg := WSA_CMSG_NXTHDR(@LMsg,LCurCmsg);
      if LCurCmsg=nil then
      begin
        break;
      end;
      case LCurCmsg^.cmsg_type of
        IP_PKTINFO :     //done this way because IPV6_PKTINF and  IP_PKTINFO
        //are both 19
        begin
          if AIPVersion = Id_IPv4 then
          begin
            LCurPt := WSA_CMSG_DATA(LCurCmsg);
            APkt.DestIP := GWindowsStack.TranslateTInAddrToString(LCurPt^.ipi_addr,Id_IPv4);
            APkt.DestIF := LCurPt^.ipi_ifindex;
          end;
          if AIPVersion = Id_IPv6 then
          begin
            LCurPt6 := WSA_CMSG_DATA(LCurCmsg);
            APkt.DestIP := GWindowsStack.TranslateTInAddrToString(LCurPt6^.ipi6_addr,Id_IPv6);
            APkt.DestIF := LCurPt6^.ipi6_ifindex;
          end;
        end;
        Id_IPV6_HOPLIMIT :
        begin
          LByte :=  PByte(WSA_CMSG_DATA(LCurCmsg));
          APkt.TTL := LByte^;
        end;
      end;
    until False;
  end
  else
  begin
    Result :=  RecvFrom(ASocket, VBuffer, Length(VBuffer), 0, LIP, LPort,
     AIPVersion);
     APkt.SourceIP := LIP;
     APkt.SourcePort := LPort;
  end;
end;

function TIdStackWindows.CheckIPVersionSupport(
  const AIPVersion: TIdIPVersion): boolean;
var LTmpSocket:TIdStackSocketHandle;
begin
  LTmpSocket := WSSocket(IdIPFamily[AIPVersion], Id_SOCK_STREAM, Id_IPPROTO_IP );
  result:=LTmpSocket<>Id_INVALID_SOCKET;
  if LTmpSocket<>Id_INVALID_SOCKET then begin
    WSCloseSocket(LTmpSocket);
  end;
end;

initialization
  GSocketListClass := TIdSocketListWindows;
  // Check if we are running under windows NT
  if (Sys.Win32Platform = VER_PLATFORM_WIN32_NT) then begin
    GServeFileProc := ServeFile;
  end;
finalization
  if GStarted then begin
    WSACleanup;
  end;
end.
