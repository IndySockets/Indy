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


  $Log$


   Rev 1.8    10/26/2004 8:20:04 PM  JPMugaas
 Fixed some oversights with conversion.  OOPS!!!


   Rev 1.7    07/06/2004 21:31:24  CCostelloe
 Kylix 3 changes


   Rev 1.6    4/18/04 10:43:24 PM  RLebeau
 Fixed syntax error


   Rev 1.5    4/18/04 10:29:58 PM  RLebeau
 Renamed Int64Parts structure to TIdInt64Parts


   Rev 1.4    4/18/04 2:47:46 PM  RLebeau
 Conversion support for Int64 values


   Rev 1.3    2004.03.07 11:45:28 AM  czhower
 Flushbuffer fix + other minor ones found


   Rev 1.2    3/6/2004 5:16:34 PM  JPMugaas
 Bug 67 fixes.  Do not write to const values.


   Rev 1.1    3/6/2004 4:23:52 PM  JPMugaas
 Error #62 fix.  This seems to work in my tests.


   Rev 1.0    2004.02.03 3:14:48 PM  czhower
 Move and updates


   Rev 1.33    2/1/2004 6:10:56 PM  JPMugaas
 GetSockOpt.


   Rev 1.32    2/1/2004 3:28:36 AM  JPMugaas
 Changed WSGetLocalAddress to GetLocalAddress and moved into IdStack since
 that will work the same in the DotNET as elsewhere.  This is required to
 reenable IPWatch.


   Rev 1.31    1/31/2004 1:12:48 PM  JPMugaas
 Minor stack changes required as DotNET does support getting all IP addresses
 just like the other stacks.


   Rev 1.30    12/4/2003 3:14:52 PM  BGooijen
 Added HostByAddress


   Rev 1.29    1/3/2004 12:38:56 AM  BGooijen
 Added function SupportsIPv6


   Rev 1.28    12/31/2003 9:52:02 PM  BGooijen
 Added IPv6 support


   Rev 1.27    10/26/2003 05:33:14 PM  JPMugaas
 LocalAddresses should work.


   Rev 1.26    10/26/2003 5:04:28 PM  BGooijen
 UDP Server and Client


   Rev 1.25    10/26/2003 09:10:26 AM  JPMugaas
 Calls necessary for IPMulticasting.


   Rev 1.24    10/22/2003 04:40:52 PM  JPMugaas
 Should compile with some restored functionality.  Still not finished.


   Rev 1.23    10/21/2003 11:04:20 PM  BGooijen
 Fixed name collision


   Rev 1.22    10/21/2003 01:20:02 PM  JPMugaas
 Restore GWindowsStack because it was needed by SuperCore.


   Rev 1.21    10/21/2003 06:24:28 AM  JPMugaas
 BSD Stack now have a global variable for refercing by platform specific
 things.  Removed corresponding var from Windows stack.


   Rev 1.20    10/19/2003 5:21:32 PM  BGooijen
 SetSocketOption


   Rev 1.19    2003.10.11 5:51:16 PM  czhower
 -VCL fixes for servers
 -Chain suport for servers (Super core)
 -Scheduler upgrades
 -Full yarn support


   Rev 1.18    2003.10.02 8:01:08 PM  czhower
 .Net


   Rev 1.17    2003.10.02 12:44:44 PM  czhower
 Fix for Bind, Connect


   Rev 1.16    2003.10.02 10:16:32 AM  czhower
 .Net


   Rev 1.15    2003.10.01 9:11:26 PM  czhower
 .Net


   Rev 1.14    2003.10.01 12:30:08 PM  czhower
 .Net


   Rev 1.12    10/1/2003 12:14:12 AM  BGooijen
 DotNet: removing CheckForSocketError


   Rev 1.11    2003.10.01 1:12:40 AM  czhower
 .Net


   Rev 1.10    2003.09.30 1:23:04 PM  czhower
 Stack split for DotNet


   Rev 1.9    9/8/2003 02:13:10 PM  JPMugaas
 SupportsIP6 function added for determining if IPv6 is installed on a system.


   Rev 1.8    2003.07.14 1:57:24 PM  czhower
 -First set of IOCP fixes.
 -Fixed a threadsafe problem with the stack class.


   Rev 1.7    7/1/2003 05:20:44 PM  JPMugaas
 Minor optimizations.  Illiminated some unnecessary string operations.


   Rev 1.5    7/1/2003 03:39:58 PM  JPMugaas
 Started numeric IP function API calls for more efficiency.


   Rev 1.4    7/1/2003 12:46:06 AM  JPMugaas
 Preliminary stack functions taking an IP address numerical structure instead
 of a string.


    Rev 1.3    5/19/2003 6:00:28 PM  BGooijen
  TIdStackWindows.WSGetHostByAddr raised an ERangeError when the last number in
  the ip>127


    Rev 1.2    5/10/2003 4:01:28 PM  BGooijen


   Rev 1.1    2003.05.09 10:59:28 PM  czhower


   Rev 1.0    11/13/2002 08:59:38 AM  JPMugaas
}
unit IdStackWindows;

interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  IdGlobal, IdException, IdStackBSDBase, IdStackConsts, IdWinsock2, IdStack,
  SysUtils, 
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
    function ContainsSocket(AHandle: TIdStackSocketHandle): boolean; override;
    procedure GetFDSet(var VSet: TFDSet);
    procedure SetFDSet(var VSet: TFDSet);
    class function Select(AReadList: TIdSocketList; AWriteList: TIdSocketList;
     AExceptList: TIdSocketList; const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
    function SelectRead(const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
    function SelectReadList(var VSocketList: TIdSocketList;
      const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
  end;

  TIdStackWindows = class(TIdStackBSDBase)
  protected
     procedure WSQuerryIPv6Route(ASocket: TIdStackSocketHandle;
       const AIP: String; const APort : Word; var VSource; var VDest);
    procedure WriteChecksumIPv6(s : TIdStackSocketHandle; var VBuffer : TIdBytes;
      const AOffset : Integer; const AIP : String; const APort : TIdPort);
    function HostByName(const AHostName: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;
    function ReadHostName: string; override;
    function WSCloseSocket(ASocket: TIdStackSocketHandle): Integer; override;
    function WSRecv(ASocket: TIdStackSocketHandle; var ABuffer;
      const ABufferLength, AFlags: Integer): Integer; override;
    function WSSend(ASocket: TIdStackSocketHandle; const ABuffer;
      const ABufferLength, AFlags: Integer): Integer; override;
    function WSShutdown(ASocket: TIdStackSocketHandle; AHow: Integer): Integer; override;
  public
    function Accept(ASocket: TIdStackSocketHandle; var VIP: string; var VPort: TIdPort;
      var VIPVersion: TIdIPVersion): TIdStackSocketHandle; override;
    function HostToNetwork(AValue: Word): Word; override;
    function HostToNetwork(AValue: LongWord): LongWord; override;
    function HostToNetwork(AValue: Int64): Int64; override;
    procedure Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer); override;
    function NetworkToHost(AValue: Word): Word; override;
    function NetworkToHost(AValue: LongWord): LongWord; override;
    function NetworkToHost(AValue: Int64): Int64; override;
    procedure SetBlocking(ASocket: TIdStackSocketHandle; const ABlocking: Boolean); override;
    function WouldBlock(const AResult: Integer): Boolean; override;
    //
    function HostByAddress(const AAddress: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;

    function WSGetServByName(const AServiceName: string): TIdPort; override;
    function WSGetServByPort(const APortNumber: TIdPort): TStrings; override;

    function RecvFrom(const ASocket: TIdStackSocketHandle; var VBuffer;
     const ALength, AFlags: Integer; var VIP: string; var VPort: TIdPort;
     var VIPVersion: TIdIPVersion): Integer; override;
   function ReceiveMsg(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes;
      APkt : TIdPacketInfo): LongWord; override;

    procedure WSSendTo(ASocket: TIdStackSocketHandle; const ABuffer;
      const ABufferLength, AFlags: Integer; const AIP: string; const APort: TIdPort; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;

    function WSSocket(AFamily : Integer; AStruct : TIdSocketType; AProtocol: Integer;
      const AOverlapped: Boolean = False): TIdStackSocketHandle; override;
    function WSTranslateSocketErrorMsg(const AErr: integer): string; override;
    function WSGetLastError: Integer; override;
    procedure WSSetLastError(const AErr : Integer); override;
    procedure WSGetSockOpt(ASocket: TIdStackSocketHandle; Alevel, AOptname: Integer;
      AOptval: PAnsiChar; var AOptlen: Integer); override;
    //
    procedure Bind(ASocket: TIdStackSocketHandle; const AIP: string;
     const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure Connect(const ASocket: TIdStackSocketHandle; const AIP: string;
     const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    constructor Create; override;
    destructor Destroy; override;
    procedure Disconnect(ASocket: TIdStackSocketHandle); override;
    procedure GetPeerName(ASocket: TIdStackSocketHandle; var VIP: string;
     var VPort: TIdPort; var VIPVersion: TIdIPVersion); override;
    procedure GetSocketName(ASocket: TIdStackSocketHandle; var VIP: string;
     var VPort: TIdPort; var VIPVersion: TIdIPVersion); override;
    procedure GetSocketOption(ASocket: TIdStackSocketHandle;
      ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption;
      out AOptVal: Integer); override;
    procedure SetSocketOption(ASocket: TIdStackSocketHandle;
      ALevel: TIdSocketProtocol; AOptName: TIdSocketOption;
      AOptVal: Integer); overload; override;
    procedure SetSocketOption( const ASocket: TIdStackSocketHandle;
      const Alevel, Aoptname: Integer; Aoptval: PAnsiChar;
      const Aoptlen: Integer); overload; override;
    function IOControl(const s:  TIdStackSocketHandle; const cmd: LongWord; var arg: LongWord): Integer; override;
    function SupportsIPv6: Boolean; override;
    function CheckIPVersionSupport(const AIPVersion: TIdIPVersion): boolean; override;
    procedure WriteChecksum(s : TIdStackSocketHandle;
       var VBuffer : TIdBytes;
      const AOffset : Integer;
      const AIP : String;
      const APort : TIdPort;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure AddLocalAddressesToList(AAddresses: TStrings); override;
  end;

var
//This is for the Win32-only package (SuperCore)
  GWindowsStack : TIdStackWindows = nil;

implementation

uses
  IdResourceStrings, IdWship6;

{$IFNDEF WINCE}
type
  TGetFileSizeEx = function (hFile : THandle; var lpFileSize : LARGE_INTEGER) : BOOL; stdcall;
{$ENDIF}

const
  SIZE_HOSTNAME = 250;

var
  GStarted: Boolean = False;
{$IFNDEF WINCE}
  GetFileSizeEx : TGetFileSizeEx = nil;
{$ENDIF}

constructor TIdStackWindows.Create;
begin
  inherited Create;
  if not GStarted then begin
    try
      InitializeWinSock;
      IdWship6.InitLibrary;
    except
      on E: Exception do begin
        raise EIdStackInitializationFailed.Create(E.Message);
      end;
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
  var VIP: string; var VPort: TIdPort; var VIPVersion: TIdIPVersion): TIdStackSocketHandle;
var
  LSize: Integer;
  LAddr: TSockAddrIn6;
begin
  LSize := SizeOf(LAddr);
  Result := IdWinsock2.accept(ASocket, PSOCKADDR(@LAddr), @LSize);
  if Result <> INVALID_SOCKET then begin
    case LAddr.sin6_family of
      Id_PF_INET4: begin
        with PSOCKADDR(@LAddr)^ do
        begin
          VIP := TranslateTInAddrToString(sin_addr, Id_IPv4);
          VPort := ntohs(sin_port);
        end;
        VIPVersion := Id_IPv4;
      end;
      Id_PF_INET6: begin
        with LAddr do
        begin
          VIP := TranslateTInAddrToString(sin6_addr, Id_IPv6);
          VPort := ntohs(sin6_port);
        end;
        VIPVersion := Id_IPv6;
      end;
      else begin
        CloseSocket(Result);
        Result := INVALID_SOCKET;
        IPVersionUnsupported;
      end;
    end;
  end;
end;

procedure TIdStackWindows.Bind(ASocket: TIdStackSocketHandle;
  const AIP: string; const APort: TIdPort;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LAddr: TSockAddrIn6;
  LSize: Integer;
begin
  FillChar(LAddr, SizeOf(LAddr), 0);
  case AIPVersion of
    Id_IPv4: begin
      with PSOCKADDR(@LAddr)^ do
      begin
        sin_family := Id_PF_INET4;
        if AIP <> '' then begin
          TranslateStringToTInAddr(AIP, sin_addr, Id_IPv4);
        end;
        sin_port := htons(APort);
      end;
      LSize := SIZE_TSOCKADDRIN;
    end;
    Id_IPv6: begin
      with LAddr do
      begin
        sin6_family := Id_PF_INET6;
        if AIP <> '' then begin
          TranslateStringToTInAddr(AIP, sin6_addr, Id_IPv6);
        end;
        sin6_port := htons(APort);
      end;
      LSize := SIZE_TSOCKADDRIN6;
    end;
    else begin
      LSize := 0; // avoid warning
      IPVersionUnsupported;
    end;
  end;
  CheckForSocketError(IdWinsock2.bind(ASocket, PSOCKADDR(@LAddr), LSize));
end;

function TIdStackWindows.WSCloseSocket(ASocket: TIdStackSocketHandle): Integer;
begin
  Result := CloseSocket(ASocket);
end;

function TIdStackWindows.HostByAddress(const AAddress: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
var
  Host: PHostEnt;
  {$IFNDEF WINCE}
  LAddr: u_long;
  {$ENDIF}
  {$IFDEF UNICODE}
  Hints: TAddrInfoW;
  LAddrInfo: pAddrInfoW;
  {$ELSE}
  Hints: TAddrInfo;
  LAddrInfo: pAddrInfo;
  {$ENDIF}
  RetVal: Integer;
  {$IFDEF STRING_IS_UNICODE}
  LTemp: AnsiString;
  {$ELSE}
    {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
  LTemp: WideString;
    {$ENDIF}
  {$ENDIF}
begin
  //GetHostByName and GetHostByAddr may not be availble in future versions
  //of Windows CE.  Those functions are depreciated in favor of the new
  //getaddrinfo and getname functions even in Windows so they should be used
  //when available anyway.
  //We do have to use the depreciated functions in Windows NT 4.0, probably
  //Windows 2000, and of course Win9x so fall to our old code in these cases.
  {$IFNDEF WINCE}
  if not GIdIPv6FuncsAvailable then
  begin
    case AIPVersion of
      Id_IPv4:
        begin
          {$IFDEF STRING_IS_UNICODE}
          LTemp := AnsiString(AAddress); // explicit convert to Ansi
          {$ENDIF}
          LAddr := inet_addr(PAnsiChar({$IFDEF STRING_IS_UNICODE}LTemp{$ELSE}AAddress{$ENDIF}));
          Host := gethostbyAddr(@LAddr, SIZE_TADDRINFO, AF_INET);
          if Host = nil then begin
            CheckForSocketError(SOCKET_ERROR);
          end else begin
            Result := String(Host^.h_name);
          end;
        end;
      Id_IPv6: begin
        raise EIdIPv6Unavailable.Create(RSIPv6Unavailable);
      end;
    else
      IPVersionUnsupported;
    end;
    Exit;
  end;
  {$ENDIF}
  if not (AIPVersion in [Id_IPv4, Id_IPv6]) then begin
    IPVersionUnsupported;
  end;
  FillChar(Hints, SizeOf(Hints), 0);
  Hints.ai_family := IdIPFamily[AIPVersion];
  Hints.ai_socktype := Integer(SOCK_STREAM);
  Hints.ai_flags := AI_CANONNAME;
  LAddrInfo := nil;

  {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
  LTemp := WideString(AAddress); // explicit convert to Unicode
  {$ENDIF}

  RetVal := getaddrinfo(
    {$IFDEF UNICODE_BUT_STRING_IS_ANSI}PWideChar(LTemp){$ELSE}PChar(AAddress){$ENDIF},
    nil, @Hints, @LAddrInfo);
  if RetVal <> 0 then begin
    RaiseSocketError(gaiErrorToWsaError(RetVal));
  end;
  try
    SetLength(
      {$IFDEF UNICODE_BUT_STRING_IS_ANSI}LTemp{$ELSE}Result{$ENDIF},
      NI_MAXHOST);
    RetVal := getnameinfo(
      LAddrInfo.ai_addr, LAddrInfo.ai_addrlen,
      {$IFDEF UNICODE_BUT_STRING_IS_ANSI}PWideChar(LTemp){$ELSE}PChar(Result){$ENDIF},
      NI_MAXHOST, nil, 0, NI_NAMEREQD);
    if RetVal <> 0 then begin
      RaiseSocketError(gaiErrorToWsaError(RetVal));
    end;
    Result := {$IFDEF UNICODE_BUT_STRING_IS_ANSI}PWideChar(LTemp){$ELSE}PChar(Result){$ENDIF};
  finally
    freeaddrinfo(LAddrInfo);
  end;
end;

function TIdStackWindows.ReadHostName: string;
var
  // Note that there is no Unicode version of gethostname.
  LStr: AnsiString;
begin
  SetLength(LStr, SIZE_HOSTNAME);
  gethostname(PAnsiChar(LStr), SIZE_HOSTNAME);
  //we have to specifically type cast a PAnsiChar to a string for D2009+.
  //otherwise, we will get a warning about implicit typecast from AnsiString
  //to string
  Result := String(PAnsiChar(LStr));
end;

procedure TIdStackWindows.Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer);
begin
  CheckForSocketError(IdWinsock2.Listen(ASocket, ABacklog));
end;

// RLebeau 12/16/09: MS Hotfix #971383 supposedly fixes a bug in Windows
// Server 2003 when client and server are running on the same machine.
// The bug can cause recv() to return 0 bytes prematurely even though data
// is actually pending.  Uncomment the below define if you do not want to
// rely on the Hotfix always being installed.  The workaround described by
// MS is to simply call recv() again to make sure data is really not pending.
//
{.$DEFINE IGNORE_KB971383_FIX}

function TIdStackWindows.WSRecv(ASocket: TIdStackSocketHandle; var ABuffer;
  const ABufferLength, AFlags: Integer) : Integer;
begin
  Result := recv(ASocket, ABuffer, ABufferLength, AFlags);
  {$IFDEF IGNORE_KB971383_FIX}
  if Result = 0 then begin
    Result := recv(ASocket, ABuffer, ABufferLength, AFlags);
  end;
  {$ENDIF}
end;

function TIdStackWindows.RecvFrom(const ASocket: TIdStackSocketHandle;
  var VBuffer; const ALength, AFlags: Integer; var VIP: string;
  var VPort: TIdPort; var VIPVersion: TIdIPVersion): Integer;
var
  LSize: Integer;
  LAddr: TSockAddrIn6;
begin
  LSize := SizeOf(LAddr);
  Result := IdWinsock2.recvfrom(ASocket, VBuffer, ALength, AFlags, PSOCKADDR(@LAddr), @LSize);
  if Result >= 0 then
  begin
    case LAddr.sin6_family of
      Id_PF_INET4: begin
        with PSOCKADDR(@LAddr)^ do
        begin
          VIP := TranslateTInAddrToString(sin_addr, Id_IPv4);
          VPort := ntohs(sin_port);
        end;
        VIPVersion := Id_IPv4;
      end;
      Id_PF_INET6: begin
        with LAddr do
        begin
          VIP := TranslateTInAddrToString(sin6_addr, Id_IPv6);
          VPort := ntohs(sin6_port);
        end;
        VIPVersion := Id_IPv6;
      end;
      else begin
        IPVersionUnsupported;
      end;
    end;
  end;
end;

function TIdStackWindows.WSSend(ASocket: TIdStackSocketHandle;
  const ABuffer; const ABufferLength, AFlags: Integer): Integer;
begin
  Result := CheckForSocketError(IdWinsock2.send(ASocket, ABuffer, ABufferLength, AFlags));
end;

procedure TIdStackWindows.WSSendTo(ASocket: TIdStackSocketHandle;
  const ABuffer; const ABufferLength, AFlags: Integer; const AIP: string;
  const APort: TIdPort; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LAddr: TSockAddrIn6;
  LSize: Integer;
begin
  FillChar(LAddr, SizeOf(LAddr), 0);
  case AIPVersion of
    Id_IPv4: begin
      with PSOCKADDR(@LAddr)^ do begin
        sin_family := Id_PF_INET4;
        TranslateStringToTInAddr(AIP, sin_addr, Id_IPv4);
        sin_port := htons(APort);
      end;
      LSize := SIZE_TSOCKADDRIN;
    end;
    Id_IPv6: begin
      with LAddr do
      begin
        sin6_family := Id_PF_INET6;
        TranslateStringToTInAddr(AIP, sin6_addr, Id_IPv6);
        sin6_port := htons(APort);
      end;
      LSize := SIZE_TSOCKADDRIN6;
    end;
    else begin
      LSize := 0; // avoid warning
      IPVersionUnsupported;
    end;
  end;
  LSize := IdWinsock2.sendto(ASocket, ABuffer, ABufferLength, AFlags, PSOCKADDR(@LAddr), LSize);
  if LSize = Id_SOCKET_ERROR then begin
    // TODO: move this into RaiseLastSocketError() directly
    if WSGetLastError() = Id_WSAEMSGSIZE then begin
      raise EIdPackageSizeTooBig.Create(RSPackageSizeTooBig);
    end else begin
      RaiseLastSocketError;
    end;
  end
  else if LSize <> ABufferLength then begin
    raise EIdNotAllBytesSent.Create(RSNotAllBytesSent);
  end;
end;

procedure TIdStackWindows.SetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel: TIdSocketProtocol; AOptName: TIdSocketOption; AOptVal: Integer);
begin
  CheckForSocketError(IdWinsock2.setsockopt(ASocket, ALevel, AOptName, PAnsiChar(@AOptVal), SIZE_INTEGER));
end;

function TIdStackWindows.WSGetLastError: Integer;
begin
  Result := WSAGetLastError;
end;

procedure TIdStackWindows.WSSetLastError(const AErr : Integer);
begin
  WSASetLastError(AErr);
end;

function TIdStackWindows.WSSocket(AFamily : Integer; AStruct : TIdSocketType; AProtocol: Integer;
  const AOverlapped: Boolean = False): TIdStackSocketHandle;
begin
  if AOverlapped then begin
    Result := WSASocket(AFamily, AStruct, AProtocol, nil, 0, WSA_FLAG_OVERLAPPED);
  end else begin
    Result := IdWinsock2.socket(AFamily, AStruct, AProtocol);
  end;
end;

function TIdStackWindows.WSGetServByName(const AServiceName: string): TIdPort;
var
  ps: PServEnt;
  {$IFDEF STRING_IS_UNICODE}
  LTemp: AnsiString;
  {$ENDIF}
begin
  {$IFDEF STRING_IS_UNICODE}
  LTemp := AnsiString(AServiceName); // explicit convert to Ansi
  {$ENDIF}
  ps := getservbyname(
    PAnsiChar({$IFDEF STRING_IS_UNICODE}LTemp{$ELSE}AServiceName{$ENDIF}),
    nil);
  if ps <> nil then begin
    Result := ntohs(ps^.s_port);
  end else begin
    try
      Result := IndyStrToInt(AServiceName);
    except
      on EConvertError do begin
        raise EIdInvalidServiceName.CreateFmt(RSInvalidServiceName, [AServiceName]);
      end;
    end;
  end;
end;

function TIdStackWindows.WSGetServByPort(const APortNumber: TIdPort): TStrings;
type
  // Note that there is no Unicode version of getservbyport.
  PPAnsiCharArray = ^TPAnsiCharArray;
  TPAnsiCharArray = packed array[0..(MaxLongint div SizeOf(PAnsiChar))-1] of PAnsiChar;
var
  ps: PServEnt;
  i: integer;
  p: PPAnsiCharArray;
begin
  Result := TStringList.Create;
  try
    ps := getservbyport(htons(APortNumber), nil);
    if ps <> nil then
    begin
      //we have to specifically type cast a PAnsiChar to a string for D2009+.
      //otherwise, we will get a warning about implicit typecast from AnsiString
      //to string
      Result.Add(String(PAnsiChar(ps^.s_name)));
      i := 0;
      p := Pointer(ps^.s_aliases);
      while p[i] <> nil do
      begin
        Result.Add(String(PAnsiChar(p[i])));
        Inc(i);
      end;
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TIdStackWindows.HostToNetwork(AValue: Word): Word;
begin
  Result := htons(AValue);
end;

function TIdStackWindows.NetworkToHost(AValue: Word): Word;
begin
  Result := ntohs(AValue);
end;

function TIdStackWindows.HostToNetwork(AValue: LongWord): LongWord;
begin
  Result := htonl(AValue);
end;

function TIdStackWindows.NetworkToHost(AValue: LongWord): LongWord;
begin
  Result := ntohl(AValue);
end;

function TIdStackWindows.HostToNetwork(AValue: Int64): Int64;
var
  LParts: TIdInt64Parts;
  L: LongWord;
begin
  LParts.QuadPart := AValue;
  L := htonl(LParts.HighPart);
  LParts.HighPart := htonl(LParts.LowPart);
  LParts.LowPart := L;
  Result := LParts.QuadPart;
end;

function TIdStackWindows.NetworkToHost(AValue: Int64): Int64;
var
  LParts: TIdInt64Parts;
  L: LongWord;
begin
  LParts.QuadPart := AValue;
  L := ntohl(LParts.HighPart);
  LParts.HighPart := ntohl(LParts.LowPart);
  LParts.LowPart := L;
  Result := LParts.QuadPart;
end;

procedure TIdStackWindows.AddLocalAddressesToList(AAddresses: TStrings);
{$IFNDEF WINCE}
type
  TaPInAddr = array[0..250] of PInAddr;
  PaPInAddr = ^TaPInAddr;
{$ENDIF}
var
  {$IFNDEF WINCE}
  i: integer;
  AHost: PHostEnt;
  PAdrPtr: PaPInAddr;
  {$ENDIF}
  {$IFDEF UNICODE}
  Hints: TAddrInfoW;
  LAddrList, LAddrInfo: pAddrInfoW;
  {$ELSE}
  Hints: TAddrInfo;
  LAddrList, LAddrInfo: pAddrInfo;
  {$ENDIF}
  RetVal: Integer;
  LHostName: String;
  {$IFDEF STRING_IS_UNICODE}
  LTemp: AnsiString;
  {$ELSE}
    {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
  LTemp: WideString;
    {$ENDIF}
  {$ENDIF}
begin
  LHostName := HostName;

  {$IFNDEF WINCE}
  if not GIdIPv6FuncsAvailable then
  begin
    {$IFDEF STRING_IS_UNICODE}
    LTemp := AnsiString(LHostName); // explicit convert to Ansi
    {$ENDIF}
    AHost := gethostbyname(
      PAnsiChar({$IFDEF STRING_IS_UNICODE}LTemp{$ELSE}LHostName{$ENDIF}));
    if AHost = nil then begin
      RaiseLastSocketError;
    end;
    PAdrPtr := PAPInAddr(AHost^.h_address_list);
    i := 0;
    if PAdrPtr^[i] <> nil then begin
      AAddresses.BeginUpdate;
      try
        repeat
          AAddresses.Add(TranslateTInAddrToString(PAdrPtr^[I]^, Id_IPv4)); //BGO FIX
          Inc(I);
        until PAdrPtr^[i] = nil;
      finally
        AAddresses.EndUpdate;
      end;
    end;
    Exit;
  end;
  {$ENDIF}

  ZeroMemory(@Hints, SIZE_TADDRINFO);
  Hints.ai_family := Id_PF_INET4; // TODO: support IPv6 addresses
  Hints.ai_socktype := SOCK_STREAM;
  LAddrList := nil;

  {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
  LTemp := WideString(LHostName); // explicit convert to Unicode
  {$ENDIF}

  RetVal := getaddrinfo(
    {$IFDEF UNICODE_BUT_STRING_IS_ANSI}PWideChar(LTemp){$ELSE}PChar(LHostName){$ENDIF},
    nil, @Hints, @LAddrList);
  if RetVal <> 0 then begin
    RaiseSocketError(gaiErrorToWsaError(RetVal));
  end;
  try
    AAddresses.BeginUpdate;
    try
      LAddrInfo := LAddrList;
      repeat
        AAddresses.Add(TranslateTInAddrToString(LAddrInfo^.ai_addr^.sin_addr, Id_IPv4));
        LAddrInfo := LAddrInfo^.ai_next;
      until LAddrInfo = nil;
    finally;
      AAddresses.EndUpdate;
    end;
  finally
    freeaddrinfo(LAddrList);
  end;
end;

{ TIdStackVersionWinsock }

function TIdStackWindows.WSShutdown(ASocket: TIdStackSocketHandle; AHow: Integer): Integer;
begin
  Result := Shutdown(ASocket, AHow);
end;

procedure TIdStackWindows.GetSocketName(ASocket: TIdStackSocketHandle;
  var VIP: string; var VPort: TIdPort; var VIPVersion: TIdIPVersion);
var
  LSize: Integer;
  LAddr: TSockAddrIn6;
begin
  LSize := SizeOf(LAddr);
  CheckForSocketError(getsockname(ASocket, PSOCKADDR(@LAddr), LSize));
  case LAddr.sin6_family of
    Id_PF_INET4: begin
      with PSOCKADDR(@LAddr)^ do
      begin
        VIP := TranslateTInAddrToString(sin_addr, Id_IPv4);
        VPort := ntohs(sin_port);
      end;
      VIPVersion := Id_IPv4;
    end;
    Id_PF_INET6: begin
      with LAddr do
      begin
        VIP := TranslateTInAddrToString(sin6_addr, Id_IPv6);
        VPort := Ntohs(sin6_port);
      end;
      VIPVersion := Id_IPv6;
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackWindows.WSGetSockOpt(ASocket: TIdStackSocketHandle;
  Alevel, AOptname: Integer; AOptval: PAnsiChar; var AOptlen: Integer);
begin
  CheckForSocketError(getsockopt(ASocket, ALevel, AOptname, AOptval, AOptlen));
end;

{ TIdSocketListWindows }

procedure TIdSocketListWindows.Add(AHandle: TIdStackSocketHandle);
begin
  Lock;
  try
    if FFDSet.fd_count >= FD_SETSIZE then begin
      raise EIdStackSetSizeExceeded.Create(RSSetSizeExceeded);
    end;
    FFDSet.fd_array[FFDSet.fd_count] := AHandle;
    Inc(FFDSet.fd_count);
  finally
    Unlock;
  end;
end;

procedure TIdSocketListWindows.Clear;
begin
  Lock;
  try
    fd_zero(FFDSet);
  finally
    Unlock;
  end;
end;

function TIdSocketListWindows.ContainsSocket(AHandle: TIdStackSocketHandle): Boolean;
begin
  Lock;
  try
    Result := fd_isset(AHandle, FFDSet);
  finally
    Unlock;
  end;
end;

function TIdSocketListWindows.Count: Integer;
begin
  Lock;
  try
    Result := FFDSet.fd_count;
  finally
    Unlock;
  end;
end;

function TIdSocketListWindows.GetItem(AIndex: Integer): TIdStackSocketHandle;
begin
  Result := 0;
  Lock;
  try
    //We can't redefine AIndex to be a LongWord because the libc Interface
    //and DotNET define it as a LongInt.  OS/2 defines it as a Word.
    if (AIndex >= 0) and (u_int(AIndex) < FFDSet.fd_count) then begin
      Result := FFDSet.fd_array[AIndex];
    end else begin
      raise EIdStackSetSizeExceeded.Create(RSSetSizeExceeded);
    end;
  finally
    Unlock;
   end;
end;

procedure TIdSocketListWindows.Remove(AHandle: TIdStackSocketHandle);
var
  i: Integer;
begin
  Lock;
  try
    {
    IMPORTANT!!!

    Sometimes, there may not be a member of the FDSET.  If you attempt to "remove"
    an item, the loop would execute once.
    }
    if FFDSet.fd_count > 0 then
    begin
      for i:= 0 to FFDSet.fd_count - 1 do
      begin
        if FFDSet.fd_array[i] = AHandle then
        begin
          Dec(FFDSet.fd_count);
          FFDSet.fd_array[i] := FFDSet.fd_array[FFDSet.fd_count];
          FFDSet.fd_array[FFDSet.fd_count] := 0; //extra purity
          Break;
        end;//if found
      end;
    end;
  finally
    Unlock;
  end;
end;

function TIdStackWindows.WSTranslateSocketErrorMsg(const AErr: Integer): string;
begin
  if AErr = WSAHOST_NOT_FOUND then begin
    Result := IndyFormat(RSStackError, [AErr, RSStackHOST_NOT_FOUND]);
  end else begin
    Result :=  inherited WSTranslateSocketErrorMsg(AErr);
  end;
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
  LTimePtr: PTimeVal;
begin
  if ATimeout = IdTimeoutInfinite then begin
    LTimePtr := nil;
  end else begin
    LTime.tv_sec := ATimeout div 1000;
    LTime.tv_usec := (ATimeout mod 1000) * 1000;
    LTimePtr := @LTime;
  end;
  LResult := IdWinsock2.select(0, AReadSet, AWriteSet, AExceptSet, LTimePtr);
  //TODO: Remove this cast
  Result := GBSDStack.CheckForSocketError(LResult) > 0;
end;

function TIdSocketListWindows.SelectReadList(var VSocketList: TIdSocketList;
  const ATimeout: Integer): Boolean;
var
  LSet: TFDSet;
begin
  // Windows updates this structure on return, so we need to copy it each time we need it
  GetFDSet(LSet);
  FDSelect(@LSet, nil, nil, ATimeout);
  Result := LSet.fd_count > 0;
  if Result then
  begin
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

  Result := FDSelect(LPReadSet, LPWriteSet, LPExceptSet, ATimeout);

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
  Lock;
  try
    FFDSet := VSet;
  finally
    Unlock;
  end;
end;

procedure TIdSocketListWindows.GetFDSet(var VSet: TFDSet);
begin
  Lock;
  try
    VSet := FFDSet;
  finally
    Unlock;
  end;
end;

procedure TIdStackWindows.SetBlocking(ASocket: TIdStackSocketHandle;
  const ABlocking: Boolean);
var
  LValue: LongWord;
begin
  LValue := LongWord(not ABlocking);
  CheckForSocketError(ioctlsocket(ASocket, FIONBIO, LValue));
end;

function TIdSocketListWindows.Clone: TIdSocketList;
begin
  Result := TIdSocketListWindows.Create;
  try
    Lock;
    try
      TIdSocketListWindows(Result).SetFDSet(FFDSet);
    finally
      Unlock;
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TIdStackWindows.WouldBlock(const AResult: Integer): Boolean;
begin
  Result := CheckForSocketError(AResult, [WSAEWOULDBLOCK]) <> 0;
end;

function TIdStackWindows.HostByName(const AHostName: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
var
  LPa: PAnsiChar;
  LSa: TInAddr;
  {$IFNDEF WINCE}
  LHost: PHostEnt;
  {$ENDIF}
  {$IFDEF UNICODE}
  LAddrInfo: pAddrInfoW;
  Hints: TAddrInfoW;
  {$ELSE}
  LAddrInfo: pAddrInfo;
  Hints: TAddrInfo;
  {$ENDIF}
  RetVal: Integer;
  {$IFDEF STRING_IS_UNICODE}
  LTemp: AnsiString;
  {$ELSE}
    {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
  LTemp: WideString;
    {$ENDIF}
  {$ENDIF}
begin
  //GetHostByName and GetHostByAddr may not be availble in future versions
  //of Windows CE.  Those functions are depreciated in favor of the new
  //getaddrinfo and getname functions even in Windows so they should be used
  //when available anyway.
  //We do have to use the depreciated functions in Windows NT 4.0, probably
  //Windows 2000, and of course Win9x so fall to our old code in these cases.
  {$IFNDEF WINCE}
  if not GIdIPv6FuncsAvailable then
  begin
    case AIPVersion of
      Id_IPv4:
        begin
          {$IFDEF STRING_IS_UNICODE}
          LTemp := AnsiString(AHostName); // explicit convert to Ansi
          {$ENDIF}
          LHost := IdWinsock2.gethostbyname(
            PAnsiChar({$IFDEF STRING_IS_UNICODE}LTemp{$ELSE}AHostName{$ENDIF}));
          if LHost = nil then begin
            RaiseLastSocketError;
          end;
          LPa := LHost^.h_address_list^;
          LSa.S_un_b.s_b1 := Ord(LPa[0]);
          LSa.S_un_b.s_b2 := Ord(LPa[1]);
          LSa.S_un_b.s_b3 := Ord(LPa[2]);
          LSa.S_un_b.s_b4 := Ord(LPa[3]);
          Result := TranslateTInAddrToString(LSa, Id_IPv4);
        end;
      Id_IPv6: begin
        raise EIdIPv6Unavailable.Create(RSIPv6Unavailable);
      end;
    else
      IPVersionUnsupported;
    end;
    Exit;
  end;
  {$ENDIF}

  if not (AIPVersion in [Id_IPv4, Id_IPv6]) then begin
    IPVersionUnsupported;
  end;

  ZeroMemory(@Hints, SIZE_TADDRINFO);
  Hints.ai_family := IdIPFamily[AIPVersion];
  Hints.ai_socktype := SOCK_STREAM;
  LAddrInfo := nil;

  {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
  LTemp := WideString(AHostName); // explicit convert to Unicode
  {$ENDIF}

  RetVal := getaddrinfo(
    {$IFDEF UNICODE_BUT_STRING_IS_ANSI}PWideChar(LTemp){$ELSE}PChar(AHostName){$ENDIF},
    nil, @Hints, @LAddrInfo);
  if RetVal <> 0 then begin
    RaiseSocketError(gaiErrorToWsaError(RetVal));
  end;
  try
    if AIPVersion = Id_IPv4 then begin
      Result := TranslateTInAddrToString(LAddrInfo^.ai_addr^.sin_addr, AIPVersion)
    end else begin
      Result := TranslateTInAddrToString(LAddrInfo^.ai_addr^.sin_zero, AIPVersion);
    end;
  finally
    freeaddrinfo(LAddrInfo);
  end;
end;

procedure TIdStackWindows.Connect(const ASocket: TIdStackSocketHandle;
  const AIP: string; const APort: TIdPort;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LAddr: TSockAddrIn6;
  LSize: Integer;
begin
  FillChar(LAddr, SizeOf(LAddr), 0);
  case AIPVersion of
    Id_IPv4: begin
      with PSOCKADDR(@LAddr)^ do
      begin
        sin_family := Id_PF_INET4;
        TranslateStringToTInAddr(AIP, sin_addr, Id_IPv4);
        sin_port := htons(APort);
      end;
      LSize := SIZE_TSOCKADDRIN;
    end;
    Id_IPv6: begin
      with LAddr do
      begin
        sin6_family := Id_PF_INET6;
        TranslateStringToTInAddr(AIP, sin6_addr, Id_IPv6);
        sin6_port := htons(APort);
      end;
      LSize := SIZE_TSOCKADDRIN6;
    end;
    else begin
      LSize := 0; // avoid warning
      IPVersionUnsupported;
    end;
  end;
  CheckForSocketError(IdWinsock2.connect(ASocket, PSOCKADDR(@LAddr), LSize));
end;

procedure TIdStackWindows.GetPeerName(ASocket: TIdStackSocketHandle;
  var VIP: string; var VPort: TIdPort; var VIPVersion: TIdIPVersion);
var
  LSize: Integer;
  LAddr: TSockAddrIn6;
begin
  LSize := SizeOf(LAddr);
  CheckForSocketError(IdWinsock2.getpeername(ASocket, PSOCKADDR(@LAddr), LSize));
  case LAddr.sin6_family of
    Id_PF_INET4: begin
      with PSOCKADDR(@LAddr)^ do
      begin
        VIP := TranslateTInAddrToString(sin_addr, Id_IPv4);
        VPort := ntohs(sin_port);
      end;
      VIPVersion := Id_IPv4;
    end;
    Id_PF_INET6: begin
      with LAddr do
      begin
        VIP := TranslateTInAddrToString(sin6_addr, Id_IPv6);
        VPort := ntohs(sin6_port);
      end;
      VIPVersion := Id_IPv6;
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

procedure TIdStackWindows.SetSocketOption(const ASocket: TIdStackSocketHandle;
  const Alevel, Aoptname: Integer; Aoptval: PAnsiChar; const Aoptlen: Integer);
begin
  CheckForSocketError(setsockopt(ASocket, ALevel, Aoptname, Aoptval, Aoptlen));
end;

procedure TIdStackWindows.GetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption; out AOptVal: Integer);
var
  LP : PAnsiChar;
  LLen : Integer;
  LBuf : Integer;
begin
  LP := PAnsiChar(@LBuf);
  LLen := SIZE_INTEGER;
  WSGetSockOpt(ASocket, ALevel, AOptName, LP, LLen);
  AOptVal := LBuf;
end;

{
based on
http://groups.google.com/groups?q=Winsock2+Delphi+protocol&hl=en&lr=&ie=UTF-8&oe=utf-8&selm=3cebe697_2%40dnews&rnum=9
}
function TIdStackWindows.SupportsIPv6: Boolean;
var
  LLen : LongWord;
  LPInfo, LPCurPtr: LPWSAPROTOCOL_INFO;
  LCount : Integer;
  i : Integer;
begin
  Result := False;
  LLen := 0;
  // Note: WSAEnumProtocols returns -1 when it is just called to get the needed Buffer Size!
  if (IdWinsock2.WSAEnumProtocols(nil, nil, LLen) = SOCKET_ERROR) and (LLen > 0) then
  begin
    GetMem(LPInfo, LLen);
    try
      LCount := IdWinsock2.WSAEnumProtocols(nil, LPInfo, LLen);
      if LCount > 0 then
      begin
        LPCurPtr := LPInfo;
        for i := 0 to LCount-1 do
        begin
          if LPCurPtr^.iAddressFamily = PF_INET6 then
          begin
            Result := True;
            Break;
          end;
          Inc(LPCurPtr);
        end;
      end;
    finally
      FreeMem(LPInfo);
    end;
  end;
end;

function TIdStackWindows.IOControl(const s: TIdStackSocketHandle;
  const cmd: LongWord; var arg: LongWord): Integer;
begin
  Result := IdWinsock2.ioctlsocket(s, cmd, arg);
end;

procedure TIdStackWindows.WSQuerryIPv6Route(ASocket: TIdStackSocketHandle;
  const AIP: String; const APort: TIdPort; var VSource; var VDest);
var
  Llocalif : SOCKADDR_STORAGE;
  LPLocalIP : PSOCKADDR_IN6;
  LAddr : TSockAddrIn6;
  Bytes : LongWord;
begin
  {
  if not GIdIPv6FuncsAvailable then begin
    EIdIPv6Unavailable.Toss(RSIPv6Unavailable);
  end;
  }
  //make our LAddrInfo structure
  FillChar(LAddr, SizeOf(LAddr), 0);
  with LAddr do
  begin
    sin6_family := AF_INET6;
    TranslateStringToTInAddr(AIP, sin6_addr, Id_IPv6);
    Move(sin6_addr, VDest, SizeOf(in6_addr));
    sin6_port := htons(APort);
  end;
  LPLocalIP := PSOCKADDR_IN6(@Llocalif);
  // Find out which local interface for the destination
  CheckForSocketError(WSAIoctl(ASocket, SIO_ROUTING_INTERFACE_QUERY,
    @LAddr, SizeOf(LAddr), @Llocalif, SizeOf(Llocalif), @Bytes, nil, nil));
  Move(LPLocalIP^.sin6_addr, VSource, SizeOf(in6_addr));
end;

procedure TIdStackWindows.WriteChecksum(s: TIdStackSocketHandle;
  var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
  const APort: TIdPort; const AIPVersion: TIdIPVersion);
begin
  case AIPVersion of
    Id_IPv4 : CopyTIdWord(HostToLittleEndian(CalcCheckSum(VBuffer)), VBuffer, AOffset);
    Id_IPv6 : WriteChecksumIPv6(s, VBuffer, AOffset, AIP, APort);
  else
    IPVersionUnsupported;
  end;
end;

procedure TIdStackWindows.WriteChecksumIPv6(s: TIdStackSocketHandle;
  var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
  const APort: TIdPort);
var 
  LSource : TIdIn6Addr;
  LDest : TIdIn6Addr;
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
  WSQuerryIPv6Route(s, AIP, APort, LSource, LDest);
  SetLength(LTmp, Length(VBuffer)+40);

  //16
  Move(LSource, LTmp[0], SIZE_TSOCKADDRIN6);
  LIdx := SIZE_TSOCKADDRIN6;
  //32
  Move(LDest, LTmp[LIdx], SIZE_TSOCKADDRIN6);
  Inc(LIdx, SIZE_TSOCKADDRIN6);
  //use a word so you don't wind up using the wrong network byte order function
  LC := LongWord(Length(VBuffer));
  CopyTIdLongWord(GStack.HostToNetwork(LC), LTmp, LIdx);
  Inc(LIdx, 4);
  //36
  //zero the next three bytes
  FillChar(LTmp[LIdx], 3, 0);
  Inc(LIdx, 3);
  //next header (protocol type determines it
  LTmp[LIdx] := Id_IPPROTO_ICMPV6; // Id_IPPROTO_ICMP6;
  Inc(LIdx);
  //zero our checksum feild for now
  VBuffer[2] := 0;
  VBuffer[3] := 0;
  //combine the two
  CopyTIdBytes(VBuffer, 0, LTmp, LIdx, Length(VBuffer));
  LW := CalcCheckSum(LTmp);

  CopyTIdWord(HostToLittleEndian(LW), VBuffer, AOffset);
end;

function TIdStackWindows.ReceiveMsg(ASocket: TIdStackSocketHandle; var VBuffer : TIdBytes;
  APkt: TIdPacketInfo): LongWord;
var
  LIP : String;
  LPort : TIdPort;
  LIPVersion : TIdIPVersion;
  {Windows CE does not have WSARecvMsg}
   {$IFNDEF WINCE}
  LSize: PtrUInt;
  LAddr: TSockAddrIn6;
  LMsg : TWSAMSG;
  LMsgBuf : TWSABUF;
  LControl : TIdBytes;
  LCurCmsg : LPWSACMSGHDR;   //for iterating through the control buffer
  {$ENDIF}
begin
  {$IFNDEF WINCE}
  //This runs only on WIndows XP or later
  // XP 5.1 at least, Vista 6.0
  if (Win32MajorVersion > 5) or
    ((Win32MajorVersion = 5) and (Win32MinorVersion >= 1)) then
  begin
    //we call the macro twice because we specified two possible structures.
    //Id_IPV6_HOPLIMIT and Id_IPV6_PKTINFO
    LSize := WSA_CMSG_LEN(WSA_CMSG_LEN(Length(VBuffer)));
    SetLength(LControl, LSize);

    LMsgBuf.len := Length(VBuffer); // Length(VMsgData);
    LMsgBuf.buf := PAnsiChar(@VBuffer[0]); // @VMsgData[0];

    FillChar(LMsg, SIZE_TWSAMSG, 0);

    LMsg.lpBuffers := @LMsgBuf;
    LMsg.dwBufferCount := 1;

    LMsg.Control.Len := LSize;
    LMsg.Control.buf := PAnsiChar(@LControl[0]);

    LMsg.name :=  PSOCKADDR(@LAddr);
    LMsg.namelen := SizeOf(LAddr);

    CheckForSocketError(WSARecvMsg(ASocket, @LMsg, Result, nil, nil));
    APkt.Reset;

    case LAddr.sin6_family of
      Id_PF_INET4: begin
        with PSOCKADDR(@LAddr)^ do
        begin
          APkt.SourceIP := TranslateTInAddrToString(sin_addr, Id_IPv4);
          APkt.SourcePort := ntohs(sin_port);
        end;
        APkt.SourceIPVersion := Id_IPv4;
      end;
      Id_PF_INET6: begin
        with LAddr do
        begin
          APkt.SourceIP := TranslateTInAddrToString(sin6_addr, Id_IPv6);
          APkt.SourcePort := ntohs(sin6_port);
        end;
        APkt.SourceIPVersion := Id_IPv6;
      end;
      else begin
        Result := 0; // avoid warning
        IPVersionUnsupported;
      end;
    end;

    LCurCmsg := nil;
    repeat
      LCurCmsg := WSA_CMSG_NXTHDR(@LMsg, LCurCmsg);
      if LCurCmsg = nil then begin
        Break;
      end;
      case LCurCmsg^.cmsg_type of
        IP_PKTINFO :     //done this way because IPV6_PKTINF and  IP_PKTINFO are both 19
        begin
          case LAddr.sin6_family of
            Id_PF_INET4: begin
              with PInPktInfo(WSA_CMSG_DATA(LCurCmsg))^ do begin
                APkt.DestIP := TranslateTInAddrToString(ipi_addr, Id_IPv4);
                APkt.DestIF := ipi_ifindex;
              end;
              APkt.DestIPVersion := Id_IPv4;
            end;
            Id_PF_INET6: begin
              with PIn6PktInfo(WSA_CMSG_DATA(LCurCmsg))^ do begin
                APkt.DestIP := TranslateTInAddrToString(ipi6_addr, Id_IPv6);
                APkt.DestIF := ipi6_ifindex;
              end;
              APkt.DestIPVersion := Id_IPv6;
            end;
          end;
        end;
        Id_IPV6_HOPLIMIT :
        begin
          APkt.TTL := WSA_CMSG_DATA(LCurCmsg)^;
        end;
      end;
    until False;
  end else
  begin
  {$ENDIF}
    Result := RecvFrom(ASocket, VBuffer, Length(VBuffer), 0, LIP, LPort, LIPVersion);
    APkt.Reset;
    APkt.SourceIP := LIP;
    APkt.SourcePort := LPort;
    APkt.SourceIPVersion := LIPVersion;
    APkt.DestIPVersion := LIPVersion;
  {$IFNDEF WINCE}
  end;
  {$ENDIF}
end;

function TIdStackWindows.CheckIPVersionSupport(const AIPVersion: TIdIPVersion): Boolean;
var
  LTmpSocket: TIdStackSocketHandle;
begin
  LTmpSocket := WSSocket(IdIPFamily[AIPVersion], Id_SOCK_STREAM, Id_IPPROTO_IP);
  Result := LTmpSocket <> Id_INVALID_SOCKET;
  if Result then begin
    WSCloseSocket(LTmpSocket);
  end;
end;

{$IFNDEF WINCE}
{
This is somewhat messy but I wanted to do things this way to support Int64
file sizes.
}
function ServeFile(ASocket: TIdStackSocketHandle; const AFileName: string): Int64;
var
  LFileHandle: THandle;
  LSize: LARGE_INTEGER;
  {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
  LTemp: WideString;
  {$ENDIF}
begin
  Result := 0;

  {$IFDEF UNICODE_BUT_STRING_IS_ANSI}
  LTemp := WideString(AFileName); // explicit convert to Unicode
  {$ENDIF}

  LFileHandle := CreateFile(
    {$IFDEF UNICODE_BUT_STRING_IS_ANSI}PWideChar(LTemp){$ELSE}PChar(AFileName){$ENDIF},
    GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING,
    FILE_ATTRIBUTE_NORMAL or FILE_FLAG_SEQUENTIAL_SCAN, 0);

  if LFileHandle <> INVALID_HANDLE_VALUE then
  begin
    try
      if TransmitFile(ASocket, LFileHandle, 0, 0, nil, nil, 0) then
      begin
        if Assigned(GetFileSizeEx) then
        begin
          if not GetFileSizeEx(LFileHandle, LSize) then begin
            Exit;
          end;
        end else
        begin
          LSize.LowPart := GetFileSize(LFileHandle, @LSize.HighPart);
          if (LSize.LowPart = $FFFFFFFF) and (GetLastError() <> 0) then begin
            Exit;
          end;
        end;
        Result := LSize.QuadPart;
      end;
    finally
      CloseHandle(LFileHandle);
    end;
  end;
end;
{$ENDIF}

initialization
  GStarted := False;
  GSocketListClass := TIdSocketListWindows;
  // Check if we are running under windows NT
  {$IFNDEF WINCE}
  if Win32Platform = VER_PLATFORM_WIN32_NT then begin
    GetFileSizeEx := Windows.GetProcAddress(GetModuleHandle('Kernel32.dll'), 'GetFileSizeEx');
    GServeFileProc := ServeFile;
  end;
  {$ENDIF}
finalization
  if GStarted then begin
    IdWship6.CloseLibrary;
    UninitializeWinSock;
    GStarted := False;
  end;

end.
