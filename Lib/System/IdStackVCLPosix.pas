unit IdStackVCLPosix;

interface

{$I IdCompilerDefines.inc}

{IMPORTANT!!!

Platform warnings in this unit should be disabled because Indy we have no
intention of porting this unit to Windows or any non-Unix-like operating system.

Any differences between Unix-like operating systems have to dealt with in other
ways.
}

{$WARN SYMBOL_PLATFORM OFF}
{$WARN UNIT_PLATFORM OFF}
uses
  Classes,
  IdCTypes,
  Posix.SysSelect,
  Posix.SysSocket,
  Posix.SysTime,
  IdStack,
  IdStackConsts,
  IdGlobal,
  IdStackBSDBase;

type

  TIdSocketListVCLPosix = class (TIdSocketList)
  protected
    FCount: Integer;
    FFDSet: fd_set;
    //
    class function FDSelect(AReadSet, AWriteSet,
      AExceptSet: Pfd_set; const ATimeout: Integer): Integer;
    function GetItem(AIndex: Integer): TIdStackSocketHandle; override;
  public


    procedure Add(AHandle: TIdStackSocketHandle); override;
    procedure Remove(AHandle: TIdStackSocketHandle); override;
    function Count: Integer; override;
    procedure Clear; override;
    function Clone: TIdSocketList; override;
    function ContainsSocket(AHandle: TIdStackSocketHandle): Boolean; override;
    procedure GetFDSet(var VSet: fd_set);
    procedure SetFDSet(var VSet: fd_set);
    class function Select(AReadList: TIdSocketList; AWriteList: TIdSocketList;
      AExceptList: TIdSocketList; const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
    function SelectRead(const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
    function SelectReadList(var VSocketList: TIdSocketList;
      const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
  end;

  TIdStackVCLPosix = class(TIdStackBSDBase)
  protected
//    procedure SetSocketOption(ASocket: TIdStackSocketHandle;
//      ALevel: TIdSocketProtocol; AOptName: TIdSocketOption; AOptVal: Integer);
    procedure WriteChecksumIPv6(s: TIdStackSocketHandle; var VBuffer: TIdBytes;
      const AOffset: Integer; const AIP: String; const APort: TIdPort);
    function GetLastError: Integer;
    procedure SetLastError(const AError: Integer);
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
    constructor Create; override;
    destructor Destroy; override;
    procedure SetBlocking(ASocket: TIdStackSocketHandle; const ABlocking: Boolean); override;
    function WouldBlock(const AResult: Integer): Boolean; override;
    function Accept(ASocket: TIdStackSocketHandle; var VIP: string; var VPort: TIdPort;
      var VIPVersion: TIdIPVersion): TIdStackSocketHandle; override;
    procedure Bind(ASocket: TIdStackSocketHandle; const AIP: string;
     const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure Connect(const ASocket: TIdStackSocketHandle; const AIP: string;
     const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    function HostByAddress(const AAddress: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;
    function WSGetLastError: Integer; override;
    procedure WSSetLastError(const AErr : Integer); override;
    function WSGetServByName(const AServiceName: string): TIdPort; override;
    procedure AddServByPortToList(const APortNumber: TIdPort; AAddresses: TStrings); override;
    procedure WSGetSockOpt(ASocket: TIdStackSocketHandle; Alevel, AOptname: Integer;
      AOptval: PAnsiChar; var AOptlen: Integer); override;
    procedure GetSocketOption(ASocket: TIdStackSocketHandle;
      ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption;
      out AOptVal: Integer); override;
    procedure GetPeerName(ASocket: TIdStackSocketHandle; var VIP: string;
     var VPort: TIdPort; var VIPVersion: TIdIPVersion); override;
    procedure GetSocketName(ASocket: TIdStackSocketHandle; var VIP: string;
     var VPort: TIdPort; var VIPVersion: TIdIPVersion); override;
    procedure Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer); override;
    function HostToNetwork(AValue: Word): Word; override;
    function NetworkToHost(AValue: Word): Word; override;
    function HostToNetwork(AValue: LongWord): LongWord; override;
    function NetworkToHost(AValue: LongWord): LongWord; override;
    function HostToNetwork(AValue: Int64): Int64; override;
    function NetworkToHost(AValue: Int64): Int64; override;
    function RecvFrom(const ASocket: TIdStackSocketHandle;
      var VBuffer; const ALength, AFlags: Integer; var VIP: string;
      var VPort: TIdPort; var VIPVersion: TIdIPVersion): Integer; override;
    function ReceiveMsg(ASocket: TIdStackSocketHandle;
      var VBuffer: TIdBytes; APkt: TIdPacketInfo): LongWord;  override;
    procedure WSSendTo(ASocket: TIdStackSocketHandle; const ABuffer;
      const ABufferLength, AFlags: Integer; const AIP: string; const APort: TIdPort;
      AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    function WSSocket(AFamily : Integer; AStruct : TIdSocketType; AProtocol: Integer;
      const AOverlapped: Boolean = False): TIdStackSocketHandle; override;
    procedure Disconnect(ASocket: TIdStackSocketHandle); override;
    procedure SetSocketOption(ASocket: TIdStackSocketHandle; ALevel: TIdSocketOptionLevel;
      AOptName: TIdSocketOption; AOptVal: Integer); overload;override;
    procedure SetSocketOption( const ASocket: TIdStackSocketHandle;
      const Alevel, Aoptname: Integer; Aoptval: PAnsiChar; const Aoptlen: Integer); overload; override;
    function SupportsIPv6: Boolean; overload; override;
    function CheckIPVersionSupport(const AIPVersion: TIdIPVersion): boolean; override;
    //In Windows, this writes a checksum into a buffer.  In Linux, it would probably
    //simply have the kernal write the checksum with something like this (RFC 2292):
//
//    int  offset = 2;
//    setsockopt(fd, IPPROTO_IPV6, IPV6_CHECKSUM, &offset, sizeof(offset));
//
//  Note that this should be called
    //IMMEDIATELY before you do a SendTo because the Local IPv6 address might change

    procedure WriteChecksum(s : TIdStackSocketHandle; var VBuffer : TIdBytes;
      const AOffset : Integer; const AIP : String; const APort : TIdPort;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    function IOControl(const s: TIdStackSocketHandle; const cmd: LongWord;
      var arg: LongWord): Integer; override;

    procedure AddLocalAddressesToList(AAddresses: TStrings); override;
  end;

implementation

{$O-}

uses
  IdResourceStrings,
  IdException,
  IdVCLPosixSupplemental,
  Posix.Base,
  Posix.ArpaInet,
  Posix.Errno,
  Posix.NetDB,
  Posix.NetinetIn,
  Posix.StrOpts,
  Posix.SysTypes,
  Posix.SysUio,
  Posix.Unistd,
  SysUtils;

  {$UNDEF HAS_MSG_NOSIGNAL}
  {$IFDEF LINUX}  //this LINUX ifdef is deliberate
    {$DEFINE HAS_MSG_NOSIGNAL}
  {$ENDIF}


const
  {$IFDEF HAS_MSG_NOSIGNAL}
  //fancy little trick since OS X does not have MSG_NOSIGNAL
  Id_MSG_NOSIGNAL = MSG_NOSIGNAL;
  {$ELSE}
    Id_MSG_NOSIGNAL = 0;
  {$ENDIF}
  Id_WSAEPIPE = EPIPE;



//helper functions for some structs

{Note:  These hide an API difference in structures.

BSD 4.4 introduced a minor API change.  sa_family was changed from a 16bit
word to an 8 bit byteee and an 8 bit byte feild named sa_len was added.

}
procedure InitSockAddr_In(var VSock : SockAddr_In);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  FillChar(VSock, SizeOf(SockAddr_In), 0);
  VSock.sin_family := PF_INET;
  {$IFDEF SOCK_HAS_SINLEN}
  VSock.sin_len := SizeOf(SockAddr_In);
  {$ENDIF}
end;

procedure InitSockAddr_in6(var VSock : SockAddr_in6);
{$IFDEF USE_INLINE} inline; {$ENDIF}
begin
  FillChar(VSock, SizeOf(SockAddr_in6), 0);
  {$IFDEF SOCK_HAS_SINLEN}
  VSock.sin6_len := SizeOf(SockAddr_in6);
  {$ENDIF}
  VSock.sin6_family := PF_INET6;
end;
//

{ TIdSocketListVCLPosix }

procedure TIdSocketListVCLPosix.Add(AHandle: TIdStackSocketHandle);
begin
  Lock;
  try
    if not __FD_ISSET(AHandle, FFDSet) then begin
      if Count >= FD_SETSIZE then begin
        raise EIdStackSetSizeExceeded.Create(RSSetSizeExceeded);
      end;
      __FD_SET(AHandle, FFDSet);
      Inc(FCount);
    end;
  finally
    Unlock;
  end;
end;

procedure TIdSocketListVCLPosix.Clear;
begin
  Lock;
  try
    __FD_ZERO(FFDSet);
    FCount := 0;
  finally
    Unlock;
  end;
end;

function TIdSocketListVCLPosix.Clone: TIdSocketList;
begin
  Result := TIdSocketListVCLPosix.Create;
  try
    Lock;
    try
      TIdSocketListVCLPosix(Result).SetFDSet(FFDSet);
    finally
      Unlock;
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TIdSocketListVCLPosix.ContainsSocket(
  AHandle: TIdStackSocketHandle): Boolean;
begin
  Lock;
  try
    Result := __FD_ISSET(AHandle, FFDSet);
  finally
    Unlock;
  end;
end;

function TIdSocketListVCLPosix.Count: Integer;
begin
  Lock;
  try
    Result := FCount;
  finally
    Unlock;
  end;
end;

class function TIdSocketListVCLPosix.FDSelect(AReadSet, AWriteSet,
  AExceptSet: Pfd_set; const ATimeout: Integer): Integer;
var
  LTime: TimeVal;
  LTimePtr: PTimeVal;
begin
  if ATimeout = IdTimeoutInfinite then begin
    LTimePtr := nil;
  end else begin
    LTime.tv_sec := ATimeout div 1000;
    LTime.tv_usec := (ATimeout mod 1000) * 1000;
    LTimePtr := @LTime;
  end;
  Result := Posix.SysSelect.select(MaxLongint, AReadSet, AWriteSet, AExceptSet, LTimePtr);
end;

procedure TIdSocketListVCLPosix.GetFDSet(var VSet: fd_set);
begin
  Lock;
  try
    VSet := FFDSet;
  finally
    Unlock;
  end;
end;

function TIdSocketListVCLPosix.GetItem(AIndex: Integer): TIdStackSocketHandle;
var
  LIndex, i: Integer;
begin
  Result := 0;
  Lock;
  try
    LIndex := 0;
    //? use FMaxHandle div x
    for i:= 0 to FD_SETSIZE - 1 do begin
      if __FD_ISSET(i, FFDSet) then begin
        if LIndex = AIndex then begin
          Result := i;
          Break;
        end;
        Inc(LIndex);
      end;
    end;
  finally
    Unlock;
  end;
end;

procedure TIdSocketListVCLPosix.Remove(AHandle: TIdStackSocketHandle);
begin
  Lock;
  try
    if __FD_ISSET(AHandle, FFDSet) then begin
      Dec(FCount);
      __FD_CLR(AHandle, FFDSet);
    end;
  finally
    Unlock;
  end;
end;

class function TIdSocketListVCLPosix.Select(AReadList, AWriteList,
  AExceptList: TIdSocketList; const ATimeout: Integer): Boolean;

var
  LReadSet: fd_set;
  LWriteSet: fd_set;
  LExceptSet: fd_set;
  LPReadSet: Pfd_set;
  LPWriteSet: Pfd_set;
  LPExceptSet: Pfd_set;

  procedure ReadSet(AList: TIdSocketList; var ASet: fd_set; var APSet: Pfd_set);
  begin
    if AList <> nil then begin
      TIdSocketListVCLPosix(AList).GetFDSet(ASet);
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
  Result := FDSelect(LPReadSet, LPWriteSet, LPExceptSet, ATimeout) >0;
  //
  if AReadList <> nil then begin
    TIdSocketListVCLPosix(AReadList).SetFDSet(LReadSet);
  end;
  if AWriteList <> nil then begin
    TIdSocketListVCLPosix(AWriteList).SetFDSet(LWriteSet);
  end;
  if AExceptList <> nil then begin
    TIdSocketListVCLPosix(AExceptList).SetFDSet(LExceptSet);
  end;
end;

function TIdSocketListVCLPosix.SelectRead(const ATimeout: Integer): Boolean;
var
  LSet: fd_set;
begin
  Lock;
  try
    LSet := FFDSet;
    // select() updates this structure on return,
    // so we need to copy it each time we need it
  finally
    Unlock;
  end;
  Result := FDSelect(@LSet, nil, nil, ATimeout) > 0;
end;

function TIdSocketListVCLPosix.SelectReadList(var VSocketList: TIdSocketList;
  const ATimeout: Integer): Boolean;
var
  LSet: fd_set;
begin
  Lock;
  try
    LSet := FFDSet;
    // select() updates this structure on return,
    // so we need to copy it each time we need it
  finally
    Unlock;
  end;
  Result := FDSelect(@LSet, nil, nil, ATimeout) > 0;
  if Result then begin
    if VSocketList = nil then begin
      VSocketList := TIdSocketList.CreateSocketList;
    end;
    TIdSocketListVCLPosix(VSocketList).SetFDSet(LSet);
  end;
end;

procedure TIdSocketListVCLPosix.SetFDSet(var VSet: fd_set);
begin
  Lock;
  try
    FFDSet := VSet;
  finally
    Unlock;
  end;
end;

{ TIdStackVCLPosix }

{
IMPORTANT!!!

Throughout much of this code, you will see stuff such as:

var
  LAddrStore: sockaddr_storage;
  LAddrIPv4 : SockAddr_In absolute LAddrStore;
  LAddrIPv6 : sockaddr_in6 absolute LAddrStore;
  LAddr : sockaddr absolute LAddrStore;

This is just a fancy way to do typecasting with various types of address type.
Many functions take a sockaddr parameter but that parameter is typecast for various
address types.  The structures mentioned above are designed just for such
typecasting.  The reason we use sockaddr_storage instead of sockaddr is that
we need something that is guaranteed to be able to contain various address types
and sockaddr would be too short for some of them and we can't know what
someone else will add to Indy as time goes by.
}

function TIdStackVCLPosix.Accept(ASocket: TIdStackSocketHandle; var VIP: string;
  var VPort: TIdPort; var VIPVersion: TIdIPVersion): TIdStackSocketHandle;
var
  LN: socklen_t;
  LAddrStore: sockaddr_storage;
  LAddrIPv4 : SockAddr_In absolute LAddrStore;
  LAddrIPv6 : sockaddr_in6 absolute LAddrStore;
  LAddr : sockaddr absolute LAddrStore;

begin
  Result := Posix.SysSocket.accept(ASocket, LAddr, LN);
  if Result <> -1 then begin
    case LAddr.sa_family of
      Id_PF_INET4: begin
        VIP := TranslateTInAddrToString( LAddrIPv4.sin_addr, Id_IPv4);
        VPort := Ntohs(LAddrIPv4.sin_port);
        VIPVersion := Id_IPV4;
      end;
      Id_PF_INET6: begin
        VIP := TranslateTInAddrToString(LAddrIPv6.sin6_addr, Id_IPv6);
        VPort := ntohs(LAddrIPv6.sin6_port);
        VIPVersion := Id_IPV6;
      end
      else begin
        __close(Result);
        Result := Id_INVALID_SOCKET;
        IPVersionUnsupported;
      end;
    end;
  end else begin
    if GetLastError = EBADF then begin
      SetLastError(EINTR);
    end;
  end;
end;

procedure TIdStackVCLPosix.AddLocalAddressesToList(AAddresses: TStrings);
var
  LRetVal: Integer;
  LHostName: AnsiString;
  Hints: AddrInfo;
  LAddrList, LAddrInfo: pAddrInfo;

begin
  //IMPORTANT!!!
  //
  //The Hints structure must be zeroed out or you might get an AV.
  //I've seen this in Mac OS X
  FillChar(Hints, SizeOf(Hints), 0);
  Hints.ai_family := PF_UNSPEC; // TODO: support IPv6 addresses
  Hints.ai_socktype := SOCK_STREAM;

  LHostName := AnsiString(HostName);
  LRetVal := getaddrinfo( PAnsiChar(LHostName), nil, Hints, LAddrList);
  if LRetVal <> 0 then begin
    raise EIdReverseResolveError.CreateFmt(RSReverseResolveError, [LHostName, gai_strerror(LRetVal), LRetVal]);
  end;
  try
    AAddresses.BeginUpdate;
    try
      LAddrInfo := LAddrList;
      repeat
        case LAddrInfo^.ai_addr^.sa_family  of
        Id_PF_INET4 :
          begin
            AAddresses.Add(TranslateTInAddrToString( PSockAddr_In(LAddrInfo^.ai_addr)^.sin_addr, Id_IPv4));
          end;
        Id_PF_INET6 :
          begin
            AAddresses.Add(TranslateTInAddrToString( PSockAddr_In6(LAddrInfo^.ai_addr)^.sin6_addr, Id_IPv6));
          end;
        end;
        LAddrInfo := LAddrInfo^.ai_next;
      until LAddrInfo = nil;
    finally;
      AAddresses.EndUpdate;
    end;
  finally
    freeaddrinfo(LAddrList^);
  end;
end;

procedure TIdStackVCLPosix.Bind(ASocket: TIdStackSocketHandle;
  const AIP: string; const APort: TIdPort; const AIPVersion: TIdIPVersion);
var
  LAddrStore: sockaddr_storage;
  LAddrIPv4 : SockAddr_In absolute LAddrStore;
  LAddrIPv6 : sockaddr_in6 absolute LAddrStore;
  LAddr : sockaddr absolute LAddrStore;
begin
  case AIPVersion of
    Id_IPv4: begin
        InitSockAddr_In(LAddrIPv4);
        if AIP <> '' then begin
          TranslateStringToTInAddr(AIP, LAddrIPv4.sin_addr, Id_IPv4);
        end;
        LAddrIPv4.sin_port := htons(APort);
        CheckForSocketError(Posix.SysSocket.bind(ASocket, LAddr,SizeOf(LAddrIPv4)));
      end;
    Id_IPv6: begin
        InitSockAddr_in6(LAddrIPv6);
        if AIP <> '' then begin
          TranslateStringToTInAddr(AIP, LAddrIPv6.sin6_addr, Id_IPv6);
        end;
        LAddrIPv6.sin6_port := htons(APort);
        CheckForSocketError(Posix.SysSocket.bind(ASocket,LAddr, SizeOf(LAddrIPv6)));
      end;
    else begin
      IPVersionUnsupported;
    end;
  end;

end;

function TIdStackVCLPosix.CheckIPVersionSupport(
  const AIPVersion: TIdIPVersion): boolean;
var
  LTmpSocket: TIdStackSocketHandle;
begin
  LTmpSocket := WSSocket(IdIPFamily[AIPVersion], Id_SOCK_STREAM, Id_IPPROTO_IP );
  Result := LTmpSocket <> Id_INVALID_SOCKET;
  if Result then begin
    WSCloseSocket(LTmpSocket);
  end;
end;

procedure TIdStackVCLPosix.Connect(const ASocket: TIdStackSocketHandle;
  const AIP: string; const APort: TIdPort; const AIPVersion: TIdIPVersion);
var
  LAddrStore: sockaddr_storage;
  LAddrIPv4 : SockAddr_In absolute LAddrStore;
  LAddrIPv6 : sockaddr_in6 absolute LAddrStore;
  LAddr : sockaddr absolute LAddrStore;
begin
  case AIPVersion of
    Id_IPv4: begin
      InitSockAddr_In(LAddrIPv4);
      TranslateStringToTInAddr(AIP, LAddrIPv4.sin_addr, Id_IPv4);
      LAddrIPv4.sin_port := htons(APort);
      CheckForSocketError(Posix.SysSocket.connect(
        ASocket,LAddr,SizeOf(LAddrIPv4)));
    end;
    Id_IPv6: begin
      InitSockAddr_in6(LAddrIPv6);
      TranslateStringToTInAddr(AIP, LAddrIPv6.sin6_addr, Id_IPv6);
      LAddrIPv6.sin6_port := htons(APort);
      CheckForSocketError(
        Posix.SysSocket.connect( ASocket, LAddr, SizeOf(LAddrIPv6) ));
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;

end;

constructor TIdStackVCLPosix.Create;
begin
  inherited Create;
end;

destructor TIdStackVCLPosix.Destroy;
begin
  inherited Destroy;
end;

procedure TIdStackVCLPosix.Disconnect(ASocket: TIdStackSocketHandle);
begin
  // Windows uses Id_SD_Send, Linux should use Id_SD_Both
  WSShutdown(ASocket, Id_SD_Both);
  // SO_LINGER is false - socket may take a little while to actually close after this
  WSCloseSocket(ASocket);
end;

function TIdStackVCLPosix.GetLastError: Integer;
begin
  Result := errno;
end;

procedure TIdStackVCLPosix.GetPeerName(ASocket: TIdStackSocketHandle;
  var VIP: string; var VPort: TIdPort; var VIPVersion: TIdIPVersion);
var
  i: socklen_t;
  LAddrStore: sockaddr_storage;
  LAddrIPv4 : SockAddr_In absolute LAddrStore;
  LAddrIPv6 : sockaddr_in6 absolute LAddrStore;
  LAddr : sockaddr absolute LAddrStore;
begin
  i := SizeOf(LAddrStore);
  CheckForSocketError(Posix.SysSocket.getpeername(ASocket, LAddr, i));
  case LAddr.sa_family of
    Id_PF_INET4: begin
      VIP := TranslateTInAddrToString(LAddrIPv4.sin_addr, Id_IPv4);
      VPort := ntohs(LAddrIPv4.sin_port);
      VIPVersion := Id_IPV4;
    end;
    Id_PF_INET6: begin
      VIP := TranslateTInAddrToString(LAddrIPv6.sin6_addr, Id_IPv6);
      VPort := Ntohs(LAddrIPv6.sin6_port);
      VIPVersion := Id_IPV6;
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;

end;

procedure TIdStackVCLPosix.GetSocketName(ASocket: TIdStackSocketHandle;
  var VIP: string; var VPort: TIdPort; var VIPVersion: TIdIPVersion);
var
  LiSize: socklen_t;
  LAddrStore: sockaddr_storage;
  LAddrIPv4 : SockAddr_In absolute LAddrStore;
  LAddrIPv6 : sockaddr_in6 absolute LAddrStore;
  LAddr : sockaddr absolute LAddrStore;
begin
  LiSize := SizeOf(LAddrStore);
  CheckForSocketError(getsockname(ASocket, psockaddr(@LAddr)^, LiSize));
  case LAddr.sa_family of
    Id_PF_INET4: begin
      VIP := TranslateTInAddrToString(LAddrIPv4.sin_addr, Id_IPv4);
      VPort := ntohs(LAddrIPv4.sin_port);
      VIPVersion := Id_IPV4;
    end;
    Id_PF_INET6: begin
      VIP := TranslateTInAddrToString(LAddrIPv6.sin6_addr, Id_IPv6);
      VPort := ntohs(LAddrIPv6.sin6_port);
      VIPVersion := Id_IPV6;
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackVCLPosix.GetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption;
  out AOptVal: Integer);
var
  LLen : Integer;
  LBuf : Integer;
begin
  LLen := SizeOf(Integer);
  WSGetSockOpt(ASocket, ALevel, AOptName, PAnsiChar(@LBuf), LLen);
  AOptVal := LBuf;
end;

function TIdStackVCLPosix.HostByAddress(const AAddress: string;
  const AIPVersion: TIdIPVersion): string;
var
  LiSize: socklen_t;
  LAddrStore: sockaddr_storage;
  LAddrIPv4 : SockAddr_In absolute LAddrStore;
  LAddrIPv6 : sockaddr_in6 absolute LAddrStore;
  LAddr : sockaddr absolute LAddrStore;
  LHostName : AnsiString;
  LRet : Integer;
  LHints : addrinfo;
  LAddrInfo: pAddrInfo;
begin
  LiSize := 0;
  case AIPVersion of
    Id_IPv4 :
    begin
      InitSockAddr_In(LAddrIPv4);
      TranslateStringToTInAddr(AAddress,LAddrIPv4.sin_addr,Id_IPv4);
      LiSize := SizeOf(SockAddr_In);
    end;
    Id_IPv6 :
    begin
      InitSockAddr_In6(LAddrIPv6);
      TranslateStringToTInAddr(AAddress,LAddrIPv6.sin6_addr,Id_IPv6);
      LiSize := SizeOf(SockAddr_In6);
    end
  else
    IPVersionUnsupported;
  end;
  SetLength(LHostname,NI_MAXHOST);
  FillChar(LHostName[1],NI_MAXHOST,0);
  LRet := getnameinfo(LAddr,LiSize, PAnsiChar(@LHostName[1]),NI_MAXHOST,nil,0,NI_NAMEREQD );
  if LRet <> 0 then begin
    if LRet = EAI_SYSTEM then begin
      RaiseLastOSError;
    end else begin
      raise EIdReverseResolveError.CreateFmt(RSReverseResolveError, [AAddress, gai_strerror(LRet), LRet]);
    end;
  end;
{
IMPORTANT!!!

getnameinfo can return either results from a numeric to text conversion or
results from a DNS reverse lookup.  Someone could make a malicous PTR record
such as 

   1.0.0.127.in-addr.arpa. IN PTR  10.1.1.1
   
and trick a caller into beleiving the socket address is 10.1.1.1 instead of
127.0.0.1.  If there is a numeric host in LAddr, than this is the case and
we disregard the result and raise an exception.
}
  FillChar(LHints,SizeOf(LHints),0);
  LHints.ai_socktype := SOCK_DGRAM; //*dummy*/
  LHints.ai_flags := AI_NUMERICHOST;
  if (getaddrinfo(PAnsiChar(LHostName), '0', LHints, LAddrInfo)=0) then begin
    freeaddrinfo(LAddrInfo^);
    Result := '';
    raise EIdMaliciousPtrRecord.Create(RSMaliciousPtrRecord);
  end;

  Result := String(LHostName);
end;

function TIdStackVCLPosix.HostByName(const AHostName: string;
  const AIPVersion: TIdIPVersion): string;
var
  LAddrInfo: pAddrInfo;
  LHints: AddrInfo;
  LHost: AnsiString;
  LRetVal: Integer;
begin
  if not (AIPVersion in [Id_IPv4, Id_IPv6]) then begin
    IPVersionUnsupported;
  end;
  //IMPORTANT!!!
  //
  //The Hints structure must be zeroed out or you might get an AV.
  //I've seen this in Mac OS X
  FillChar(LHints, SizeOf(LHints), 0);
  LHints.ai_family := IdIPFamily[AIPVersion];
  LHints.ai_socktype := SOCK_STREAM;
  LAddrInfo := nil;
  LHost := AnsiString(AHostName);

  LRetVal := getaddrinfo( PAnsiChar(LHost), nil, LHints, LAddrInfo);
  if LRetVal <> 0 then begin
    if LRetVal = EAI_SYSTEM then begin
      RaiseLastOSError;
    end else begin
      raise EIdResolveError.CreateFmt(RSReverseResolveError, [LHost, gai_strerror(LRetVal), LRetVal]);
    end;
  end;
  try
    if AIPVersion = Id_IPv4 then begin
      Result := TranslateTInAddrToString( PSockAddr_In( LAddrInfo^.ai_addr)^.sin_addr, AIPVersion);
    end else begin
      Result := TranslateTInAddrToString( PSockAddr_In6( LAddrInfo^.ai_addr)^.sin6_addr, AIPVersion);
    end;
  finally
    freeaddrinfo(LAddrInfo^);
  end;
end;

function TIdStackVCLPosix.HostToNetwork(AValue: LongWord): LongWord;
begin
 Result := htonl(AValue);
end;

function TIdStackVCLPosix.HostToNetwork(AValue: Word): Word;
begin
  Result := htons(AValue);
end;

function TIdStackVCLPosix.HostToNetwork(AValue: Int64): Int64;
var
  LParts: TIdInt64Parts;
  L: LongWord;
begin
  LParts.QuadPart := AValue;
  L := htonl(LParts.HighPart);
  if (L <> LParts.HighPart) then begin
    LParts.HighPart := htonl(LParts.LowPart);
    LParts.LowPart := L;
  end;
  Result := LParts.QuadPart;
end;

function TIdStackVCLPosix.IOControl(const s: TIdStackSocketHandle;
  const cmd: LongWord; var arg: LongWord): Integer;
begin
  Result := ioctl(s, cmd, @LArg);
end;

procedure TIdStackVCLPosix.Listen(ASocket: TIdStackSocketHandle;
  ABackLog: Integer);
begin
  CheckForSocketError(Posix.SysSocket.listen(ASocket, ABacklog));
end;

function TIdStackVCLPosix.NetworkToHost(AValue: LongWord): LongWord;
begin
  Result := ntohl(AValue);
end;

function TIdStackVCLPosix.NetworkToHost(AValue: Int64): Int64;
var
  LParts: TIdInt64Parts;
  L: LongWord;
begin
  LParts.QuadPart := AValue;
  L := ntohl(LParts.HighPart);
  if (L <> LParts.HighPart) then begin
    LParts.HighPart := ntohl(LParts.LowPart);
    LParts.LowPart := L;
  end;
  Result := LParts.QuadPart;

end;

function TIdStackVCLPosix.NetworkToHost(AValue: Word): Word;
begin
   Result := ntohs(AValue);
end;

function TIdStackVCLPosix.ReadHostName: string;
var
  LStr: AnsiString;
begin
  SetLength(LStr, 250);
  gethostname(PAnsiChar(LStr), 250);
  Result := String(PAnsiChar(LStr));
end;

function TIdStackVCLPosix.ReceiveMsg(ASocket: TIdStackSocketHandle;
  var VBuffer: TIdBytes; APkt: TIdPacketInfo): LongWord;
var
  LSize: socklen_t;
  LAddrStore: sockaddr_storage;
  LAddrIPv4 : SockAddr_In absolute LAddrStore;
  LAddrIPv6 : sockaddr_in6 absolute LAddrStore;
  LAddr : sockaddr absolute LAddrStore;
  LMsg : msghdr;
  LIOV : iovec;
  LControl : TIdBytes;
  LCurCmsg : Pcmsghdr;   //for iterating through the control buffer
  LByte : PByte;

begin
  //we call the macro twice because we specified two possible structures.
  //Id_IPV6_HOPLIMIT and Id_IPV6_PKTINFO
  LSize := CMSG_LEN(CMSG_LEN(Length(VBuffer)));
  SetLength( LControl,LSize);

  LIOV.iov_len := Length(VBuffer); // Length(VMsgData);
  LIOV.iov_base := @VBuffer[0]; // @VMsgData[0];

  FillChar(LMsg,SizeOf(LMsg),0);

  LMsg.msg_iov := @LIOV;//lpBuffers := @LMsgBuf;
  LMsg.msg_iovlen := 1;

  LMsg.msg_controllen := LSize;
  LMsg.msg_control := @LControl[0];

  LMsg.msg_name := @LAddr;
  LMsg.msg_namelen := SizeOf(LAddrStore);

  Result := 0;
  CheckForSocketError(RecvMsg(ASocket, LMsg, Result ));
  APkt.Reset;

  case LAddr.sa_family of
    Id_PF_INET4: begin
      APkt.SourceIP := TranslateTInAddrToString(LAddrIPv4.sin_addr, Id_IPv4);
      APkt.SourcePort := ntohs(LAddrIPv4.sin_port);
      APkt.SourceIPVersion := Id_IPv4;
    end;
    Id_PF_INET6: begin
      APkt.SourceIP := TranslateTInAddrToString(LAddrIPv6.sin6_addr, Id_IPv6);
      APkt.SourcePort := ntohs(LAddrIPv6.sin6_port);
      APkt.SourceIPVersion := Id_IPv6;
    end;
    else begin
      Result := 0; // avoid warning
      IPVersionUnsupported;
    end;
  end;

  LCurCmsg := nil;
  repeat
    LCurCmsg := CMSG_NXTHDR(@LMsg,LCurCmsg);
    if LCurCmsg=nil then begin
      break;
    end;
    case LCurCmsg^.cmsg_type of
      IPV6_PKTINFO :     //done this way because IPV6_PKTINF and  IP_PKTINFO
      //are both 19
      begin
        case LAddr.sa_family of
          Id_PF_INET4: begin
            {$IFNDEF DARWIN}
            //This is not supported in OS X.
            with Pin_pktinfo(CMSG_DATA(LCurCmsg))^ do begin
              APkt.DestIP := TranslateTInAddrToString(ipi_addr, Id_IPv4);
              APkt.DestIF := ipi_ifindex;
            end;
            APkt.DestIPVersion := Id_IPv4;
            {$ENDIF}
          end;
          Id_PF_INET6: begin
            with pin6_pktinfo(CMSG_DATA(LCurCmsg))^ do begin
              APkt.DestIP := TranslateTInAddrToString(ipi6_addr, Id_IPv6);
              APkt.DestIF :=  ipi6_ifindex;
            end;
            APkt.DestIPVersion := Id_IPv6;
          end;
        end;
      end;
      Id_IPV6_HOPLIMIT :
      begin
        LByte :=  PByte(CMSG_DATA(LCurCmsg));
        APkt.TTL := LByte^;
      end;
    end;
  until False;
end;

function TIdStackVCLPosix.RecvFrom(const ASocket: TIdStackSocketHandle;
  var VBuffer; const ALength, AFlags: Integer; var VIP: string;
  var VPort: TIdPort; var VIPVersion: TIdIPVersion): Integer;
var
  LiSize: socklen_t;
  LAddrStore: sockaddr_storage;
  LAddrIPv4 : SockAddr_In absolute LAddrStore;
  LAddrIPv6 : sockaddr_in6 absolute LAddrStore;
  LAddr : sockaddr absolute LAddrStore;

begin
  LiSize := SizeOf(sockaddr_storage);
  Result := Posix.SysSocket.recvfrom(ASocket,VBuffer, ALength, AFlags or Id_MSG_NOSIGNAL, psockaddr(@LAddr)^, LiSize);
  if Result >= 0 then
  begin
    case LAddr.sa_family of
      Id_PF_INET4: begin
        VIP := TranslateTInAddrToString(LAddrIPv4.sin_addr, Id_IPv4);
        VPort := Ntohs(LAddrIPv4.sin_port);
        VIPVersion := Id_IPV4;
      end;
      Id_PF_INET6: begin
        VIP := TranslateTInAddrToString(LAddrIPv6.sin6_addr, Id_IPv6);
        VPort := ntohs(LAddrIPv6.sin6_port);
        VIPVersion := Id_IPV6;
      end;
      else begin
        Result := 0;
        IPVersionUnsupported;
      end;
    end;
  end;
end;

procedure TIdStackVCLPosix.SetBlocking(ASocket: TIdStackSocketHandle;
  const ABlocking: Boolean);
begin
  if not ABlocking then begin
    raise EIdBlockingNotSupported.Create(RSStackNotSupportedOnUnix);
  end;
end;

procedure TIdStackVCLPosix.SetLastError(const AError: Integer);
begin
  __error^ := AError;
end;

procedure TIdStackVCLPosix.SetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption; AOptVal: Integer);
begin
  CheckForSocketError(Posix.SysSocket.setsockopt(ASocket, ALevel, AOptName, AOptVal, SizeOf(AOptVal)));
end;

procedure TIdStackVCLPosix.SetSocketOption(const ASocket: TIdStackSocketHandle;
  const Alevel, Aoptname: Integer; Aoptval: PAnsiChar; const Aoptlen: Integer);
begin
  CheckForSocketError(Posix.SysSocket.setsockopt(ASocket, ALevel, Aoptname, Aoptval, Aoptlen));
end;

function TIdStackVCLPosix.SupportsIPv6: Boolean;
begin
  //In Windows, this does something else.  It checks the LSP's installed.
  Result := CheckIPVersionSupport(Id_IPv6);
end;

function TIdStackVCLPosix.WouldBlock(const AResult: Integer): Boolean;
begin
  //non-blocking does not exist in Linux, always indicate things will block
  Result := True;
end;

procedure TIdStackVCLPosix.WriteChecksum(s: TIdStackSocketHandle;
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

procedure TIdStackVCLPosix.WriteChecksumIPv6(s: TIdStackSocketHandle;
  var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
  const APort: TIdPort);
begin
//we simply request that the kernal write the checksum when the data
//is sent.  All of the parameters required are because Windows is bonked
//because it doesn't have the IPV6CHECKSUM socket option meaning we have
//to querry the network interface in TIdStackWindows -- yuck!!
  SetSocketOption(s, Id_IPPROTO_IPV6, IPV6_CHECKSUM, AOffset);
end;

function TIdStackVCLPosix.WSCloseSocket(ASocket: TIdStackSocketHandle): Integer;
begin
  Result := __close(ASocket);
end;

function TIdStackVCLPosix.WSGetLastError: Integer;
begin
  //IdStackWindows just uses   result := WSAGetLastError;
  Result := GetLastError; //System.GetLastOSError; - FPC doesn't define it in System
  if Result = Id_WSAEPIPE then begin
    Result := Id_WSAECONNRESET;
  end;
end;

function TIdStackVCLPosix.WSGetServByName(const AServiceName: string): TIdPort;
var
  Lps: PServEnt;
  LAStr: AnsiString;
begin
  LAStr := AnsiString(AServiceName); // explicit convert to Ansi
  Lps := Posix.NetDB.getservbyname( PAnsiChar(LAStr), nil);
  if Lps <> nil then begin
    Result := ntohs(Lps^.s_port);
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

procedure TIdStackVCLPosix.AddServByPortToList(const APortNumber: TIdPort; AAddresses: TStrings);
//function TIdStackVCLPosix.WSGetServByPort(const APortNumber: TIdPort): TStrings;
type
  PPAnsiCharArray = ^TPAnsiCharArray;
  TPAnsiCharArray = packed array[0..(MaxLongint div SizeOf(PAnsiChar))-1] of PAnsiChar;
var
  Lps: PServEnt;
  Li: Integer;
  Lp: PPAnsiCharArray;
begin
  Lps := Posix.NetDB.getservbyport(htons(APortNumber), nil);
  if Lps <> nil then begin
    AAddresses.Add(String(Lps^.s_name));
    Li := 0;
    Lp := Pointer(Lps^.s_aliases);
    while Lp[Li] <> nil do begin
      AAddresses.Add(String(Lp[Li]));
      Inc(Li);
    end;
  end;
end;

procedure TIdStackVCLPosix.WSGetSockOpt(ASocket: TIdStackSocketHandle; Alevel,
  AOptname: Integer; AOptval: PAnsiChar; var AOptlen: Integer);
var s : socklen_t;
begin
  CheckForSocketError(Posix.SysSocket.getsockopt(ASocket, ALevel, AOptname, AOptval, s));
  AOptlen := s;
end;

function TIdStackVCLPosix.WSRecv(ASocket: TIdStackSocketHandle; var ABuffer;
  const ABufferLength, AFlags: Integer): Integer;
begin
  //IdStackWindows is just: Result := Recv(ASocket, ABuffer, ABufferLength, AFlags);
  Result := Posix.SysSocket.Recv(ASocket, ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL);

end;

function TIdStackVCLPosix.WSSend(ASocket: TIdStackSocketHandle; const ABuffer;
  const ABufferLength, AFlags: Integer): Integer;
begin
  //CC: Should Id_MSG_NOSIGNAL be included?
  //  Result := Send(ASocket, ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL);
  Result := CheckForSocketError(Posix.SysSocket.send(ASocket, ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL));

end;

procedure TIdStackVCLPosix.WSSendTo(ASocket: TIdStackSocketHandle;
  const ABuffer; const ABufferLength, AFlags: Integer; const AIP: string;
  const APort: TIdPort; AIPVersion: TIdIPVersion);
var
  LAddrStore: sockaddr_storage;
  LAddrIPv4 : SockAddr_In absolute LAddrStore;
  LAddrIPv6 : sockaddr_in6 absolute LAddrStore;
  LAddr : sockaddr absolute LAddrStore;
  LiSize: socklen_t;
begin
  case AIPVersion of
    Id_IPv4: begin
      InitSockAddr_In(LAddrIPv4);
      TranslateStringToTInAddr(AIP, LAddrIPv4.sin_addr, Id_IPv4);
      LAddrIPv4.sin_port := htons(APort);
      LiSize := SizeOf(LAddrIPv4);
    end;
    Id_IPv6: begin
      InitSockAddr_in6(LAddrIPv6);
      TranslateStringToTInAddr(AIP, LAddrIPv6.sin6_addr, Id_IPv6);
      LAddrIPv6.sin6_port := htons(APort);
      LiSize := SizeOf(LAddrIPv6);
    end;
 else
   LiSize := 0; // avoid warning
   IPVersionUnsupported;
 end;
  LiSize := Posix.SysSocket.sendto(
    ASocket, ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL, LAddr,LiSize);
  if LiSize = Id_SOCKET_ERROR then begin
    // TODO: move this into RaiseLastSocketError directly
    if WSGetLastError() = Id_WSAEMSGSIZE then begin
      raise EIdPackageSizeTooBig.Create(RSPackageSizeTooBig);
    end else begin
      RaiseLastSocketError;
    end;
  end
  else if Integer(LiSize) <> ABufferLength then begin
    raise EIdNotAllBytesSent.Create(RSNotAllBytesSent);
  end;

end;

procedure TIdStackVCLPosix.WSSetLastError(const AErr: Integer);
begin
  __error^ := AErr;
end;

function TIdStackVCLPosix.WSShutdown(ASocket: TIdStackSocketHandle;
  AHow: Integer): Integer;
begin
  Result := Posix.SysSocket.shutdown(ASocket, AHow);
end;

function TIdStackVCLPosix.WSSocket(AFamily : Integer; AStruct : TIdSocketType; AProtocol: Integer;
      const AOverlapped: Boolean = False): TIdStackSocketHandle;
begin
  Result := Posix.SysSocket.socket(AFamily, AStruct, AProtocol);
  if Result <> INVALID_SOCKET then begin
    Self.SetSocketOption(Result,SOL_SOCKET,SO_NOSIGPIPE,1);
  end;
end;

{$WARN UNIT_PLATFORM ON}
{$WARN SYMBOL_PLATFORM ON}
initialization
  GSocketListClass := TIdSocketListVCLPosix;
end.
