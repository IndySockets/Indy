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
  Rev 1.7    1/17/2005 7:25:48 PM  JPMugaas
  Moved some stack management code here to so that we can reuse it in
  non-TIdComponent classes.
  Made HostToNetwork and NetworkToHost byte order overload functions for IPv6
  addresses.

  Rev 1.6    10/26/2004 8:12:30 PM  JPMugaas
  Now uses TIdStrings and TIdStringList for portability.

  Rev 1.5    6/30/2004 12:41:14 PM  BGooijen
  Added SetStackClass

  Rev 1.4    6/11/2004 8:28:50 AM  DSiders
  Added "Do not Localize" comments.

  Rev 1.3    4/18/04 2:45:38 PM  RLebeau
  Conversion support for Int64 values

  Rev 1.2    2004.03.07 11:45:22 AM  czhower
  Flushbuffer fix + other minor ones found

  Rev 1.1    3/6/2004 5:16:20 PM  JPMugaas
  Bug 67 fixes.  Do not write to const values.

  Rev 1.0    2004.02.03 3:14:42 PM  czhower
  Move and updates

  Rev 1.39    2/1/2004 6:10:50 PM  JPMugaas
  GetSockOpt.

  Rev 1.38    2/1/2004 3:28:24 AM  JPMugaas
  Changed WSGetLocalAddress to GetLocalAddress and moved into IdStack since
  that will work the same in the DotNET as elsewhere.  This is required to
  reenable IPWatch.

  Rev 1.37    2/1/2004 1:54:56 AM  JPMugaas
  Missapplied fix.  IP 0.0.0.0 should now be accepted.

  Rev 1.36    1/31/2004 4:39:12 PM  JPMugaas
  Removed empty methods.

  Rev 1.35    1/31/2004 1:13:04 PM  JPMugaas
  Minor stack changes required as DotNET does support getting all IP addresses
  just like the other stacks.

  Rev 1.34    2004.01.22 5:59:10 PM  czhower
  IdCriticalSection

  Rev 1.33    1/18/2004 11:15:52 AM  JPMugaas
  IsIP was not handling "0" in an IP address.  This caused the address
  "127.0.0.1" to be treated as a hostname.

  Rev 1.32    12/4/2003 3:14:50 PM  BGooijen
  Added HostByAddress

  Rev 1.31    1/3/2004 12:21:44 AM  BGooijen
  Added function SupportsIPv6

  Rev 1.30    12/31/2003 9:54:16 PM  BGooijen
  Added IPv6 support

  Rev 1.29    2003.12.31 3:47:42 PM  czhower
  Changed to use TextIsSame

  Rev 1.28    10/21/2003 9:24:32 PM  BGooijen
  Started on SendTo, ReceiveFrom

  Rev 1.27    10/19/2003 5:21:28 PM  BGooijen
  SetSocketOption

  Rev 1.26    10/15/2003 7:21:02 PM  DSiders
  Added resource strings in TIdStack.Make.

  Rev 1.25    2003.10.11 5:51:02 PM  czhower
  -VCL fixes for servers
  -Chain suport for servers (Super core)
  -Scheduler upgrades
  -Full yarn support

  Rev 1.24    10/5/2003 9:55:30 PM  BGooijen
  TIdTCPServer works on D7 and DotNet now

  Rev 1.23    04/10/2003 22:31:56  HHariri
  moving of WSNXXX method to IdStack and renaming of the DotNet ones

  Rev 1.22    10/2/2003 7:31:18 PM  BGooijen
  .net

  Rev 1.21    10/2/2003 6:05:16 PM  GGrieve
  DontNet

  Rev 1.20    2003.10.02 10:16:30 AM  czhower
  .Net

  Rev 1.19    2003.10.01 9:11:20 PM  czhower
  .Net

  Rev 1.18    2003.10.01 5:05:16 PM  czhower
  .Net

  Rev 1.17    2003.10.01 2:30:40 PM  czhower
  .Net

  Rev 1.16    2003.10.01 12:30:08 PM  czhower
  .Net

  Rev 1.14    2003.10.01 1:37:36 AM  czhower
  .Net

  Rev 1.12    9/30/2003 7:15:46 PM  BGooijen
  IdCompilerDefines.inc is included now

  Rev 1.11    2003.09.30 1:23:04 PM  czhower
  Stack split for DotNet
}

unit IdStack;

interface

{$I IdCompilerDefines.inc}

uses
  Classes,
  IdException, IdStackConsts, IdGlobal, SysUtils;

type
  EIdSocketError = class(EIdException)
  protected
    FLastError: Integer;
  public
    // Params must be in this order to avoid conflict with CreateHelp
    // constructor in CBuilder
    constructor CreateError(const AErr: Integer; const AMsg: string); virtual;
    //
    property LastError: Integer read FLastError;
  end;

  { resolving hostnames }
  EIdStackError = class (EIdException);
  EIdIPVersionUnsupported = class (EIdStackError);
  EIdResolveError = class(EIdSocketError);
  EIdReverseResolveError = class(EIdSocketError);
  EIdNotASocket = class(EIdSocketError);

  TIdPacketInfo = class
  protected
    FSourceIP: String;
    FSourcePort : Integer;
    FDestIP: String;
    FDestPort : Integer;
    FSourceIF: LongWord;
    FDestIF: LongWord;
    FTTL: Byte;
  public
    property TTL : Byte read FTTL write FTTL;
    //The computer that sent it to you
    property SourceIP : String read FSourceIP write FSourceIP;
    property SourcePort : Integer read FSourcePort write FSourcePort;
    property SourceIF : LongWord read FSourceIF write FSourceIF;
    //you, the receiver - this is provided for multihorned machines
    property DestIP : String read FDestIP write FDestIP;
    property DestPort : Integer read FDestPort write FDestPort;
    property DestIF : LongWord read FDestIF write FDestIF;
  end;
  TIdSocketListClass = class of TIdSocketList;

  // Descend from only TObject. This objects is created a lot and should be fast
  // and small
  TIdSocketList = class(TObject)
  protected
    FLock: TIdCriticalSection;
    //
    function GetItem(AIndex: Integer): TIdStackSocketHandle; virtual; abstract;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    procedure Add(AHandle: TIdStackSocketHandle); virtual; abstract;
    function Clone: TIdSocketList; virtual; abstract;
    function Count: Integer; virtual; abstract;
    class function CreateSocketList: TIdSocketList;
    property Items[AIndex: Integer]: TIdStackSocketHandle read GetItem; default;
    procedure Remove(AHandle: TIdStackSocketHandle); virtual; abstract;
    procedure Clear; virtual; abstract;
    function Contains(AHandle: TIdStackSocketHandle): boolean; virtual; abstract;
    procedure Lock;
    class function Select(AReadList: TIdSocketList; AWriteList: TIdSocketList;
     AExceptList: TIdSocketList; const ATimeout: Integer = IdTimeoutInfinite): Boolean; virtual;
    function SelectRead(const ATimeout: Integer = IdTimeoutInfinite): Boolean; virtual; abstract;
    function  SelectReadList(var VSocketList: TIdSocketList; const ATimeout: Integer = IdTimeoutInfinite): Boolean; virtual; abstract;
    procedure Unlock;
  end;

  TIdStack = class(TObject)
  protected
    FLocalAddresses: TStrings;
    //
    procedure IPVersionUnsupported;
    function HostByName(const AHostName: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; virtual; abstract;

    function MakeCanonicalIPv6Address(const AAddr: string): string;
    function ReadHostName: string; virtual; abstract;
    procedure PopulateLocalAddresses; virtual; abstract;
    function GetLocalAddress: string;
    function GetLocalAddresses: TStrings;
  public
    function Accept(ASocket: TIdStackSocketHandle; var VIP: string; var VPort: TIdPort): TIdStackSocketHandle; overload;
    function Accept(ASocket: TIdStackSocketHandle; var VIP: string; var VPort: TIdPort;
      var VIPVersion: TIdIPVersion): TIdStackSocketHandle; overload; virtual; abstract;
    procedure Bind(ASocket: TIdStackSocketHandle; const AIP: string;
              const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION ); virtual; abstract;
    procedure Connect(const ASocket: TIdStackSocketHandle; const AIP: string;
              const APort: TIdPort; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); virtual; abstract;
    constructor Create; virtual;
    procedure Disconnect(ASocket: TIdStackSocketHandle); virtual; abstract;
    function IOControl(const s: TIdStackSocketHandle; const cmd: LongWord; var arg: LongWord): Integer; virtual; abstract;
    class procedure Make;
    class procedure IncUsage; //create stack if necessary and inc counter
    class procedure DecUsage; //decrement counter and free if it gets to zero
    procedure GetPeerName(ASocket: TIdStackSocketHandle; var VIP: string; var VPort: TIdPort); overload;
    procedure GetPeerName(ASocket: TIdStackSocketHandle; var VIP: string; var VPort: TIdPort;
      var VIPVersion: TIdIPVersion); overload; virtual; abstract;
    procedure GetSocketName(ASocket: TIdStackSocketHandle; var VIP: string; var VPort: TIdPort); overload;
    procedure GetSocketName(ASocket: TIdStackSocketHandle; var VIP: string; var VPort: TIdPort;
      var VIPVersion: TIdIPVersion); overload; virtual; abstract;
    function HostByAddress(const AAddress: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string; virtual; abstract;
    function HostToNetwork(AValue: Word): Word; overload; virtual; abstract;
    function HostToNetwork(AValue: LongWord): LongWord; overload; virtual; abstract;
    function HostToNetwork(AValue: Int64): Int64; overload; virtual; abstract;
    function HostToNetwork(AValue: TIdIPv6Address): TIdIPv6Address; overload; virtual;
    function IsIP(AIP: string): Boolean;
    procedure Listen(ASocket: TIdStackSocketHandle; ABackLog: Integer); virtual; abstract;
    function WSGetLastError: Integer; virtual; abstract;
    function WSTranslateSocketErrorMsg(const AErr: integer): string; virtual;
    function CheckForSocketError(const AResult: Integer): Integer; overload;
    function CheckForSocketError(const AResult: Integer; const AIgnore: array of Integer): Integer; overload;
    procedure RaiseLastSocketError;
    procedure RaiseSocketError(AErr: integer); virtual;
    function NewSocketHandle(const ASocketType:TIdSocketType; const AProtocol: TIdSocketProtocol;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION; const AOverlapped: Boolean = False)
      : TIdStackSocketHandle; virtual; abstract;
    function NetworkToHost(AValue: Word): Word; overload; virtual; abstract;
    function NetworkToHost(AValue: LongWord): LongWord; overload; virtual; abstract;
    function NetworkToHost(AValue: Int64): Int64; overload; virtual; abstract;
    function NetworkToHost(AValue: TIdIPv6Address): TIdIPv6Address; overload; virtual;
    procedure GetSocketOption(ASocket: TIdStackSocketHandle;
      ALevel: TIdSocketOptionLevel; AOptName: TIdSocketOption;
      out AOptVal: Integer); virtual; abstract;
    procedure SetSocketOption(ASocket: TIdStackSocketHandle; ALevel: TIdSocketOptionLevel;
      AOptName: TIdSocketOption; AOptVal: Integer); overload; virtual; abstract;
    function ResolveHost(const AHost: string;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;

    // Result:
    // > 0: Number of bytes received
    //   0: Connection closed gracefully
    // Will raise exceptions in other cases
    function Receive(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes): Integer; virtual; abstract;
    function Send(ASocket: TIdStackSocketHandle; const ABuffer: TIdBytes;
      const AOffset: Integer = 0; const ASize: Integer = -1): Integer; virtual; abstract;

    function ReceiveFrom(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes;
             var VIP: string; var VPort: TIdPort;
             const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer; virtual; abstract;
    function SendTo(ASocket: TIdStackSocketHandle; const ABuffer: TIdBytes;
             const AOffset: Integer; const AIP: string; const APort: TIdPort;
             const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): Integer; virtual; abstract;
    function ReceiveMsg(ASocket: TIdStackSocketHandle; var VBuffer: TIdBytes; APkt: TIdPacketInfo;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): LongWord; virtual; abstract;
    function SupportsIPv6: Boolean; virtual; abstract;

    //multicast stuff Kudzu permitted me to add here.
    function IsValidIPv4MulticastGroup(const Value: string): Boolean;
    function IsValidIPv6MulticastGroup(const Value: string): Boolean;
    procedure SetMulticastTTL(AHandle: TIdStackSocketHandle;
      const AValue : Byte; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); virtual; abstract;
    procedure SetLoopBack(AHandle: TIdStackSocketHandle; const AValue: Boolean;
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); virtual; abstract;
    procedure DropMulticastMembership(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); virtual; abstract;
    procedure AddMulticastMembership(AHandle: TIdStackSocketHandle;
      const AGroupIP, ALocalIP : String; const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); virtual; abstract;
    //I know this looks like an odd place to put a function for calculating a
    //packet checksum.  There is a reason for it though.  The reason is that
    //you need it for ICMPv6 and in Windows, you do that with some other stuff
    //in the stack descendants
    function CalcCheckSum(const AData : TIdBytes): word; virtual;
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
      const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION); virtual; abstract;
    //
    // Properties
    //
    property HostName: string read ReadHostName;
    property LocalAddress: string read GetLocalAddress;
    property LocalAddresses: TStrings read GetLocalAddresses;
  end;

  TIdStackClass = class of TIdStack;

var
  GStack: TIdStack = nil;
  GSocketListClass: TIdSocketListClass;

// Procedures
  function IdStackFactory : TIdStack;
  procedure SetStackClass( AStackClass: TIdStackClass );

implementation

uses
  //done this way so we can have a separate stack for FPC under Unix systems
  {$IFDEF UNIX}
    {$IFDEF USELIBC}
  IdStackLinux,
    {$ELSE}
  IdStackUnix,
    {$ENDIF}
  {$ENDIF}
  {$IFDEF WIN32_OR_WIN64_OR_WINCE}
    {$IFDEF USEINLINE}
    Windows,
    {$ENDIF}
  IdStackWindows,
  {$ENDIF}
  {$IFDEF DOTNET}
  IdStackDotNet,
  {$ENDIF}
  IdResourceStrings;

var
  GStackClass: TIdStackClass = nil;

var
  GInstanceCount: Integer = 0;
  GStackCriticalSection: TIdCriticalSection;

//for IPv4 Multicast address chacking
const
  IPv4MCastLo = 224;
  IPv4MCastHi = 239;

procedure SetStackClass( AStackClass: TIdStackClass );
begin
  GStackClass := AStackClass;
end;

function IdStackFactory: TIdStack;
begin
  Result := GStackClass.Create;
end;

{ TIdSocketList }

constructor TIdSocketList.Create;
begin
  inherited Create;
  FLock := TIdCriticalSection.Create;
end;

class function TIdSocketList.CreateSocketList: TIdSocketList;
Begin
  Result := GSocketListClass.Create;
End;

destructor TIdSocketList.Destroy;
begin
  FreeAndNil(FLock);
  inherited Destroy;
end;

procedure TIdSocketList.Lock;
begin
  FLock.Acquire;
end;

class function TIdSocketList.Select(AReadList, AWriteList,
  AExceptList: TIdSocketList; const ATimeout: Integer): Boolean;
begin
  // C++ Builder cannot have abstract class functions thus we need this base
  Result := False;
end;

procedure TIdSocketList.Unlock;
begin
  FLock.Release;
end;

{ TIdStack }

constructor TIdStack.Create;
begin
  // Here for .net
  inherited Create;
end;

procedure TIdStack.IPVersionUnsupported;
begin
  raise EIdIPVersionUnsupported.Create(RSIPVersionUnsupported);
end;

function TIdStack.Accept(ASocket: TIdStackSocketHandle; var VIP: string;
  var VPort: TIdPort): TIdStackSocketHandle;
var
  LIPVersion: TIdIPVersion;
begin
  Result := Accept(ASocket, VIP, VPort, LIPVersion);
end;

procedure TIdStack.GetPeerName(ASocket: TIdStackSocketHandle; var VIP: string;
  var VPort: TIdPort);
var
  LIPVersion: TIdIPVersion;
begin
  GetPeerName(ASocket, VIP, VPort, LIPVersion);
end;

procedure TIdStack.GetSocketName(ASocket: TIdStackSocketHandle; var VIP: string;
  var VPort: TIdPort);
var
  LIPVersion: TIdIPVersion;
begin
  GetSocketName(ASocket, VIP, VPort, LIPVersion);
end;

function TIdStack.GetLocalAddresses: TStrings;
begin
  if FLocalAddresses = nil then begin
    FLocalAddresses := TStringList.Create;
  end;
  FLocalAddresses.Clear;
  PopulateLocalAddresses;
  Result := FLocalAddresses;
end;

function TIdStack.GetLocalAddress: string;
begin
  Result := LocalAddresses[0];
end;

function TIdStack.IsIP(AIP: string): Boolean;
var
  i: Integer;
begin
//
//Result := Result and ((i > 0) and (i < 256));
//
  i := IndyStrToInt(Fetch(AIP, '.'), -1);    {Do not Localize}
  Result := (i > -1) and (i < 256);
  i := IndyStrToInt(Fetch(AIP, '.'), -1);    {Do not Localize}
  Result := Result and ((i > -1) and (i < 256));
  i := IndyStrToInt(Fetch(AIP, '.'), -1);    {Do not Localize}
  Result := Result and ((i > -1) and (i < 256));
  i := IndyStrToInt(Fetch(AIP, '.'), -1);    {Do not Localize}
  Result := Result and ((i > -1) and (i < 256)) and (AIP = '');
end;

function TIdStack.MakeCanonicalIPv6Address(const AAddr: string): string;
begin
  Result := IdGlobal.MakeCanonicalIPv6Address(AAddr);
end;

class procedure TIdStack.Make;
begin
  EIdException.IfTrue(GStackClass = nil, RSStackClassUndefined);
  EIdException.IfTrue(GStack <> nil, RSStackAlreadyCreated);
  GStack := IdStackFactory;
end;

function TIdStack.ResolveHost(const AHost: string;
  const AIPVersion: TIdIPVersion = ID_DEFAULT_IP_VERSION): string;
begin
  Result := '';
  if AIPVersion = Id_IPv4 then begin
    // Sometimes 95 forgets who localhost is
    if TextIsSame(AHost, 'LOCALHOST') then begin    {Do not Localize}
      Result := '127.0.0.1';    {Do not Localize}
    end else if IsIP(AHost) then begin
      Result := AHost;
    end else begin
      Result := HostByName(AHost, Id_IPv4);
    end;
  end else if AIPVersion = Id_IPv6 then begin
    Result := MakeCanonicalIPv6Address(AHost);
    if Result = '' then begin
      Result := HostByName(AHost, Id_IPv6);
    end;
  end //else IPVersionUnsupported; // IPVersionUnsupported is introduced in
                                   // a decendant class, so we can't use it here,
                                   // TODO: move it to this class
end;

constructor EIdSocketError.CreateError(const AErr: Integer; const AMsg: string);
begin
  inherited Create(AMsg);
  FLastError := AErr;
end;

class procedure TIdStack.DecUsage;
begin
  Assert(GStackCriticalSection<>nil);

  GStackCriticalSection.Acquire; try
    Dec(GInstanceCount);
    if GInstanceCount = 0 then begin
      // This CS will guarantee that during the FreeAndNil nobody will try to use
      // or construct GStack
      FreeAndNil(GStack);
    end;
  finally GStackCriticalSection.Release; end;
end;

class procedure TIdStack.IncUsage;
begin
  Assert(GStackCriticalSection<>nil);

  GStackCriticalSection.Acquire; try
    Inc(GInstanceCount);
    if GInstanceCount = 1 then begin
      TIdStack.Make;
    end;
  finally GStackCriticalSection.Release; end;
end;

function TIdStack.CheckForSocketError(const AResult: Integer): Integer;
begin
  if AResult = Id_SOCKET_ERROR then begin
    RaiseLastSocketError;
  end;
  Result := AResult;
end;

function TIdStack.CheckForSocketError(const AResult: Integer;
  const AIgnore: array of integer): Integer;
var
  i: Integer;
  LLastError: Integer;
begin
  Result := AResult;
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

procedure TIdStack.RaiseLastSocketError;
begin
  RaiseSocketError(WSGetLastError);
end;

procedure TIdStack.RaiseSocketError(AErr: integer);
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

function TIdStack.WSTranslateSocketErrorMsg(const AErr: integer): string;
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
  Result := IndyFormat(RSStackError, [AErr, Result]);
end;

function TIdStack.HostToNetwork(AValue: TIdIPv6Address): TIdIPv6Address;
var i : Integer;
begin
  for i := 0 to 7 do begin
    Result[i] := HostToNetwork(AValue[i]);
  end;
end;

function TIdStack.NetworkToHost(AValue: TIdIPv6Address): TIdIPv6Address;
var i : Integer;
begin
  for i := 0 to 7 do begin
    Result[i] := NetworkToHost(AValue[i]);
  end;
end;

function TIdStack.IsValidIPv4MulticastGroup(const Value: string): Boolean;
var
  ThisIP: string;
  s1: string;
  ip1: integer;
begin
  Result := False;

  if not GStack.IsIP(Value) then begin
    Exit;
  end;

  ThisIP := Value;
  s1 := Fetch(ThisIP, '.');    {Do not Localize}
  ip1 := IndyStrToInt(s1);

  if (ip1 < IPv4MCastLo) or (ip1 > IPv4MCastHi) then begin
    Exit;
  end;

  Result := True;
end;

function TIdStack.IsValidIPv6MulticastGroup(const Value: string): Boolean;
var
  LTmp : String;
begin
  Result := False;
  LTmp := MakeCanonicalIPv6Address(Value);
  if LTmp = '' then
  begin
    //not valid IP
    Exit;
  end;
{ From "rfc 2373"

2.7 Multicast Addresses

   An IPv6 multicast address is an identifier for a group of nodes.  A
   node may belong to any number of multicast groups.  Multicast
   addresses have the following format:

#
   |   8    |  4 |  4 |                  112 bits                   |
   +------ -+----+----+---------------------------------------------+
   |11111111|flgs|scop|                  group ID                   |
   +--------+----+----+---------------------------------------------+

      11111111 at the start of the address identifies the address as
      being a multicast address.

                                    +-+-+-+-+
      flgs is a set of 4 flags:     |0|0|0|T|
                                    +-+-+-+-+

         The high-order 3 flags are reserved, and must be initialized to
         0.

         T = 0 indicates a permanently-assigned ("well-known") multicast
         address, assigned by the global internet numbering authority.

         T = 1 indicates a non-permanently-assigned ("transient")
         multicast address.

      scop is a 4-bit multicast scope value used to limit the scope of
      the multicast group.  The values are:

         0  reserved
         1  node-local scope
         2  link-local scope
         3  (unassigned)
         4  (unassigned)
         5  site-local scope
         6  (unassigned)
         7  (unassigned)
         8  organization-local scope
         9  (unassigned)
         A  (unassigned)
         B  (unassigned)
         C  (unassigned)

         D  (unassigned)
         E  global scope
         F  reserved

      group ID identifies the multicast group, either permanent or
      transient, within the given scope.

   The "meaning" of a permanently-assigned multicast address is
   independent of the scope value.  For example, if the "NTP servers
   group" is assigned a permanent multicast address with a group ID of
   101 (hex), then:

      FF01:0:0:0:0:0:0:101 means all NTP servers on the same node as the
      sender.

      FF02:0:0:0:0:0:0:101 means all NTP servers on the same link as the
      sender.

      FF05:0:0:0:0:0:0:101 means all NTP servers at the same site as the
      sender.

      FF0E:0:0:0:0:0:0:101 means all NTP servers in the internet.

   Non-permanently-assigned multicast addresses are meaningful only
   within a given scope.  For example, a group identified by the non-
   permanent, site-local multicast address FF15:0:0:0:0:0:0:101 at one
   site bears no relationship to a group using the same address at a
   different site, nor to a non-permanent group using the same group ID
   with different scope, nor to a permanent group with the same group
   ID.

   Multicast addresses must not be used as source addresses in IPv6
   packets or appear in any routing header.
}
   Result := TextStartsWith(LTmp, 'FF');
end;

function TIdStack.CalcCheckSum(const AData: TIdBytes): word;
var
  i : Integer;
  LSize : Integer;
  LCRC : LongWord;
begin
  LCRC := 0;
  i := 0;
  LSize := Length(AData);
  while LSize >1 do
  begin
    LCRC := LCRC + IdGlobal.BytesToWord(AData,i);
    Dec(LSize,2);
    inc(i,2);
  end;
  if LSize>0 then
  begin
    LCRC := LCRC + AData[i];
  end;
  LCRC := (LCRC shr 16) + (LCRC and $ffff);  //(LCRC >> 16)
  LCRC := LCRC + (LCRC shr 16);

  Result := not Word(LCRC);
end;

initialization
  //done this way so we can have a separate stack just for FPC under Unix systems
  GStackClass :=
    {$IFDEF UNIX}
      {$IFDEF USELIBC}
      TIdStackLinux;
      {$ENDIF}
      {$IFDEF USEBASEUNIX}
      TIdStackUnix;
      {$ENDIF}
    {$ENDIF}
    {$IFDEF WIN32_OR_WIN64_OR_WINCE}
    TIdStackWindows;
    {$ENDIF}
    {$IFDEF DOTNET}
    TIdStackDotNet;
    {$ENDIF}
  GStackCriticalSection := TIdCriticalSection.Create;
  {$IFNDEF IDFREEONFINAL}
    {$IFDEF REGISTER_EXPECTED_MEMORY_LEAK}
  SysRegisterExpectedMemoryLeak(GStackCriticalSection);
    {$ENDIF}
  {$ENDIF}
finalization
  // Dont Free. If shutdown is from another Init section, it can cause GPF when stack
  // tries to access it. App will kill it off anyways, so just let it leak
  {$IFDEF IDFREEONFINAL}
  FreeAndNil(GStackCriticalSection);
  {$ENDIF}
end.
