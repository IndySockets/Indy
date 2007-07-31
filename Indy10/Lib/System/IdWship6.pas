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
  Rev 1.0    2004.02.03 3:14:52 PM  czhower
  Move and updates

  Rev 1.2    10/15/2003 9:43:20 PM  DSiders
  Added localization comments.

  Rev 1.1    1-10-2003 19:44:28  BGooijen
  fixed leak in CloseLibrary()

  Rev 1.0    11/13/2002 09:03:24 AM  JPMugaas
}

unit IdWship6;

interface

{$I IdCompilerDefines.inc}

uses
  Windows,
  IdWinSock2;

const
  Wship6_dll =   'Wship6.dll';    {do not localize}
  iphlpapi_dll = 'iphlpapi.dll';  {do not localize}

//
// Error codes from getaddrinfo().
//
const
  {$EXTERNALSYM EAI_ADDRFAMILY}
  EAI_ADDRFAMILY = 1  ; // Address family for nodename not supported.
  {$EXTERNALSYM EAI_AGAIN}
  EAI_AGAIN      = 2  ; // Temporary failure in name resolution.
  {$EXTERNALSYM EAI_BADFLAGS}
  EAI_BADFLAGS   = 3  ; // Invalid value for ai_flags.
  {$EXTERNALSYM EAI_FAIL}
  EAI_FAIL       = 4  ; // Non-recoverable failure in name resolution.
  {$EXTERNALSYM EAI_FAMILY}
  EAI_FAMILY     = 5  ; // Address family ai_family not supported.
  {$EXTERNALSYM EAI_MEMORY}
  EAI_MEMORY     = 6  ; // Memory allocation failure.
  {$EXTERNALSYM EAI_NODATA}
  EAI_NODATA     = 7  ; // No address associated with nodename.
  {$EXTERNALSYM EAI_NONAME}
  EAI_NONAME     = 8  ; // Nodename nor servname provided, or not known.
  {$EXTERNALSYM EAI_SERVICE}
  EAI_SERVICE    = 9  ; // Servname not supported for ai_socktype.
  {$EXTERNALSYM EAI_SOCKTYPE}
  EAI_SOCKTYPE   = 10 ; // Socket type ai_socktype not supported.
  {$EXTERNALSYM EAI_SYSTEM}
  EAI_SYSTEM     = 11 ; // System error returned in errno.

const
  {$EXTERNALSYM NI_MAXHOST}
  NI_MAXHOST  = 1025;      // Max size of a fully-qualified domain name.
  {$EXTERNALSYM NI_MAXSERV}
  NI_MAXSERV  =   32;      // Max size of a service name.

//
// Flags for getnameinfo().
//
const
  {$EXTERNALSYM NI_NOFQDN}
  NI_NOFQDN       =   $1  ;  // Only return nodename portion for local hosts.
  {$EXTERNALSYM NI_NUMERICHOST}
  NI_NUMERICHOST  =   $2  ;  // Return numeric form of the host's address.
  {$EXTERNALSYM NI_NAMEREQD}
  NI_NAMEREQD     =   $4  ;  // Error if the host's name not in DNS.
  {$EXTERNALSYM NI_NUMERICSERV}
  NI_NUMERICSERV  =   $8  ;  // Return numeric form of the service (port #).
  {$EXTERNALSYM NI_DGRAM}
  NI_DGRAM        =   $10 ;  // Service is a datagram service.

//
// Flag values for getipnodebyname().
//
const
  {$EXTERNALSYM AI_V4MAPPED}
  AI_V4MAPPED    = 1 ;
  {$EXTERNALSYM AI_ALL}
  AI_ALL         = 2 ;
  {$EXTERNALSYM AI_ADDRCONFIG}
  AI_ADDRCONFIG  = 4 ;
  {$EXTERNALSYM AI_DEFAULT}
  AI_DEFAULT     = AI_V4MAPPED or AI_ADDRCONFIG ;

const
  {$EXTERNALSYM PROTECTION_LEVEL_RESTRICTED}
  PROTECTION_LEVEL_RESTRICTED   = 10;  //* for Intranet apps      /*
  {$EXTERNALSYM PROTECTION_LEVEL_DEFAULT}
  PROTECTION_LEVEL_DEFAULT      = 20;  //* default level          /*
  {$EXTERNALSYM PROTECTION_LEVEL_UNRESTRICTED}
  PROTECTION_LEVEL_UNRESTRICTED = 30;  //* for peer-to-peer apps  /*

  {$EXTERNALSYM SOCKET_SETTINGS_GUARANTEE_ENCRYPTION}
  SOCKET_SETTINGS_GUARANTEE_ENCRYPTION = $00000001;
    {$EXTERNALSYM SOCKET_SETTINGS_ALLOW_INSECURE}
  SOCKET_SETTINGS_ALLOW_INSECURE = $00000002;
  
type
  {$NODEFINE PPaddrinfo}
  PPaddrinfo = ^PAddrInfo;
///* Argument structure for IPV6_JOIN_GROUP and IPV6_LEAVE_GROUP */
  {$EXTERNALSYM IPV6_MREQ}
  IPV6_MREQ = packed record
    ipv6mr_multiaddr: IN6_ADDR; // IPv6 multicast address
    ipv6mr_interface: u_int;     // Interface index
  end;
  TIPv6_MReq = IPV6_MREQ;
  PIPv6_MReq = ^TIPv6_MReq;

  {$EXTERNALSYM SOCKET_SECURITY_PROTOCOL}
  {$EXTERNALSYM SOCKET_SECURITY_PROTOCOL_DEFAULT}
  {$EXTERNALSYM SOCKET_SECURITY_PROTOCOL_IPSEC}
  {$EXTERNALSYM SOCKET_SECURITY_PROTOCOL_INVALID}
  SOCKET_SECURITY_PROTOCOL = (SOCKET_SECURITY_PROTOCOL_DEFAULT,
  SOCKET_SECURITY_PROTOCOL_IPSEC,
  SOCKET_SECURITY_PROTOCOL_INVALID);
  SOCKET_PEER_TARGET_NAME = packed record
    SecurityProtocol : SOCKET_SECURITY_PROTOCOL;
    PeerAddress : SOCKADDR_STORAGE;
    PeerTargetNameStringLen : ULONG;
    AllStrings : Word;//wchar_t;
  end;
  {$EXTERNALSYM PSOCKET_PEER_TARGET_NAME}
  PSOCKET_PEER_TARGET_NAME = ^SOCKET_PEER_TARGET_NAME;

//callback defs
type
  {$EXTERNALSYM LPLOOKUPSERVICE_COMPLETION_ROUTINE}
  LPLOOKUPSERVICE_COMPLETION_ROUTINE = procedure (const dwError, dwBytes : DWORD; lpOverlapped : LPWSAOVERLAPPED); stdcall;

type
  {$EXTERNALSYM LPFN_GETADDRINFO}
  LPFN_GETADDRINFO = function(NodeName: PChar; ServiceName: PChar; Hints: Paddrinfo; ppResult: PPaddrinfo): Integer; stdcall;
  {$EXTERNALSYM LPFN_GETADDRINFOW}
  LPFN_GETADDRINFOW = function(NodeName: PWideChar; ServiceName: PWideChar; Hints: Paddrinfo; ppResult: PPaddrinfo): Integer; stdcall;
  {$EXTERNALSYM LPFN_GETNAMEINFO}
  LPFN_GETNAMEINFO = function(sa: psockaddr; salen: u_int; host: PChar; hostlen: u_int; serv: PChar; servlen: u_int; flags: Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_GETNAMEINFOW}
  LPFN_GETNAMEINFOW = function(sa: psockaddr; salen: u_int; host: PWideChar; hostlen: u_int; serv: PWideChar; servlen: u_int; flags: Integer): Integer; stdcall;

  {$EXTERNALSYM LPFN_FREEADDRINFO}
  LPFN_FREEADDRINFO = procedure(ai: Paddrinfo); stdcall;

//function GetAdaptersAddresses( Family:cardinal; Flags:cardinal; Reserved:pointer; pAdapterAddresses: PIP_ADAPTER_ADDRESSES; pOutBufLen:pcardinal):cardinal;stdcall;  external iphlpapi_dll;

{ the following are not used, nor tested}
{function getipnodebyaddr(const src:pointer;  len:integer; af:integer;var error_num:integer) :phostent;stdcall; external Wship6_dll;
procedure freehostent(ptr:phostent);stdcall; external Wship6_dll;
function inet_pton(af:integer; const src:pchar; dst:pointer):integer;stdcall; external Wship6_dll;
function inet_ntop(af:integer; const src:pointer; dst:pchar;size:integer):pchar;stdcall; external Wship6_dll;
}
  {$EXTERNALSYM LPFN_inet_pton}
  LPFN_inet_pton = function (af:integer; const src:pchar; dst:pointer):integer;stdcall;
  {$EXTERNALSYM LPFN_inet_ptonW}
  LPFN_inet_ptonW = function (af:integer; const src:pWideChar; dst:pointer):integer;stdcall;
  {$EXTERNALSYM LPFN_inet_ntop}
  LPFN_inet_ntop = function (af:integer; const src:pointer; dst:pchar;size:integer):pchar;stdcall;
  {$EXTERNALSYM LPFN_inet_ntopW}
  LPFN_inet_ntopW = function (af:integer; const src:pointer; dst:PWideChar;size:integer):pchar;stdcall;

{ end the following are not used, nor tested}
//These are provided in case we need them later
//Windows Vista
 {$EXTERNALSYM LPFN_GETADDRINFOEXA}
  LPFN_GETADDRINFOEXA = function(pName : PChar; pServiceName : PChar;
    const dwNameSpace: DWord; lpNspId : LPGUID;hints : PADDRINFOEXA;
    ppResult : PADDRINFOEXA; timeout : Ptimeval; lpOverlapped : LPWSAOVERLAPPED;
    lpCompletionRoutine : LPLOOKUPSERVICE_COMPLETION_ROUTINE;
    var lpNameHandle : THandle) : Integer; stdcall;
 {$EXTERNALSYM LPFN_GETADDRINFOEXW}
  LPFN_GETADDRINFOEXW = function(pName : PWideChar; pServiceName : PWideChar;
    const dwNameSpace: DWord; lpNspId : LPGUID;hints : PADDRINFOEXW;
    ppResult : PADDRINFOEXW; timeout : Ptimeval; lpOverlapped : LPWSAOVERLAPPED;
    lpCompletionRoutine : LPLOOKUPSERVICE_COMPLETION_ROUTINE;
    var lpNameHandle : THandle) : Integer; stdcall;
  {$EXTERNALSYM LPFN_SETADDRINFOEXA}
  LPFN_SETADDRINFOEXA= function(pName : PChar; pServiceName : PChar;
    pAddresses : PSOCKET_ADDRESS; const dwAddressCount : DWord; lpBlob : LPBLOB;
    const dwFlags : DWord; const dwNameSpace : DWord; lpNspId : LPGUID;
    timeout : Ptimeval;
    lpOverlapped : LPWSAOVERLAPPED;
    lpCompletionRoutine : LPLOOKUPSERVICE_COMPLETION_ROUTINE; var lpNameHandle : THandle) : Integer; stdcall;
  {$EXTERNALSYM LPFN_FREEADDRINFOEX}
  LPFN_FREEADDRINFOEX = procedure(pAddrInfoEx : PADDRINFOEXA) ; stdcall;
  {$EXTERNALSYM LPFN_FREEADDRINFOEXW}
  LPFN_FREEADDRINFOEXW = procedure(pAddrInfoEx : PADDRINFOEXW) ; stdcall;

  {$IFDEF UNICODE}
    LPFN_GetAddrInfoEx = LPFN_GetAddrInfoExW;
   LPFN_SetAddrInfoEx = LPFN_SetAddrInfoExW;
  {$ELSE}
   LPFN_GetAddrInfoEx = LPFN_GetAddrInfoExA;
   LPFN_SetAddrInfoEx = LPFN_SetAddrInfoExA;
  {$ENDIF}

const
  {$IFDEF UNICODE}
  fn_GetAddrInfoEx = 'GetAddrInfoExW';
  fn_SetAddrInfoEx = 'SetAddrInfoExW';
  fn_FreeAddrInfoEx = 'FreeAddrInfoExW';
  fn_GetAddrInfo = 'GetAddrInfoW';
  fn_getnameinfo = 'GetNameInfoW';
  fn_freeaddrinfo = 'FreeAddrInfoW';
  fn_inet_pton = 'InetPtonW';
  fn_inet_ntop = 'InetNtopW';
  {$ELSE}
  fn_GetAddrInfoEx = 'GetAddrInfoExA';
  fn_SetAddrInfoEx = 'SetAddrInfoExA';
  fn_FreeAddrInfoEx = 'FreeAddrInfoEx';
  fn_GetAddrInfo = 'getaddrinfo';
  fn_getnameinfo = 'getnameinfo';
  fn_freeaddrinfo = 'freeaddrinfo';
  fn_inet_pton = 'inet_pton';
  fn_inet_ntop = 'inet_ntop';
  {$ENDIF}

var
  {$EXTERNALSYM getaddrinfo}
  {$EXTERNALSYM getnameinfo}
  {$EXTERNALSYM freeaddrinfo}
  {$EXTERNALSYM inet_pton}
  {$EXTERNALSYM inet_ntop}
  {$IFDEF UNICODE}
  getaddrinfo: LPFN_GETADDRINFOW = nil;
  getnameinfo: LPFN_GETNAMEINFOW = nil;
  freeaddrinfo: LPFN_FREEADDRINFOW = nil;
  //These are here for completeness
  inet_pton : LPFN_inet_ptonW = nil;
  inet_ntop : LPFN_inet_ntopW = nil;
  {$ELSE}
  getaddrinfo: LPFN_GETADDRINFO = nil;
  getnameinfo: LPFN_GETNAMEINFO = nil;
  freeaddrinfo: LPFN_FREEADDRINFO = nil;
  //These are here for completeness
  inet_pton : LPFN_inet_pton = nil;
  inet_ntop : LPFN_inet_ntop = nil;  
  {$ENDIF}
  {
  IMPORTANT!!!

  These are Windows Vista functions and there's no guarantee that you will have
  them so ALWAYS check the function pointer before calling them.
  }
  {$EXTERNALSYM GetAddrInfoEx}
  GetAddrInfoEx :  LPFN_GETADDRINFOEX = nil;
  {$EXTERNALSYM SetAddrInfoEx}
  SetAddrInfoEx : LPFN_SetAddrInfoEx = nil;
  {$EXTERNALSYM FreeAddrInfoEx}
  //You can't alias the LPFN for this because the ASCII version of this
  //does not end with an "a"
   {$IFDEF UNICODE}
  FreeAddrInfoEx : LPFN_FreeAddrInfoEx = nil;
  {$ELSE}
  FreeAddrInfoEx : LPFN_FreeAddrInfoExW = nil;
  {$ENDIF}

var
  IdIPv6Available: Boolean = False;

function gaiErrorToWsaError(const gaiError: Integer): Integer;

implementation

uses
  SysUtils, IdGlobal;

var
  hWship6Dll : THandle = 0; // Wship6.dll handle
  //Use this instead of hWship6Dll because this will point to the correct lib.
  hProcHandle : THandle = 0;

function gaiErrorToWsaError(const gaiError: Integer): Integer;
begin
  case gaiError of
    EAI_ADDRFAMILY: Result := 0; // TODO: find a decent error for here
    EAI_AGAIN:    Result := WSATRY_AGAIN;
    EAI_BADFLAGS: Result := WSAEINVAL;
    EAI_FAIL:     Result := WSANO_RECOVERY;
    EAI_FAMILY:   Result := WSAEAFNOSUPPORT;
    EAI_MEMORY:   Result := WSA_NOT_ENOUGH_MEMORY;
    EAI_NODATA:   Result := WSANO_DATA;
    EAI_NONAME:   Result := WSAHOST_NOT_FOUND;
    EAI_SERVICE:  Result := WSATYPE_NOT_FOUND;
    EAI_SOCKTYPE: Result := WSAESOCKTNOSUPPORT;
    EAI_SYSTEM:   begin
    	Result := 0; // avoid warning
      IndyRaiseLastError;
    	end;
    else
      Result := gaiError;
  end;
end;

procedure CloseLibrary;
var
  h : THandle;
begin
  h := InterlockedExchangeTHandle(hWship6Dll,0);
  if h <> 0 then begin
    FreeLibrary(h);
  end;
  IdIPv6Available := False;
  getaddrinfo := nil;
  getnameinfo := nil;
  freeaddrinfo := nil;
end;

procedure InitLibrary;
begin
  IdIPv6Available := False;
{
IMPORTANT!!!

I am doing things this way because the functions we want are probably in the
Winsock2 .dll.  If they are not there, only then do you actually want to
try the Wship6.dll.   I know it's a mess but I found that the functions
may not load if they aren't in Wship6.dll (and they aren't there in some
versions of Winsdows).

 hProcHandle provides a transparant way of managing
the two possible library locations.  hWship6Dll is kept so we can unload
the Wship6.dll if necessary.
}
  //Winsock2 has to be loaded by IdWinsock first.
  if not IdWinsock2.Winsock2Loaded then
  begin
    IdWinsock2.InitializeWinSock;
    hProcHandle := IdWinsock2.WinsockHandle;
  end;
  getaddrinfo := GetProcAddress(hProcHandle,fn_getaddrinfo);
  if not Assigned(getaddrinfo) then
  begin
    hWship6Dll := LoadLibrary( Wship6_dll );
    hProcHandle := hWship6Dll;
    getaddrinfo := GetProcAddress(hProcHandle,fn_getaddrinfo);  {do not localize}
  end;

  if Assigned(getaddrinfo) then begin
    getnameinfo := GetProcAddress(hProcHandle,fn_getnameinfo);  {do not localize}
    if Assigned(getnameinfo) then begin
      freeaddrinfo := GetProcAddress(hProcHandle,fn_freeaddrinfo);  {do not localize}
      if Assigned(freeaddrinfo) then begin
        IdIPv6Available := True;

        //Additional functions should be initialized here.
        inet_pton := GetProcAddress(hProcHandle,fn_inet_pton);  {do not localize}
        inet_ntop := GetProcAddress(hProcHandle,fn_inet_ntop);  {do not localize}
        GetAddrInfoEx := GetProcAddress(hProcHandle,fn_GetAddrInfoEx); {Do not localize}
        SetAddrInfoEx := GetProcAddress(hProcHandle, fn_SetAddrInfoEx); {Do not localize}
        FreeAddrInfoEx := GetProcAddress(hProcHandle,fn_FreeAddrInfoEx); {Do not localize}
        Exit;
      end;
    end;
  end;
  CloseLibrary;

end;

initialization
  InitLibrary;
finalization
  CloseLibrary;
end.

