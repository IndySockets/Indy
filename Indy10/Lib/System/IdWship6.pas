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

//function GetAdaptersAddresses( Family:cardinal; Flags:cardinal; Reserved:pointer; pAdapterAddresses: PIP_ADAPTER_ADDRESSES; pOutBufLen:pcardinal):cardinal;stdcall;  external iphlpapi_dll;

{ the following are not used, nor tested}
//function getipnodebyaddr(const src:pointer;  len:integer; af:integer;var error_num:integer) :phostent;stdcall; external Wship6_dll;
//procedure freehostent(ptr:phostent);stdcall; external Wship6_dll;
//function inet_pton(af:integer; const src:pchar; dst:pointer):integer;stdcall; external Wship6_dll;
//function inet_ntop(af:integer; const src:pointer; dst:pchar;size:integer):pchar;stdcall; external Wship6_dll;
{ end the following are not used, nor tested}


type
  {$EXTERNALSYM LPFN_GETADDRINFO}
  LPFN_GETADDRINFO = function(NodeName: PChar; ServName: PChar; Hints: Paddrinfo; addrinfo: PPaddrinfo): Integer; stdcall;
  {$EXTERNALSYM LPFN_GETNAMEINFO}
  LPFN_GETNAMEINFO = function(sa: psockaddr; salen: u_int; host: PChar; hostlen: u_int; serv: PChar; servlen: u_int; flags: Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_FREEADDRINFO}
  LPFN_FREEADDRINFO = procedure(ai: Paddrinfo); stdcall;

var
  {$EXTERNALSYM getaddrinfo}
  getaddrinfo: LPFN_GETADDRINFO = nil;
  {$EXTERNALSYM getnameinfo}
  getnameinfo: LPFN_GETNAMEINFO = nil;
  {$EXTERNALSYM freeaddrinfo}
  freeaddrinfo: LPFN_FREEADDRINFO = nil;

var
  IdIPv6Available: Boolean = False;

function gaiErrorToWsaError(const gaiError: Integer): Integer;

implementation

uses
  SysUtils, Windows;

var
  hWship6Dll : THandle = 0; // Wship6.dll handle

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
    	{$IFNDEF VCL6ORABOVE}
    	RaiseLastWin32Error;
    	{$ELSE}
    	RaiseLastOSError;
    	{$ENDIF}
    	end;
    else
                  Result := gaiError;
  end;
end;

procedure CloseLibrary;
var
  h : THandle;
begin
  h := InterlockedExchange(Integer(hWship6Dll), 0);
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
  hWship6Dll := LoadLibrary( Wship6_dll );
  if hWship6Dll <> 0 then begin
    getaddrinfo := GetProcAddress(hWship6Dll, 'getaddrinfo');  {do not localize}
    if Assigned(getaddrinfo) then begin
      getnameinfo := GetProcAddress(hWship6Dll, 'getnameinfo');  {do not localize}
      if Assigned(getnameinfo) then begin
        freeaddrinfo := GetProcAddress(hWship6Dll, 'freeaddrinfo');  {do not localize}
        if Assigned(freeaddrinfo) then begin
          IdIPv6Available := True;
          Exit;
        end;
      end;
    end;
    CloseLibrary;
  end;
end;

initialization
  InitLibrary;
finalization
  CloseLibrary;
end.

