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
  Rev 1.7    10/26/2004 8:20:04 PM  JPMugaas
  Fixed some oversights with conversion.  OOPS!!!

  Rev 1.6    10/26/2004 8:12:32 PM  JPMugaas
  Now uses TIdStrings and TIdStringList for portability.

  Rev 1.5    12/06/2004 15:17:20  CCostelloe
  Restructured to correspond with IdStackWindows, now works.

  Rev 1.4    07/06/2004 21:31:02  CCostelloe
  Kylix 3 changes

  Rev 1.3    4/18/04 10:43:22 PM  RLebeau
  Fixed syntax error

  Rev 1.2    4/18/04 10:29:46 PM  RLebeau
  Renamed Int64Parts structure to TIdInt64Parts

  Rev 1.1    4/18/04 2:47:28 PM  RLebeau
  Conversion support for Int64 values

  Removed WSHToNs(), WSNToHs(), WSHToNL(), and WSNToHL() methods, obsolete

  Rev 1.0    2004.02.03 3:14:48 PM  czhower
  Move and updates

  Rev 1.3    10/19/2003 5:35:14 PM  BGooijen
  SetSocketOption

  Rev 1.2    2003.10.01 9:11:24 PM  czhower
  .Net

  Rev 1.1    7/5/2003 07:25:50 PM  JPMugaas
  Added functions to the Linux stack which use the new TIdIPAddress record type
  for IP address parameters.  I also fixed a compile bug.

  Rev 1.0    11/13/2002 08:59:24 AM  JPMugaas
}

unit IdStackLinux;
{$i IdCompilerDefines.inc}
interface

uses
  Classes,
  Libc,
  IdStack,
  IdStackConsts,
  IdObjs,
  IdGlobal,
  IdStackBSDBase;

type

  TIdSocketListLinux = class (TIdSocketList)
  protected
    FCount: integer;
    FFDSet: TFDSet;
    //
    class function FDSelect(AReadSet: PFDSet; AWriteSet: PFDSet; AExceptSet: PFDSet;
     const ATimeout: Integer = IdTimeoutInfinite): integer;
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
  End;//TIdSocketList

  TIdStackLinux = class(TIdStackBSDBase)
  private
//    procedure SetSocketOption(ASocket: TIdStackSocketHandle;
//      ALevel: TIdSocketProtocol; AOptName: TIdSocketOption; AOptVal: Integer);
    procedure WriteChecksumIPv6(s: TIdStackSocketHandle;
      var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
      const APort: TIdPort);
  protected
    function GetLastError : Integer;
    procedure SetLastError(Const AError : Integer);
    function HostByName(const AHostName: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;
    procedure PopulateLocalAddresses; override;
    function ReadHostName: string; override;
    function WSCloseSocket(ASocket: TIdStackSocketHandle): Integer; override;
    function GetLocalAddress: string; override;
    function GetLocalAddresses: TIdStrings; override;
    function WSRecv(ASocket: TIdStackSocketHandle;
      var ABuffer; const ABufferLength, AFlags: Integer): Integer; override;
    function WSSend(ASocket: TIdStackSocketHandle; const ABuffer; const ABufferLength, AFlags: Integer): Integer; override;
    function WSShutdown(ASocket: TIdStackSocketHandle; AHow: Integer): Integer; override;
  public
    procedure SetBlocking(ASocket: TIdStackSocketHandle;
     const ABlocking: Boolean); override;
    function WouldBlock(const AResult: Integer): Boolean; override;
    function WSTranslateSocketErrorMsg(const AErr: Integer): string; override;
    function Accept(ASocket: TIdStackSocketHandle; var VIP: string;
             var VPort: TIdPort;
             const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION
             ): TIdStackSocketHandle; override;

    procedure Bind(ASocket: TIdStackSocketHandle; const AIP: string;
     const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure Connect(const ASocket: TIdStackSocketHandle; const AIP: string;
     const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    function HostByAddress(const AAddress: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;
    function WSGetLastError: Integer; override;
    function WSGetServByName(const AServiceName: string): TIdPort; override;
    function WSGetServByPort(const APortNumber: TIdPort): TIdStrings; override;
    procedure WSGetSockOpt(ASocket: TIdStackSocketHandle;
      Alevel, AOptname: Integer; AOptval: PChar; var AOptlen: Integer); override;
    procedure GetSocketOption(ASocket: TIdStackSocketHandle;
      ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption;
      out AOptVal: Integer); override;
    procedure GetPeerName(ASocket: TIdStackSocketHandle; var VIP: string;
     var VPort: TIdPort); override;
    procedure GetSocketName(ASocket: TIdStackSocketHandle; var VIP: string;
     var VPort: TIdPort); override;
    procedure Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer); override;
    function HostToNetwork(AValue: Word): Word; override;
    function NetworkToHost(AValue: Word): Word; override;
    function HostToNetwork(AValue: LongWord): LongWord; override;
    function NetworkToHost(AValue: LongWord): LongWord; override;
    function HostToNetwork(AValue: Int64): Int64; override;
    function NetworkToHost(AValue: Int64): Int64; override;
    function RecvFrom(const ASocket: TIdStackSocketHandle; var VBuffer;
      const ALength, AFlags: Integer; var VIP: string; var VPort: TIdPort;
      AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer; override;
    function ReceiveMsg(ASocket: TIdStackSocketHandle;
      var VBuffer: TIdBytes;
      APkt :  TIdPacketInfo;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Cardinal; override;
    procedure WSSendTo(ASocket: TIdStackSocketHandle; const ABuffer;
      const ABufferLength, AFlags: Integer;
      const AIP: string; const APort: TIdPort; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    function WSSocket(AFamily, AStruct, AProtocol: Integer;
     const AOverlapped: Boolean = False): TIdStackSocketHandle; override;
    procedure Disconnect(ASocket: TIdStackSocketHandle); override;
    procedure SetSocketOption(ASocket: TIdStackSocketHandle; ALevel:TIdSocketOptionLevel;
      AOptName: TIdSocketOption; AOptVal: Integer); overload;override;
    procedure SetSocketOption( const ASocket: TIdStackSocketHandle;
      const Alevel, Aoptname: Integer;
      Aoptval: PChar;
      const Aoptlen: Integer ); overload; override;
    function SupportsIPv6: boolean; overload; override;
    function CheckIPVersionSupport(const AIPVersion: TIdIPVersion): boolean; override;
    constructor Create; override;
    destructor Destroy; override;
    //In Windows, this writes a checksum into a buffer.  In Linux, it would probably
    //simply have the kernal write the checksum with something like this (RFC 2292):
//
//    int  offset = 2;
//    setsockopt(fd, IPPROTO_IPV6, IPV6_CHECKSUM, &offset, sizeof(offset));
//
//  Note that this should be called
    //IMMEDIATELY before you do a SendTo because the Local IPv6 address might change

    procedure WriteChecksum(s : TIdStackSocketHandle;
      var VBuffer : TIdBytes;
      const AOffset : Integer;
      const AIP : String;
      const APort : TIdPort;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    function IOControl(const s:  TIdStackSocketHandle; const cmd: cardinal;
      var arg: cardinal ): Integer; override;

  end;

  TLinger = record
    l_onoff: Word;
    l_linger: Word;
  end;
  TIdLinger = TLinger;

implementation
uses
  IdResourceStrings,
  IdException,
  SysUtils;

type
  psockaddr_in6 = ^sockaddr_in6;
const
  Id_MSG_NOSIGNAL = MSG_NOSIGNAL;
  Id_WSAEPIPE = EPIPE;

constructor TIdStackLinux.Create;
begin
  inherited Create;
end;

destructor TIdStackLinux.Destroy;
begin
  inherited Destroy;
end;

function TIdStackLinux.GetLastError : Integer;
begin
  Result := errno;
end;

procedure TIdStackLinux.SetLastError(Const AError : Integer);
begin
  __errno_location^ := AError;
end;

function TIdStackLinux.Accept(ASocket: TIdStackSocketHandle;
 var VIP: string; var VPort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): TIdStackSocketHandle;
var
  LN: Cardinal;
  LAddr: sockaddr_in6;
begin
  LN := SizeOf(LAddr);
  Result := Libc.accept(ASocket, PSockAddr(@LAddr), @LN);
  if Result <> SOCKET_ERROR then begin
    VIP := TranslateTInAddrToString(TIdIn6Addr(LAddr.sin6_addr), AIPVersion);
    VPort := NToHs(LAddr.sin6_port);
  end else begin
    if GetLastError = EBADF then begin
      SetLastError(EINTR);
    end;
  end;
end;

procedure TIdStackLinux.Bind(ASocket: TIdStackSocketHandle; const AIP: string;
              const APort: TIdPort;
              const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION );
var
  LAddr: SockAddr;
  LAddr6: SockAddr_in6;
begin
  case AIPVersion of
    Id_IPv4: begin
        LAddr.sin_family := Id_PF_INET4;
        if Length(AIP) = 0 then begin
          LAddr.sin_addr.s_addr := INADDR_ANY;
        end else begin
          TranslateStringToTInAddr(AIP, LAddr.sin_addr, Id_IPv4);
        end;
        LAddr.sin_port := HToNs(APort);
        CheckForSocketError(Libc.Bind(ASocket, LAddr, SizeOf(LAddr)));
      end;
    Id_IPv6: begin
        FillChar(LAddr6, SizeOf(LAddr6), 0);
        LAddr6.sin6_family := Id_PF_INET6;
        if Length(AIP) <> 0 then begin
          TranslateStringToTInAddr(AIP, LAddr6.sin6_addr, Id_IPv6);
        end;
        LAddr6.sin6_port := HToNs(APort);
        CheckForSocketError(Libc.Bind(ASocket, Psockaddr(@LAddr6)^, SizeOf(LAddr6)));
      end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackLinux.WSCloseSocket(ASocket: TIdStackSocketHandle): Integer;
begin
  Result := Libc.__close(ASocket);
end;

procedure TIdStackLinux.Connect(const ASocket: TIdStackSocketHandle;
 const AIP: string; const APort: TIdPort;
 const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LAddr: SockAddr_in;
  LAddr6: SockAddr_in6;
begin
  case AIPVersion of
    Id_IPv4: begin
      LAddr.sin_family := Id_PF_INET4;
      TranslateStringToTInAddr(AIP, LAddr.sin_addr, Id_IPv4);
      LAddr.sin_port := HToNs(APort);
      CheckForSocketError(Libc.Connect(ASocket, @LAddr, SizeOf(LAddr)));
    end;
    Id_IPv6: begin
      LAddr6.sin6_flowinfo := 0;
      LAddr6.sin6_scope_id := 0;
      LAddr6.sin6_family := Id_PF_INET6;
      TranslateStringToTInAddr(AIP, LAddr6.sin6_addr, Id_IPv6);
      LAddr6.sin6_port := HToNs(APort);
      CheckForSocketError(Libc.Connect(ASocket, @LAddr6, SizeOf(LAddr6)));
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackLinux.HostByName(const AHostName: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
var
  Lpa: pchar;
  Lsa: TInAddr;
  LHost: PHostEnt;
// ipv6
  LHints: TAddressInfo;
  {$IFDEF KYLIX}
  LAddrInfo: PPAddressInfo;
  {$ELSE}
  LAddrInfo: PAddrInfo;
  {$ENDIF}
  LRetVal: integer;
begin
  case AIPVersion of
    Id_IPv4: begin
      LHost := Libc.GethostByName(PChar(AHostName));
      if (LHost <> nil) then begin
        Lpa := LHost^.h_addr_list^;
        Lsa.S_un_b.s_b1 := Ord(Lpa[0]);
        Lsa.S_un_b.s_b2 := Ord(Lpa[1]);
        Lsa.S_un_b.s_b3 := Ord(Lpa[2]);
        Lsa.S_un_b.s_b4 := Ord(Lpa[3]);
        Result := TranslateTInAddrToString(Lsa, Id_IPv4);
      end else begin
        //RaiseSocketError(h_errno);
        RaiseLastSocketError;
      end;
    end;
    Id_IPv6: begin
      FillChar(LHints,sizeof(LHints), 0);
      LHints.ai_family := IdIPFamily[AIPVersion];
      LHints.ai_socktype := Integer(SOCK_STREAM);
      LAddrInfo:=nil;
      LRetVal := getaddrinfo(pchar(AHostName), nil, @LHints, @LAddrInfo);
      if LRetVal<>0 then begin
        if LRetVal = EAI_SYSTEM then begin
          RaiseLastOSError;
        end else begin
          raise EIdResolveError.CreateFmt(RSResolveError, [ahostname, gai_strerror(LRetVal), LRetVal]);
        end;
      end else begin
        result := TranslateTInAddrToString(LAddrInfo^.ai_addr^.sin_zero, Id_IPv6);
        freeaddrinfo(LAddrInfo);
      end;
    end;
    else
      Result := ''; // avoid warning
      IPVersionUnsupported;
  end;
end;

function TIdStackLinux.ReadHostName: string;
begin
  SetLength(Result, 250);
  GetHostName(PChar(Result), Length(Result));
  Result := String(PChar(Result));
end;

procedure TIdStackLinux.Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer);
begin
  CheckForSocketError(Libc.Listen(ASocket, ABacklog));
end;

function TIdStackLinux.WSRecv(ASocket: TIdStackSocketHandle; var ABuffer;
  const ABufferLength, AFlags: Integer): Integer;
begin
  //IdStackWindows is just: Result := Recv(ASocket, ABuffer, ABufferLength, AFlags);
  Result := Recv(ASocket, ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL);
end;

function TIdStackLinux.RecvFrom(const ASocket: TIdStackSocketHandle;
  var VBuffer; const ALength, AFlags: Integer; var VIP: string;
  var VPort: TIdPort; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION ): Integer;
var
  LiSize: Cardinal;
  LAddr6: sockaddr_in6;
begin
  case AIPVersion of
    Id_IPv4,
    Id_IPv6: begin
      LiSize := SizeOf(LAddr6);
      Result := Libc.RecvFrom(ASocket, VBuffer, ALength, AFlags or Id_MSG_NOSIGNAL, PSockAddr(@LAddr6), @LiSize);
      VIP := TranslateTInAddrToString(LAddr6.sin6_addr, AIPVersion);
      VPort := NToHs(LAddr6.sin6_port);
    end;
    else begin
      Result := 0;
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackLinux.ReceiveMsg(ASocket: TIdStackSocketHandle;
     var VBuffer: TIdBytes;
     APkt :  TIdPacketInfo;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Cardinal;
{var
  LIP : String;
  LPort : TIdPort;
  LSize: Cardinal;
  LAddr4: SockAddr_In;
  LAddr6: SockAddr_In6;
  LMsg : msghdr;
  LMsgBuf : BUF;
  LControl : TIdBytes;
  LCurCmsg : CMSGHDR;   //for iterating through the control buffer
  LCurPt : Pin_pktinfo;
  LCurPt6 : Pin6_pktinfo;
  LByte : PByte;
  LDummy, LDummy2 : Cardinal;
      
begin
   //we call the macro twice because we specified two possible structures.
   //Id_IPV6_HOPLIMIT and Id_IPV6_PKTINFO
   LSize := CMSG_LEN(CMSG_LEN(Length(VBuffer)));
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

        GWindowsStack.CheckForSocketError(RecvMsg(ASocket,@LMsg,Result,nil,nil));
        APkt.SourceIP :=  TranslateTInAddrToString(LAddr4.sin_addr,Id_IPv4);

        APkt.SourcePort := NToHs(LAddr4.sin_port);
      end;
      Id_IPv6: begin
        LMsg.name := PSOCKADDR( @LAddr6);
        LMsg.namelen := SizeOf(LAddr6);

        CheckForSocketError( RecvMsg(ASocket,@LMsg,Result,@LDummy,LPwsaoverlapped_COMPLETION_ROUTINE(@LDummy2)));
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
      LCurCmsg := CMSG_NXTHDR(@LMsg,LCurCmsg);
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
    until False; }
begin
end;

function TIdStackLinux.WSSend(ASocket: TIdStackSocketHandle;
  const ABuffer; const ABufferLength, AFlags: Integer): Integer;
begin
  //CC: Should Id_MSG_NOSIGNAL be included?
  //  Result := Send(ASocket, ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL);
  Result := CheckForSocketError(Libc.send(ASocket, ABuffer, ABufferLength, AFlags));
end;

procedure TIdStackLinux.WSSendTo(ASocket: TIdStackSocketHandle;
  const ABuffer; const ABufferLength, AFlags: Integer; const AIP: string;
  const APort: TIdPort; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LAddr6: SockAddr_in6;
  LBytesOut: integer;
begin
  case AIPVersion of
    Id_IPv4, Id_IPv6:
      begin
        FillChar(LAddr6, SizeOf(LAddr6), 0);
        with LAddr6 do begin
          sin6_family := IdIPFamily[AIPVersion];
          TranslateStringToTInAddr(AIP, sin6_addr, AIPVersion);
          sin6_port := HToNs(APort);
        end;
        {$IFDEF KYLIX}
        LBytesOut := Libc.SendTo(ASocket, ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL, Psockaddr(@LAddr6)^, SizeOf(LAddr6));
        {$ELSE}
                LBytesOut := Libc.SendTo(ASocket, ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL, Psockaddr(@LAddr6), SizeOf(LAddr6));
        {$ENDIF}
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

procedure TIdStackLinux.SetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel:TIdSocketProtocol; AOptName: TIdSocketOption; AOptVal: Integer);
begin
  CheckForSocketError(SetSockOpt(ASocket, ALevel, AOptName, PChar(@AOptVal), SizeOf(AOptVal)));
end;

procedure TIdStackLinux.SetSocketOption(
  const ASocket: TIdStackSocketHandle; const Alevel, Aoptname: Integer;
  Aoptval: PChar; const Aoptlen: Integer);
begin
  CheckForSocketError( setsockopt(ASocket,ALevel,Aoptname,Aoptval,Aoptlen ));
end;

function TIdStackLinux.WSGetLastError: Integer;
begin
  //IdStackWindows just uses   result := WSAGetLastError;
  Result := GetLastError; //System.GetLastOSError; - FPC doesn't define it in System
  if Result = Id_WSAEPIPE then begin
    Result := Id_WSAECONNRESET;
  end;
end;

function TIdStackLinux.WSSocket(AFamily, AStruct, AProtocol: Integer;
     const AOverlapped: Boolean = False): TIdStackSocketHandle; 
begin
  Result := Libc.socket(AFamily, AStruct, AProtocol);
end;

function TIdStackLinux.GetLocalAddresses: TIdStrings;
begin
  if FLocalAddresses = nil then
  begin
    FLocalAddresses := TIdStringList.Create;
  end;
  PopulateLocalAddresses;
  Result := FLocalAddresses;
end;

function TIdStackLinux.WSGetServByName(const AServiceName: string): TIdPort;
var
  Lps: PServEnt;
begin
  Lps := GetServByName(PChar(AServiceName), nil);
  if Lps <> nil then begin
    Result := Ntohs(Lps^.s_port);
  end else begin
    try
      Result := StrToInt(AServiceName);
    except
      on EConvertError do begin
        raise EIdInvalidServiceName.CreateFmt(RSInvalidServiceName, [AServiceName]);
      end;
    end;
  end;
end;

function TIdStackLinux.WSGetServByPort(const APortNumber: TIdPort): TIdStrings;
var
  Lps: PServEnt;
  Li: Integer;
  Lp: array of PChar;
begin
  Result := TIdStringList.Create;
  Lp := nil;
  try
    Lps := GetServByPort(HToNs(APortNumber), nil);
    if Lps <> nil then begin
      Result.Add(Lps^.s_name);
      Li := 0;
      Lp := pointer(Lps^.s_aliases);
      while Lp[Li] <> nil do begin
        Result.Add(PChar(Lp[Li]));
        inc(Li);
      end;
    end;
  except
    Result.Free;
  end;
end;

function TIdStackLinux.HostToNetwork(AValue: Word): Word;
begin
  Result := HToNs(AValue);
end;

function TIdStackLinux.NetworkToHost(AValue: Word): Word;
begin
  Result := NToHs(AValue);
end;

function TIdStackLinux.HostToNetwork(AValue: LongWord): LongWord;
begin
  Result := HToNL(AValue);
end;

function TIdStackLinux.NetworkToHost(AValue: LongWord): LongWord;
begin
  Result := NToHL(AValue);
end;

{ RP - I'm not sure what endian Linux natively uses, thus the
check to see if the bytes need swapping or not ... }
function TIdStackLinux.HostToNetwork(AValue: Int64): Int64;
var
  LParts: TIdInt64Parts;
  L: LongWord;
begin
  LParts.QuadPart := AValue;
  L := HToNL(LParts.HighPart);
  if (L <> LParts.HighPart) then begin
    LParts.HighPart := HToNL(LParts.LowPart);
    LParts.LowPart := L;
  end;
  Result := LParts.QuadPart;
end;

function TIdStackLinux.NetworkToHost(AValue: Int64): Int64;
var
  LParts: TIdInt64Parts;
  L: LongWord;
begin
  LParts.QuadPart := AValue;
  L := NToHL(LParts.HighPart);
  if (L <> LParts.HighPart) then begin
    LParts.HighPart := NToHL(LParts.LowPart);
    LParts.LowPart := L;
  end;
  Result := LParts.QuadPart;
end;

procedure TIdStackLinux.PopulateLocalAddresses;
type
  TaPInAddr = Array[0..250] of PInAddr;
  PaPInAddr = ^TaPInAddr;
var
  Li: Integer;
  LAHost: PHostEnt;
  LPAdrPtr: PaPInAddr;
begin
  // this won't get IPv6 addresses as I didn't find a way
  // to enumerate IPv6 addresses on a linux machine
  FLocalAddresses.Clear;
  LAHost := GetHostByName(PChar(HostName));
  if LAHost = nil then begin
    CheckForSocketError(SOCKET_ERROR);
  end else begin
    LPAdrPtr := PAPInAddr(LAHost^.h_addr_list);
    Li := 0;
    while LPAdrPtr^[Li] <> nil do begin
      FLocalAddresses.Add(TranslateTInAddrToString(LPAdrPtr^[Li]^, Id_IPv4));
      Inc(Li);
    end;
  end;
end;

function TIdStackLinux.GetLocalAddress: string;
begin
  Result := LocalAddresses[0];
end;

function TIdStackLinux.HostByAddress(const AAddress: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
var
{$IFDEF KYLIX}
  LHints: TAddressInfo;
  LAddrInfo: PAddressInfo;
{$ELSE}
  LHints: AddrInfo; //The T is no omission - that's what I found in the header
  LAddrInfo: PAddrInfo;
{$ENDIF}
  LRetVal: integer;
begin
  case AIPVersion of
    Id_IPv6, Id_IPv4: begin
      FillChar(LHints,sizeof(LHints), 0);
      LHints.ai_family := IdIPFamily[AIPVersion];
      LHints.ai_socktype := Integer(SOCK_STREAM);
      LHints.ai_flags := AI_CANONNAME + AI_NUMERICHOST;
      LAddrInfo:=nil;
      LRetVal := getaddrinfo(pchar(AAddress), nil, @LHints, @LAddrInfo);
      if LRetVal<>0 then begin
        if LRetVal = EAI_SYSTEM then begin
          RaiseLastOSError;
        end else begin
          raise EIdReverseResolveError.CreateFmt(RSReverseResolveError, [AAddress, gai_strerror(LRetVal), LRetVal]);
        end;
      end else begin
        result := LAddrInfo^.ai_canonname;
        freeaddrinfo(LAddrInfo);
      end;
    end;
(* JMB: I left this in here just in case someone
        complains, but the other code works on all
        linux systems for all addresses and is thread-safe

variables for it:
  Host: PHostEnt;
  LAddr: u_long;

    Id_IPv4: begin
      // GetHostByAddr is thread-safe in Linux.
      // It might not be safe in Solaris or BSD Unix
      LAddr := inet_addr(PChar(AAddress));
      Host := GetHostByAddr(@LAddr,SizeOf(LAddr),AF_INET);
      if (Host <> nil) then begin
        Result := Host^.h_name;
      end else begin
        RaiseSocketError(h_errno);
      end;
    end;
*)
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackLinux.WSShutdown(ASocket: TIdStackSocketHandle; AHow: Integer): Integer;
begin
  Result := Shutdown(ASocket, AHow);
end;

procedure TIdStackLinux.Disconnect(ASocket: TIdStackSocketHandle);
begin
  // Windows uses Id_SD_Send, Linux should use Id_SD_Both
  WSShutdown(ASocket, Id_SD_Both);
  // SO_LINGER is false - socket may take a little while to actually close after this
  WSCloseSocket(ASocket);
end;

procedure TIdStackLinux.GetPeerName(ASocket: TIdStackSocketHandle;
 var VIP: string; var VPort: TIdPort);
var
  i: Cardinal;
  LAddr6: sockaddr_in6;
begin
  i := SizeOf(LAddr6);
  CheckForSocketError(Libc.GetPeerName(ASocket, Psockaddr(@LAddr6)^, i));
  case LAddr6.sin6_family of
    Id_PF_INET4: begin
      VIP := TranslateTInAddrToString(Psockaddr(@LAddr6)^.sin_addr, Id_IPv4);
      VPort := Ntohs(Psockaddr(@LAddr6)^.sin_port);
    end;
    Id_PF_INET6: begin
      VIP := TranslateTInAddrToString(LAddr6.sin6_addr, Id_IPv6);
      VPort := Ntohs(LAddr6.sin6_port);
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackLinux.GetSocketName(ASocket: TIdStackSocketHandle;
 var VIP: string; var VPort: TIdPort);
var
  i: Cardinal;
  LAddr6: sockaddr_in6;
begin
  i := SizeOf(LAddr6);
  CheckForSocketError(GetSockName(ASocket, Psockaddr(@LAddr6)^, i));
  case LAddr6.sin6_family of
    Id_PF_INET4: begin
      VIP := TranslateTInAddrToString(Psockaddr(@LAddr6)^.sin_addr, Id_IPv4);
      VPort := Ntohs(Psockaddr(@LAddr6)^.sin_port);
    end;
    Id_PF_INET6: begin
      VIP := TranslateTInAddrToString(LAddr6.sin6_addr, Id_IPv6);
      VPort := Ntohs(LAddr6.sin6_port);
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackLinux.WSGetSockOpt(ASocket: TIdStackSocketHandle; ALevel, AOptname: Integer; AOptval: PChar; var AOptlen: Integer);
begin
  CheckForSocketError(Libc.GetSockOpt(ASocket, ALevel, AOptname, AOptval, Cardinal(AOptlen)));
end;

procedure TIdStackLinux.GetSocketOption(ASocket: TIdStackSocketHandle;
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


function TIdStackLinux.WouldBlock(const AResult: Integer): Boolean;
begin
  //non-blocking does not exist in Linux, always indicate things will block
  Result := True;
end;

function TIdStackLinux.SupportsIPv6:boolean;
//In Windows, this does something else.  It checks the LSP's installed.
begin
  Result := CheckIPVersionSupport(Id_IPv6);
end;


function TIdStackLinux.CheckIPVersionSupport(
  const AIPVersion: TIdIPVersion): boolean;
var LTmpSocket:TIdStackSocketHandle;
begin
  LTmpSocket := WSSocket(IdIPFamily[AIPVersion], Integer(Id_SOCK_STREAM), Id_IPPROTO_IP );
  result:=LTmpSocket<>Id_INVALID_SOCKET;
  if LTmpSocket<>Id_INVALID_SOCKET then begin
    WSCloseSocket(LTmpSocket);
  end;
end;

procedure TIdStackLinux.WriteChecksum(s: TIdStackSocketHandle;
  var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
  const APort: TIdPort; const AIPVersion: TIdIPVersion);
begin
  case AIPVersion of
    Id_IPv4 : CopyTIdWord(HostToLittleEndian(CalcCheckSum(VBuffer)),VBuffer,AOffset);
    Id_IPv6 : WriteChecksumIPv6(s,VBuffer, AOffset, AIP, APort);
  else
    IPVersionUnsupported;
  end;
end;

procedure TIdStackLinux.WriteChecksumIPv6(s: TIdStackSocketHandle;
  var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
  const APort: TIdPort);
var LOffset : Integer;
begin
//we simply request that the kernal write the checksum when the data
//is sent.  All of the parameters required are because Windows is bonked
//because it doesn't have the IPV6CHECKSUM socket option meaning we have
//to querry the network interface in TIdStackWindows -- yuck!!
  LOffset := AOffset;
  CheckForSocketError(setsockopt(s, IPPROTO_IPV6, IPV6_CHECKSUM, @Loffset, sizeof(Loffset)));
end;

function TIdStackLinux.IOControl(const s:  TIdStackSocketHandle; const cmd: cardinal; var arg: cardinal ): Integer;
var LArg : PtrUInt;
begin
  LArg := arg;
  Result := ioctl(s,cmd,Pointer(LArg));
end;

{ TIdSocketListLinux }

procedure TIdSocketListLinux.Add(AHandle: TIdStackSocketHandle);
begin
  lock;
  try
    if not FD_ISSET(AHandle, FFDSet) then begin
      if Count >= __FD_SETSIZE then begin
        raise EIdStackSetSizeExceeded.Create(RSSetSizeExceeded);
      end;
      FD_SET(AHandle, FFDSet);
      Inc(FCount);
    end;
  finally
    Unlock;
  end;
end;//

procedure TIdSocketListLinux.Clear;
begin
  lock;
  try
    FD_ZERO(FFDSet);
    FCount := 0;
  finally
    Unlock;
  end;
end;

function TIdSocketListLinux.Contains(
  AHandle: TIdStackSocketHandle): boolean;
begin
  lock; try
    Result := FD_ISSET(AHandle, FFDSet);
  finally Unlock; end;
end;

function TIdSocketListLinux.Count: Integer;
begin
  lock; try
    Result := FCount;
  finally Unlock; end;
end;//

class function TIdSocketListLinux.FDSelect(AReadSet, AWriteSet,
  AExceptSet: PFDSet; const ATimeout: Integer): integer;
var
  LTime: TTimeVal;
begin
  if ATimeout = IdTimeoutInfinite then begin
    Result := Libc.Select(FD_SETSIZE, AReadSet, AWriteSet, AExceptSet, nil);
  end else begin
    LTime.tv_sec := ATimeout div 1000;
    LTime.tv_usec := (ATimeout mod 1000) * 1000;
    Result := Libc.Select(FD_SETSIZE, AReadSet, AWriteSet, AExceptSet, @LTime);
  end;
end;

procedure TIdSocketListLinux.GetFDSet(var VSet: TFDSet);
begin
  Lock; try
    VSet := FFDSet;
  finally Unlock; end;
end;

function TIdSocketListLinux.GetItem(AIndex: Integer): TIdStackSocketHandle;
var
  LIndex, i: Integer;
begin
  Result := 0;
  LIndex := 0;
  //? use FMaxHandle div x
  for i:= 0 to __FD_SETSIZE - 1 do begin
    if FD_ISSET(i, FFDSet) then begin
      if LIndex = AIndex then begin
        Result := i;
        break;
      end else begin
        Inc(LIndex);
      end;
    end;
  end;
End;//

procedure TIdSocketListLinux.Remove(AHandle: TIdStackSocketHandle);
begin
  Lock;
  try
    if FD_ISSET(AHandle, FFDSet) then begin
      Dec(FCount);
      FD_CLR(AHandle, FFDSet);
    end;
  finally
    Unlock;
  end;
end;//


function TIdStackLinux.WSTranslateSocketErrorMsg(const AErr: Integer): string;
begin
  //we override this function for the herr constants that
  //are returned by the DNS functions
  case AErr of
    Libc.HOST_NOT_FOUND: Result := RSStackHOST_NOT_FOUND;
    Libc.TRY_AGAIN: Result := RSStackTRY_AGAIN;
    Libc.NO_RECOVERY: Result := RSStackNO_RECOVERY;
    Libc.NO_DATA: Result := RSStackNO_DATA;
  else
    Result := inherited WSTranslateSocketErrorMsg(AErr);
  end;
end;

procedure TIdSocketListLinux.SetFDSet(var VSet: TFDSet);
begin
  Lock; try
    FFDSet := VSet;
  finally Unlock; end;
end;

class function TIdSocketListLinux.Select(AReadList: TIdSocketList; AWriteList: TIdSocketList;
      AExceptList: TIdSocketList; const ATimeout: Integer = IdTimeoutInfinite): Boolean;
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
      TIdSocketListLinux(AList).GetFDSet(ASet);
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
  TIdSocketListLinux(AReadList).SetFDSet(LReadSet);
  TIdSocketListLinux(AWriteList).SetFDSet(LWriteSet);
  TIdSocketListLinux(AExceptList).SetFDSet(LExceptSet);
end;

function TIdSocketListLinux.SelectRead(const ATimeout: Integer): Boolean;
var
  LSet: TFDSet;
begin
  Lock; try
    LSet := FFDSet;
    // select() updates this structure on return,
    // so we need to copy it each time we need it
  finally
    Unlock;
  end;
  Result := FDSelect(@LSet, nil, nil, ATimeout) > 0;
end;

function TIdSocketListLinux.SelectReadList(var VSocketList: TIdSocketList; const ATimeout: Integer = IdTimeoutInfinite): Boolean;
var
  LSet: TFDSet;
begin
  lock;
  try
    LSet := FFDSet;
    // select() updates this structure on return,
    // so we need to copy it each time we need it
  finally
    Unlock;
  end;
  Result := FDSelect(@LSet, nil, nil, ATimeout) > 0;
  if Result then begin
    if VSocketList = NIL then begin
      VSocketList := TIdSocketList.CreateSocketList;
    end;
    TIdSocketListLinux(VSocketList).SetFDSet(LSet);
  end;
end;

procedure TIdStackLinux.SetBlocking(ASocket: TIdStackSocketHandle;
  const ABlocking: Boolean);
begin
  if (ABlocking=False) then begin
    Raise EIdBlockingNotSupported.Create( RSStackNotSupportedOnLinux );
  end;
end;

(*
Why did I remove this again?

 1) it sends SIGPIPE even if the socket is created with the no-sigpipe bit set
    that could be solved by blocking sigpipe within this thread
    This is probably a bug in the Linux kernel, but we could work around it
    by blocking that signal for the time of sending the file (just get the
    sigprocmask, see if pipe bit is set, if not set it and remove again after
    sending the file)

But the more serious reason is another one, which exists in Windows too:
 2) I think that ServeFile is misdesigned:
    ServeFile does not raise an exception if it didn't send all the bytes.
    Now what happens if I have OnExecute assigned like this
      AThread.Connection.ServeFile('...', True); // <-- true to send via kernel
    is that it will return 0, but notice that in this case I didn't ask for the
    result. Net effect is that the thread will loop in OnExecute even if the
    socket is long gone. This doesn't fit Indy semantics at all, exceptions are
    always raised if the remote end disconnects. Even if I would do
      AThread.Connection.ServeFile('...', False);
    then it would raise an exception.
    I think this is a big flaw in the design of the ServeFile function.
    Maybe GServeFile should only return the bytes sent, but then
    TCPConnection.ServeFile() should raise an exception if GServeFile didn't
    send all the bytes.

JM Berg, 2002-09-09

function ServeFile(ASocket: TIdStackSocketHandle; AFileName: string): cardinal;
var
  LFileHandle: integer;
  offset: integer;
  stat: _stat;
begin
  LFileHandle := open(PChar(AFileName), O_RDONLY);
  try
    offset := 0;
    fstat(LFileHandle, stat);
    Result := sendfile(ASocket, LFileHandle, offset, stat.st_size);
//**    if Result = Cardinal(-1) then RaiseLastOSError;
  finally libc.__close(LFileHandle); end;
end;
*)
function TIdSocketListLinux.Clone: TIdSocketList;
begin
  Result := TIdSocketListLinux.Create;
  Lock; try
    TIdSocketListLinux(Result).SetFDSet(FFDSet);
  finally
    Unlock;
  end;
end;

initialization
  GSocketListClass := TIdSocketListLinux;
end.

