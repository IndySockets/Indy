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

  Rev 1.7    12/06/2004 15:16:44  CCostelloe
  Restructured to remove inconsistencies with derived classes

  Rev 1.6    07/06/2004 21:30:48  CCostelloe
  Kylix 3 changes

  Rev 1.5    5/15/2004 3:32:30 AM  DSiders
  Corrected case in name of TIdIPAddressRec.

  Rev 1.4    4/18/04 10:29:24 PM  RLebeau
  Added TIdInt64Parts structure

  Rev 1.3    2004.04.18 4:41:40 PM  czhower
  RaiseSocketError

  Rev 1.2    2004.03.07 11:45:24 AM  czhower
  Flushbuffer fix + other minor ones found

  Rev 1.1    3/6/2004 5:16:24 PM  JPMugaas
  Bug 67 fixes.  Do not write to const values.

  Rev 1.0    2004.02.03 3:14:44 PM  czhower
  Move and updates

  Rev 1.22    2/1/2004 3:28:26 AM  JPMugaas
  Changed WSGetLocalAddress to GetLocalAddress and moved into IdStack since
  that will work the same in the DotNET as elsewhere.  This is required to
  reenable IPWatch.

  Rev 1.21    1/31/2004 1:13:00 PM  JPMugaas
  Minor stack changes required as DotNET does support getting all IP addresses
  just like the other stacks.

  Rev 1.20    12/4/2003 3:14:56 PM  BGooijen
  Added HostByAddress

  Rev 1.19    12/31/2003 9:52:00 PM  BGooijen
  Added IPv6 support

  Rev 1.18    10/26/2003 5:04:24 PM  BGooijen
  UDP Server and Client

  Rev 1.17    10/26/2003 09:10:24 AM  JPMugaas
  Calls necessary for IPMulticasting.

  Rev 1.16    10/22/2003 04:41:04 PM  JPMugaas
  Should compile with some restored functionality.  Still not finished.

  Rev 1.15    10/21/2003 06:24:24 AM  JPMugaas
  BSD Stack now have a global variable for refercing by platform specific
  things.  Removed corresponding var from Windows stack.

  Rev 1.14    10/19/2003 5:21:28 PM  BGooijen
  SetSocketOption

  Rev 1.13    2003.10.11 5:51:08 PM  czhower
  -VCL fixes for servers
  -Chain suport for servers (Super core)
  -Scheduler upgrades
  -Full yarn support

  Rev 1.12    10/5/2003 9:55:28 PM  BGooijen
  TIdTCPServer works on D7 and DotNet now

  Rev 1.11    04/10/2003 22:32:02  HHariri
  moving of WSNXXX method to IdStack and renaming of the DotNet ones

  Rev 1.10    10/2/2003 7:36:28 PM  BGooijen
  .net

  Rev 1.9    2003.10.02 10:16:30 AM  czhower
  .Net

  Rev 1.8    2003.10.01 9:11:22 PM  czhower
  .Net

  Rev 1.7    2003.10.01 5:05:16 PM  czhower
  .Net

  Rev 1.6    2003.10.01 2:30:42 PM  czhower
  .Net

  Rev 1.3    10/1/2003 12:14:16 AM  BGooijen
  DotNet: removing CheckForSocketError

  Rev 1.2    2003.10.01 1:12:38 AM  czhower
  .Net

  Rev 1.1    2003.09.30 1:25:02 PM  czhower
  Added .inc file.

  Rev 1.0    2003.09.30 1:24:20 PM  czhower
  Initial Checkin

  Rev 1.10    2003.09.30 10:36:02 AM  czhower
  Moved stack creation to IdStack
  Added DotNet stack.

  Rev 1.9    9/8/2003 02:13:14 PM  JPMugaas
  SupportsIP6 function added for determining if IPv6 is installed on a system.

  Rev 1.8    2003.07.17 4:57:04 PM  czhower
  Added new exception type so it can be added to debugger list of ignored
  exceptions.

  Rev 1.7    2003.07.14 11:46:46 PM  czhower
  IOCP now passes all bubbles.

  Rev 1.6    2003.07.14 1:57:24 PM  czhower
  -First set of IOCP fixes.
  -Fixed a threadsafe problem with the stack class.

  Rev 1.5    7/1/2003 05:20:38 PM  JPMugaas
  Minor optimizations.  Illiminated some unnecessary string operations.

  Rev 1.4    7/1/2003 03:39:54 PM  JPMugaas
  Started numeric IP function API calls for more efficiency.

  Rev 1.3    7/1/2003 12:46:08 AM  JPMugaas
  Preliminary stack functions taking an IP address numerical structure instead
  of a string.

  Rev 1.2    5/10/2003 4:02:22 PM  BGooijen

  Rev 1.1    2003.05.09 10:59:26 PM  czhower

  Rev 1.0    11/13/2002 08:59:02 AM  JPMugaas
}

unit IdStackBSDBase;

interface

{$I IdCompilerDefines.inc}

{$IFDEF DotNet}
Improper compile.
This unit must NOT be linked into DotNet applications.
{$ENDIF}

uses
  Classes,
  IdException, IdStack, IdStackConsts, IdGlobal;

type
  EIdNotASocket = class(EIdSocketError);

  TIdServeFile = function(ASocket: TIdStackSocketHandle; AFileName: string): LongWord;

  // RP - for use with the HostToNetwork() and NetworkToHost()
  // methods under Windows and Linux since the Socket API doesn't
  // have native conversion functions for int64 values...
  TIdInt64Parts = packed record
    case Integer of
    0: (
      LowPart: LongWord;
      HighPart: LongWord);
    1: (
      QuadPart: Int64);
  end;

  TIdIPv6AddressRec = packed array[0..7] of Word;

  TIdIPAddressRec = packed record
    IPVer: TIdIPVersion;
    case Integer of
    0: (IPv4, Junk1, Junk2, Junk3: LongWord);
    2: (IPv6 : TIdIPv6AddressRec);
  end;

//procedure EmptyIPRec(var VIP : TIdIPAddress);

  TIdSunB = packed record
    s_b1, s_b2, s_b3, s_b4: byte;
  end;

  TIdSunW = packed record
    s_w1, s_w2: word;
  end;

  PIdIn4Addr = ^TIdIn4Addr;
  TIdIn4Addr = packed record
    case integer of
        0: (S_un_b: TIdSunB);
        1: (S_un_w: TIdSunW);
        2: (S_addr: longword);
  end;

  PIdIn6Addr = ^TIdIn6Addr;
  TIdIn6Addr = packed record
    case Integer of
    0: (s6_addr: packed array [0..16-1] of Byte);
    1: (s6_addr16: packed array [0..8-1] of Word);
    2: (s6_addr32: packed array [0..4-1] of LongWord);
  end;

  PIdInAddr = ^TIdInAddr;
  TIdInAddr = {$IFDEF IPv6} TIdIn6Addr; {$ELSE} TIdIn4Addr; {$ENDIF}

  //Do not change these structures or insist on objects
  //because these are parameters to IP_ADD_MEMBERSHIP and IP_DROP_MEMBERSHIP
  TIdIPMreq = packed record
    IMRMultiAddr : TIdIn4Addr;   // IP multicast address of group */
    IMRInterface : TIdIn4Addr;   // local IP address of interface */
  end;
  TIdIPv6Mreq = packed record
    ipv6mr_multiaddr : TIdIn6Addr;  //IPv6 multicast addr
    ipv6mr_interface : LongWord;  //interface index
  end;

  TIdStackBSDBase = class(TIdStack)
  protected
    function WSCloseSocket(ASocket: TIdStackSocketHandle): Integer; virtual; abstract;
    function WSRecv(ASocket: TIdStackSocketHandle; var ABuffer;
     const ABufferLength, AFlags: Integer): Integer; virtual; abstract;
    function WSSend(ASocket: TIdStackSocketHandle; const ABuffer;
     const ABufferLength, AFlags: Integer): Integer; virtual; abstract;
    function WSShutdown(ASocket: TIdStackSocketHandle; AHow: Integer): Integer;
     virtual; abstract;
     //internal for multicast membership stuff
    procedure MembershipSockOpt(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String; const ASockOpt : Integer;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
  public
    constructor Create; override;
    destructor Destroy; override;
    function CheckIPVersionSupport(const AIPVersion: TIdIPVersion): boolean; virtual; abstract;
    function Receive(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes): Integer; override;
    function Send(ASocket: TIdStackSocketHandle; const ABuffer: TIdBytes;
      AOffset: Integer = 0; ASize: Integer = -1): Integer; override;
    function ReceiveFrom(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes;
      var VIP: string; var VPort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION
      ): Integer; override;
    function SendTo(ASocket: TIdStackSocketHandle; const ABuffer: TIdBytes;
      const AOffset: Integer; const AIP: string; const APort: TIdPort;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer; override;
    procedure SetSocketOption( const ASocket: TIdStackSocketHandle;
      const Alevel, Aoptname: Integer; Aoptval: PChar;
      const Aoptlen: Integer); overload; virtual; abstract;
    function TranslateTInAddrToString(var AInAddr; const AIPVersion: TIdIPVersion): string;
    procedure TranslateStringToTInAddr(const AIP: string; var AInAddr; const AIPVersion: TIdIPVersion);
    function WSGetServByName(const AServiceName: string): TIdPort; virtual; abstract;
    function WSGetServByPort(const APortNumber: TIdPort): TStrings; virtual; abstract;
    function RecvFrom(const ASocket: TIdStackSocketHandle; var ABuffer;
      const ALength, AFlags: Integer; var VIP: string; var VPort: TIdPort;
      AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer; virtual; abstract;
    procedure WSSendTo(ASocket: TIdStackSocketHandle; const ABuffer;
      const ABufferLength, AFlags: Integer; const AIP: string; const APort: TIdPort;
      AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); virtual; abstract;
    function WSSocket(AFamily, AStruct, AProtocol: Integer;
      const AOverlapped: Boolean = False): TIdStackSocketHandle; virtual; abstract;
    procedure WSGetSockOpt(ASocket: TIdStackSocketHandle; Alevel, AOptname: Integer;
      AOptval: PChar; var AOptlen: Integer); virtual; abstract;
    procedure SetBlocking(ASocket: TIdStackSocketHandle;
     const ABlocking: Boolean); virtual; abstract;
    function WouldBlock(const AResult: Integer): Boolean; virtual; abstract;
    function NewSocketHandle(const ASocketType: TIdSocketType;
      const AProtocol: TIdSocketProtocol;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION;
      const AOverlapped: Boolean = False)
     : TIdStackSocketHandle; override;
    //multicast stuff Kudzu permitted me to add here.
    procedure SetMulticastTTL(AHandle: TIdStackSocketHandle;
      const AValue : Byte; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure SetLoopBack(AHandle: TIdStackSocketHandle; const AValue: Boolean;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure DropMulticastMembership(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
    procedure AddMulticastMembership(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); override;
  end;

  EIdInvalidServiceName = class(EIdException);
  EIdStackInitializationFailed = class (EIdStackError);
  EIdStackSetSizeExceeded = class (EIdStackError);

var
  GServeFileProc: TIdServeFile = nil;

//for some reason, if GDBSDStack is in the same block as GServeFileProc then
//FPC gives a type declaration error.
var
  GBSDStack: TIdStackBSDBase = nil;

const
  IdIPFamily : array[TIdIPVersion] of Integer = (Id_PF_INET4, Id_PF_INET6);

implementation

uses
  //done this way so we can have a separate stack for the Unix systems in FPC
  {$IFDEF UNIX}
    {$IFDEF USELIBC}
  IdStackLinux,
    {$ELSE}
  IdStackUnix,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
  IdStackWindows,
  {$ENDIF}
  {$IFDEF DOTNET}
  IdStackDotNet,
  {$ENDIF}
  IdResourceStrings, SysUtils;

{ TIdStackBSDBase }

function TIdStackBSDBase.TranslateTInAddrToString(var AInAddr;
  const AIPVersion: TIdIPVersion): string;
var
  i: integer;
begin
  case AIPVersion of
    Id_IPv4: begin
      with TIdIn4Addr(AInAddr).S_un_b do begin
        Result := IntToStr(s_b1) + '.' + IntToStr(s_b2) + '.' + IntToStr(s_b3) + '.'    {Do not Localize}
         + IntToStr(s_b4);
      end;
    end;
    Id_IPv6: begin
      Result := '';
      for i := 0 to 7 do begin
        Result := Result + IntToHex(NetworkToHost(TIdIn6Addr(AInAddr).s6_addr16[i]),1)+':';
      end;
      SetLength(Result, Length(Result)-1);
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackBSDBase.TranslateStringToTInAddr(const AIP: string;
  var AInAddr; const AIPVersion: TIdIPVersion);
var
  LIP: String;
  LAddress: TIdIPv6Address;
begin
  case AIPVersion of
    Id_IPv4: begin
      LIP := AIP;
      with TIdIn4Addr(AInAddr).S_un_b do begin
        s_b1 := IndyStrToInt(Fetch(LIP, '.'));    {Do not Localize}
        s_b2 := IndyStrToInt(Fetch(LIP, '.'));    {Do not Localize}
        s_b3 := IndyStrToInt(Fetch(LIP, '.'));    {Do not Localize}
        s_b4 := IndyStrToInt(Fetch(LIP, '.'));    {Do not Localize}
      end;
    end;
    Id_IPv6: begin
      IPv6ToIdIPv6Address(AIP, LAddress);
      TIdIPv6Address(TIdIn6Addr(AInAddr).s6_addr16) := HostToNetwork(LAddress);
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

function TIdStackBSDBase.NewSocketHandle(const ASocketType:TIdSocketType;
  const AProtocol: TIdSocketProtocol;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION;
  const AOverlapped: Boolean = False): TIdStackSocketHandle;
begin
  Result := CheckForSocketError(WSSocket(IdIPFamily[AIPVersion], ASocketType,
    AProtocol, AOverlapped));
end;

constructor TIdStackBSDBase.Create;
begin
  inherited Create;
  GBSDStack := Self;
end;

destructor TIdStackBSDBase.Destroy;
begin
  FreeAndNil(FLocalAddresses);
  inherited Destroy;
end;

function TIdStackBSDBase.Receive(ASocket: TIdStackSocketHandle;
 var VBuffer: TIdBytes): Integer;
begin
  Result := CheckForSocketError(WSRecv(ASocket, VBuffer[0], Length(VBuffer) , 0));
end;

function TIdStackBSDBase.Send(ASocket: TIdStackSocketHandle; const ABuffer: TIdBytes;
  AOffset: Integer = 0; ASize: Integer = -1): Integer;
begin
  ASize := IndyLength(ABuffer, ASize, AOffset);
  if ASize > 0 then begin
    Result := WSSend(ASocket, PChar(@ABuffer[AOffset])^, ASize, 0);
  end else begin
    Result := 0;
  end;
end;

function TIdStackBSDBase.ReceiveFrom(ASocket: TIdStackSocketHandle;
  var VBuffer: TIdBytes; var VIP: string; var VPort: TIdPort;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer;
begin
   Result := CheckForSocketError(RecvFrom(ASocket, VBuffer[0], Length(VBuffer),
     0, VIP, VPort, AIPVersion));
end;

function TIdStackBSDBase.SendTo(ASocket: TIdStackSocketHandle;
  const ABuffer: TIdBytes; const AOffset: Integer; const AIP: string;
  const APort: TIdPort;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer;
begin
   // must use pointer(ABuffer)^, can't use ABuffer[0], because ABuffer may have a 0 length
   WSSendTo(ASocket, Pointer(ABuffer)^, Length(ABuffer), 0, AIP, APort, AIPVersion);
   Result := Length(ABuffer);
end;

procedure TIdStackBSDBase.DropMulticastMembership(AHandle: TIdStackSocketHandle;
  const AGroupIP, ALocalIP : String; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  if AIPVersion = Id_IPv4 then begin
    MembershipSockOpt(AHandle, AGroupIP, ALocalIP, Id_IP_DROP_MEMBERSHIP);
  end else begin
    MembershipSockOpt(AHandle, AGroupIP, ALocalIP, Id_IPV6_DROP_MEMBERSHIP, AIPVersion);
  end;
end;

procedure TIdStackBSDBase.AddMulticastMembership(AHandle: TIdStackSocketHandle;
  const AGroupIP, ALocalIP : String; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
begin
  if AIPVersion = Id_IPv4 then begin
    MembershipSockOpt(AHandle, AGroupIP, ALocalIP, Id_IP_ADD_MEMBERSHIP, AIPVersion);
  end else begin
    MembershipSockOpt(AHandle, AGroupIP, ALocalIP, Id_IPV6_ADD_MEMBERSHIP, AIPVersion);
  end;
end;

procedure TIdStackBSDBase.SetMulticastTTL(AHandle: TIdStackSocketHandle;
  const AValue: Byte; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LThisTTL: Integer;
begin
  LThisTTL := AValue;
  if AIPVersion = Id_IPv4 then begin
    GBSDStack.SetSocketOption(AHandle, Id_IPPROTO_IP, Id_IP_MULTICAST_TTL,
      PChar(@LThisTTL), SizeOf(LThisTTL));
  end else begin
    GBSDStack.SetSocketOption(AHandle, Id_IPPROTO_IPv6, Id_IPV6_MULTICAST_HOPS,
      PChar(@LThisTTL), SizeOf(LThisTTL));
  end;
end;

procedure TIdStackBSDBase.SetLoopBack(AHandle: TIdStackSocketHandle;
  const AValue: Boolean; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LThisLoopback: Integer;
begin
  if AValue then begin
    LThisLoopback := 1;
  end else begin
    LThisLoopback := 0;
  end;
  if AIPVersion = Id_IPv4 then begin
    GBSDStack.SetSocketOption(AHandle, Id_IPPROTO_IP, Id_IP_MULTICAST_LOOP,
      PChar(@LThisLoopback), SizeOf(LThisLoopback));
  end else begin
    GBSDStack.SetSocketOption(AHandle, Id_IPPROTO_IPv6, Id_IPV6_MULTICAST_LOOP,
      PChar(@LThisLoopback), SizeOf(LThisLoopback));
  end;
end;

procedure TIdStackBSDBase.MembershipSockOpt(AHandle: TIdStackSocketHandle;
  const AGroupIP, ALocalIP: String;  const ASockOpt: Integer;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION);
var
  LIP4: TIdIPMreq;
  LIP6: TIdIPv6Mreq;
begin
  if IsValidIPv4MulticastGroup(AGroupIP) then
  begin
    GBSDStack.TranslateStringToTInAddr(AGroupIP, LIP4.IMRMultiAddr, Id_IPv4);
    LIP4.IMRInterface.S_addr := Id_INADDR_ANY;
    GBSDStack.SetSocketOption(AHandle, Id_IPPROTO_IP, ASockOpt, PChar(@LIP4), SizeOf(LIP4));
  end
  else if IsValidIPv6MulticastGroup(AGroupIP) then
  begin
    GBSDStack.TranslateStringToTInAddr(AGroupIP, LIP6.ipv6mr_multiaddr, Id_IPv6);
    //this should be safe meaning any adaptor
    //we can't support a localhost address in IPv6 because we can't get that
    //and even if you could, you would have to convert it into a network adaptor
    //index - Yuk
    LIP6.ipv6mr_interface := 0;
    GBSDStack.SetSocketOption(AHandle, Id_IPPROTO_IPv6, ASockOpt, PChar(@LIP6), SizeOf(LIP6));
  end;
end;

end.
