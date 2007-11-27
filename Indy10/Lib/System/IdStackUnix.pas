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
unit IdStackUnix;

interface

{$i IdCompilerDefines.inc}

uses
  Classes,
  sockets,
  baseunix,
  IdStack,
  IdStackConsts,
  IdGlobal,
  IdStackBSDBase;

  {$IFDEF FREEBSD}
     {$DEFINE SOCK_HAS_SINLEN}
  {$ENDIF}
  {$IFDEF DARWIN}
     {$DEFINE SOCK_HAS_SINLEN}
  {$ENDIF}
type
  {$IFNDEF NOREDECLARE}
  Psockaddr = ^sockaddr;
  {$ENDIF}
  TIdSocketListUnix = class (TIdSocketList)
  protected
    FCount: Integer;
    FFDSet: TFDSet;
    //
    class function FDSelect(AReadSet: PFDSet; AWriteSet: PFDSet; AExceptSet: PFDSet;
      const ATimeout: Integer = IdTimeoutInfinite): Integer;
    function GetItem(AIndex: Integer): TIdStackSocketHandle; override;
  public
    procedure Add(AHandle: TIdStackSocketHandle); override;
    procedure Remove(AHandle: TIdStackSocketHandle); override;
    function Count: Integer; override;
    procedure Clear; override;
    function Clone: TIdSocketList; override;
    function ContainsSocket(AHandle: TIdStackSocketHandle): Boolean; override;
    procedure GetFDSet(var VSet: TFDSet);
    procedure SetFDSet(var VSet: TFDSet);
    class function Select(AReadList: TIdSocketList; AWriteList: TIdSocketList;
      AExceptList: TIdSocketList; const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
    function SelectRead(const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
    function SelectReadList(var VSocketList: TIdSocketList;
      const ATimeout: Integer = IdTimeoutInfinite): Boolean; override;
  end;

  TIdStackUnix = class(TIdStackBSDBase)
  protected
//    procedure SetSocketOption(ASocket: TIdStackSocketHandle;
//      ALevel: TIdSocketProtocol; AOptName: TIdSocketOption; AOptVal: Integer);
    procedure WriteChecksumIPv6(s: TIdStackSocketHandle; var VBuffer: TIdBytes;
      const AOffset: Integer; const AIP: String; const APort: TIdPort);
    function GetLastError: Integer;
    procedure SetLastError(const AError: Integer);
    function HostByName(const AHostName: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;
    procedure PopulateLocalAddresses; override;
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
    function WSTranslateSocketErrorMsg(const AErr: Integer): string; override;
    function Accept(ASocket: TIdStackSocketHandle; var VIP: string; var VPort: TIdPort;
      var VIPVersion: TIdIPVersion): TIdStackSocketHandle; override;
    procedure Bind(ASocket: TIdStackSocketHandle; const AIP: string;
     const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure Connect(const ASocket: TIdStackSocketHandle; const AIP: string;
     const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    function HostByAddress(const AAddress: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; override;
    function WSGetLastError: Integer; override;
    function WSGetServByName(const AServiceName: string): TIdPort; override;
    function WSGetServByPort(const APortNumber: TIdPort): TStrings; override;
    procedure WSGetSockOpt(ASocket: TIdStackSocketHandle; Alevel, AOptname: Integer;
      AOptval: PChar; var AOptlen: Integer); override;
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
    function RecvFrom(const ASocket: TIdStackSocketHandle; var VBuffer;
      const ALength, AFlags: Integer; var VIP: string; var VPort: TIdPort;
      AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer; override;
    function ReceiveMsg(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes;
      APkt :  TIdPacketInfo; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): LongWord; override;
    procedure WSSendTo(ASocket: TIdStackSocketHandle; const ABuffer;
      const ABufferLength, AFlags: Integer; const AIP: string; const APort: TIdPort;
      AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    function WSSocket(AFamily, AStruct, AProtocol: Integer;
     const AOverlapped: Boolean = False): TIdStackSocketHandle; override;
    procedure Disconnect(ASocket: TIdStackSocketHandle); override;
    procedure SetSocketOption(ASocket: TIdStackSocketHandle; ALevel: TIdSocketOptionLevel;
      AOptName: TIdSocketOption; AOptVal: Integer); overload;override;
    procedure SetSocketOption( const ASocket: TIdStackSocketHandle;
      const Alevel, Aoptname: Integer; Aoptval: PChar; const Aoptlen: Integer); overload; override;
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
  end;

  {$IFNDEF NOREDECLARE}
  TLinger = record
    l_onoff: Word;
    l_linger: Word;
  end;
  {$ENDIF}
  TIdLinger = TLinger;

implementation

uses
  netdb,
  unix,
  IdResourceStrings,
  IdException,
  SysUtils;


//from: netdbh.inc, we can not include it with the I derrective and netdb.pas
//does not expose it.
{const
  EAI_SYSTEM = -(11);}

const
  FD_SETSIZE = FD_MAXFDSET;
  __FD_SETSIZE = FD_MAXFDSET;
  {$IFDEF DARWIN}
  Id_MSG_NOSIGNAL = SO_NOSIGPIPE;
  {$ELSE}
  Id_MSG_NOSIGNAL = MSG_NOSIGNAL;
  {$ENDIF}
  ESysEPIPE = ESysEPIPE;

//helper functions for some structs

{Note:  These hide an API difference in structures.

BSD 4.4 introduced a minor API change.  sa_family was changed from a 16bit
word to an 8 bit byteee and an 8 bit byte feild named sa_len was added.

}
procedure InitSockaddr(var VSock : Sockaddr);
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  FillChar(VSock, SizeOf(Sockaddr),0);
  VSock.sin_family := PF_INET;
  {$IFDEF SOCK_HAS_SINLEN}
  VSock.sa_len := SizeOf(Sockaddr);
  {$ENDIF}
end;

procedure InitSockAddr_in6(var VSock : SockAddr_in6);
{$IFDEF USEINLINE} inline; {$ENDIF}
begin
  FillChar(VSock, SizeOf(SockAddr_in6), 0);
  {$IFDEF SOCK_HAS_SINLEN}
  VSock.sin6_len := SizeOf(SockAddr_in6);
  {$ENDIF}
  VSock.sin6_family := PF_INET6;
end;
//
constructor TIdStackUnix.Create;
begin
  inherited Create;
end;

destructor TIdStackUnix.Destroy;
begin
  inherited Destroy;
end;

function TIdStackUnix.GetLastError : Integer;
begin
  Result := SocketError;
end;

procedure TIdStackUnix.SetLastError(Const AError : Integer);
begin
  errno := AError;
end;

function TIdStackUnix.Accept(ASocket: TIdStackSocketHandle;
  var VIP: string; var VPort: TIdPort; var VIPVersion: TIdIPVersion): TIdStackSocketHandle;
var
  LA : LongInt;
  LAddr: sockaddr_in6;
  PIP4 : PSockAddr;
begin
  LA := SizeOf(LAddr);
  Result := fpaccept(ASocket, @LAddr, @LA);
  //calls prefixed by fp to avoid clashing with libc

  if Result <> ID_SOCKET_ERROR then begin
    case LAddr.sin6_family of
      PF_INET : begin
        PIP4 := @LAddr;
        VIP := NetAddrToStr(PIP4^.sin_addr);
        VPort := Ntohs(PIP4^.sin_port);
        VIPVersion := Id_IPv4;
      end;
      PF_INET6: begin
        VIP := NetAddrToStr6(LAddr.sin6_addr);
        VPort := Ntohs(LAddr.sin6_port);
        VIPVersion := Id_IPv6;
      end;
      else begin
        fpclose(Result);
        Result := Id_INVALID_SOCKET;
        IPVersionUnsupported;
      end;
    end;
  end else begin
    if GetLastError = ESysEBADF then begin
      SetLastError(ESysEINTR);
    end;
  end;
end;

procedure TIdStackUnix.Bind(ASocket: TIdStackSocketHandle; const AIP: string;
  const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LAddr: SockAddr;
  LAddr6: SockAddr_in6;
begin
  case AIPVersion of
    Id_IPv4: begin
        InitSockAddr(LAddr);
        if Length(AIP) = 0 then begin
          LAddr.sin_addr.s_addr := INADDR_ANY;
        end else begin
          LAddr.sin_addr := StrToNetAddr(AIP);
      //    TranslateStringToTInAddr(AIP, LAddr.sin_addr, Id_IPv4);
        end;
        LAddr.sin_port := HToNs(APort);
        CheckForSocketError(fpBind(ASocket, @LAddr, SizeOf(LAddr)));
      end;
    Id_IPv6: begin
        InitSockAddr_in6(LAddr6);
        if Length(AIP) <> 0 then begin
          LAddr6.sin6_addr := StrToNetAddr6(AIP);
         // TranslateStringToTInAddr(AIP, LAddr6.sin6_addr, Id_IPv6);
        end;
        LAddr6.sin6_port := HToNs(APort);

        CheckForSocketError(fpBind(ASocket, Psockaddr(@LAddr6), SizeOf(LAddr6)));
      end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackUnix.WSCloseSocket(ASocket: TIdStackSocketHandle): Integer;
begin
  Result := fpclose(ASocket);
end;

procedure TIdStackUnix.Connect(const ASocket: TIdStackSocketHandle;
  const AIP: string; const APort: TIdPort;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LAddr: SockAddr;
  LAddr6: SockAddr_in6;
begin
  case AIPVersion of
    Id_IPv4: begin
      InitSockAddr(LAddr);
      LAddr.sin_addr := StrToNetAddr(AIP);
//      TranslateStringToTInAddr(AIP, LAddr.sin_addr, Id_IPv4);
      LAddr.sin_port := HToNs(APort);
      CheckForSocketError(fpConnect(ASocket, @LAddr, SizeOf(LAddr)));
    end;
    Id_IPv6: begin
      InitSockAddr_in6(LAddr6);
//      LAddr6.sin6_flowinfo := 0;
//      LAddr6.sin6_scope_id := 0;
      LAddr6.sin6_addr := StrToNetAddr6(AIP);
     //  TranslateStringToTInAddr(AIP, LAddr6.sin6_addr, Id_IPv6);
      LAddr6.sin6_port := HToNs(APort);
      CheckForSocketError(fpConnect(ASocket, Psockaddr(@LAddr6), SizeOf(LAddr6)));
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackUnix.HostByName(const AHostName: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
var
  LI4 : array of THostAddr;
  LH4 : THostEntry;
  LI6 : array of THostAddr6;

  LRetVal : Integer;
begin
  case AIPVersion of
    ID_IPv4 :
    begin
      if GetHostByName(AHostName,LH4) then
      begin
        Result := HostAddrToStr( LH4.Addr );
        exit;
      end
      else
      begin
        SetLength(LI4, 10);
        LRetVal := ResolveName(AHostName, LI4);
        if LRetVal < 1 then begin
          raise EIdResolveError.CreateFmt(RSResolveError, [AHostName, 'Error', LRetVal]); {do not localize}
        end;
        Result := NetAddrToStr(LI4[0]);
      end;
    end;
    ID_IPv6 :
    begin
      SetLength(LI6, 10);
      LRetVal :=  ResolveName6(AHostName, LI6);
      if LRetVal < 1 then begin
        raise EIdResolveError.CreateFmt(RSResolveError, [AHostName, LRetVal]);
      end;
      Result := NetAddrToStr6(LI6[0]);
    end;
  end;
end;

function TIdStackUnix.ReadHostName: string;
begin
  Result := GetHostName;
end;

procedure TIdStackUnix.Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer);
begin
  CheckForSocketError(fpListen(ASocket, ABacklog));
end;

function TIdStackUnix.WSRecv(ASocket: TIdStackSocketHandle; var ABuffer;
  const ABufferLength, AFlags: Integer): Integer;
begin
  //IdStackWindows is just: Result := Recv(ASocket, ABuffer, ABufferLength, AFlags);
  Result := fpRecv(ASocket, @ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL);
end;

function TIdStackUnix.RecvFrom(const ASocket: TIdStackSocketHandle;
  var VBuffer; const ALength, AFlags: Integer; var VIP: string;
  var VPort: TIdPort; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION ): Integer;
var
  LiSize: tsocklen;
  LAddr: SockAddr;
  LAddr6: sockaddr_in6;
begin
  case AIPVersion of
    Id_IPv4 :
      begin
        LiSize := SizeOf(LAddr);
        Result := fpRecvFrom(ASocket, @VBuffer, ALength, AFlags or Id_MSG_NOSIGNAL, @LAddr, @LiSize);
        VIP := NetAddrToStr(LAddr.sin_addr);
        VPort := NToHs(LAddr.sin_port);
      end;
    Id_IPv6:
      begin
        LiSize := SizeOf(LAddr6);
        Result := fpRecvFrom(ASocket, @VBuffer, ALength, AFlags or Id_MSG_NOSIGNAL, PSockAddr(@LAddr6), @LiSize);
        VIP := NetAddrToStr6(LAddr6.sin6_addr);
        VPort := NToHs(LAddr6.sin6_port);
      end;
    else begin
      Result := 0;
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackUnix.ReceiveMsg(ASocket: TIdStackSocketHandle;
  var VBuffer: TIdBytes; APkt :  TIdPacketInfo;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): LongWord;
var
  LIP : String;
  LPort : TIdPort;
begin
  LongWord(Result) := RecvFrom(ASocket, VBuffer[0], Length(VBuffer), 0, LIP, LPort);
  APkt.SourceIP := LIP;
  APkt.SourcePort := LPort;
  SetLength(VBuffer,Result);
end;
{The stuff below is commented out until I figure out what to do}
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

        CheckForSocketError(RecvMsg(ASocket,@LMsg,Result,nil,nil));
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


function TIdStackUnix.WSSend(ASocket: TIdStackSocketHandle;
  const ABuffer; const ABufferLength, AFlags: Integer): Integer;
begin
  //CC: Should Id_MSG_NOSIGNAL be included?
  //  Result := Send(ASocket, ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL);
  Result := CheckForSocketError(fpsend(ASocket, @ABuffer, ABufferLength, AFlags));
end;

procedure TIdStackUnix.WSSendTo(ASocket: TIdStackSocketHandle;
  const ABuffer; const ABufferLength, AFlags: Integer; const AIP: string;
  const APort: TIdPort; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LAddr : Sockaddr;
  LAddr6: SockAddr_in6;
  LBytesOut: integer;
begin
  case AIPVersion of
    Id_IPv4 :
      begin
        InitSockAddr(LAddr);
        LAddr.sin_addr := StrToNetAddr(AIP);
        LAddr.sin_port := HToNs(APort);
        LBytesOut := fpSendTo(ASocket, @ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL, Psockaddr(@LAddr), SizeOf(sockaddr));
      end;
    Id_IPv6:
      begin
        InitSockAddr_in6(LAddr6);
        LAddr6.sin6_addr := StrToHostAddr6(AIP);
        // TranslateStringToTInAddr(AIP, sin6_addr, AIPVersion);
        LAddr6.sin6_port := HToNs(APort);
        LBytesOut := fpSendTo(ASocket, @ABuffer, ABufferLength, AFlags or Id_MSG_NOSIGNAL, Psockaddr(@LAddr6), SizeOf(LAddr6));
      end;
    else begin
      LBytesOut := 0; // avoid warning
      IPVersionUnsupported;
    end;
  end;
  if LBytesOut = -1 then begin
    if WSGetLastError() = Id_WSAEMSGSIZE then begin
      raise EIdPackageSizeTooBig.Create(RSPackageSizeTooBig);
    end else begin
      RaiseLastSocketError;
    end;
  end else if LBytesOut <> ABufferLength then begin
    raise EIdNotAllBytesSent.Create(RSNotAllBytesSent);
  end;
end;

procedure TIdStackUnix.SetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel: TIdSocketProtocol; AOptName: TIdSocketOption; AOptVal: Integer);
begin
  CheckForSocketError(fpSetSockOpt(ASocket, ALevel, AOptName, PChar(@AOptVal), SizeOf(AOptVal)));
end;

procedure TIdStackUnix.SetSocketOption(const ASocket: TIdStackSocketHandle;
  const Alevel, Aoptname: Integer; Aoptval: PChar; const Aoptlen: Integer);
begin
  CheckForSocketError(fpsetsockopt(ASocket, ALevel, Aoptname, Aoptval, Aoptlen));
end;

function TIdStackUnix.WSGetLastError: Integer;
begin
  //IdStackWindows just uses   result := WSAGetLastError;
  Result := GetLastError; //System.GetLastOSError; - FPC doesn't define it in System
  if Result = ESysEPIPE then begin
    Result := Id_WSAECONNRESET;
  end;
end;

function TIdStackUnix.WSSocket(AFamily, AStruct, AProtocol: Integer;
  const AOverlapped: Boolean = False): TIdStackSocketHandle; 
begin
  Result := fpsocket(AFamily, AStruct, AProtocol);
end;

function TIdStackUnix.WSGetServByName(const AServiceName: string): TIdPort;
var
  LS : TServiceEntry;
begin
  if GetServiceByName(AServiceName, '', LS) then begin
    Result := LS.Port;
  end else begin
    raise EIdInvalidServiceName.CreateFmt(RSInvalidServiceName, [AServiceName]);
  end;
end;

function TIdStackUnix.WSGetServByPort(const APortNumber: TIdPort): TStrings;
var
  LS : TServiceEntry;
begin
  Result := TStringList.Create;
  try
    if GetServiceByPort(APortNumber, '', LS) then begin
      Result.Add(LS.Name);
    end;
  except
    FreeAndNil(Result);
    raise;
  end;
end;

function TIdStackUnix.HostToNetwork(AValue: Word): Word;
begin
  Result := HToNs(AValue);
end;

function TIdStackUnix.NetworkToHost(AValue: Word): Word;
begin
  Result := NToHs(AValue);
end;

function TIdStackUnix.HostToNetwork(AValue: LongWord): LongWord;
begin
  Result := HToNL(AValue);
end;

function TIdStackUnix.NetworkToHost(AValue: LongWord): LongWord;
begin
  Result := NToHL(AValue);
end;

{ RP - I'm not sure what endian Linux natively uses, thus the
check to see if the bytes need swapping or not ... }
function TIdStackUnix.HostToNetwork(AValue: Int64): Int64;
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

function TIdStackUnix.NetworkToHost(AValue: Int64): Int64;
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

procedure TIdStackUnix.PopulateLocalAddresses;
var
  LI : array of THostAddr;
  i : Integer;
  LHostName : String;
begin
  LHOstName := GetHostName;
  if LHostName = '' then begin
    CheckForSocketError(Id_SOCKET_ERROR);
  end;
  // this won't get IPv6 addresses as I didn't find a way
  // to enumerate IPv6 addresses on a linux machine
  FLocalAddresses.Clear;
  if ResolveName(LHostName, LI) = 0 then
  begin
    for i := Low(LI) to High(LI) do
    begin
      //byte order conversion was done by resolveName
      FLocalAddresses.Add(HostAddrToStr(LI[i]));
    end;
  end;
end;

function TIdStackUnix.HostByAddress(const AAddress: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
var
  LI : Array of string;
  LAddr4: THostAddr;
  LAddr6: THostAddr6;
begin
  Result := '';
  case AIPVersion of
    Id_IPv4 :
    begin
      LAddr4 := StrToNetAddr(AAddress);
      if ResolveAddress(LAddr4, LI) = 0 then begin
        Result := LI[0];
      end;
    end;
    Id_IPv6 :
    begin
      LAddr6 := StrToNetAddr6(AAddress);
      if ResolveAddress6(LAddr6, LI) = 0 then begin
        Result := LI[0];
      end;
    end;
  end;
end;

function TIdStackUnix.WSShutdown(ASocket: TIdStackSocketHandle; AHow: Integer): Integer;
begin
  Result := fpShutdown(ASocket, AHow);
end;

procedure TIdStackUnix.Disconnect(ASocket: TIdStackSocketHandle);
begin
  // Windows uses Id_SD_Send, Linux should use Id_SD_Both
  WSShutdown(ASocket, Id_SD_Both);
  // SO_LINGER is false - socket may take a little while to actually close after this
  WSCloseSocket(ASocket);
end;

procedure TIdStackUnix.GetPeerName(ASocket: TIdStackSocketHandle; var VIP: string;
  var VPort: TIdPort; var VIPVersion: TIdIPVersion);
var
  i: tsocklen;
  LAddr6: sockaddr_in6;
  LP: PSockAddr;
begin
  i := SizeOf(LAddr6);
  CheckForSocketError(fpGetPeerName(ASocket, @LAddr6, @i));
  case LAddr6.sin6_family of
    PF_INET: begin
      LP := @LAddr6;
      VIP := NetAddrToStr(LP^.sin_addr );
      VPort := Ntohs(LP^.sin_port);
      VIPVersion := Id_IPv4;
    end;
    PF_INET6: begin
      VIP := NetAddrToStr6(LAddr6.sin6_addr);
      VPort := Ntohs(LAddr6.sin6_port);
      VIPVersion := Id_IPv6;
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackUnix.GetSocketName(ASocket: TIdStackSocketHandle;
  var VIP: string; var VPort: TIdPort; var VIPVersion: TIdIPVersion);
var
  i: tsocklen;
  PIP4 : PSockAddr;
  LAddr6: sockaddr_in6;
begin
  i := SizeOf(LAddr6);
  CheckForSocketError(fpGetSockName(ASocket, @LAddr6, @i));
  case LAddr6.sin6_family of
    PF_INET : begin
      PIP4 := @LAddr6;
      VIP := NetAddrToStr(PIP4^.sin_addr);
      VPort := Ntohs(PIP4^.sin_port);
      VIPVersion := Id_IPV4;
    end;
    PF_INET6: begin
      VIP := NetAddrToStr6(LAddr6.sin6_addr);
      VPort := Ntohs(LAddr6.sin6_port);
      VIPVersion := Id_IPv6;
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackUnix.WSGetSockOpt(ASocket: TIdStackSocketHandle;
  ALevel, AOptname: Integer; AOptval: PChar; var AOptlen: Integer);
var
  LP : TSockLen;
begin
  LP := AOptLen;
  CheckForSocketError(fpGetSockOpt(ASocket, ALevel, AOptname, AOptval, @LP));
end;

procedure TIdStackUnix.GetSocketOption(ASocket: TIdStackSocketHandle;
  ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption;
  out AOptVal: Integer);
var
  LP : PAnsiChar;
  LLen : Integer;
  LBuf : Integer;
begin
  LP := Addr(LBuf);
  LLen := SizeOf(Integer);
  WSGetSockOpt(ASocket, ALevel, AOptName, LP, LLen);
  AOptVal := LBuf;
end;


function TIdStackUnix.WSTranslateSocketErrorMsg(const AErr: Integer): string;
begin
  //we override this function for the herr constants that
  //are returned by the DNS functions
  //note that this is not really applicable because we are using some
  //FPC functions that do direct DNS lookups without the standard Unix
  //DNS functions.  It sounds odd but I think there's a good reason for it.
  Result := inherited WSTranslateSocketErrorMsg(AErr);
end;

procedure TIdStackUnix.SetBlocking(ASocket: TIdStackSocketHandle;
  const ABlocking: Boolean);
begin
  if not ABlocking then begin
    raise EIdBlockingNotSupported.Create(RSStackNotSupportedOnUnix);
  end;
end;

function TIdStackUnix.WouldBlock(const AResult: Integer): Boolean;
begin
  //non-blocking does not exist in Linux, always indicate things will block
  Result := True;
end;

function TIdStackUnix.SupportsIPv6: Boolean;
//In Windows, this does something else.  It checks the LSP's installed.
begin
  Result := CheckIPVersionSupport(Id_IPv6);
end;

function TIdStackUnix.CheckIPVersionSupport(const AIPVersion: TIdIPVersion): Boolean;
var
  LTmpSocket: TIdStackSocketHandle;
begin
  LTmpSocket := WSSocket(IdIPFamily[AIPVersion], Integer(Id_SOCK_STREAM), Id_IPPROTO_IP);
  Result := LTmpSocket <> Id_INVALID_SOCKET;
  if Result then begin
    WSCloseSocket(LTmpSocket);
  end;
end;

procedure TIdStackUnix.WriteChecksum(s: TIdStackSocketHandle;
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

procedure TIdStackUnix.WriteChecksumIPv6(s: TIdStackSocketHandle;
  var VBuffer: TIdBytes; const AOffset: Integer; const AIP: String;
  const APort: TIdPort);
var
  LOffset : Integer;
begin
//we simply request that the kernal write the checksum when the data
//is sent.  All of the parameters required are because Windows is bonked
//because it doesn't have the IPV6CHECKSUM socket option meaning we have
//to querry the network interface in TIdStackWindows -- yuck!!
  LOffset := AOffset;
  CheckForSocketError(fpsetsockopt(s, Id_IPPROTO_IPV6, IPV6_CHECKSUM, @Loffset, SizeOf(Loffset)));
end;

function TIdStackUnix.IOControl(const s: TIdStackSocketHandle; const cmd: LongWord;
  var arg: LongWord): Integer;
var
  LArg : PtrUInt;
begin
  LArg := arg;
  Result := fpioctl(s, cmd, Pointer(LArg));
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

{ TIdSocketListUnix }

procedure TIdSocketListUnix.Add(AHandle: TIdStackSocketHandle);
begin
  Lock;
  try
    if fpFD_ISSET(AHandle, FFDSet) = 0 then begin
      if Count >= FD_SETSIZE then begin
        raise EIdStackSetSizeExceeded.Create(RSSetSizeExceeded);
      end;
      fpFD_SET(AHandle, FFDSet);
      Inc(FCount);
    end;
  finally
    Unlock;
  end;
end;//

procedure TIdSocketListUnix.Clear;
begin
  Lock;
  try
    fpFD_ZERO(FFDSet);
    FCount := 0;
  finally
    Unlock;
  end;
end;

function TIdSocketListUnix.ContainsSocket(AHandle: TIdStackSocketHandle): Boolean;
begin
  Lock; try
    Result := fpFD_ISSET(AHandle, FFDSet) > 0;
  finally Unlock; end;
end;

function TIdSocketListUnix.Count: Integer;
begin
  Lock; try
    Result := FCount;
  finally Unlock; end;
end;//

class function TIdSocketListUnix.FDSelect(AReadSet, AWriteSet, AExceptSet: PFDSet;
  const ATimeout: Integer): Integer;
var
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
  Result := fpSelect(FD_SETSIZE, AReadSet, AWriteSet, AExceptSet, LTimePtr);
end;

procedure TIdSocketListUnix.GetFDSet(var VSet: TFDSet);
begin
  Lock; try
    VSet := FFDSet;
  finally Unlock; end;
end;

function TIdSocketListUnix.GetItem(AIndex: Integer): TIdStackSocketHandle;
var
  LIndex, i: Integer;
begin
  Result := 0;
  LIndex := 0;
  //? use FMaxHandle div x
  for i:= 0 to __FD_SETSIZE - 1 do begin
    if fpFD_ISSET(i, FFDSet)=1 then begin
      if LIndex = AIndex then begin
        Result := i;
        Break;
      end else begin
        Inc(LIndex);
      end;
    end;
  end;
end;

procedure TIdSocketListUnix.Remove(AHandle: TIdStackSocketHandle);
begin
  Lock;
  try
    if fpFD_ISSET(AHandle, FFDSet) = 1 then
    begin
      Dec(FCount);
      fpFD_CLR(AHandle, FFDSet);
    end;
  finally
    Unlock;
  end;
end;//

procedure TIdSocketListUnix.SetFDSet(var VSet: TFDSet);
begin
  Lock; try
    FFDSet := VSet;
  finally Unlock; end;
end;

class function TIdSocketListUnix.Select(AReadList: TIdSocketList; AWriteList: TIdSocketList;
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
      TIdSocketListUnix(AList).GetFDSet(ASet);
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
  Result := FDSelect(LPReadSet, LPWriteSet, LPExceptSet, ATimeout) <> 0;
  //
  TIdSocketListUnix(AReadList).SetFDSet(LReadSet);
  TIdSocketListUnix(AWriteList).SetFDSet(LWriteSet);
  TIdSocketListUnix(AExceptList).SetFDSet(LExceptSet);
end;

function TIdSocketListUnix.SelectRead(const ATimeout: Integer): Boolean;
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

function TIdSocketListUnix.SelectReadList(var VSocketList: TIdSocketList;
  const ATimeout: Integer = IdTimeoutInfinite): Boolean;
var
  LSet: TFDSet;
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
    TIdSocketListUnix(VSocketList).SetFDSet(LSet);
  end;
end;

function TIdSocketListUnix.Clone: TIdSocketList;
begin
  Result := TIdSocketListUnix.Create;
  Lock; try
    TIdSocketListUnix(Result).SetFDSet(FFDSet);
  finally
    Unlock;
  end;
end;

initialization
  GSocketListClass := TIdSocketListUnix;

end.

