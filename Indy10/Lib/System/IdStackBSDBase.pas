{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  56390: IdStackBSDBase.pas
{
{   Rev 1.8    10/26/2004 8:12:30 PM  JPMugaas
{ Now uses TIdStrings and TIdStringList for portability.
}
{
{   Rev 1.7    12/06/2004 15:16:44  CCostelloe
{ Restructured to remove inconsistencies with derived classes
}
{
{   Rev 1.6    07/06/2004 21:30:48  CCostelloe
{ Kylix 3 changes
}
{
    Rev 1.5    5/15/2004 3:32:30 AM  DSiders
  Corrected case in name of TIdIPAddressRec.
}
{
{   Rev 1.4    4/18/04 10:29:24 PM  RLebeau
{ Added TIdInt64Parts structure
}
{
{   Rev 1.3    2004.04.18 4:41:40 PM  czhower
{ RaiseSocketError
}
{
{   Rev 1.2    2004.03.07 11:45:24 AM  czhower
{ Flushbuffer fix + other minor ones found
}
{
{   Rev 1.1    3/6/2004 5:16:24 PM  JPMugaas
{ Bug 67 fixes.  Do not write to const values.
}
{
{   Rev 1.0    2004.02.03 3:14:44 PM  czhower
{ Move and updates
}
{
{   Rev 1.22    2/1/2004 3:28:26 AM  JPMugaas
{ Changed WSGetLocalAddress to GetLocalAddress and moved into IdStack since
{ that will work the same in the DotNET as elsewhere.  This is required to
{ reenable IPWatch.
}
{
{   Rev 1.21    1/31/2004 1:13:00 PM  JPMugaas
{ Minor stack changes required as DotNET does support getting all IP addresses
{ just like the other stacks.
}
{
{   Rev 1.20    12/4/2003 3:14:56 PM  BGooijen
{ Added HostByAddress
}
{
{   Rev 1.19    12/31/2003 9:52:00 PM  BGooijen
{ Added IPv6 support
}
{
{   Rev 1.18    10/26/2003 5:04:24 PM  BGooijen
{ UDP Server and Client
}
{
{   Rev 1.17    10/26/2003 09:10:24 AM  JPMugaas
{ Calls necessary for IPMulticasting.
}
{
{   Rev 1.16    10/22/2003 04:41:04 PM  JPMugaas
{ Should compile with some restored functionality.  Still not finished.
}
{
{   Rev 1.15    10/21/2003 06:24:24 AM  JPMugaas
{ BSD Stack now have a global variable for refercing by platform specific
{ things.  Removed corresponding var from Windows stack.
}
{
{   Rev 1.14    10/19/2003 5:21:28 PM  BGooijen
{ SetSocketOption
}
{
{   Rev 1.13    2003.10.11 5:51:08 PM  czhower
{ -VCL fixes for servers
{ -Chain suport for servers (Super core)
{ -Scheduler upgrades
{ -Full yarn support
}
{
{   Rev 1.12    10/5/2003 9:55:28 PM  BGooijen
{ TIdTCPServer works on D7 and DotNet now
}
{
{   Rev 1.11    04/10/2003 22:32:02  HHariri
{ moving of WSNXXX method to IdStack and renaming of the DotNet ones
}
{
{   Rev 1.10    10/2/2003 7:36:28 PM  BGooijen
{ .net
}
{
{   Rev 1.9    2003.10.02 10:16:30 AM  czhower
{ .Net
}
{
{   Rev 1.8    2003.10.01 9:11:22 PM  czhower
{ .Net
}
{
{   Rev 1.7    2003.10.01 5:05:16 PM  czhower
{ .Net
}
{
{   Rev 1.6    2003.10.01 2:30:42 PM  czhower
{ .Net
}
{
{   Rev 1.3    10/1/2003 12:14:16 AM  BGooijen
{ DotNet: removing CheckForSocketError
}
{
{   Rev 1.2    2003.10.01 1:12:38 AM  czhower
{ .Net
}
{
{   Rev 1.1    2003.09.30 1:25:02 PM  czhower
{ Added .inc file.
}
{
{   Rev 1.0    2003.09.30 1:24:20 PM  czhower
{ Initial Checkin
}
{
{   Rev 1.10    2003.09.30 10:36:02 AM  czhower
{ Moved stack creation to IdStack
{ Added DotNet stack.
}
{
{   Rev 1.9    9/8/2003 02:13:14 PM  JPMugaas
{ SupportsIP6 function added for determining if IPv6 is installed on a system.
}
{
{   Rev 1.8    2003.07.17 4:57:04 PM  czhower
{ Added new exception type so it can be added to debugger list of ignored
{ exceptions.
}
{
{   Rev 1.7    2003.07.14 11:46:46 PM  czhower
{ IOCP now passes all bubbles.
}
{
{   Rev 1.6    2003.07.14 1:57:24 PM  czhower
{ -First set of IOCP fixes.
{ -Fixed a threadsafe problem with the stack class.
}
{
{   Rev 1.5    7/1/2003 05:20:38 PM  JPMugaas
{ Minor optimizations.  Illiminated some unnecessary string operations.
}
{
{   Rev 1.4    7/1/2003 03:39:54 PM  JPMugaas
{ Started numeric IP function API calls for more efficiency.
}
{
{   Rev 1.3    7/1/2003 12:46:08 AM  JPMugaas
{ Preliminary stack functions taking an IP address numerical structure instead
{ of a string.
}
{
    Rev 1.2    5/10/2003 4:02:22 PM  BGooijen
}
{
{   Rev 1.1    2003.05.09 10:59:26 PM  czhower
}
{
{   Rev 1.0    11/13/2002 08:59:02 AM  JPMugaas
}
unit IdStackBSDBase;

{$I IdCompilerDefines.inc}

{$IFDEF DotNet}
Improper compile.
This unit must NOT be linked into DotNet applications.
{$ENDIF}

interface

uses
  Classes,
  IdException, IdStack, IdStackConsts,IdObjs, IdGlobal,
  SyncObjs, IdSys;

type
  EIdNotASocket = class(EIdSocketError);

  TIdServeFile = function(ASocket: TIdStackSocketHandle; AFileName: string): cardinal;

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
    0: (IPv4, Junk1, Junk2, Junk3: Cardinal);
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
    0: (s6_addr: packed array [0..16-1] of byte);
    1: (s6_addr16: packed array [0..8-1] of word);
    2: (s6_addr32: packed array [0..4-1] of cardinal);
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
    ipv6mr_interface : Cardinal;  //interface index
  end;
  TIdStackBSDBase = class(TIdStack)
  protected
    procedure IPVersionUnsupported;
    procedure RaiseLastSocketError;
    function WSCloseSocket(ASocket: TIdStackSocketHandle): Integer; virtual; abstract;
    function WSRecv(ASocket: TIdStackSocketHandle; var ABuffer;
     const ABufferLength, AFlags: Integer): Integer; virtual; abstract;
    function WSSend(ASocket: TIdStackSocketHandle; const ABuffer;
     const ABufferLength, AFlags: Integer): Integer; virtual; abstract;
    function WSShutdown(ASocket: TIdStackSocketHandle; AHow: Integer): Integer;
     virtual; abstract;
     //internal for multicast membership stuff
    procedure MembershipSockOpt(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String; const ASockOpt : Integer);
  public
    constructor Create; override;
    destructor Destroy; override;
    function CheckIPVersionSupport(const AIPVersion: TIdIPVersion): boolean; {virtual;}
    procedure RaiseSocketError(AErr: integer);
    function Receive(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes)
     : Integer; override;
    function Send(
      ASocket: TIdStackSocketHandle;
      const ABuffer: TIdBytes;
      AOffset: Integer = 0;
      ASize: Integer = -1
      ): Integer; override;
    function ReceiveFrom(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes;
             var VIP: string; var VPort: Integer;
             const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION
             ): Integer; override;
    function SendTo(ASocket: TIdStackSocketHandle; const ABuffer: TIdBytes;
             const AOffset: Integer; const AIP: string; const APort: integer;
             const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION
             ): Integer; override;
    procedure SetSocketOption( const ASocket: TIdStackSocketHandle;
      const Alevel, Aoptname: Integer;
      Aoptval: PChar;
      const Aoptlen: Integer ); overload; virtual; abstract;
    function TranslateTInAddrToString(var AInAddr; const AIPVersion: TIdIPVersion): string;
    procedure TranslateStringToTInAddr(AIP: string; var AInAddr; const AIPVersion: TIdIPVersion);
    function WSGetServByName(const AServiceName: string): Integer; virtual; abstract;
    function WSGetServByPort(const APortNumber: Integer): TIdStrings; virtual; abstract;
    function RecvFrom(const ASocket: TIdStackSocketHandle; var ABuffer;
     const ALength, AFlags: Integer; var VIP: string; var VPort: Integer;
     AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer; virtual; abstract;
    procedure WSSendTo(ASocket: TIdStackSocketHandle; const ABuffer;
     const ABufferLength, AFlags: Integer; const AIP: string; const APort: integer; AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); virtual; abstract;
    function WSSocket(AFamily, AStruct, AProtocol: Integer;
     const AOverlapped: Boolean = False): TIdStackSocketHandle; virtual; abstract;
    function WSTranslateSocketErrorMsg(const AErr: integer): string; virtual;
    function WSGetLastError: Integer; virtual; abstract;
    procedure WSGetSockOpt(ASocket: TIdStackSocketHandle; Alevel, AOptname: Integer; AOptval: PChar; var AOptlen: Integer); virtual; abstract;
    procedure SetBlocking(ASocket: TIdStackSocketHandle;
     const ABlocking: Boolean); virtual; abstract;
    function WouldBlock(const AResult: Integer): Boolean; virtual; abstract;
    function CheckForSocketError(const AResult: Integer): Integer; overload;
    function CheckForSocketError(const AResult: Integer;
     const AIgnore: array of Integer): Integer; overload;
    function NewSocketHandle(const ASocketType:TIdSocketType;
      const AProtocol: TIdSocketProtocol;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION;
      const AOverlapped: Boolean = False)
     : TIdStackSocketHandle; override;
    //multicast stuff Kudzu permitted me to add here.
    procedure SetMulticastTTL(AHandle: TIdStackSocketHandle;
      const AValue : Byte); override;
    procedure SetLoopBack(AHandle: TIdStackSocketHandle; const AValue: Boolean); override;
    procedure DropMulticastMembership(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String); override;
    procedure AddMulticastMembership(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String); override;
  end;

  EIdStackError = class (EIdException);
  EIdInvalidServiceName = class(EIdException);
  EIdStackInitializationFailed = class (EIdStackError);
  EIdStackSetSizeExceeded = class (EIdStackError);
  EIdIPVersionUnsupported = class (EIdStackError);

var
  GServeFileProc: TIdServeFile = nil;
  GBSDStack: TIdStackBSDBase = nil;

const
  IdIPFamily : array[TIdIPVersion] of Integer = (Id_PF_INET4, Id_PF_INET6);

implementation

uses
  {$IFDEF LINUX}     IdStackLinux, {$ENDIF}
  {$IFDEF MSWINDOWS} IdStackWindows, {$ENDIF}
  {$IFDEF DOTNET}    IdStackDotNet, {$ENDIF}
  IdResourceStrings;

{ TIdStackBSDBase }

function TIdStackBSDBase.TranslateTInAddrToString(var AInAddr;
  const AIPVersion: TIdIPVersion): string;
var
  i: integer;
begin
  case AIPVersion of
    Id_IPv4: begin
      with TIdIn4Addr(AInAddr).S_un_b do begin
        result := Sys.IntToStr(s_b1) + '.' + Sys.IntToStr(s_b2) + '.' + Sys.IntToStr(s_b3) + '.'    {Do not Localize}
         + Sys.IntToStr(s_b4);
      end;
    end;
    Id_IPv6: begin
      Result := '';
      for i := 0 to 7 do begin
        Result := Result + Sys.IntToHex(NetworkToHost(TIdIn6Addr(AInAddr).s6_addr16[i]),1)+':';
      end;
      SetLength(Result,Length(Result)-1);
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackBSDBase.TranslateStringToTInAddr(AIP: string;
  var AInAddr; const AIPVersion: TIdIPVersion);
//var
//  i: integer;
//  LW : Word;
//  LIP : TIdIPv6Address;

begin
  case AIPVersion of
    Id_IPv4: begin
      with TIdIn4Addr(AInAddr).S_un_b do begin
        s_b1 := Sys.StrToInt(Fetch(AIP, '.'));    {Do not Localize}
        s_b2 := Sys.StrToInt(Fetch(AIP, '.'));    {Do not Localize}
        s_b3 := Sys.StrToInt(Fetch(AIP, '.'));    {Do not Localize}
        s_b4 := Sys.StrToInt(Fetch(AIP, '.'));    {Do not Localize}
      end;
    end;
    Id_IPv6: begin

   //   AIP := MakeCanonicalIPv6Address(AIP);

      TIdIPv6Address(TIdIn6Addr(AInAddr).s6_addr16) := HostToNetwork(IPv6ToIdIPv6Address(AIP) );
{      with TIdIn6Addr(AInAddr) do begin
      //We don't call HostToNetwork with an arguement such as:
      // Sys.StrToInt('$'+Fetch(AIP, ':')
      //because that can actually be a Cardinal or possibly an Int64 value
      //and it may be clear which overloaded function should be called.
        for i := 0 to 7 do begin
          LW :=  Sys.StrToInt('$'+Fetch(AIP, ':'));
          s6_addr16[i] := HostToNetwork(LW);    {Do not Localize}
{        end;
      end;          }
    end;
    else begin
      IPVersionUnsupported;
    end;
  end;
end;

procedure TIdStackBSDBase.RaiseLastSocketError;
begin
  RaiseSocketError(WSGetLastError);
end;

function TIdStackBSDBase.CheckForSocketError(const AResult: Integer): Integer;
begin
  if AResult = Id_SOCKET_ERROR then begin
    RaiseLastSocketError;
  end;
  Result := AResult;
end;

function TIdStackBSDBase.CheckForSocketError(const AResult: Integer;
  const AIgnore: array of integer): Integer;
var
  i: Integer;
  LLastError: Integer;
begin
  Result := 0;
  if AResult = Id_SOCKET_ERROR then begin
    LLastError := WSGetLastError;
    for i := Low(AIgnore) to High(AIgnore) do begin
      if LLastError = AIgnore[i] then begin
        Result := LLastError;
        Exit;
      end;
    end;
    RaiseSocketError(LLastError);
  end;
end;

function TIdStackBSDBase.NewSocketHandle(const ASocketType:TIdSocketType;
  const AProtocol: TIdSocketProtocol;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION;
  const AOverlapped: Boolean = False): TIdStackSocketHandle;
begin
  Result := CheckForSocketError(WSSocket(IdIPFamily[AIPVersion], ASocketType, AProtocol
   , AOverlapped));
end;

procedure TIdStackBSDBase.RaiseSocketError(AErr: integer);
begin
  (*
    RRRRR    EEEEEE   AAAA   DDDDD         MM     MM  EEEEEE    !!  !!  !!
    RR  RR   EE      AA  AA  DD  DD        MMMM MMMM  EE        !!  !!  !!
    RRRRR    EEEE    AAAAAA  DD   DD       MM MMM MM  EEEE      !!  !!  !!
    RR  RR   EE      AA  AA  DD  DD        MM     MM  EE
    RR   RR  EEEEEE  AA  AA  DDDDD         MM     MM  EEEEEE    ..  ..  ..

    Please read the note in the next comment.
  *)
  if AErr = Id_WSAENOTSOCK then begin
    // You can add this to your exception ignore list for easier debugging.
    // However please note that sometimes it is a true error. Your program
    // will still run correctly, but the debugger will not stop on it if you
    // list it in the ignore list. But for most times its fine to put it in
    // the ignore list, it only affects your debugging.
    raise EIdNotASocket.CreateError(AErr, WSTranslateSocketErrorMsg(AErr));
  end;
  (*
    It is normal to receive a 10038 exception (10038, NOT others!) here when
    *shutting down* (NOT at other times!) servers (NOT clients!).

    If you receive a 10038 exception here please see the FAQ at:
    http://www.IndyProject.org/

    If you insist upon requesting help via our email boxes on the 10038 error
    that is already answered in the FAQ and you are simply too slothful to
    search for your answer and ask your question in the public forums you may be
    publicly flogged, tarred and feathered and your name may be added to every
    chain letter / EMail in existence today."

    Otherwise, if you DID read the FAQ and have further questions, please feel
    free to ask using one of the methods (Carefullly note that these methods do
    not list email) listed on the Tech Support link at:
    http://www.IndyProject.org/

    RRRRR    EEEEEE   AAAA   DDDDD         MM     MM  EEEEEE    !!  !!  !!
    RR  RR   EE      AA  AA  DD  DD        MMMM MMMM  EE        !!  !!  !!
    RRRRR    EEEE    AAAAAA  DD   DD       MM MMM MM  EEEE      !!  !!  !!
    RR  RR   EE      AA  AA  DD  DD        MM     MM  EE
    RR   RR  EEEEEE  AA  AA  DDDDD         MM     MM  EEEEEE    ..  ..  ..
  *)
  raise EIdSocketError.CreateError(AErr, WSTranslateSocketErrorMsg(AErr));
end;

function TIdStackBSDBase.WSTranslateSocketErrorMsg(const AErr: integer): string;
begin
  Result := '';    {Do not Localize}
  case AErr of
    Id_WSAEINTR: Result           := RSStackEINTR;
    Id_WSAEBADF: Result           := RSStackEBADF;
    Id_WSAEACCES: Result          := RSStackEACCES;
    Id_WSAEFAULT: Result          := RSStackEFAULT;
    Id_WSAEINVAL: Result          := RSStackEINVAL;
    Id_WSAEMFILE: Result          := RSStackEMFILE;

    Id_WSAEWOULDBLOCK: Result     := RSStackEWOULDBLOCK;
    Id_WSAEINPROGRESS: Result     := RSStackEINPROGRESS;
    Id_WSAEALREADY: Result        := RSStackEALREADY;
    Id_WSAENOTSOCK: Result        := RSStackENOTSOCK;
    Id_WSAEDESTADDRREQ: Result    := RSStackEDESTADDRREQ;
    Id_WSAEMSGSIZE: Result        := RSStackEMSGSIZE;
    Id_WSAEPROTOTYPE: Result      := RSStackEPROTOTYPE;
    Id_WSAENOPROTOOPT: Result     := RSStackENOPROTOOPT;
    Id_WSAEPROTONOSUPPORT: Result := RSStackEPROTONOSUPPORT;
    Id_WSAESOCKTNOSUPPORT: Result := RSStackESOCKTNOSUPPORT;
    Id_WSAEOPNOTSUPP: Result      := RSStackEOPNOTSUPP;
    Id_WSAEPFNOSUPPORT: Result    := RSStackEPFNOSUPPORT;
    Id_WSAEAFNOSUPPORT: Result    := RSStackEAFNOSUPPORT;
    Id_WSAEADDRINUSE: Result      := RSStackEADDRINUSE;
    Id_WSAEADDRNOTAVAIL: Result   := RSStackEADDRNOTAVAIL;
    Id_WSAENETDOWN: Result        := RSStackENETDOWN;
    Id_WSAENETUNREACH: Result     := RSStackENETUNREACH;
    Id_WSAENETRESET: Result       := RSStackENETRESET;
    Id_WSAECONNABORTED: Result    := RSStackECONNABORTED;
    Id_WSAECONNRESET: Result      := RSStackECONNRESET;
    Id_WSAENOBUFS: Result         := RSStackENOBUFS;
    Id_WSAEISCONN: Result         := RSStackEISCONN;
    Id_WSAENOTCONN: Result        := RSStackENOTCONN;
    Id_WSAESHUTDOWN: Result       := RSStackESHUTDOWN;
    Id_WSAETOOMANYREFS: Result    := RSStackETOOMANYREFS;
    Id_WSAETIMEDOUT: Result       := RSStackETIMEDOUT;
    Id_WSAECONNREFUSED: Result    := RSStackECONNREFUSED;
    Id_WSAELOOP: Result           := RSStackELOOP;
    Id_WSAENAMETOOLONG: Result    := RSStackENAMETOOLONG;
    Id_WSAEHOSTDOWN: Result       := RSStackEHOSTDOWN;
    Id_WSAEHOSTUNREACH: Result    := RSStackEHOSTUNREACH;
    Id_WSAENOTEMPTY: Result       := RSStackENOTEMPTY;
  end;
  Result := Sys.Format(RSStackError, [AErr, Result]);
end;

procedure TIdStackBSDBase.IPVersionUnsupported;
begin
  raise EIdIPVersionUnsupported.Create(RSIPVersionUnsupported);
end;

constructor TIdStackBSDBase.Create;
begin
  inherited Create;
  GBSDStack := Self;
end;

destructor TIdStackBSDBase.Destroy;
begin
  Sys.FreeAndNil(FLocalAddresses);
  inherited Destroy;
end;

function TIdStackBSDBase.CheckIPVersionSupport(const AIPVersion: TIdIPVersion): boolean;
var LTmpSocket:TIdStackSocketHandle;
begin
  //TODO: Take out IFDEFs if the Linux version gives correct result under Windows...
{$IFDEF LINUX}
  LTmpSocket := WSSocket(IdIPFamily[AIPVersion], Integer(Id_SOCK_STREAM), Id_IPPROTO_IP );
{$ELSE}
  LTmpSocket := WSSocket(IdIPFamily[AIPVersion], Id_SOCK_STREAM, Id_IPPROTO_IP );
{$ENDIF}
  result:=LTmpSocket<>Id_INVALID_SOCKET;
  if LTmpSocket<>Id_INVALID_SOCKET then begin
    WSCloseSocket(LTmpSocket);
  end;
end;

function TIdStackBSDBase.Receive(ASocket: TIdStackSocketHandle;
 var VBuffer: TIdBytes): Integer;
begin
  Result := CheckForSocketError(WSRecv(ASocket, VBuffer[0], Length(VBuffer) , 0));
end;

function TIdStackBSDBase.Send(
  ASocket: TIdStackSocketHandle;
  const ABuffer: TIdBytes;
  AOffset: Integer = 0;
  ASize: Integer = -1
  ): Integer;
begin
  if ASize = -1 then begin
    ASize := Length(ABuffer) - AOffset;
  end;
  Result := WSSend(ASocket, PChar(@ABuffer[AOffset])^, ASize, 0);
end;

function TIdStackBSDBase.ReceiveFrom(ASocket: TIdStackSocketHandle;
  var VBuffer: TIdBytes; var VIP: string; var VPort: Integer;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION
  ): Integer;
begin
   Result :=  CheckForSocketError(RecvFrom(ASocket,VBuffer[0],Length(VBuffer),0,VIP,VPort,AIPVersion));
end;

function TIdStackBSDBase.SendTo(ASocket: TIdStackSocketHandle;
  const ABuffer: TIdBytes; const AOffset: Integer; const AIP: string;
  const APort: integer;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer;
begin
   // must use pointer(ABuffer)^, can't use ABuffer[0], because ABuffer may have a 0 length
   WSSendTo(ASocket,pointer(ABuffer)^,Length(ABuffer),0,AIP,APort,AIPVersion);
   Result := Length(ABuffer);
end;

procedure TIdStackBSDBase.DropMulticastMembership(AHandle: TIdStackSocketHandle;
  const AGroupIP, ALocalIP : String);
begin
  MembershipSockOpt(AHandle,AGroupIP,ALocalIP,Id_IP_DROP_MEMBERSHIP);
end;

procedure TIdStackBSDBase.AddMulticastMembership(AHandle: TIdStackSocketHandle;
  const AGroupIP, ALocalIP : String);
begin
  MembershipSockOpt(AHandle,AGroupIP,ALocalIP,Id_IP_ADD_MEMBERSHIP);
end;

procedure TIdStackBSDBase.SetMulticastTTL(AHandle: TIdStackSocketHandle;
  const AValue: Byte);
var
  LThisTTL: Integer;
begin
  LThisTTL := AValue;
  GBSDStack.SetSocketOption(AHandle,Id_IPPROTO_IP,
      Id_IP_MULTICAST_TTL, pchar(@LThisTTL), SizeOf(LThisTTL));
end;

procedure TIdStackBSDBase.SetLoopBack(AHandle: TIdStackSocketHandle; const AValue: Boolean);
var
  LThisLoopback: Integer;
begin
  if AValue then begin
    LThisLoopback := 1;
  end else begin
    LThisLoopback := 0;
  end;
  GBSDStack.SetSocketOption(AHandle,Id_IPPROTO_IP, Id_IP_MULTICAST_LOOP, PChar(@LThisLoopback)
    , SizeOf(LThisLoopback));
end;

procedure TIdStackBSDBase.MembershipSockOpt(AHandle: TIdStackSocketHandle;
  const AGroupIP, ALocalIP: String; const ASockOpt: Integer);
var
  LIP4 : TIdIPMreq;
  LIP6 : TIdIPv6Mreq;
begin
  if IsValidIPv4MulticastGroup(AGroupIP) then
  begin
    GBSDStack.TranslateStringToTInAddr(AGroupIP, LIP4.IMRMultiAddr, Id_IPv4);
    GBSDStack.TranslateStringToTInAddr(AGroupIP, LIP4.IMRInterface , Id_IPv4);
    GBSDStack.SetSocketOption(AHandle,Id_IPPROTO_IP, Id_IP_ADD_MEMBERSHIP,
      pchar(@LIP4), SizeOf(LIP4));
  end
  else
  begin
    if Self.IsValidIPv4MulticastGroup(AGroupIP) then
    begin
      GBSDStack.TranslateStringToTInAddr(AGroupIP, LIP6.ipv6mr_multiaddr, Id_IPv6);
      //this should be safe meaning any adaptor
      //we can't support a localhost address in IPv6 because we can't get that
      //and even if you could, you would have to convert it into a network adaptor
      //index - Yuk
      LIP6.ipv6mr_interface := 0;
      GBSDStack.SetSocketOption(AHandle,Id_IPPROTO_IP, ASockOpt,
        pchar(@LIP6), SizeOf(LIP6));
    end;
  end;
end;

end.
