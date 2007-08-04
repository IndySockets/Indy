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
  Log:  56400: IdWinsock2.pas

  Rev 1.0    2004.02.03 3:14:50 PM  czhower
  Move and updates


  Rev 1.15    1/3/2004 12:41:48 AM  BGooijen
  Fixed WSAEnumProtocols


  Rev 1.14    10/15/2003 1:20:48 PM  DSiders
  Added localization comments.


  Rev 1.13    2003.10.01 11:16:38 AM  czhower
  .Net


  Rev 1.12    9/24/2003 09:18:24 AM  JPMugaas
  Fixed an AV that happened when a stack call was made.


  Rev 1.11    24/9/2003 3:11:34 PM  SGrobety
  First wave of fixes for compiling in dotnet. Still not functional, needed to
  unlock to fix critical failure in Delphi code


  Rev 1.10    9/22/2003 11:20:14 PM  EHill
  Removed assembly code and replaced with defined API stubs.


  Rev 1.9    7/7/2003 12:55:10 PM  BGooijen
  Fixed ServiceQueryTransmitFile, and made it public


  Rev 1.8    2003.05.09 10:59:30 PM  czhower


  Rev 1.7    4/19/2003 10:28:24 PM  BGooijen
  some functions were linked to the wrong dll


  Rev 1.6    4/19/2003 11:14:40 AM  JPMugaas
  Made some tentitive wrapper functions for some things that should be called
  from the Service Provider.  Fixed WSARecvMsg.


  Rev 1.5    4/19/2003 02:29:26 AM  JPMugaas
  Added TransmitPackets API function call.  Note that this is only supported in
  Windows XP or later.


  Rev 1.4    4/19/2003 12:22:58 AM  BGooijen
  fixed: ConnectEx DisconnectEx WSARecvMsg


  Rev 1.3    4/18/2003 12:00:58 AM  JPMugaas
  added
  ConnectEx
  DisconnectEx
  WSARecvMsg

  Changed header procedure type names to be consistant with the old
  IdWinsock.pas in Indy 8.0 and with the rest of the unit.


  Rev 1.2    3/22/2003 10:01:26 PM  JPMugaas
  WSACreateEvent couldn't load because of a space.


  Rev 1.1    3/22/2003 09:46:54 PM  JPMugaas
  It turns out that we really do not need the TGUID defination in the header at
  all.  It's defined in D4, D5, D6, and D7.


  Rev 1.0    11/13/2002 09:02:54 AM  JPMugaas
}
//-------------------------------------------------------------
//
//       Borland Delphi Runtime Library
//       <API> interface unit
//
// Portions created by Microsoft are
// Copyright (C) 1995-1999 Microsoft Corporation.
// All Rights Reserved.
//
// The original file is: Winsock2.h from CBuilder5 distribution.
// The original Pascal code is: winsock2.pas, released 03 Mar 2001.
// The initial developer of the Pascal code is Alex Konshin
// (alexk@mtgroup.ru).
//-------------------------------------------------------------


{ Winsock2.h -- definitions to be used with the WinSock 2 DLL and WinSock 2 applications.
  This header file corresponds to version 2.2.x of the WinSock API specification.
  This file includes parts which are Copyright (c) 1982-1986 Regents
  of the University of California. All rights reserved.
  The Berkeley Software License Agreement specifies the terms and
  conditions for redistribution. }

// Note that the original unit is copyrighted by the original author and I did obtain his
// permission to port and use this as part of Indy - J. Peter Mugaas

// 2002-01-28 - Hadi Hariri. Fixes for C++ Builder. Thanks to Chuck Smith.
// 2001 - Oct -25  J. Peter Mugaas
//    Made adjustments for Indy usage by
//    1) including removing Trace logging
//    2) renaming and consolidating some .INC files as appropriate
//    3) modifying the unit to follow Indy conventions
//    4) Adding TransmitFile support for the HTTP Server
//    5) Removing all static loading code that was IFDEF'ed.    {Do not Localize}
// 2001 - Mar - 1  Alex Konshin
// Revision 3
// converted by Alex Konshin, mailto:alexk@mtgroup.ru
// revision 3, March,1 2001


unit IdWinSock2;

interface

{$I IdCompilerDefines.inc}

{$ALIGN OFF}
{$RANGECHECKS OFF}
{$WRITEABLECONST OFF}

uses
  IdException, IdGlobal, SysUtils, Windows;

type
  EIdWinsockStubError = class(EIdException)
  protected
    FWin32Error : DWORD;
    FWin32ErrorMessage : String;
    FTitle : String;
  public
    constructor Build(AWin32Error: DWORD; const ATitle: String; AArgs: array of const);
    property Win32Error : DWORD read FWin32Error;
    property Win32ErrorMessage : String read FWin32ErrorMessage;
    property Title : String read FTitle;
  end;

const
  {$IFDEF UNDER_CE}
  WINSOCK2_DLL = 'ws2.dll'; {Do not Localize}
  {$ELSE}
  WINSOCK2_DLL = 'WS2_32.DLL';   {Do not Localize}
  MSWSOCK_DLL = 'MSWSOCK.DLL';   {Do not Localize}
  {$ENDIF}
  {$EXTERNALSYM WINSOCK_VERSION}
  WINSOCK_VERSION = $0202;

{$DEFINE WS2_DLL_FUNC_VARS}
{$DEFINE INCL_WINSOCK_API_PROTOTYPES}
{$DEFINE INCL_WINSOCK_API_TYPEDEFS}

type
  {$EXTERNALSYM u_char}
  u_char  = Byte;
  {$EXTERNALSYM u_short}
  u_short = Word;
  {$EXTERNALSYM u_int}
  u_int   = DWord;  //Integer;
  {$EXTERNALSYM u_long}
  u_long  = DWORD;
// The new type to be used in all instances which refer to sockets.
  {$EXTERNALSYM TSocket}
  TSocket = PtrUInt;
  {$EXTERNALSYM WSAEVENT}
  WSAEVENT = THandle;
  PWSAEVENT = ^WSAEVENT;
  {$EXTERNALSYM LPWSAEVENT}
  LPWSAEVENT = PWSAEVENT;

const
  {$EXTERNALSYM FD_SETSIZE}
  FD_SETSIZE     =   64;

// the following emits are a workaround to the name conflicts
// with the winsock2 header files
(*$HPPEMIT '#include <winsock2.h>'*)
(*$HPPEMIT '#include <ws2tcpip.h>'*)
(*$HPPEMIT '#include <wsipx.h>'*)
(*$HPPEMIT '#include <wsnwlink.h>'*)
(*$HPPEMIT '#include <wsnetbs.h>'*)
(*$HPPEMIT '#include <ws2atm.h>'*)
(*$HPPEMIT '#include <mswsock.h>'*)
(*$HPPEMIT ''*)
(*$HPPEMIT 'namespace Idwinsock2'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT '    typedef fd_set *PFDSet;'*) // due to name conflict with procedure FD_SET
(*$HPPEMIT '    typedef fd_set TFDSet;'*)  // due to name conflict with procedure FD_SET
(*$HPPEMIT '}'*)
(*$HPPEMIT ''*)

// the following emits are to ensure all supported versions
// of C++Builder know about the latest winsock2 structures
{$IFNDEF VCL6ORABOVE} // prior to BCB6
(*$HPPEMIT 'typedef struct in_pktinfo {'*)
(*$HPPEMIT '    IN_ADDR ipi_addr;    // destination IPv4 address'*)
(*$HPPEMIT '    UINT    ipi_ifindex; // received interface index'*)
(*$HPPEMIT '} IN_PKTINFO;'*)
(*$HPPEMIT ''*)
(*$HPPEMIT 'typedef struct in6_pktinfo {'*)
(*$HPPEMIT '    IN6_ADDR ipi6_addr;    // destination IPv6 address'*)
(*$HPPEMIT '    UINT     ipi6_ifindex; // received interface index'*)
(*$HPPEMIT '} IN6_PKTINFO;'*)
(*$HPPEMIT ''*)
(*$HPPEMIT 'typedef struct addrinfo {'*)
(*$HPPEMIT '    int ai_flags;              /* AI_PASSIVE, AI_CANONNAME, AI_NUMERICHOST */'*)
(*$HPPEMIT '    int ai_family;             /* PF_xxx */'*)
(*$HPPEMIT '    int ai_socktype;           /* SOCK_xxx */'*)
(*$HPPEMIT '    int ai_protocol;           /* 0 or IPPROTO_xxx for IPv4 and IPv6 */'*)
(*$HPPEMIT '    size_t ai_addrlen;         /* Length of ai_addr */'*)
(*$HPPEMIT '    char *ai_canonname;        /* Canonical name for nodename */'*)
(*$HPPEMIT '    struct sockaddr *ai_addr;  /* Binary address */'*)
(*$HPPEMIT '    struct addrinfo *ai_next;  /* Next structure in linked list */'*)
(*$HPPEMIT '} ADDRINFO, FAR * LPADDRINFO;'*)
{$ENDIF}
{$IFNDEF VCL5ORABOVE} // prior to BCB5
(*$HPPEMIT 'typedef struct _INTERFACE_INFO_EX'*)
(*$HPPEMIT '{'*)
(*$HPPEMIT '    u_long          iiFlags;            /* Interface flags */'*)
(*$HPPEMIT '    SOCKET_ADDRESS  iiAddress;          /* Interface address */'*)
(*$HPPEMIT '    SOCKET_ADDRESS  iiBroadcastAddress; /* Broadcast address */'*)
(*$HPPEMIT '    SOCKET_ADDRESS  iiNetmask;          /* Network mask */'*)
(*$HPPEMIT '} INTERFACE_INFO_EX, FAR * LPINTERFACE_INFO_EX;'*)
{$ENDIF}

type
  {$NODEFINE PFDSet}
  PFDSet = ^TFDSet;
  {$NODEFINE TFDSet}
  TFDSet = packed record
    fd_count: u_int;
    fd_array: array[0..FD_SETSIZE-1] of TSocket;
  end;

  {$EXTERNALSYM timeval}
  timeval = record
    tv_sec: Longint;
    tv_usec: Longint;
  end;
  TTimeVal = timeval;
  PTimeVal = ^TTimeVal;

const
  {$EXTERNALSYM IOCPARM_MASK}
  IOCPARM_MASK = $7F;
  {$EXTERNALSYM IOC_VOID}
  IOC_VOID     = $20000000;
  {$EXTERNALSYM IOC_OUT}
  IOC_OUT      = $40000000;
  {$EXTERNALSYM IOC_IN}
  IOC_IN       = $80000000;
  {$EXTERNALSYM IOC_INOUT}
  IOC_INOUT    = (IOC_IN or IOC_OUT);

// get # bytes to read
  {$EXTERNALSYM FIONREAD}
  FIONREAD     = IOC_OUT or ((SizeOf(u_long) and IOCPARM_MASK) shl 16) or (Ord('f') shl 8) or 127;    {Do not Localize}
// set/clear non-blocking i/o
  {$EXTERNALSYM FIONBIO}
  FIONBIO      = IOC_IN  or ((SizeOf(u_long) and IOCPARM_MASK) shl 16) or (Ord('f') shl 8) or 126;    {Do not Localize}
// set/clear async i/o
  {$EXTERNALSYM FIOASYNC}
  FIOASYNC     = IOC_IN  or ((SizeOf(u_long) and IOCPARM_MASK) shl 16) or (Ord('f') shl 8) or 125;    {Do not Localize}

//  Socket I/O Controls

// set high watermark
  {$EXTERNALSYM SIOCSHIWAT}
  SIOCSHIWAT   = IOC_IN  or ((SizeOf(u_long) and IOCPARM_MASK) shl 16) or (Ord('s') shl 8) or 0;    {Do not Localize}
// get high watermark
  {$EXTERNALSYM SIOCGHIWAT}
  SIOCGHIWAT   = IOC_OUT or ((SizeOf(u_long) and IOCPARM_MASK) shl 16) or (Ord('s') shl 8) or 1;    {Do not Localize}
// set low watermark
  {$EXTERNALSYM SIOCSLOWAT}
  SIOCSLOWAT   = IOC_IN or ((SizeOf(u_long) and IOCPARM_MASK) shl 16) or (Ord('s') shl 8) or 2;    {Do not Localize}
// get low watermark
  {$EXTERNALSYM SIOCGLOWAT}
  SIOCGLOWAT   = IOC_OUT or ((SizeOf(u_long) and IOCPARM_MASK) shl 16) or (Ord('s') shl 8) or 3;    {Do not Localize}
// at oob mark?
  {$EXTERNALSYM SIOCATMARK}
  SIOCATMARK   = IOC_OUT or ((SizeOf(u_long) and IOCPARM_MASK) shl 16) or (Ord('s') shl 8) or 7;    {Do not Localize}


//  Structures returned by network data base library, taken from the
//  BSD file netdb.h.  All addresses are supplied in host order, and
//  returned in network order (suitable for use in system calls).
type
  {$EXTERNALSYM hostent}
  hostent = packed record
    h_name: PChar;                 // official name of host
    h_aliases: ^PChar;             // alias list
    h_addrtype: Smallint;          // host address type
    h_length: Smallint;            // length of address
    case Byte of
      0: (h_address_list: ^PChar);
      1: (h_addr: PChar);         // address, for backward compat
  end;
  THostEnt = hostent;
  PHostEnt = ^THostEnt;

//  It is assumed here that a network number
//  fits in 32 bits.
  {$EXTERNALSYM netent}
  netent = packed record
    n_name: PChar;                 // official name of net
    n_aliases: ^PChar;             // alias list
    n_addrtype: Smallint;          // net address type
    n_net: u_long;                 // network #
  end;
  TNetEnt = netent;
  PNetEnt = ^TNetEnt;

  {$EXTERNALSYM servent}
  servent = packed record
    s_name: PChar;                 // official service name
    s_aliases: ^PChar;             // alias list
    {$IFDEF _WIN64}
    s_proto: PChar;                // protocol to use
    s_port: Smallint;              // port #
    {$ELSE}
    s_port: Smallint;              // port #
    s_proto: PChar;                // protocol to use
    {$ENDIF}
  end;
  TServEnt = servent;
  PServEnt = ^TServEnt;

  {$EXTERNALSYM protoent}
  protoent = packed record
    p_name: PChar;                 // official protocol name
    p_aliases: ^PChar;             // alias list
    p_proto: Smallint;             // protocol #
  end;
  TProtoEnt = protoent;
  PProtoEnt = ^TProtoEnt;

// Constants and structures defined by the internet system,
// Per RFC 790, September 1981, taken from the BSD file netinet/in.h.
const

// Protocols
  {$EXTERNALSYM IPPROTO_IP}
  IPPROTO_IP     =   0;             // dummy for IP
  {$EXTERNALSYM IPPROTO_ICMP}
  IPPROTO_ICMP   =   1;             // control message protocol
  {$EXTERNALSYM IPPROTO_IGMP}
  IPPROTO_IGMP   =   2;             // group management protocol
  {$EXTERNALSYM IPPROTO_GGP}
  IPPROTO_GGP    =   3;             // gateway^2 (deprecated)
  {$EXTERNALSYM IPPROTO_TCP}
  IPPROTO_TCP    =   6;             // TCP
  {$EXTERNALSYM IPPROTO_PUP}
  IPPROTO_PUP    =  12;             // pup
  {$EXTERNALSYM IPPROTO_UDP}
  IPPROTO_UDP    =  17;             // UDP - user datagram protocol
  {$EXTERNALSYM IPPROTO_IDP}
  IPPROTO_IDP    =  22;             // xns idp
  {$EXTERNALSYM IPPROTO_ND}
  IPPROTO_ND     =  77;             // UNOFFICIAL net disk proto

  {$EXTERNALSYM IPPROTO_IPV6}
  IPPROTO_IPV6   =  41;             // IPv6
  {$EXTERNALSYM IPPROTO_ICLFXBM}
  IPPROTO_ICLFXBM = 78;

  {$EXTERNALSYM IPPROTO_ICMPV6}
  IPPROTO_ICMPV6 =  58;             // control message protocol

  {$EXTERNALSYM IPPROTO_RAW}
  IPPROTO_RAW    = 255;             // raw IP packet
  {$EXTERNALSYM IPPROTO_MAX}
  IPPROTO_MAX    = 256;

// Port/socket numbers: network standard functions
  {$EXTERNALSYM IPPORT_ECHO}
  IPPORT_ECHO        =   7;
  {$EXTERNALSYM IPPORT_DISCARD}
  IPPORT_DISCARD     =   9;
  {$EXTERNALSYM IPPORT_SYSTAT}
  IPPORT_SYSTAT      =  11;
  {$EXTERNALSYM IPPORT_DAYTIME}
  IPPORT_DAYTIME     =  13;
  {$EXTERNALSYM IPPORT_NETSTAT}
  IPPORT_NETSTAT     =  15;
  {$EXTERNALSYM IPPORT_FTP}
  IPPORT_FTP         =  21;
  {$EXTERNALSYM IPPORT_TELNET}
  IPPORT_TELNET      =  23;
  {$EXTERNALSYM IPPORT_SMTP}
  IPPORT_SMTP        =  25;
  {$EXTERNALSYM IPPORT_TIMESERVER}
  IPPORT_TIMESERVER  =  37;
  {$EXTERNALSYM IPPORT_NAMESERVER}
  IPPORT_NAMESERVER  =  42;
  {$EXTERNALSYM IPPORT_WHOIS}
  IPPORT_WHOIS       =  43;
  {$EXTERNALSYM IPPORT_MTP}
  IPPORT_MTP         =  57;

// Port/socket numbers: host specific functions
  {$EXTERNALSYM IPPORT_TFTP}
  IPPORT_TFTP        =  69;
  {$EXTERNALSYM IPPORT_RJE}
  IPPORT_RJE         =  77;
  {$EXTERNALSYM IPPORT_FINGER}
  IPPORT_FINGER      =  79;
  {$EXTERNALSYM ipport_ttylink}
  IPPORT_TTYLINK     =  87;
  {$EXTERNALSYM IPPORT_SUPDUP}
  IPPORT_SUPDUP      =  95;

// UNIX TCP sockets
  {$EXTERNALSYM IPPORT_EXECSERVER}
  IPPORT_EXECSERVER  = 512;
  {$EXTERNALSYM IPPORT_LOGINSERVER}
  IPPORT_LOGINSERVER = 513;
  {$EXTERNALSYM IPPORT_CMDSERVER}
  IPPORT_CMDSERVER   = 514;
  {$EXTERNALSYM IPPORT_EFSSERVER}
  IPPORT_EFSSERVER   = 520;

// UNIX UDP sockets
  {$EXTERNALSYM IPPORT_BIFFUDP}
  IPPORT_BIFFUDP     = 512;
  {$EXTERNALSYM IPPORT_WHOSERVER}
  IPPORT_WHOSERVER   = 513;
  {$EXTERNALSYM IPPORT_ROUTESERVER}
  IPPORT_ROUTESERVER = 520;

// Ports < IPPORT_RESERVED are reserved for privileged processes (e.g. root).
  {$EXTERNALSYM ipport_reserved}
  IPPORT_RESERVED    =1024;

// Link numbers
  {$EXTERNALSYM IMPLINK_IP}
  IMPLINK_IP         = 155;
  {$EXTERNALSYM IMPLINK_LOWEXPER}
  IMPLINK_LOWEXPER   = 156;
  {$EXTERNALSYM IMPLINK_HIGHEXPER}
  IMPLINK_HIGHEXPER  = 158;

  {$EXTERNALSYM TF_DISCONNECT}
  TF_DISCONNECT      = $01;
  {$EXTERNALSYM TF_REUSE_SOCKET}
  TF_REUSE_SOCKET    = $02;
  {$EXTERNALSYM TF_WRITE_BEHIND}
  TF_WRITE_BEHIND    = $04;
  {$EXTERNALSYM TF_USE_DEFAULT_WORKER}
  TF_USE_DEFAULT_WORKER = $00;
  {$EXTERNALSYM TF_USE_SYSTEM_THREAD}
  TF_USE_SYSTEM_THREAD = $10;
  {$EXTERNALSYM TF_USE_KERNEL_APC}
  TF_USE_KERNEL_APC   = $20;

// This is used instead of -1, since the TSocket type is unsigned.
  {$EXTERNALSYM INVALID_SOCKET}
  INVALID_SOCKET     = TSocket(not(0));
  {$EXTERNALSYM SOCKET_ERROR}
  SOCKET_ERROR       = -1;

//  The following may be used in place of the address family, socket type, or
//  protocol in a call to WSASocket to indicate that the corresponding value
//  should be taken from the supplied WSAPROTOCOL_INFO structure instead of the
//  parameter itself.
  {$EXTERNALSYM FROM_PROTOCOL_INFO}
  FROM_PROTOCOL_INFO = -1;


// Types
  {$EXTERNALSYM SOCK_STREAM}
  SOCK_STREAM     = 1;               { stream socket }
  {$EXTERNALSYM SOCK_DGRAM}
  SOCK_DGRAM      = 2;               { datagram socket }
  {$EXTERNALSYM SOCK_RAW}
  SOCK_RAW        = 3;               { raw-protocol interface }
  {$EXTERNALSYM SOCK_RDM}
  SOCK_RDM        = 4;               { reliably-delivered message }
  {$EXTERNALSYM SOCK_SEQPACKET}
  SOCK_SEQPACKET  = 5;               { sequenced packet stream }

// option flags per-socket.
  {$EXTERNALSYM SO_DEBUG}
  SO_DEBUG            = $0001;            // turn on debugging info recording
  {$EXTERNALSYM SO_ACCEPTCONN}
  SO_ACCEPTCONN       = $0002;            // socket has had listen()
  {$EXTERNALSYM SO_REUSEADDR}
  SO_REUSEADDR        = $0004;            // allow local address reuse
  {$EXTERNALSYM SO_KEEPALIVE}
  SO_KEEPALIVE        = $0008;            // keep connections alive
  {$EXTERNALSYM SO_DONTROUTE}
  SO_DONTROUTE        = $0010;            // just use interface addresses
  {$EXTERNALSYM SO_BROADCAST}
  SO_BROADCAST        = $0020;            // permit sending of broadcast msgs
  {$EXTERNALSYM SO_USELOOPBACK}
  SO_USELOOPBACK      = $0040;            // bypass hardware when possible
  {$EXTERNALSYM SO_LINGER}
  SO_LINGER           = $0080;            // linger on close if data present
  {$EXTERNALSYM SO_OOBINLINE}
  SO_OOBINLINE        = $0100;            // leave received OOB data in line

  {$EXTERNALSYM SO_DONTLINGER}
  SO_DONTLINGER       = not SO_LINGER;
  {$EXTERNALSYM SO_EXCLUSIVEADDRUSE}
  SO_EXCLUSIVEADDRUSE = not SO_REUSEADDR; // disallow local address reuse

// additional options.

  {$EXTERNALSYM SO_SNDBUF}
  SO_SNDBUF           = $1001;      // send buffer size
  {$EXTERNALSYM SO_RCVBUF}
  SO_RCVBUF           = $1002;      // receive buffer size
  {$EXTERNALSYM SO_SNDLOWAT}
  SO_SNDLOWAT         = $1003;      // send low-water mark
  {$EXTERNALSYM SO_RCVLOWAT}
  SO_RCVLOWAT         = $1004;      // receive low-water mark
  {$EXTERNALSYM SO_SNDTIMEO}
  SO_SNDTIMEO         = $1005;      // send timeout
  {$EXTERNALSYM SO_RCVTIMEO}
  SO_RCVTIMEO         = $1006;      // receive timeout
  {$EXTERNALSYM SO_ERROR}
  SO_ERROR            = $1007;      // get error status and clear
  {$EXTERNALSYM SO_TYPE}
  SO_TYPE             = $1008;      // get socket type

// options for connect and disconnect data and options.
// used only by non-tcp/ip transports such as DECNet, OSI TP4, etc.
  {$EXTERNALSYM SO_CONNDATA}
  SO_CONNDATA         = $7000;
  {$EXTERNALSYM SO_CONNOPT}
  SO_CONNOPT          = $7001;
  {$EXTERNALSYM SO_DISCDATA}
  SO_DISCDATA         = $7002;
  {$EXTERNALSYM SO_DISCOPT}
  SO_DISCOPT          = $7003;
  {$EXTERNALSYM SO_CONNDATALEN}
  SO_CONNDATALEN      = $7004;
  {$EXTERNALSYM SO_CONNOPTLEN}
  SO_CONNOPTLEN       = $7005;
  {$EXTERNALSYM SO_DISCDATALEN}
  SO_DISCDATALEN      = $7006;
  {$EXTERNALSYM SO_DISCOPTLEN}
  SO_DISCOPTLEN       = $7007;

// option for opening sockets for synchronous access.
  {$EXTERNALSYM SO_OPENTYPE}
  SO_OPENTYPE         = $7008;
  {$EXTERNALSYM SO_SYNCHRONOUS_ALERT}
  SO_SYNCHRONOUS_ALERT    = $10;
  {$EXTERNALSYM SO_SYNCHRONOUS_NONALERT}
  SO_SYNCHRONOUS_NONALERT = $20;

// other nt-specific options.
  {$EXTERNALSYM SO_MAXDG}
  SO_MAXDG                 = $7009;
  {$EXTERNALSYM SO_MAXPATHDG}
  SO_MAXPATHDG             = $700A;
  {$EXTERNALSYM SO_UPDATE_ACCEPT_CONTEXT}
  SO_UPDATE_ACCEPT_CONTEXT = $700B;
  {$EXTERNALSYM SO_CONNECT_TIME}
  SO_CONNECT_TIME          = $700C;

// tcp options.
  {$EXTERNALSYM TCP_NODELAY}
  TCP_NODELAY              = $0001;
  {$EXTERNALSYM TCP_BSDURGENT}
  TCP_BSDURGENT            = $7000;

// winsock 2 extension -- new options
  {$EXTERNALSYM SO_GROUP_ID}
  SO_GROUP_ID              = $2001; // ID of a socket group
  {$EXTERNALSYM SO_GROUP_PRIORITY}
  SO_GROUP_PRIORITY        = $2002; // the relative priority within a group
  {$EXTERNALSYM SO_MAX_MSG_SIZE}
  SO_MAX_MSG_SIZE          = $2003; // maximum message size
  {$EXTERNALSYM SO_PROTOCOL_INFOA}
  SO_PROTOCOL_INFOA        = $2004; // WSAPROTOCOL_INFOA structure
  {$EXTERNALSYM SO_PROTOCOL_INFOW}
  SO_PROTOCOL_INFOW        = $2005; // WSAPROTOCOL_INFOW structure
  {$EXTERNALSYM SO_PROTOCOL_INFO}
{$IFDEF UNICODE}
  SO_PROTOCOL_INFO         = SO_PROTOCOL_INFOW;
{$ELSE}
  SO_PROTOCOL_INFO         = SO_PROTOCOL_INFOA;
{$ENDIF}
  {$EXTERNALSYM PVD_CONFIG}
  PVD_CONFIG               = $3001; // configuration info for service provider
  {$EXTERNALSYM SO_CONDITIONAL_ACCEPT}
  SO_CONDITIONAL_ACCEPT    = $3002; // enable true conditional accept:
                                    // connection is not ack-ed to the
                                    // other side until conditional
                                    // function returns CF_ACCEPT

// Address families.
  {$EXTERNALSYM AF_UNSPEC}
  AF_UNSPEC       = 0;               // unspecified
  {$EXTERNALSYM AF_UNIX}
  AF_UNIX         = 1;               // local to host (pipes, portals)
  {$EXTERNALSYM AF_INET}
  AF_INET         = 2;               // internetwork: UDP, TCP, etc.
  {$EXTERNALSYM AF_IMPLINK}
  AF_IMPLINK      = 3;               // arpanet imp addresses
  {$EXTERNALSYM AF_PUP}
  AF_PUP          = 4;               // pup protocols: e.g. BSP
  {$EXTERNALSYM AF_CHAOS}
  AF_CHAOS        = 5;               // mit CHAOS protocols
  {$EXTERNALSYM AF_IPX}
  AF_IPX          = 6;               // ipx and SPX
  {$EXTERNALSYM AF_NS}
  AF_NS           = AF_IPX;          // xerOX NS protocols
  {$EXTERNALSYM AF_ISO}
  AF_ISO          = 7;               // iso protocols
  {$EXTERNALSYM AF_OSI}
  AF_OSI          = AF_ISO;          // osi is ISO
  {$EXTERNALSYM AF_ECMA}
  AF_ECMA         = 8;               // european computer manufacturers
  {$EXTERNALSYM AF_DATAKIT}
  AF_DATAKIT      = 9;               // datakit protocols
  {$EXTERNALSYM AF_CCITT}
  AF_CCITT        = 10;              // cciTT protocols, X.25 etc
  {$EXTERNALSYM AF_SNA}
  AF_SNA          = 11;              // ibm SNA
  {$EXTERNALSYM AF_DECNET}
  AF_DECNET       = 12;              // decnet
  {$EXTERNALSYM AF_DLI}
  AF_DLI          = 13;              // direct data link interface
  {$EXTERNALSYM AF_LAT}
  AF_LAT          = 14;              // lat
  {$EXTERNALSYM AF_HYLINK}
  AF_HYLINK       = 15;              // nsc Hyperchannel
  {$EXTERNALSYM AF_APPLETALK}
  AF_APPLETALK    = 16;              // appleTalk
  {$EXTERNALSYM AF_NETBIOS}
  AF_NETBIOS      = 17;              // netBios-style addresses
  {$EXTERNALSYM AF_VOICEVIEW}
  AF_VOICEVIEW    = 18;              // voiceView
  {$EXTERNALSYM AF_FIREFOX}
  AF_FIREFOX      = 19;              // fireFox
  {$EXTERNALSYM AF_UNKNOWN1}
  AF_UNKNOWN1     = 20;              // somebody is using this!
  {$EXTERNALSYM AF_BAN}
  AF_BAN          = 21;              // banyan
  {$EXTERNALSYM AF_ATM}
  AF_ATM          = 22;              // native ATM Services
  {$EXTERNALSYM AF_INET6}
  AF_INET6        = 23;              // internetwork Version 6
  {$EXTERNALSYM AF_CLUSTER}
  AF_CLUSTER      = 24;              // microsoft Wolfpack
  {$EXTERNALSYM AF_12844}
  AF_12844        = 25;              // ieeE 1284.4 WG AF
  {$EXTERNALSYM AF_IRDA}
  AF_IRDA         = 26;              // irdA
  {$EXTERNALSYM AF_NETDES}
  AF_NETDES       = 28;              // network Designers OSI & gateway enabled protocols
  {$EXTERNALSYM AF_TCNPROCESS}
  AF_TCNPROCESS   = 29;
  {$EXTERNALSYM AF_TCNMESSAGE}
  AF_TCNMESSAGE   = 30;
  {$EXTERNALSYM AF_ICLFXBM}
  AF_ICLFXBM      = 31;

  {$EXTERNALSYM AF_MAX}
  AF_MAX          = 32;


// protocol families, same as address families for now.

  {$EXTERNALSYM PF_UNSPEC}
  PF_UNSPEC       = AF_UNSPEC;
  {$EXTERNALSYM PF_UNIX}
  PF_UNIX         = AF_UNIX;
  {$EXTERNALSYM PF_INET}
  PF_INET         = AF_INET;
  {$EXTERNALSYM PF_IMPLINK}
  PF_IMPLINK      = AF_IMPLINK;
  {$EXTERNALSYM PF_PUP}
  PF_PUP          = AF_PUP;
  {$EXTERNALSYM PF_CHAOS}
  PF_CHAOS        = AF_CHAOS;
  {$EXTERNALSYM PF_NS}
  PF_NS           = AF_NS;
  {$EXTERNALSYM PF_IPX}
  PF_IPX          = AF_IPX;
  {$EXTERNALSYM PF_ISO}
  PF_ISO          = AF_ISO;
  {$EXTERNALSYM PF_OSI}
  PF_OSI          = AF_OSI;
  {$EXTERNALSYM PF_ECMA}
  PF_ECMA         = AF_ECMA;
  {$EXTERNALSYM PF_DATAKIT}
  PF_DATAKIT      = AF_DATAKIT;
  {$EXTERNALSYM PF_CCITT}
  PF_CCITT        = AF_CCITT;
  {$EXTERNALSYM PF_SNA}
  PF_SNA          = AF_SNA;
  {$EXTERNALSYM PF_DECNET}
  PF_DECNET       = AF_DECNET;
  {$EXTERNALSYM PF_DLI}
  PF_DLI          = AF_DLI;
  {$EXTERNALSYM PF_LAT}
  PF_LAT          = AF_LAT;
  {$EXTERNALSYM PF_HYLINK}
  PF_HYLINK       = AF_HYLINK;
  {$EXTERNALSYM PF_APPLETALK}
  PF_APPLETALK   = AF_APPLETALK;
  {$EXTERNALSYM PF_VOICEVIEW}
  PF_VOICEVIEW    = AF_VOICEVIEW;
  {$EXTERNALSYM PF_FIREFOX}
  PF_FIREFOX      = AF_FIREFOX;
  {$EXTERNALSYM PF_UNKNOWN1}
  PF_UNKNOWN1     = AF_UNKNOWN1;
  {$EXTERNALSYM pf_ban}
  PF_BAN          = AF_BAN;
  {$EXTERNALSYM PF_ATM}
  PF_ATM          = AF_ATM;
  {$EXTERNALSYM PF_INET6}
  PF_INET6        = AF_INET6;

  {$EXTERNALSYM PF_MAX}
  PF_MAX          = AF_MAX;

  {$EXTERNALSYM _SS_MAXSIZE}
  _SS_MAXSIZE     = 128;
  {$EXTERNALSYM _SS_ALIGNSIZE}
  _SS_ALIGNSIZE   = SizeOf(Int64);
  {$EXTERNALSYM _SS_PAD1SIZE}
  _SS_PAD1SIZE    = _SS_ALIGNSIZE - SizeOf(short);
  {$EXTERNALSYM _SS_PAD2SIZE}
  _SS_PAD2SIZE    = _SS_MAXSIZE - (SizeOf(short) + _SS_PAD1SIZE + _SS_ALIGNSIZE);

type
  {$NODEFINE SunB}
  SunB = packed record
    s_b1, s_b2, s_b3, s_b4: u_char;
  end;

  {$NODEFINE SunW}
  SunW = packed record
    s_w1, s_w2: u_short;
  end;

  {$EXTERNALSYM in_addr}
  in_addr = packed record
    case integer of
      0: (S_un_b: SunB);
      1: (S_un_w: SunW);
      2: (S_addr: u_long);
  end;
  TInAddr = in_addr;
  PInAddr = ^TInAddr;

  // Structure used by kernel to store most addresses.

  {$EXTERNALSYM sockaddr_in}
  sockaddr_in = packed record
    case Integer of
      0: (sin_family : u_short;
          sin_port   : u_short;
          sin_addr   : TInAddr;
          sin_zero   : array[0..7] of Char);
      1: (sa_family  : u_short;
          sa_data    : array[0..13] of Char)
  end;
  TSockAddrIn = sockaddr_in;
  PSockAddrIn = ^TSockAddrIn;

  TSockAddr   = TSockAddrIn;
  {$EXTERNALSYM SOCKADDR}
  SOCKADDR    = TSockAddr;
  {$EXTERNALSYM PSOCKADDR}
  PSOCKADDR   = ^TSockAddr;
  {$EXTERNALSYM LPSOCKADDR}
  LPSOCKADDR   = PSOCKADDR;

  {$EXTERNALSYM SOCKADDR_STORAGE}
  SOCKADDR_STORAGE = packed record
    ss_family: short;                            // Address family.
    __ss_pad1: array[0.._SS_PAD1SIZE-1] of Char; // 6 byte pad, this is to make
                                                 // implementation specific pad up to
                                                 // alignment field that follows explicit
                                                 // in the data structure.
    __ss_align: Int64;                           // Field to force desired structure.
    __ss_pad2: array[0.._SS_PAD2SIZE-1] of Char; // 112 byte pad to achieve desired size;
                                                 // _SS_MAXSIZE value minus size of
                                                 // ss_family, __ss_pad1, and
                                                 // __ss_align fields is 112.
  end;
  TSockAddrStorage = SOCKADDR_STORAGE;
  PSockAddrStorage = ^TSockAddrStorage;
  {$EXTERNALSYM PSOCKADDR_STORAGE}
  PSOCKADDR_STORAGE = PSockAddrStorage;
  {$EXTERNALSYM LPSOCKADDR_STORAGE}
  LPSOCKADDR_STORAGE = PSOCKADDR_STORAGE;

  // Structure used by kernel to pass protocol information in raw sockets.
  {$EXTERNALSYM sockproto}
  sockproto = packed record
    sp_family   : u_short;
    sp_protocol : u_short;
  end;
  TSockProto = sockproto;
  PSockProto = ^TSockProto;

// Structure used for manipulating linger option.
  {$EXTERNALSYM linger}
  linger = packed record
    l_onoff: u_short;
    l_linger: u_short;
  end;
  TLinger = linger;
  {$EXTERNALSYM PLINGER}
  PLINGER = ^TLinger;
  {$EXTERNALSYM LPLINGER}
  LPLINGER = PLINGER;

const
  {$EXTERNALSYM INADDR_ANY}
  INADDR_ANY       = $00000000;
  {$EXTERNALSYM INADDR_LOOPBACK}
  INADDR_LOOPBACK  = $7F000001;
  {$EXTERNALSYM INADDR_BROADCAST}
  INADDR_BROADCAST = $FFFFFFFF;
  {$EXTERNALSYM INADDR_NONE}
  INADDR_NONE      = $FFFFFFFF;

  {$EXTERNALSYM ADDR_ANY}
  ADDR_ANY         = INADDR_ANY;

  {$EXTERNALSYM SOL_SOCKET}
  SOL_SOCKET       = $FFFF;          // options for socket level

  {$EXTERNALSYM MSG_OOB}
  MSG_OOB          = $1;             // process out-of-band data
  {$EXTERNALSYM MSG_PEEK}
  MSG_PEEK         = $2;             // peek at incoming message
  {$EXTERNALSYM MSG_DONTROUTE}
  MSG_DONTROUTE    = $4;             // send without using routing tables

  {$EXTERNALSYM MSG_PARTIAL}
  MSG_PARTIAL      = $8000;          // partial send or recv for message xport

// WinSock 2 extension -- new flags for WSASend(), WSASendTo(), WSARecv() and WSARecvFrom()
  {$EXTERNALSYM MSG_INTERRUPT}
  MSG_INTERRUPT    = $10;    // send/recv in the interrupt context
  {$EXTERNALSYM MSG_MAXIOVLEN}
  MSG_MAXIOVLEN    = 16;


// Define constant based on rfc883, used by gethostbyxxxx() calls.

  {$EXTERNALSYM MAXGETHOSTSTRUCT}
  MAXGETHOSTSTRUCT = 1024;

// Maximum queue length specifiable by listen.
  {$EXTERNALSYM SOMAXCONN}
  SOMAXCONN        = $7FFFFFFF;

// WinSock 2 extension -- bit values and indices for FD_XXX network events
  {$EXTERNALSYM FD_READ_BIT}
  FD_READ_BIT                     = 0;
  {$EXTERNALSYM FD_WRITE_BIT}
  FD_WRITE_BIT                    = 1;
  {$EXTERNALSYM FD_OOB_BIT}
  FD_OOB_BIT                      = 2;
  {$EXTERNALSYM FD_ACCEPT_BIT}
  FD_ACCEPT_BIT                   = 3;
  {$EXTERNALSYM FD_CONNECT_BIT}
  FD_CONNECT_BIT                  = 4;
  {$EXTERNALSYM FD_CLOSE_BIT}
  FD_CLOSE_BIT                    = 5;
  {$EXTERNALSYM fd_qos_bit}
  FD_QOS_BIT                      = 6;
  {$EXTERNALSYM FD_GROUP_QOS_BIT}
  FD_GROUP_QOS_BIT                = 7;
  {$EXTERNALSYM FD_ROUTING_INTERFACE_CHANGE_BIT}
  FD_ROUTING_INTERFACE_CHANGE_BIT = 8;
  {$EXTERNALSYM FD_ADDRESS_LIST_CHANGE_BIT}
  FD_ADDRESS_LIST_CHANGE_BIT      = 9;

  {$EXTERNALSYM FD_MAX_EVENTS}
  FD_MAX_EVENTS    = 10;

  {$EXTERNALSYM FD_READ}
  FD_READ       = (1 shl FD_READ_BIT);
  {$EXTERNALSYM FD_WRITE}
  FD_WRITE      = (1 shl FD_WRITE_BIT);
  {$EXTERNALSYM FD_OOB}
  FD_OOB        = (1 shl FD_OOB_BIT);
  {$EXTERNALSYM FD_ACCEPT}
  FD_ACCEPT     = (1 shl FD_ACCEPT_BIT);
  {$EXTERNALSYM FD_CONNECT}
  FD_CONNECT    = (1 shl FD_CONNECT_BIT);
  {$EXTERNALSYM FD_CLOSE}
  FD_CLOSE      = (1 shl FD_CLOSE_BIT);
  {$EXTERNALSYM FD_QOS}
  FD_QOS        = (1 shl FD_QOS_BIT);
  {$EXTERNALSYM FD_GROUP_QOS}
  FD_GROUP_QOS  = (1 shl FD_GROUP_QOS_BIT);
  {$EXTERNALSYM FD_ROUTING_INTERFACE_CHANGE}
  FD_ROUTING_INTERFACE_CHANGE = (1 shl FD_ROUTING_INTERFACE_CHANGE_BIT);
  {$EXTERNALSYM FD_ADDRESS_LIST_CHANGE}
  FD_ADDRESS_LIST_CHANGE      = (1 shl FD_ADDRESS_LIST_CHANGE_BIT);

  {$EXTERNALSYM FD_ALL_EVENTS}
  FD_ALL_EVENTS = (1 shl FD_MAX_EVENTS) - 1;

// All Windows Sockets error constants are biased by WSABASEERR from the "normal"

  {$EXTERNALSYM WSABASEERR}
  WSABASEERR              = 10000;

// Windows Sockets definitions of regular Microsoft C error constants

  {$EXTERNALSYM WSAEINTR}
  WSAEINTR                = WSABASEERR+  4;
  {$EXTERNALSYM WSAEBADF}
  WSAEBADF                = WSABASEERR+  9;
  {$EXTERNALSYM WSAEACCES}
  WSAEACCES               = WSABASEERR+ 13;
  {$EXTERNALSYM WSAEFAULT}
  WSAEFAULT               = WSABASEERR+ 14;
  {$EXTERNALSYM WSAEINVAL}
  WSAEINVAL               = WSABASEERR+ 22;
  {$EXTERNALSYM WSAEMFILE}
  WSAEMFILE               = WSABASEERR+ 24;

// Windows Sockets definitions of regular Berkeley error constants

  {$EXTERNALSYM WSAEWOULDBLOCK}
  WSAEWOULDBLOCK          = WSABASEERR+ 35;
  {$EXTERNALSYM WSAEINPROGRESS}
  WSAEINPROGRESS          = WSABASEERR+ 36;
  {$EXTERNALSYM WSAEALREADY}
  WSAEALREADY             = WSABASEERR+ 37;
  {$EXTERNALSYM WSAENOTSOCK}
  WSAENOTSOCK             = WSABASEERR+ 38;
  {$EXTERNALSYM WSAEDESTADDRREQ}
  WSAEDESTADDRREQ         = WSABASEERR+ 39;
  {$EXTERNALSYM WSAEMSGSIZE}
  WSAEMSGSIZE             = WSABASEERR+ 40;
  {$EXTERNALSYM WSAEPROTOTYPE}
  WSAEPROTOTYPE           = WSABASEERR+ 41;
  {$EXTERNALSYM WSAENOPROTOOPT}
  WSAENOPROTOOPT          = WSABASEERR+ 42;
  {$EXTERNALSYM WSAEPROTONOSUPPORT}
  WSAEPROTONOSUPPORT      = WSABASEERR+ 43;
  {$EXTERNALSYM WSAESOCKTNOSUPPORT}
  WSAESOCKTNOSUPPORT      = WSABASEERR+ 44;
  {$EXTERNALSYM WSAEOPNOTSUPP}
  WSAEOPNOTSUPP           = WSABASEERR+ 45;
  {$EXTERNALSYM WSAEPFNOSUPPORT}
  WSAEPFNOSUPPORT         = WSABASEERR+ 46;
  {$EXTERNALSYM WSAEAFNOSUPPORT}
  WSAEAFNOSUPPORT         = WSABASEERR+ 47;
  {$EXTERNALSYM WSAEADDRINUSE}
  WSAEADDRINUSE           = WSABASEERR+ 48;
  {$EXTERNALSYM WSAEADDRNOTAVAIL}
  WSAEADDRNOTAVAIL        = WSABASEERR+ 49;
  {$EXTERNALSYM WSAENETDOWN}
  WSAENETDOWN             = WSABASEERR+ 50;
  {$EXTERNALSYM WSAENETUNREACH}
  WSAENETUNREACH          = WSABASEERR+ 51;
  {$EXTERNALSYM WSAENETRESET}
  WSAENETRESET            = WSABASEERR+ 52;
  {$EXTERNALSYM WSAECONNABORTED}
  WSAECONNABORTED         = WSABASEERR+ 53;
  {$EXTERNALSYM WSAECONNRESET}
  WSAECONNRESET           = WSABASEERR+ 54;
  {$EXTERNALSYM WSAENOBUFS}
  WSAENOBUFS              = WSABASEERR+ 55;
  {$EXTERNALSYM WSAEISCONN}
  WSAEISCONN              = WSABASEERR+ 56;
  {$EXTERNALSYM WSAENOTCONN}
  WSAENOTCONN             = WSABASEERR+ 57;
  {$EXTERNALSYM WSAESHUTDOWN}
  WSAESHUTDOWN            = WSABASEERR+ 58;
  {$EXTERNALSYM WSAETOOMANYREFS}
  WSAETOOMANYREFS         = WSABASEERR+ 59;
  {$EXTERNALSYM WSAETIMEDOUT}
  WSAETIMEDOUT            = WSABASEERR+ 60;
  {$EXTERNALSYM WSAECONNREFUSED}
  WSAECONNREFUSED         = WSABASEERR+ 61;
  {$EXTERNALSYM WSAELOOP}
  WSAELOOP                = WSABASEERR+ 62;
  {$EXTERNALSYM WSAENAMETOOLONG}
  WSAENAMETOOLONG         = WSABASEERR+ 63;
  {$EXTERNALSYM WSAEHOSTDOWN}
  WSAEHOSTDOWN            = WSABASEERR+ 64;
  {$EXTERNALSYM WSAEHOSTUNREACH}
  WSAEHOSTUNREACH         = WSABASEERR+ 65;
  {$EXTERNALSYM wsaenotempty}
  WSAENOTEMPTY            = WSABASEERR+ 66;
  {$EXTERNALSYM WSAEPROCLIM}
  WSAEPROCLIM             = WSABASEERR+ 67;
  {$EXTERNALSYM WSAEUSERS}
  WSAEUSERS               = WSABASEERR+ 68;
  {$EXTERNALSYM WSAEDQUOT}
  WSAEDQUOT               = WSABASEERR+ 69;
  {$EXTERNALSYM WSAESTALE}
  WSAESTALE               = WSABASEERR+ 70;
  {$EXTERNALSYM WSAEREMOTE}
  WSAEREMOTE              = WSABASEERR+ 71;

// Extended Windows Sockets error constant definitions

  {$EXTERNALSYM WSASYSNOTREADY}
  WSASYSNOTREADY          = WSABASEERR+ 91;
  {$EXTERNALSYM WSAVERNOTSUPPORTED}
  WSAVERNOTSUPPORTED      = WSABASEERR+ 92;
  {$EXTERNALSYM WSANOTINITIALISED}
  WSANOTINITIALISED       = WSABASEERR+ 93;
  {$EXTERNALSYM WSAEDISCON}
  WSAEDISCON              = WSABASEERR+101;
  {$EXTERNALSYM WSAENOMORE}
  WSAENOMORE              = WSABASEERR+102;
  {$EXTERNALSYM WSAECANCELLED}
  WSAECANCELLED           = WSABASEERR+103;
  {$EXTERNALSYM WSAEINVALIDPROCTABLE}
  WSAEINVALIDPROCTABLE    = WSABASEERR+104;
  {$EXTERNALSYM WSAEINVALIDPROVIDER}
  WSAEINVALIDPROVIDER     = WSABASEERR+105;
  {$EXTERNALSYM WSAEPROVIDERFAILEDINIT}
  WSAEPROVIDERFAILEDINIT  = WSABASEERR+106;
  {$EXTERNALSYM WSASYSCALLFAILURE}
  WSASYSCALLFAILURE       = WSABASEERR+107;
  {$EXTERNALSYM WSASERVICE_NOT_FOUND}
  WSASERVICE_NOT_FOUND    = WSABASEERR+108;
  {$EXTERNALSYM WSATYPE_NOT_FOUND}
  WSATYPE_NOT_FOUND       = WSABASEERR+109;
  {$EXTERNALSYM WSA_E_NO_MORE}
  WSA_E_NO_MORE           = WSABASEERR+110;
  {$EXTERNALSYM WSA_E_CANCELLED}
  WSA_E_CANCELLED         = WSABASEERR+111;
  {$EXTERNALSYM WSAEREFUSED}
  WSAEREFUSED             = WSABASEERR+112;


{ Error return codes from gethostbyname() and gethostbyaddr()
  (when using the resolver). Note that these errors are
  retrieved via WSAGetLastError() and must therefore follow
  the rules for avoiding clashes with error numbers from
  specific implementations or language run-time systems.
  For this reason the codes are based at WSABASEERR+1001.
  Note also that [WSA]NO_ADDRESS is defined only for
  compatibility purposes. }

// Authoritative Answer: Host not found
  {$EXTERNALSYM WSAHOST_NOT_FOUND}
  WSAHOST_NOT_FOUND        = WSABASEERR+1001;
  {$EXTERNALSYM HOST_NOT_FOUND}
  HOST_NOT_FOUND           = WSAHOST_NOT_FOUND;

// Non-Authoritative: Host not found, or SERVERFAIL
  {$EXTERNALSYM WSATRY_AGAIN}
  WSATRY_AGAIN             = WSABASEERR+1002;
  {$EXTERNALSYM TRY_AGAIN}
  TRY_AGAIN                = WSATRY_AGAIN;

// Non recoverable errors, FORMERR, REFUSED, NOTIMP
  {$EXTERNALSYM WSANO_RECOVERY}
  WSANO_RECOVERY           = WSABASEERR+1003;
  {$EXTERNALSYM NO_RECOVERY}
  NO_RECOVERY              = WSANO_RECOVERY;

// Valid name, no data record of requested type
  {$EXTERNALSYM WSANO_DATA}
  WSANO_DATA               = WSABASEERR+1004;
  {$EXTERNALSYM NO_DATA}
  NO_DATA                  = WSANO_DATA;

// no address, look for MX record
  {$EXTERNALSYM WSANO_ADDRESS}
  WSANO_ADDRESS            = WSANO_DATA;
  {$EXTERNALSYM NO_ADDRESS}
  NO_ADDRESS               = WSANO_ADDRESS;

// Define QOS related error return codes

  {$EXTERNALSYM WSA_QOS_RECEIVERS}
  WSA_QOS_RECEIVERS          = WSABASEERR+1005; // at least one reserve has arrived
  {$EXTERNALSYM WSA_QOS_SENDERS}
  WSA_QOS_SENDERS            = WSABASEERR+1006; // at least one path has arrived
  {$EXTERNALSYM WSA_QOS_NO_SENDERS}
  WSA_QOS_NO_SENDERS         = WSABASEERR+1007; // there are no senders
  {$EXTERNALSYM WSA_QOS_NO_RECEIVERS}
  WSA_QOS_NO_RECEIVERS       = WSABASEERR+1008; // there are no receivers
  {$EXTERNALSYM WSA_QOS_REQUEST_CONFIRMED}
  WSA_QOS_REQUEST_CONFIRMED  = WSABASEERR+1009; // reserve has been confirmed
  {$EXTERNALSYM WSA_QOS_ADMISSION_FAILURE}
  WSA_QOS_ADMISSION_FAILURE  = WSABASEERR+1010; // error due to lack of resources
  {$EXTERNALSYM WSA_QOS_POLICY_FAILURE}
  WSA_QOS_POLICY_FAILURE     = WSABASEERR+1011; // rejected for administrative reasons - bad credentials
  {$EXTERNALSYM WSA_QOS_BAD_STYLE}
  WSA_QOS_BAD_STYLE          = WSABASEERR+1012; // unknown or conflicting style
  {$EXTERNALSYM WSA_QOS_BAD_OBJECT}
  WSA_QOS_BAD_OBJECT         = WSABASEERR+1013; // problem with some part of the filterspec or providerspecific buffer in general
  {$EXTERNALSYM WSA_QOS_TRAFFIC_CTRL_ERROR}
  WSA_QOS_TRAFFIC_CTRL_ERROR = WSABASEERR+1014; // problem with some part of the flowspec
  {$EXTERNALSYM WSA_QOS_GENERIC_ERROR}
  WSA_QOS_GENERIC_ERROR      = WSABASEERR+1015; // general error
  {$EXTERNALSYM WSA_QOS_ESERVICETYPE}
  WSA_QOS_ESERVICETYPE       = WSABASEERR+1016; // invalid service type in flowspec
  {$EXTERNALSYM WSA_QOS_EFLOWSPEC}
  WSA_QOS_EFLOWSPEC          = WSABASEERR+1017; // invalid flowspec
  {$EXTERNALSYM WSA_QOS_EPROVSPECBUF}
  WSA_QOS_EPROVSPECBUF       = WSABASEERR+1018; // invalid provider specific buffer
  {$EXTERNALSYM WSA_QOS_EFILTERSTYLE}
  WSA_QOS_EFILTERSTYLE       = WSABASEERR+1019; // invalid filter style
  {$EXTERNALSYM WSA_QOS_EFILTERTYPE}
  WSA_QOS_EFILTERTYPE        = WSABASEERR+1020; // invalid filter type
  {$EXTERNALSYM WSA_QOS_EFILTERCOUNT}
  WSA_QOS_EFILTERCOUNT       = WSABASEERR+1021; // incorrect number of filters
  {$EXTERNALSYM WSA_QOS_EOBJLENGTH}
  WSA_QOS_EOBJLENGTH         = WSABASEERR+1022; // invalid object length
  {$EXTERNALSYM WSA_QOS_EFLOWCOUNT}
  WSA_QOS_EFLOWCOUNT         = WSABASEERR+1023; // incorrect number of flows
  {$EXTERNALSYM WSA_QOS_EUNKOWNPSOBJ}
  WSA_QOS_EUNKOWNPSOBJ       = WSABASEERR+1024; // unknown object in provider specific buffer
  {$EXTERNALSYM WSA_QOS_EPOLICYOBJ}
  WSA_QOS_EPOLICYOBJ         = WSABASEERR+1025; // invalid policy object in provider specific buffer
  {$EXTERNALSYM WSA_QOS_EFLOWDESC}
  WSA_QOS_EFLOWDESC          = WSABASEERR+1026; // invalid flow descriptor in the list
  {$EXTERNALSYM WSA_QOS_EPSFLOWSPEC}
  WSA_QOS_EPSFLOWSPEC        = WSABASEERR+1027; // inconsistent flow spec in provider specific buffer
  {$EXTERNALSYM WSA_QOS_EPSFILTERSPEC}
  WSA_QOS_EPSFILTERSPEC      = WSABASEERR+1028; // invalid filter spec in provider specific buffer
  {$EXTERNALSYM WSA_QOS_ESDMODEOBJ}
  WSA_QOS_ESDMODEOBJ         = WSABASEERR+1029; // invalid shape discard mode object in provider specific buffer
  {$EXTERNALSYM WSA_QOS_ESHAPERATEOBJ}
  WSA_QOS_ESHAPERATEOBJ      = WSABASEERR+1030; // invalid shaping rate object in provider specific buffer
  {$EXTERNALSYM WSA_QOS_RESERVED_PETYPE}
  WSA_QOS_RESERVED_PETYPE    = WSABASEERR+1031; // reserved policy element in provider specific buffer


{ WinSock 2 extension -- new error codes and type definition }
  {$EXTERNALSYM WSA_IO_PENDING}
  WSA_IO_PENDING          = ERROR_IO_PENDING;
  {$EXTERNALSYM WSA_IO_INCOMPLETE}
  WSA_IO_INCOMPLETE       = ERROR_IO_INCOMPLETE;
  {$EXTERNALSYM WSA_INVALID_HANDLE}
  WSA_INVALID_HANDLE      = ERROR_INVALID_HANDLE;
  {$EXTERNALSYM WSA_INVALID_PARAMETER}
  WSA_INVALID_PARAMETER   = ERROR_INVALID_PARAMETER;
  {$EXTERNALSYM WSA_NOT_ENOUGH_MEMORY}
  WSA_NOT_ENOUGH_MEMORY   = ERROR_NOT_ENOUGH_MEMORY;
  {$EXTERNALSYM WSA_OPERATION_ABORTED}
  WSA_OPERATION_ABORTED   = ERROR_OPERATION_ABORTED;
  {$EXTERNALSYM WSA_INVALID_EVENT}
  WSA_INVALID_EVENT       = WSAEVENT(nil);
  {$EXTERNALSYM WSA_MAXIMUM_WAIT_EVENTS}
  WSA_MAXIMUM_WAIT_EVENTS = MAXIMUM_WAIT_OBJECTS;
  {$EXTERNALSYM WSA_WAIT_FAILED}
  WSA_WAIT_FAILED         = $FFFFFFFF;
  {$EXTERNALSYM WSA_WAIT_EVENT_0}
  WSA_WAIT_EVENT_0        = WAIT_OBJECT_0;
  {$EXTERNALSYM WSA_WAIT_IO_COMPLETION}
  WSA_WAIT_IO_COMPLETION  = WAIT_IO_COMPLETION;
  {$EXTERNALSYM WSA_WAIT_TIMEOUT}
  WSA_WAIT_TIMEOUT        = WAIT_TIMEOUT;
  {$EXTERNALSYM WSA_INFINITE}
  WSA_INFINITE            = INFINITE;

{ Windows Sockets errors redefined as regular Berkeley error constants.
  These are commented out in Windows NT to avoid conflicts with errno.h.
  Use the WSA constants instead. }

  {$EXTERNALSYM EWOULDBLOCK}
  EWOULDBLOCK        =  WSAEWOULDBLOCK;
  {$EXTERNALSYM EINPROGRESS}
  EINPROGRESS        =  WSAEINPROGRESS;
  {$EXTERNALSYM EALREADY}
  EALREADY           =  WSAEALREADY;
  {$EXTERNALSYM ENOTSOCK}
  ENOTSOCK           =  WSAENOTSOCK;
  {$EXTERNALSYM EDESTADDRREQ}
  EDESTADDRREQ       =  WSAEDESTADDRREQ;
  {$EXTERNALSYM EMSGSIZE}
  EMSGSIZE           =  WSAEMSGSIZE;
  {$EXTERNALSYM EPROTOTYPE}
  EPROTOTYPE         =  WSAEPROTOTYPE;
  {$EXTERNALSYM ENOPROTOOPT}
  ENOPROTOOPT        =  WSAENOPROTOOPT;
  {$EXTERNALSYM EPROTONOSUPPORT}
  EPROTONOSUPPORT    =  WSAEPROTONOSUPPORT;
  {$EXTERNALSYM ESOCKTNOSUPPORT}
  ESOCKTNOSUPPORT    =  WSAESOCKTNOSUPPORT;
  {$EXTERNALSYM EOPNOTSUPP}
  EOPNOTSUPP         =  WSAEOPNOTSUPP;
  {$EXTERNALSYM EPFNOSUPPORT}
  EPFNOSUPPORT       =  WSAEPFNOSUPPORT;
  {$EXTERNALSYM EAFNOSUPPORT}
  EAFNOSUPPORT       =  WSAEAFNOSUPPORT;
  {$EXTERNALSYM EADDRINUSE}
  EADDRINUSE         =  WSAEADDRINUSE;
  {$EXTERNALSYM EADDRNOTAVAIL}
  EADDRNOTAVAIL      =  WSAEADDRNOTAVAIL;
  {$EXTERNALSYM ENETDOWN}
  ENETDOWN           =  WSAENETDOWN;
  {$EXTERNALSYM ENETUNREACH}
  ENETUNREACH        =  WSAENETUNREACH;
  {$EXTERNALSYM ENETRESET}
  ENETRESET          =  WSAENETRESET;
  {$EXTERNALSYM ECONNABORTED}
  ECONNABORTED       =  WSAECONNABORTED;
  {$EXTERNALSYM ECONNRESET}
  ECONNRESET         =  WSAECONNRESET;
  {$EXTERNALSYM ENOBUFS}
  ENOBUFS            =  WSAENOBUFS;
  {$EXTERNALSYM EISCONN}
  EISCONN            =  WSAEISCONN;
  {$EXTERNALSYM ENOTCONN}
  ENOTCONN           =  WSAENOTCONN;
  {$EXTERNALSYM ESHUTDOWN}
  ESHUTDOWN          =  WSAESHUTDOWN;
  {$EXTERNALSYM ETOOMANYREFS}
  ETOOMANYREFS       =  WSAETOOMANYREFS;
  {$EXTERNALSYM ETIMEDOUT}
  ETIMEDOUT          =  WSAETIMEDOUT;
  {$EXTERNALSYM ECONNREFUSED}
  ECONNREFUSED       =  WSAECONNREFUSED;
  {$EXTERNALSYM ELOOP}
  ELOOP              =  WSAELOOP;
  {$EXTERNALSYM ENAMETOOLONG}
  ENAMETOOLONG       =  WSAENAMETOOLONG;
  {$EXTERNALSYM EHOSTDOWN}
  EHOSTDOWN          =  WSAEHOSTDOWN;
  {$EXTERNALSYM EHOSTUNREACH}
  EHOSTUNREACH       =  WSAEHOSTUNREACH;
  {$EXTERNALSYM ENOTEMPTY}
  ENOTEMPTY          =  WSAENOTEMPTY;
  {$EXTERNALSYM EPROCLIM}
  EPROCLIM           =  WSAEPROCLIM;
  {$EXTERNALSYM EUSERS}
  EUSERS             =  WSAEUSERS;
  {$EXTERNALSYM EDQUOT}
  EDQUOT             =  WSAEDQUOT;
  {$EXTERNALSYM ESTALE}
  ESTALE             =  WSAESTALE;
  {$EXTERNALSYM EREMOTE}
  EREMOTE            =  WSAEREMOTE;

  {$EXTERNALSYM WSADESCRIPTION_LEN}
  WSADESCRIPTION_LEN     =   256;
  {$EXTERNALSYM WSASYS_STATUS_LEN}
  WSASYS_STATUS_LEN      =   128;

type
  {$EXTERNALSYM WSADATA}
  WSADATA = packed record
    wVersion       : Word;
    wHighVersion   : Word;
    {$IFDEF _WIN64}
    iMaxSockets    : Word;
    iMaxUdpDg      : Word;
    lpVendorInfo   : PChar;
    szDescription  : array[0..WSADESCRIPTION_LEN] of Char;
    szSystemStatus : array[0..WSASYS_STATUS_LEN] of Char;
    {$ELSE}
    szDescription  : array[0..WSADESCRIPTION_LEN] of Char;
    szSystemStatus : array[0..WSASYS_STATUS_LEN] of Char;
    iMaxSockets    : Word;
    iMaxUdpDg      : Word;
    lpVendorInfo   : PChar;
    {$ENDIF}
  end;
  TWSAData = WSADATA;
  PWSAData = ^TWSAData;
  {$EXTERNALSYM LPWSADATA}
  LPWSADATA = PWSAData;

  {$EXTERNALSYM WSAOVERLAPPED}
  WSAOVERLAPPED   = TOverlapped;
  TWSAOverlapped  = WSAOVERLAPPED;
  PWSAOverlapped  = ^TWSAOverlapped;
  {$EXTERNALSYM LPWSAOVERLAPPED}
  LPWSAOVERLAPPED = PWSAOverlapped;

  {$EXTERNALSYM WSC_PROVIDER_INFO_TYPE}
  {$EXTERNALSYM PROVIDERINFOLSPCATEGORIES}
  {$EXTERNALSYM PROVIDERINFOAUDIT}
  WSC_PROVIDER_INFO_TYPE = (ProviderInfoLspCategories, ProviderInfoAudit);

{ WinSock 2 extension -- WSABUF and QOS struct, include qos.h }
{ to pull in FLOWSPEC and related definitions }


  {$EXTERNALSYM WSABUF}
  WSABUF = packed record
    len: u_long;{ the length of the buffer }
    buf: PChar; { the pointer to the buffer }
  end;
  TWSABuf = WSABUF;
  PWSABuf = ^TWSABuf;
  {$EXTERNALSYM LPWSABUF}
  LPWSABUF = PWSABUF;

  {$EXTERNALSYM SERVICETYPE}
  SERVICETYPE = LongInt;
  TServiceType = SERVICETYPE;

  {$EXTERNALSYM FLOWSPEC}
  FLOWSPEC = packed record
    TokenRate,               // In Bytes/sec
    TokenBucketSize,         // In Bytes
    PeakBandwidth,           // In Bytes/sec
    Latency,                 // In microseconds
    DelayVariation : LongInt;// In microseconds
    ServiceType : TServiceType;
    MaxSduSize, MinimumPolicedSize : LongInt;// In Bytes
  end;
  TFlowSpec = FLOWSPEC;
  {$EXTERNALSYM PFLOWSPEC}
  PFLOWSPEC = ^TFlowSpec;
  {$EXTERNALSYM LPFLOWSPEC}
  LPFLOWSPEC = PFLOWSPEC;

  {$EXTERNALSYM QOS}
  QOS = packed record
    SendingFlowspec: TFlowSpec; { the flow spec for data sending }
    ReceivingFlowspec: TFlowSpec; { the flow spec for data receiving }
    ProviderSpecific: TWSABuf; { additional provider specific stuff }
  end;
  TQualityOfService = QOS;
  PQOS = ^QOS;
  {$EXTERNALSYM LPQOS}
  LPQOS = PQOS;

const
  {$EXTERNALSYM SERVICETYPE_NOTRAFFIC}
  SERVICETYPE_NOTRAFFIC             =  $00000000;  // No data in this direction
  {$EXTERNALSYM SERVICETYPE_BESTEFFORT}
  SERVICETYPE_BESTEFFORT            =  $00000001;  // Best Effort
  {$EXTERNALSYM SERVICETYPE_CONTROLLEDLOAD}
  SERVICETYPE_CONTROLLEDLOAD        =  $00000002;  // Controlled Load
  {$EXTERNALSYM SERVICETYPE_GUARANTEED}
  SERVICETYPE_GUARANTEED            =  $00000003;  // Guaranteed
  {$EXTERNALSYM SERVICETYPE_NETWORK_UNAVAILABLE}
  SERVICETYPE_NETWORK_UNAVAILABLE   =  $00000004;  // Used to notify change to user
  {$EXTERNALSYM SERVICETYPE_GENERAL_INFORMATION}
  SERVICETYPE_GENERAL_INFORMATION   =  $00000005;  // corresponds to "General Parameters" defined by IntServ
  {$EXTERNALSYM SERVICETYPE_NOCHANGE}
  SERVICETYPE_NOCHANGE              =  $00000006;  // used to indicate that the flow spec contains no change from any previous one
// to turn on immediate traffic control, OR this flag with the ServiceType field in the FLOWSPEC
  {$EXTERNALSYM SERVICE_IMMEDIATE_TRAFFIC_CONTROL}
  SERVICE_IMMEDIATE_TRAFFIC_CONTROL =  $80000000;

//  WinSock 2 extension -- manifest constants for return values of the condition function
  {$EXTERNALSYM CF_ACCEPT}
  CF_ACCEPT = $0000;
  {$EXTERNALSYM CF_REJECT}
  CF_REJECT = $0001;
  {$EXTERNALSYM CF_DEFER}
  CF_DEFER  = $0002;

//  WinSock 2 extension -- manifest constants for shutdown()
  {$EXTERNALSYM SD_RECEIVE}
  SD_RECEIVE = $00;
  {$EXTERNALSYM SD_SEND}
  SD_SEND    = $01;
  {$EXTERNALSYM SD_BOTH}
  SD_BOTH    = $02;

//  WinSock 2 extension -- data type and manifest constants for socket groups
  {$EXTERNALSYM SG_UNCONSTRAINED_GROUP}
  SG_UNCONSTRAINED_GROUP = $01;
  {$EXTERNALSYM SG_CONSTRAINED_GROUP}
  SG_CONSTRAINED_GROUP   = $02;

type
  {$EXTERNALSYM GROUP}
  GROUP = DWORD;

//  WinSock 2 extension -- data type for WSAEnumNetworkEvents()
  {$EXTERNALSYM WSANETWORKEVENTS}
  WSANETWORKEVENTS = record
    lNetworkEvents: LongInt;
    iErrorCode: Array[0..FD_MAX_EVENTS-1] of Integer;
  end;
  TWSANetworkEvents = WSANETWORKEVENTS;
  PWSANetworkEvents = ^TWSANetworkEvents;
  {$EXTERNALSYM LPWSANETWORKEVENTS}
  LPWSANETWORKEVENTS = PWSANetworkEvents;

//TransmitFile types used for the TransmitFile API function in WinNT/2000/XP
{$IFNDEF UNDER_CE}
  {$IFNDEF NOREDECLARE}
  {$EXTERNALSYM TRANSMIT_FILE_BUFFERS}
  TRANSMIT_FILE_BUFFERS = record
      Head: Pointer;
      HeadLength: DWORD;
      Tail: Pointer;
      TailLength: DWORD;
  end;
  TTransmitFileBuffers = TRANSMIT_FILE_BUFFERS;
  PTransmitFileBuffers = ^TTransmitFileBuffers;
  {$ENDIF}
  {$EXTERNALSYM LPTRANSMIT_FILE_BUFFERS}
  LPTRANSMIT_FILE_BUFFERS = PTransmitFileBuffers;
{$ENDIF}

const
  {$EXTERNALSYM TP_ELEMENT_MEMORY}
  TP_ELEMENT_MEMORY   = 1;
  {$EXTERNALSYM TP_ELEMENT_FILE}
  TP_ELEMENT_FILE     = 2;
  {$EXTERNALSYM TP_ELEMENT_EOP}
  TP_ELEMENT_EOP      = 4;

  {$EXTERNALSYM TP_DISCONNECT}
  TP_DISCONNECT       = TF_DISCONNECT;
  {$EXTERNALSYM TP_REUSE_SOCKET}
  TP_REUSE_SOCKET     = TF_REUSE_SOCKET;
  {$EXTERNALSYM TP_USE_DEFAULT_WORKER}
  TP_USE_DEFAULT_WORKER = TF_USE_DEFAULT_WORKER;
  {$EXTERNALSYM TP_USE_SYSTEM_THREAD}
   TP_USE_SYSTEM_THREAD = TF_USE_SYSTEM_THREAD;
  {$EXTERNALSYM TP_USE_KERNEL_APC}
  TP_USE_KERNEL_APC     = TF_USE_KERNEL_APC;

type
  {$EXTERNALSYM TRANSMIT_PACKETS_ELEMENT}
  TRANSMIT_PACKETS_ELEMENT = record
    dwElFlags: ULONG;
    cLength: ULONG;
    case Integer of
      1: (nFileOffset: TLargeInteger;
          hFile: THandle);
      2: (pBuffer: Pointer);
  end;
  {$NODEFINE TTransmitPacketsElement}
  TTransmitPacketsElement = TRANSMIT_PACKETS_ELEMENT;
  {$NODEFINE PTransmitPacketsElement}
  PTransmitPacketsElement = ^TTransmitPacketsElement;
  {$NODEFINE LPTransmitPacketsElement}
  LPTransmitPacketsElement = PTransmitPacketsElement;

  {$EXTERNALSYM PTRANSMIT_PACKETS_ELEMENT}
  PTRANSMIT_PACKETS_ELEMENT = ^TTransmitPacketsElement;
  {$EXTERNALSYM LPTRANSMIT_PACKETS_ELEMENT}
  LPTRANSMIT_PACKETS_ELEMENT = PTRANSMIT_PACKETS_ELEMENT;

//  WinSock 2 extension -- WSAPROTOCOL_INFO structure

{$IFNDEF NOREDECLARE}
  {$IFNDEF VER130}
  PGUID = ^TGUID;
  {$ENDIF}
  {$EXTERNALSYM LPGUID}
  LPGUID = PGUID;
{$ENDIF}

//  WinSock 2 extension -- WSAPROTOCOL_INFO manifest constants
const
  {$EXTERNALSYM MAX_PROTOCOL_CHAIN}
  MAX_PROTOCOL_CHAIN = 7;
  {$EXTERNALSYM BASE_PROTOCOL}
  BASE_PROTOCOL      = 1;
  {$EXTERNALSYM LAYERED_PROTOCOL}
  LAYERED_PROTOCOL   = 0;
  {$EXTERNALSYM WSAPROTOCOL_LEN}
  WSAPROTOCOL_LEN    = 255;

type
  {$EXTERNALSYM WSAPROTOCOLCHAIN}
  WSAPROTOCOLCHAIN = record
    ChainLen: Integer;  // the length of the chain,
    // length = 0 means layered protocol,
    // length = 1 means base protocol,
    // length > 1 means protocol chain
    ChainEntries: Array[0..MAX_PROTOCOL_CHAIN-1] of LongInt; // a list of dwCatalogEntryIds
  end;
  TWSAProtocolChain = WSAPROTOCOLCHAIN;
  {$EXTERNALSYM LPWSAPROTOCOLCHAIN}
  LPWSAPROTOCOLCHAIN = ^TWSAProtocolChain;

type
  {$EXTERNALSYM WSAPROTOCOL_INFOA}
  WSAPROTOCOL_INFOA = record
    dwServiceFlags1: DWORD;
    dwServiceFlags2: DWORD;
    dwServiceFlags3: DWORD;
    dwServiceFlags4: DWORD;
    dwProviderFlags: DWORD;
    ProviderId: TGUID;
    dwCatalogEntryId: DWORD;
    ProtocolChain: TWSAProtocolChain;
    iVersion: Integer;
    iAddressFamily: Integer;
    iMaxSockAddr: Integer;
    iMinSockAddr: Integer;
    iSocketType: Integer;
    iProtocol: Integer;
    iProtocolMaxOffset: Integer;
    iNetworkByteOrder: Integer;
    iSecurityScheme: Integer;
    dwMessageSize: DWORD;
    dwProviderReserved: DWORD;
    szProtocol: Array[0..WSAPROTOCOL_LEN+1-1] of Char;
  end;
  TWSAProtocol_InfoA = WSAPROTOCOL_INFOA;
  PWSAProtocol_InfoA = ^WSAPROTOCOL_INFOA;
  {$EXTERNALSYM LPWSAPROTOCOL_INFOA}
  LPWSAPROTOCOL_INFOA = PWSAProtocol_InfoA;

  {$EXTERNALSYM WSAPROTOCOL_INFOW}
  WSAPROTOCOL_INFOW = record
    dwServiceFlags1: DWORD;
    dwServiceFlags2: DWORD;
    dwServiceFlags3: DWORD;
    dwServiceFlags4: DWORD;
    dwProviderFlags: DWORD;
    ProviderId: TGUID;
    dwCatalogEntryId: DWORD;
    ProtocolChain: TWSAProtocolChain;
    iVersion: Integer;
    iAddressFamily: Integer;
    iMaxSockAddr: Integer;
    iMinSockAddr: Integer;
    iSocketType: Integer;
    iProtocol: Integer;
    iProtocolMaxOffset: Integer;
    iNetworkByteOrder: Integer;
    iSecurityScheme: Integer;
    dwMessageSize: DWORD;
    dwProviderReserved: DWORD;
    szProtocol: Array[0..WSAPROTOCOL_LEN+1-1] of WideChar;
  end;
  TWSAProtocol_InfoW = WSAPROTOCOL_INFOW;
  PWSAProtocol_InfoW = ^TWSAProtocol_InfoW;
  {$EXTERNALSYM LPWSAPROTOCOL_INFOW}
  LPWSAPROTOCOL_INFOW = PWSAProtocol_InfoW;

  {$EXTERNALSYM WSAPROTOCOL_INFO}
  {$EXTERNALSYM LPWSAPROTOCOL_INFO}
  {$IFDEF UNICODE}
  WSAPROTOCOL_INFO = TWSAProtocol_InfoW;
  TWSAProtocol_Info = TWSAProtocol_InfoW;
  PWSAProtocol_Info = PWSAProtocol_InfoW;
  LPWSAPROTOCOL_INFO = PWSAProtocol_InfoW;
  {$ELSE}
  WSAPROTOCOL_INFO = TWSAProtocol_InfoA;
  TWSAProtocol_Info = TWSAProtocol_InfoA;
  PWSAProtocol_Info = PWSAProtocol_InfoA;
  LPWSAPROTOCOL_INFO = PWSAProtocol_InfoA;
  {$ENDIF}

const
//  flag bit definitions for dwProviderFlags
  {$EXTERNALSYM PFL_MULTIPLE_PROTO_ENTRIES}
  PFL_MULTIPLE_PROTO_ENTRIES   = $00000001;
  {$EXTERNALSYM PFL_RECOMMENTED_PROTO_ENTRY}
  PFL_RECOMMENTED_PROTO_ENTRY  = $00000002;
  {$EXTERNALSYM PFL_HIDDEN}
  PFL_HIDDEN                   = $00000004;
  {$EXTERNALSYM PFL_MATCHES_PROTOCOL_ZERO}
  PFL_MATCHES_PROTOCOL_ZERO    = $00000008;

//  flag bit definitions for dwServiceFlags1
  {$EXTERNALSYM XP1_CONNECTIONLESS}
  XP1_CONNECTIONLESS           = $00000001;
  {$EXTERNALSYM XP1_GUARANTEED_DELIVERY}
  XP1_GUARANTEED_DELIVERY      = $00000002;
  {$EXTERNALSYM XP1_GUARANTEED_ORDER}
  XP1_GUARANTEED_ORDER         = $00000004;
  {$EXTERNALSYM XP1_MESSAGE_ORIENTED}
  XP1_MESSAGE_ORIENTED         = $00000008;
  {$EXTERNALSYM XP1_PSEUDO_STREAM}
  XP1_PSEUDO_STREAM            = $00000010;
  {$EXTERNALSYM XP1_GRACEFUL_CLOSE}
  XP1_GRACEFUL_CLOSE           = $00000020;
  {$EXTERNALSYM XP1_EXPEDITED_DATA}
  XP1_EXPEDITED_DATA           = $00000040;
  {$EXTERNALSYM XP1_CONNECT_DATA}
  XP1_CONNECT_DATA             = $00000080;
  {$EXTERNALSYM XP1_DISCONNECT_DATA}
  XP1_DISCONNECT_DATA          = $00000100;
  {$EXTERNALSYM XP1_SUPPORT_BROADCAST}
  XP1_SUPPORT_BROADCAST        = $00000200;
  {$EXTERNALSYM XP1_SUPPORT_MULTIPOINT}
  XP1_SUPPORT_MULTIPOINT       = $00000400;
  {$EXTERNALSYM XP1_MULTIPOINT_CONTROL_PLANE}
  XP1_MULTIPOINT_CONTROL_PLANE = $00000800;
  {$EXTERNALSYM XP1_MULTIPOINT_DATA_PLANE}
  XP1_MULTIPOINT_DATA_PLANE    = $00001000;
  {$EXTERNALSYM XP1_QOS_SUPPORTED}
  XP1_QOS_SUPPORTED            = $00002000;
  {$EXTERNALSYM XP1_INTERRUPT}
  XP1_INTERRUPT                = $00004000;
  {$EXTERNALSYM XP1_UNI_SEND}
  XP1_UNI_SEND                 = $00008000;
  {$EXTERNALSYM XP1_UNI_RECV}
  XP1_UNI_RECV                 = $00010000;
  {$EXTERNALSYM XP1_IFS_HANDLES}
  XP1_IFS_HANDLES              = $00020000;
  {$EXTERNALSYM XP1_PARTIAL_MESSAGE}
  XP1_PARTIAL_MESSAGE          = $00040000;

  {$EXTERNALSYM BIGENDIAN}
  BIGENDIAN    = $0000;
  {$EXTERNALSYM LITTLEENDIAN}
  LITTLEENDIAN = $0001;

  {$EXTERNALSYM SECURITY_PROTOCOL_NONE}
  SECURITY_PROTOCOL_NONE = $0000;

//  WinSock 2 extension -- manifest constants for WSAJoinLeaf()
  {$EXTERNALSYM JL_SENDER_ONLY}
  JL_SENDER_ONLY   = $01;
  {$EXTERNALSYM JL_RECEIVER_ONLY}
  JL_RECEIVER_ONLY = $02;
  {$EXTERNALSYM JL_BOTH}
  JL_BOTH          = $04;

//  WinSock 2 extension -- manifest constants for WSASocket()
  {$EXTERNALSYM WSA_FLAG_OVERLAPPED}
  WSA_FLAG_OVERLAPPED        = $01;
  {$EXTERNALSYM WSA_FLAG_MULTIPOINT_C_ROOT}
  WSA_FLAG_MULTIPOINT_C_ROOT = $02;
  {$EXTERNALSYM WSA_FLAG_MULTIPOINT_C_LEAF}
  WSA_FLAG_MULTIPOINT_C_LEAF = $04;
  {$EXTERNALSYM WSA_FLAG_MULTIPOINT_D_ROOT}
  WSA_FLAG_MULTIPOINT_D_ROOT = $08;
  {$EXTERNALSYM WSA_FLAG_MULTIPOINT_D_LEAF}
  WSA_FLAG_MULTIPOINT_D_LEAF = $10;

//  WinSock 2 extension -- manifest constants for WSAIoctl()
  {$EXTERNALSYM IOC_UNIX}
  IOC_UNIX      = $00000000;
  {$EXTERNALSYM IOC_WS2}
  IOC_WS2       = $08000000;
  {$EXTERNALSYM IOC_PROTOCOL}
  IOC_PROTOCOL  = $10000000;
  {$EXTERNALSYM IOC_VENDOR}
  IOC_VENDOR    = $18000000;

  {$EXTERNALSYM SIO_ASSOCIATE_HANDLE}
  SIO_ASSOCIATE_HANDLE                =  DWORD(IOC_IN or IOC_WS2 or 1);
  {$EXTERNALSYM SIO_ENABLE_CIRCULAR_QUEUEING}
  SIO_ENABLE_CIRCULAR_QUEUEING        =  DWORD(IOC_VOID or IOC_WS2 or 2);
  {$EXTERNALSYM SIO_FIND_ROUTE}
  SIO_FIND_ROUTE                      =  DWORD(IOC_OUT or IOC_WS2 or 3);
  {$EXTERNALSYM SIO_FLUSH}
  SIO_FLUSH                           =  DWORD(IOC_VOID or IOC_WS2 or 4);
  {$EXTERNALSYM SIO_GET_BROADCAST_ADDRESS}
  SIO_GET_BROADCAST_ADDRESS           =  DWORD(IOC_OUT or IOC_WS2 or 5);
  {$EXTERNALSYM SIO_GET_EXTENSION_FUNCTION_POINTER}
  SIO_GET_EXTENSION_FUNCTION_POINTER  =  DWORD(IOC_INOUT or IOC_WS2 or 6);
  {$EXTERNALSYM SIO_GET_QOS}
  SIO_GET_QOS                         =  DWORD(IOC_INOUT or IOC_WS2 or 7);
  {$EXTERNALSYM SIO_GET_GROUP_QOS}
  SIO_GET_GROUP_QOS                   =  DWORD(IOC_INOUT or IOC_WS2 or 8);
  {$EXTERNALSYM SIO_MULTIPOINT_LOOPBACK}
  SIO_MULTIPOINT_LOOPBACK             =  DWORD(IOC_IN or IOC_WS2 or 9);
  {$EXTERNALSYM SIO_MULTICAST_SCOPE}
  SIO_MULTICAST_SCOPE                 = DWORD(IOC_IN or IOC_WS2 or 10);
  {$EXTERNALSYM SIO_SET_QOS}
  SIO_SET_QOS                         = DWORD(IOC_IN or IOC_WS2 or 11);
  {$EXTERNALSYM SIO_SET_GROUP_QOS}
  SIO_SET_GROUP_QOS                   = DWORD(IOC_IN or IOC_WS2 or 12);
  {$EXTERNALSYM SIO_TRANSLATE_HANDLE}
  SIO_TRANSLATE_HANDLE                = DWORD(IOC_INOUT or IOC_WS2 or 13);
  {$EXTERNALSYM SIO_ROUTING_INTERFACE_QUERY}
  SIO_ROUTING_INTERFACE_QUERY         = DWORD(IOC_INOUT or IOC_WS2 or 20);
  {$EXTERNALSYM SIO_ROUTING_INTERFACE_CHANGE}
  SIO_ROUTING_INTERFACE_CHANGE        = DWORD(IOC_IN or IOC_WS2 or 21);
  {$EXTERNALSYM SIO_ADDRESS_LIST_QUERY}
  SIO_ADDRESS_LIST_QUERY              = DWORD(IOC_OUT or IOC_WS2 or 22); // see below SOCKET_ADDRESS_LIST
  {$EXTERNALSYM SIO_ADDRESS_LIST_CHANGE}
  SIO_ADDRESS_LIST_CHANGE             = DWORD(IOC_VOID or IOC_WS2 or 23);
  {$EXTERNALSYM SIO_QUERY_TARGET_PNP_HANDLE}
  SIO_QUERY_TARGET_PNP_HANDLE         = DWORD(IOC_OUT or IOC_WS2 or 24);
  {$EXTERNALSYM SIO_ADDRESS_LIST_SORT}
  SIO_ADDRESS_LIST_SORT               = DWORD(IOC_INOUT or IOC_WS2 or 25);

//  WinSock 2 extension -- manifest constants for SIO_TRANSLATE_HANDLE ioctl
  {$EXTERNALSYM TH_NETDEV}
  TH_NETDEV = $00000001;
  {$EXTERNALSYM TH_TAPI}
  TH_TAPI   = $00000002;

type
//  Manifest constants and type definitions related to name resolution and
//  registration (RNR) API
  {$IFNDEF NOREDECLARE}
  {$EXTERNALSYM BLOB}
  BLOB = packed record
    cbSize : U_LONG;
    pBlobData : PBYTE;
  end;
  TBLOB = BLOB;
  PBLOB = ^TBLOB;
  {$ENDIF}
  {$EXTERNALSYM LPBLOB}
  LPBLOB = PBLOB;

//  Service Install Flags

const
  {$EXTERNALSYM SERVICE_MULTIPLE}
  SERVICE_MULTIPLE = $00000001;

// & name spaces
  {$EXTERNALSYM NS_ALL}
  NS_ALL         =  0;

  {$EXTERNALSYM NS_SAP}
  NS_SAP         =  1;
  {$EXTERNALSYM NS_NDS}
  NS_NDS         =  2;
  {$EXTERNALSYM NS_PEER_BROWSE}
  NS_PEER_BROWSE =  3;
  {$EXTERNALSYM NS_SLP}
  NS_SLP         =  5;
  {$EXTERNALSYM NS_DHCP}
  NS_DHCP        =  6;

  {$EXTERNALSYM NS_TCPIP_LOCAL}
  NS_TCPIP_LOCAL = 10;
  {$EXTERNALSYM NS_TCPIP_HOSTS}
  NS_TCPIP_HOSTS = 11;
  {$EXTERNALSYM NS_DNS}
  NS_DNS         = 12;
  {$EXTERNALSYM NS_NETBT}
  NS_NETBT       = 13;
  {$EXTERNALSYM NS_WINS}
  NS_WINS        = 14;
  {$EXTERNALSYM NS_NLA}
  NS_NLA         = 15;  //* Network Location Awareness*/ - WindowsXP
  {$EXTERNALSYM NS_BTH}
  NS_BTH         = 16;  //* Bluetooth SDP Namespace */ - Windows Vista

  {$EXTERNALSYM NS_NBP}
  NS_NBP         = 20;

  {$EXTERNALSYM NS_MS}
  NS_MS          = 30;
  {$EXTERNALSYM NS_STDA}
  NS_STDA        = 31;
  {$EXTERNALSYM NS_NTDS}
  NS_NTDS        = 32;

  //Windows Vista namespaces
  {$EXTERNALSYM NS_EMAIL}
  NS_EMAIL      = 37;
  {$EXTERNALSYM NS_PNRPNAME}
  NS_PNRPNAME   = 38;
  {$EXTERNALSYM NS_PNRPCLOUD}
  NS_PNRPCLOUD   = 39;
  //

  {$EXTERNALSYM NS_X500}
  NS_X500        = 40;
  {$EXTERNALSYM NS_NIS}
  NS_NIS         = 41;
  {$EXTERNALSYM NS_NISPLUS}
  NS_NISPLUS     = 42;

  {$EXTERNALSYM NS_WRQ}
  NS_WRQ         = 50;

  {$EXTERNALSYM NS_NETDES}
  NS_NETDES      = 60;  // Network Designers Limited

{ Resolution flags for WSAGetAddressByName().
  Note these are also used by the 1.1 API GetAddressByName, so leave them around. }
  {$EXTERNALSYM RES_UNUSED_1}
  RES_UNUSED_1    = $00000001;
  {$EXTERNALSYM RES_FLUSH_CACHE}
  RES_FLUSH_CACHE = $00000002;
  {$EXTERNALSYM RES_SERVICE}
  RES_SERVICE     = $00000004;

{ Well known value names for Service Types }
  {$EXTERNALSYM SERVICE_TYPE_VALUE_IPXPORTA}
  SERVICE_TYPE_VALUE_IPXPORTA              = 'IpxSocket';    {Do not Localize}
  {$EXTERNALSYM SERVICE_TYPE_VALUE_SAPIDA}
  SERVICE_TYPE_VALUE_SAPIDA                = 'SapId';    {Do not Localize}
  {$EXTERNALSYM SERVICE_TYPE_VALUE_TCPPORTA}
  SERVICE_TYPE_VALUE_TCPPORTA              = 'TcpPort';    {Do not Localize}
  {$EXTERNALSYM SERVICE_TYPE_VALUE_UDPPORTA}
  SERVICE_TYPE_VALUE_UDPPORTA              = 'UdpPort';    {Do not Localize}
  {$EXTERNALSYM SERVICE_TYPE_VALUE_OBJECTIDA}
  SERVICE_TYPE_VALUE_OBJECTIDA             = 'ObjectId';    {Do not Localize}

  {$EXTERNALSYM SERVICE_TYPE_VALUE_IPXPORTW}
  SERVICE_TYPE_VALUE_IPXPORTW : PWideChar  = 'IpxSocket';    {Do not Localize}
  {$EXTERNALSYM SERVICE_TYPE_VALUE_SAPIDW}
  SERVICE_TYPE_VALUE_SAPIDW : PWideChar    = 'SapId';    {Do not Localize}
  {$EXTERNALSYM SERVICE_TYPE_VALUE_TCPPORTW}
  SERVICE_TYPE_VALUE_TCPPORTW : PWideChar  = 'TcpPort';    {Do not Localize}
  {$EXTERNALSYM SERVICE_TYPE_VALUE_UDPPORTW}
  SERVICE_TYPE_VALUE_UDPPORTW : PWideChar  = 'UdpPort';    {Do not Localize}
  {$EXTERNALSYM SERVICE_TYPE_VALUE_OBJECTIDW}
  SERVICE_TYPE_VALUE_OBJECTIDW : PWideChar = 'ObjectId';    {Do not Localize}

  {$EXTERNALSYM SERVICE_TYPE_VALUE_SAPID}
  {$EXTERNALSYM SERVICE_TYPE_VALUE_TCPPORT}
  {$EXTERNALSYM SERVICE_TYPE_VALUE_UDPPORT}
  {$EXTERNALSYM SERVICE_TYPE_VALUE_OBJECTID}
  {$IFDEF UNICODE}
  SERVICE_TYPE_VALUE_SAPID : PWideChar = 'SapId';         {Do not Localize}
  SERVICE_TYPE_VALUE_TCPPORT : PWideChar = 'TcpPort';     {Do not Localize}
  SERVICE_TYPE_VALUE_UDPPORT : PWideChar = 'UdpPort';     {Do not Localize}
  SERVICE_TYPE_VALUE_OBJECTID : PWideChar = 'ObjectId';   {Do not Localize}
  {$ELSE}
  SERVICE_TYPE_VALUE_SAPID    = SERVICE_TYPE_VALUE_SAPIDA;
  SERVICE_TYPE_VALUE_TCPPORT  = SERVICE_TYPE_VALUE_TCPPORTA;
  SERVICE_TYPE_VALUE_UDPPORT  = SERVICE_TYPE_VALUE_UDPPORTA;
  SERVICE_TYPE_VALUE_OBJECTID = SERVICE_TYPE_VALUE_OBJECTIDA;
  {$ENDIF}

// SockAddr Information
type
  {$EXTERNALSYM SOCKET_ADDRESS}
  SOCKET_ADDRESS = packed record
    lpSockaddr : PSOCKADDR;
    iSockaddrLength : Integer;
  end;
  TSocket_Address = SOCKET_ADDRESS;
  {$EXTERNALSYM PSOCKET_ADDRESS}
  PSOCKET_ADDRESS = ^TSocket_Address;

  {$EXTERNALSYM SOCKET_ADDRESS_LIST}
  SOCKET_ADDRESS_LIST = packed record
    iAddressCount : Integer;
    Address : SOCKET_ADDRESS;
  end;
  TSocket_Address_List = SOCKET_ADDRESS_LIST;
  {$EXTERNALSYM PSOCKET_ADDRESS_LIST}
  PSOCKET_ADDRESS_LIST = ^TSocket_Address_List;
  {$EXTERNALSYM LPSOCKET_ADDRESS_LIST}
  LPSOCKET_ADDRESS_LIST = PSOCKET_ADDRESS_LIST;

// CSAddr Information
  {$EXTERNALSYM CSADDR_INFO}
  CSADDR_INFO = packed record
    LocalAddr,
    RemoteAddr : TSocket_Address;
    iSocketType,
    iProtocol : Integer;
  end;
  TCSAddr_Info = CSADDR_INFO;
  {$EXTERNALSYM PCSADDR_INFO}
  PCSADDR_INFO = ^TCSAddr_Info;
  {$EXTERNALSYM LPCSADDR_INFO}
  LPCSADDR_INFO = PCSADDR_INFO;

// Address Family/Protocol Tuples
  {$EXTERNALSYM AFPROTOCOLS}
  AFPROTOCOLS = record
    iAddressFamily : Integer;
    iProtocol      : Integer;
  end;
  TAFProtocols = AFPROTOCOLS;
  {$EXTERNALSYM PAFPROTOCOLS}
  PAFPROTOCOLS = ^TAFProtocols;
  {$EXTERNALSYM LPAFPROTOCOLS}
  LPAFPROTOCOLS = PAFPROTOCOLS;

//  Client Query API Typedefs

// The comparators
  {$EXTERNALSYM WSAECOMPARATOR}
  WSAECOMPARATOR = (COMP_EQUAL {= 0}, COMP_NOTLESS);
  TWSAEComparator = WSAECOMPARATOR;
  {$EXTERNALSYM PWSAECOMPARATOR}
  PWSAECOMPARATOR = ^WSAECOMPARATOR;

  {$EXTERNALSYM WSAVERSION}
  WSAVERSION = record
    dwVersion : DWORD;
    ecHow     : TWSAEComparator;
  end;
  TWSAVersion = WSAVERSION;
  {$EXTERNALSYM PWSAVERSION}
  PWSAVERSION = ^TWSAVersion;
  {$EXTERNALSYM LPWSAVERSION}
  LPWSAVERSION = PWSAVERSION;

  {$EXTERNALSYM WSAQUERYSETA}
  WSAQUERYSETA = packed record
    dwSize                  : DWORD;
    lpszServiceInstanceName : PChar;
    lpServiceClassId        : PGUID;
    lpVersion               : LPWSAVERSION;
    lpszComment             : PChar;
    dwNameSpace             : DWORD;
    lpNSProviderId          : PGUID;
    lpszContext             : PChar;
    dwNumberOfProtocols     : DWORD;
    lpafpProtocols          : LPAFPROTOCOLS;
    lpszQueryString         : PChar;
    dwNumberOfCsAddrs       : DWORD;
    lpcsaBuffer             : LPCSADDR_INFO;
    dwOutputFlags           : DWORD;
    lpBlob                  : LPBLOB;
  end;
  TWSAQuerySetA = WSAQUERYSETA;
  {$EXTERNALSYM PWSAQUERYSETA}
  PWSAQUERYSETA = ^TWSAQuerySetA;
  {$EXTERNALSYM LPWSAQUERYSETA}
  LPWSAQUERYSETA = PWSAQUERYSETA;

  {$EXTERNALSYM WSAQUERYSETW}
  WSAQUERYSETW = packed record
    dwSize                  : DWORD;
    lpszServiceInstanceName : PWideChar;
    lpServiceClassId        : PGUID;
    lpVersion               : LPWSAVERSION;
    lpszComment             : PWideChar;
    dwNameSpace             : DWORD;
    lpNSProviderId          : PGUID;
    lpszContext             : PWideChar;
    dwNumberOfProtocols     : DWORD;
    lpafpProtocols          : LPAFPROTOCOLS;
    lpszQueryString         : PWideChar;
    dwNumberOfCsAddrs       : DWORD;
    lpcsaBuffer             : LPCSADDR_INFO;
    dwOutputFlags           : DWORD;
    lpBlob                  : LPBLOB;
  end;
  TWSAQuerySetW = WSAQUERYSETW;
  {$EXTERNALSYM PWSAQUERYSETW}
  PWSAQUERYSETW = ^TWSAQuerySetW;
  {$EXTERNALSYM LPWSAQUERYSETW}
  LPWSAQUERYSETW = PWSAQUERYSETW;

  {$EXTERNALSYM LPWSAQUERYSET}
  {$EXTERNALSYM PWSAQUERYSET}
  {$IFDEF UNICODE}
  TWSAQuerySet  = TWSAQuerySetA;
  PWSAQUERYSET  = PWSAQUERYSETW;
  LPWSAQUERYSET = LPWSAQUERYSETW;
  {$ELSE}
  TWSAQuerySet  = TWSAQuerySetA;
  PWSAQUERYSET  = PWSAQUERYSETA;
  LPWSAQUERYSET = LPWSAQUERYSETA;
  {$ENDIF}

const
  {$EXTERNALSYM LUP_DEEP}
  LUP_DEEP                = $0001;
  {$EXTERNALSYM LUP_CONTAINERS}
  LUP_CONTAINERS          = $0002;
  {$EXTERNALSYM LUP_NOCONTAINERS}
  LUP_NOCONTAINERS        = $0004;
  {$EXTERNALSYM LUP_NEAREST}
  LUP_NEAREST             = $0008;
  {$EXTERNALSYM LUP_RETURN_NAME}
  LUP_RETURN_NAME         = $0010;
  {$EXTERNALSYM LUP_RETURN_TYPE}
  LUP_RETURN_TYPE         = $0020;
  {$EXTERNALSYM LUP_RETURN_VERSION}
  LUP_RETURN_VERSION      = $0040;
  {$EXTERNALSYM LUP_RETURN_COMMENT}
  LUP_RETURN_COMMENT      = $0080;
  {$EXTERNALSYM LUP_RETURN_ADDR}
  LUP_RETURN_ADDR         = $0100;
  {$EXTERNALSYM LUP_RETURN_BLOB}
  LUP_RETURN_BLOB         = $0200;
  {$EXTERNALSYM LUP_RETURN_ALIASES}
  LUP_RETURN_ALIASES      = $0400;
  {$EXTERNALSYM LUP_RETURN_QUERY_STRING}
  LUP_RETURN_QUERY_STRING = $0800;
  {$EXTERNALSYM LUP_RETURN_ALL}
  LUP_RETURN_ALL          = $0FF0;
  {$EXTERNALSYM LUP_RES_SERVICE}
  LUP_RES_SERVICE         = $8000;

  {$EXTERNALSYM LUP_FLUSHCACHE}
  LUP_FLUSHCACHE          = $1000;
  {$EXTERNALSYM LUP_FLUSHPREVIOUS}
  LUP_FLUSHPREVIOUS       = $2000;

// Return flags
  {$EXTERNALSYM RESULT_IS_ALIAS}
  RESULT_IS_ALIAS         = $0001;
  {$EXTERNALSYM RESULT_IS_ADDED}
  RESULT_IS_ADDED         = $0010;
  {$EXTERNALSYM RESULT_IS_CHANGED}
  RESULT_IS_CHANGED       = $0020;
  {$EXTERNALSYM RESULT_IS_DELETED}
  RESULT_IS_DELETED       = $0040;

  {$EXTERNALSYM MAX_NATURAL_ALIGNMENT}
  {$IFDEF _WIN64}
  MAX_NATURAL_ALIGNMENT   = SizeOf(Int64);
  {$ELSE}
  MAX_NATURAL_ALIGNMENT   = SizeOf(DWORD);
  {$ENDIF}

// WSARecvMsg flags
  {$EXTERNALSYM MSG_TRUNC}
  MSG_TRUNC     =  $0100;
  {$EXTERNALSYM MSG_CTRUNC}
  MSG_CTRUNC    =  $0200;
  {$EXTERNALSYM MSG_BCAST}
  MSG_BCAST     =  $0400;
  {$EXTERNALSYM MSG_MCAST}
  MSG_MCAST     =  $0800;

  //Windows Vista WSAPoll
//* Event flag definitions for WSAPoll(). */
  {$EXTERNALSYM POLLRDNORM}
  POLLRDNORM  = $0100;
  {$EXTERNALSYM POLLRDBAND}
  POLLRDBAND  = $0200;
  {$EXTERNALSYM POLLIN}
  POLLIN      = (POLLRDNORM or POLLRDBAND);
  {$EXTERNALSYM POLLPRI}
  POLLPRI     = $0400;
  {$EXTERNALSYM POLLWRNORM}
  POLLWRNORM  = $0010;
  {$EXTERNALSYM POLLOUT}
  POLLOUT     = (POLLWRNORM);
  {$EXTERNALSYM POLLWRBAND}
  POLLWRBAND  = $0020;
  {$EXTERNALSYM POLLERR}
  POLLERR     = $0001;
  {$EXTERNALSYM POLLHUP}
  POLLHUP     = $0002;
  {$EXTERNALSYM POLLNVAL}
  POLLNVAL    = $0004;

type
// Service Address Registration and Deregistration Data Types.
  {$EXTERNALSYM WSAESETSERVICEOP}
  WSAESETSERVICEOP = (RNRSERVICE_REGISTER{=0}, RNRSERVICE_DEREGISTER, RNRSERVICE_DELETE);
  TWSAESetServiceOp = WSAESETSERVICEOP;

{ Service Installation/Removal Data Types. }
  {$EXTERNALSYM WSANSCLASSINFOA}
  WSANSCLASSINFOA = packed record
    lpszName    : PChar;
    dwNameSpace : DWORD;
    dwValueType : DWORD;
    dwValueSize : DWORD;
    lpValue     : Pointer;
  end;
  TWSANSClassInfoA = WSANSCLASSINFOA;
  {$EXTERNALSYM PWSANSClassInfoA}
  PWSANSCLASSINFOA = ^TWSANSClassInfoA;
  {$EXTERNALSYM LPWSANSCLASSINFOA}
  LPWSANSCLASSINFOA = PWSANSCLASSINFOA;

  {$EXTERNALSYM WSANSCLASSINFOW}
  WSANSCLASSINFOW = packed record
    lpszName    : PWideChar;
    dwNameSpace : DWORD;
    dwValueType : DWORD;
    dwValueSize : DWORD;
    lpValue     : Pointer;
  end {TWSANSClassInfoW};
  TWSANSClassInfoW = WSANSCLASSINFOW;
  {$EXTERNALSYM PWSANSClassInfoW}
  PWSANSCLASSINFOW = ^TWSANSClassInfoW;
  {$EXTERNALSYM LPWSANSCLASSINFOW}
  LPWSANSCLASSINFOW = PWSANSCLASSINFOW;

  {$EXTERNALSYM WSANSCLASSINFO}
  {$EXTERNALSYM PWSANSCLASSINFO}
  {$EXTERNALSYM LPWSANSCLASSINFO}
  {$IFDEF UNICODE}
  TWSANSClassInfo  = TWSANSClassInfoW;
  WSANSCLASSINFO   = TWSANSClassInfoW;
  PWSANSCLASSINFO  = PWSANSCLASSINFOW;
  LPWSANSCLASSINFO = LPWSANSCLASSINFOW;
  {$ELSE}
  TWSANSClassInfo  = TWSANSClassInfoA;
  WSANSCLASSINFO   = TWSANSClassInfoA;
  PWSANSCLASSINFO  = PWSANSCLASSINFOA;
  LPWSANSCLASSINFO = LPWSANSCLASSINFOA;
  {$ENDIF // UNICODE}

  {$EXTERNALSYM WSASERVICECLASSINFOA}
  WSASERVICECLASSINFOA = packed record
    lpServiceClassId     : PGUID;
    lpszServiceClassName : PChar;
    dwCount              : DWORD;
    lpClassInfos         : LPWSANSCLASSINFOA;
  end;
  TWSAServiceClassInfoA = WSASERVICECLASSINFOA;
  {$EXTERNALSYM PWSASERVICECLASSINFOA}
  PWSASERVICECLASSINFOA  = ^TWSAServiceClassInfoA;
  {$EXTERNALSYM LPWSASERVICECLASSINFOA}
  LPWSASERVICECLASSINFOA = PWSASERVICECLASSINFOA;

  {$EXTERNALSYM WSASERVICECLASSINFOW}
  WSASERVICECLASSINFOW = packed record
    lpServiceClassId     : PGUID;
    lpszServiceClassName : PWideChar;
    dwCount              : DWORD;
    lpClassInfos         : LPWSANSCLASSINFOW;
  end;
  TWSAServiceClassInfoW = WSASERVICECLASSINFOW;
  {$EXTERNALSYM PWSASERVICECLASSINFOW}
  PWSASERVICECLASSINFOW  = ^TWSAServiceClassInfoW;
  {$EXTERNALSYM LPWSASERVICECLASSINFOW}
  LPWSASERVICECLASSINFOW = PWSASERVICECLASSINFOW;

  {$EXTERNALSYM WSASERVICECLASSINFO}
  {$EXTERNALSYM PWSASERVICECLASSINFO}
  {$EXTERNALSYM LPWSASERVICECLASSINFO}
  {$IFDEF UNICODE}
  TWSAServiceClassInfo  = TWSAServiceClassInfoW;
  WSASERVICECLASSINFO   = TWSAServiceClassInfoW;
  PWSASERVICECLASSINFO  = PWSASERVICECLASSINFOW;
  LPWSASERVICECLASSINFO = LPWSASERVICECLASSINFOW;
  {$ELSE}
  TWSAServiceClassInfo  = TWSAServiceClassInfoA;
  WSASERVICECLASSINFO   = TWSAServiceClassInfoA;
  PWSASERVICECLASSINFO  = PWSASERVICECLASSINFOA;
  LPWSASERVICECLASSINFO = LPWSASERVICECLASSINFOA;
  {$ENDIF}

  {$EXTERNALSYM WSANAMESPACE_INFOA}
  WSANAMESPACE_INFOA = packed record
    NSProviderId   : TGUID;
    dwNameSpace    : DWORD;
    fActive        : DWORD{Bool};
    dwVersion      : DWORD;
    lpszIdentifier : PChar;
  end;
  TWSANameSpace_InfoA = WSANAMESPACE_INFOA;
  {$EXTERNALSYM PWSANAMESPACE_INFOA}
  PWSANAMESPACE_INFOA = ^TWSANameSpace_InfoA;
  {$EXTERNALSYM LPWSANAMESPACE_INFOA}
  LPWSANAMESPACE_INFOA = PWSANAMESPACE_INFOA;

  {$EXTERNALSYM WSANAMESPACE_INFOW}
  WSANAMESPACE_INFOW = packed record
    NSProviderId   : TGUID;
    dwNameSpace    : DWORD;
    fActive        : DWORD{Bool};
    dwVersion      : DWORD;
    lpszIdentifier : PWideChar;
  end {TWSANameSpace_InfoW};
  TWSANameSpace_InfoW = WSANAMESPACE_INFOW;
  {$EXTERNALSYM PWSANAMESPACE_INFOW}
  PWSANAMESPACE_INFOW = ^TWSANameSpace_InfoW;
  {$EXTERNALSYM LPWSANAMESPACE_INFOW}
  LPWSANAMESPACE_INFOW = PWSANAMESPACE_INFOW;

{$IFNDEF UNDER_CE}
  {$EXTERNALSYM WSANAMESPACE_INFOEXW}
  WSANAMESPACE_INFOEXW = packed record
     NSProviderId : TGUID;
     dwNameSpace : DWord;
     fActive : LongBool;
     lpszIdentifier : LPWSTR;
     ProviderSpecific : BLOB;
  end;
  TWSANameSpace_InfoExW = WSANAMESPACE_INFOEXW;
  {$EXTERNALSYM WSANAMESPACE_INFOEXW}
  PWSANAMESPACE_INFOEXW = ^TWSANameSpace_InfoExW;
  {$EXTERNALSYM LPWSANAMESPACE_INFOEXW}
  LPWSANAMESPACE_INFOEXW = PWSANAMESPACE_INFOEXW;

  {$EXTERNALSYM WSANAMESPACE_INFOEXA}
  WSANAMESPACE_INFOEXA = packed record
     NSProviderId : TGUID;
     dwNameSpace : DWord;
     fActive : LongBool;
     lpszIdentifier : LPSTR;
     ProviderSpecific : BLOB;
  end;
  TWSANameSpace_InfoExA = WSANAMESPACE_INFOEXA;
  {$EXTERNALSYM WSANAMESPACE_INFOEXW}
  PWSANAMESPACE_INFOEXA = ^TWSANameSpace_InfoExA;
  {$EXTERNALSYM LPWSANAMESPACE_INFOEXW}
  LPWSANAMESPACE_INFOEXA = PWSANAMESPACE_INFOEXA;

  {$EXTERNALSYM LPFN_WSAENUMNAMESPACEPROVIDERSEXW}
  LPFN_WSAENUMNAMESPACEPROVIDERSEXW = function (var lpdwBufferLength : DWord;
    lpnspBuffer : PWSANAMESPACE_INFOEXW): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAENUMNAMESPACEPROVIDERSEXA}
  LPFN_WSAENUMNAMESPACEPROVIDERSEXA = function (var lpdwBufferLength : DWord;
    lpnspBuffer : PWSANAMESPACE_INFOEXA): Integer; stdcall;
  {$EXTERNALSYM WSANAMESPACE_INFOEX}
  {$EXTERNALSYM PWSANAMESPACE_INFOEX}
  {$EXTERNALSYM LPWSANAMESPACE_INFOEX}
  {$EXTERNALSYM LPFN_WSAENUMNAMESPACEPROVIDERSEX}

  {$IFDEF UNICODE}
  WSANAMESPACE_INFOEX = WSANAMESPACE_INFOEXW;
  TWSANameSpace_InfoEx = TWSANameSpace_InfoExW;
  PWSANAMESPACE_INFOEX = PWSANAMESPACE_INFOEXW;
  LPWSANAMESPACE_INFOEX = PWSANAMESPACE_INFOEX;
  LPFN_WSAENUMNAMESPACEPROVIDERSEX = LPFN_WSAENUMNAMESPACEPROVIDERSEXW;
  {$ELSE}
  WSANAMESPACE_INFOEX = WSANAMESPACE_INFOEXW;
  TWSANameSpace_InfoEx = TWSANameSpace_InfoExW;
  PWSANAMESPACE_INFOEX = PWSANAMESPACE_INFOEXW;
  LPWSANAMESPACE_INFOEX = PWSANAMESPACE_INFOEX;
  LPFN_WSAENUMNAMESPACEPROVIDERSEX = LPFN_WSAENUMNAMESPACEPROVIDERSEXA;
  {$ENDIF}
{$ENDIF} // UNDER_CE

  {$EXTERNALSYM WSANAMESPACE_INFO}
  {$EXTERNALSYM PWSANAMESPACE_INFO}
  {$EXTERNALSYM LPWSANAMESPACE_INFO}
  {$IFDEF UNICODE}
  TWSANameSpace_Info  = TWSANameSpace_InfoW;
  WSANAMESPACE_INFO   = TWSANameSpace_InfoW;
  PWSANAMESPACE_INFO  = PWSANAMESPACE_INFOW;
  LPWSANAMESPACE_INFO = LPWSANAMESPACE_INFOW;
  {$ELSE}
  TWSANameSpace_Info  = TWSANameSpace_InfoA;
  WSANAMESPACE_INFO   = TWSANameSpace_InfoA;
  PWSANAMESPACE_INFO  = PWSANAMESPACE_INFOA;
  LPWSANAMESPACE_INFO = LPWSANAMESPACE_INFOA;
  {$ENDIF}

  {$EXTERNALSYM WSAMSG}
  WSAMSG = packed record
    name : PSOCKADDR;  ///* Remote address */
    namelen : Integer; ///* Remote address length *
    lpBuffers : LPWSABUF;  //  /* Data buffer array */
    dwBufferCount : DWord; //  /* Number of elements in the array */
    Control : WSABUF;  //  /* Control buffer */
    dwFlags : DWord; //  /* Flags */
  end;
  TWSAMSG = WSAMSG;
  {$EXTERNALSYM PWSAMSG}
  PWSAMSG = ^TWSAMSG;
  {$EXTERNALSYM LPWSAMSG}
  LPWSAMSG = PWSAMSG;

  {$EXTERNALSYM WSACMSGHDR}
  WSACMSGHDR = packed record
    cmsg_len: UINT;
    cmsg_level: Integer;
    cmsg_type: Integer;
    { followed by UCHAR cmsg_data[] }
  end;
  TWSACMsgHdr = WSACMSGHDR;
  {$EXTERNALSYM PWSACMSGHDR}
  PWSACMSGHDR = ^TWSACMsgHdr;
  {$EXTERNALSYM LPWSACMSGHDR}
  LPWSACMSGHDR = PWSACMSGHDR;

  {$EXTERNALSYM WSAPOLLFD}
  WSAPOLLFD = packed record
    fd : TSocket;
    events : SHORT;
    revents : SHORT;
  end;
  TWSAPOLLFD = WSAPOLLFD;
  {$EXTERNALSYM PWSAPOLLFD}
  PWSAPOLLFD = ^TWSAPOLLFD;
  {$EXTERNALSYM LPWSAPOLLFD}
  LPWSAPOLLFD = PWSAPOLLFD;
  
{ WinSock 2 extensions -- data types for the condition function in }
{ WSAAccept() and overlapped I/O completion routine. }
type
  {$EXTERNALSYM LPCONDITIONPROC}
  LPCONDITIONPROC = function(lpCallerId: LPWSABUF; lpCallerData: LPWSABUF; lpSQOS, pGQOS: LPQOS;
    lpCalleeId,lpCalleeData: LPWSABUF; g: GROUP; dwCallbackData: DWORD): Integer; stdcall;
  {$EXTERNALSYM LPWSAOVERLAPPED_COMPLETION_ROUTINE}
  LPWSAOVERLAPPED_COMPLETION_ROUTINE = procedure(const dwError, cbTransferred: DWORD;
    const lpOverlapped : LPWSAOVERLAPPED; const dwFlags: DWORD); stdcall;

type
{$IFDEF INCL_WINSOCK_API_TYPEDEFS}
  {$EXTERNALSYM LPFN_WSASTARTUP}
  LPFN_WSASTARTUP = function(const wVersionRequired: WORD; out WSData: TWSAData): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSACLEANUP}
  LPFN_WSACLEANUP = function: Integer; stdcall;
  {$EXTERNALSYM LPFN_ACCEPT}
  LPFN_ACCEPT = function(const s: TSocket; addr: PSOCKADDR; addrlen: PInteger): TSocket; stdcall;
  {$EXTERNALSYM LPFN_BIND}
  LPFN_BIND = function(const s: TSocket; const name: PSOCKADDR; const namelen: Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_CLOSESOCKET}
  LPFN_CLOSESOCKET = function(const s: TSocket): Integer; stdcall;
  {$EXTERNALSYM LPFN_CONNECT}
  LPFN_CONNECT = function(const s: TSocket; const name: PSOCKADDR; const namelen: Integer): Integer; stdcall;
  {$EXTERNALSYM lpfn_IOCTLSOCKET}
  LPFN_IOCTLSOCKET = function(const s: TSocket; const cmd: DWORD; var arg: u_long): Integer; stdcall;
  {$EXTERNALSYM LPFN_GETPEERNAME}
  LPFN_GETPEERNAME = function(const s: TSocket; const name: PSOCKADDR; var namelen: Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_GETSOCKNAME}
  LPFN_GETSOCKNAME = function(const s: TSocket; const name: PSOCKADDR; var namelen: Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_GETSOCKOPT}
  LPFN_GETSOCKOPT = function(const s: TSocket; const level, optname: Integer; optval: PChar; var optlen: Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_HTONL}
  LPFN_HTONL = function(hostlong: u_long): u_long; stdcall;
  {$EXTERNALSYM LPFN_HTONS}
  LPFN_HTONS = function(hostshort: u_short): u_short; stdcall;
  {$EXTERNALSYM LPFN_INET_ADDR}
  LPFN_INET_ADDR = function(cp: PChar): u_long; stdcall;
  {$EXTERNALSYM LPFN_INET_NTOA}
  LPFN_INET_NTOA = function(inaddr: TInAddr): PChar; stdcall;
  {$EXTERNALSYM LPFN_LISTEN}
  LPFN_LISTEN = function(const s: TSocket; backlog: Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_NTOHL}
  LPFN_NTOHL = function(netlong: u_long): u_long; stdcall;
  {$EXTERNALSYM LPFN_NTOHS}
  LPFN_NTOHS = function(netshort: u_short): u_short; stdcall;
  {$EXTERNALSYM LPFN_RECV}
  LPFN_RECV = function(const s: TSocket; var Buf; len, flags: Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_RECVFROM}
  LPFN_RECVFROM = function(const s: TSocket; var Buf; len, flags: Integer; from: PSOCKADDR; fromlen: PInteger): Integer; stdcall;
  {$EXTERNALSYM LPFN_SELECT}
  LPFN_SELECT = function(nfds: Integer; readfds, writefds, exceptfds: PFDSet; timeout: PTimeVal): Integer; stdcall;
  {$EXTERNALSYM LPFN_SEND}
  LPFN_SEND = function(const s: TSocket; const Buf; len, flags: Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_SENDTO}
  LPFN_SENDTO = function(const s: TSocket; const Buf; const len, flags: Integer; const addrto: PSOCKADDR; const tolen: Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_SETSOCKOPT}
  LPFN_SETSOCKOPT = function(const s: TSocket; const level, optname: Integer; optval: PChar; const optlen: Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_SHUTDOWN}
  LPFN_SHUTDOWN = function(const s: TSocket; const how: Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_SOCKET}
  LPFN_SOCKET = function(const af, istruct, protocol: Integer): TSocket; stdcall;
  {$EXTERNALSYM LPFN_GETHOSTBYADDR}
  LPFN_GETHOSTBYADDR = function(addr: Pointer; const len, addrtype: Integer): PHostEnt; stdcall;
  {$EXTERNALSYM LPFN_GETHOSTBYNAME}
  LPFN_GETHOSTBYNAME = function(name: PChar): PHostEnt; stdcall;
  {$EXTERNALSYM LPFN_GETHOSTNAME}
  LPFN_GETHOSTNAME = function(name: PChar; len: Integer): Integer; stdcall;
{$IFDEF UNDER_CE}
  // WinCE specific for setting the host name
  {$EXTERNALSYM LPFN_SETHOSTNAME} 
  LPFN_SETHOSTNAME = function(pName : PChar; len : Integer) : Integer; stdcall;
{$ENDIF}
  {$EXTERNALSYM LPFN_GETSERVBYPORT}
  LPFN_GETSERVBYPORT = function(const port: Integer; const proto: PChar): PServEnt; stdcall;
  {$EXTERNALSYM LPFN_GETSERVBYNAME}
  LPFN_GETSERVBYNAME = function(const name, proto: PChar): PServEnt; stdcall;
  {$EXTERNALSYM LPFN_GETPROTOBYNUMBER}
  LPFN_GETPROTOBYNUMBER = function(const proto: Integer): PProtoEnt; stdcall;
  {$EXTERNALSYM LPFN_GETPROTOBYNAME}
  LPFN_GETPROTOBYNAME = function(const name: PChar): PProtoEnt; stdcall;
  {$EXTERNALSYM LPFN_WSASETLASTERROR}
  LPFN_WSASETLASTERROR = procedure(const iError: Integer); stdcall;
  {$EXTERNALSYM LPFN_WSAGETLASTERROR}
  LPFN_WSAGETLASTERROR = function: Integer; stdcall;
{$IFNDEF UNDER_CE}
  {$EXTERNALSYM LPFN_WSAISBLOCKING}
  LPFN_WSAISBLOCKING = function: BOOL; stdcall;
  {$EXTERNALSYM LPFN_WSAUNHOOKBLOCKINGHOOK}
  LPFN_WSAUNHOOKBLOCKINGHOOK = function: Integer; stdcall;
  {$EXTERNALSYM LPFN_WSASETBLOCKINGHOOK}
  LPFN_WSASETBLOCKINGHOOK = function(lpBlockFunc: TFarProc): TFarProc; stdcall;
  {$EXTERNALSYM LPFN_WSACANCELBLOCKINGCALL}
  LPFN_WSACANCELBLOCKINGCALL = function: Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAASYNCGETSERVBYNAME}
  LPFN_WSAASYNCGETSERVBYNAME = function(HWindow: HWND; wMsg: u_int; name, proto, buf: PChar; buflen: Integer): THandle; stdcall;
  {$EXTERNALSYM LPFN_WSAASYNCGETSERVBYPORT}
  LPFN_WSAASYNCGETSERVBYPORT = function(HWindow: HWND; wMsg, port: u_int; proto, buf: PChar; buflen: Integer): THandle; stdcall;
  {$EXTERNALSYM LPFN_WSAASYNCGETPROTOBYNAME}
  LPFN_WSAASYNCGETPROTOBYNAME = function(HWindow: HWND; wMsg: u_int; name, buf: PChar; buflen: Integer): THandle; stdcall;
  {$EXTERNALSYM LPFN_WSAASYNCGETPROTOBYNUMBER}
  LPFN_WSAASYNCGETPROTOBYNUMBER = function(HWindow: HWND; wMsg: u_int; number: Integer; buf: PChar; buflen: Integer): THandle; stdcall;
  {$EXTERNALSYM LPFN_WSAASYNCGETHOSTBYNAME}
  LPFN_WSAASYNCGETHOSTBYNAME = function(HWindow: HWND; wMsg: u_int; name, buf: PChar; buflen: Integer): THandle; stdcall;
  {$EXTERNALSYM LPFN_WSAASYNCGETHOSTBYADDR}
  LPFN_WSAASYNCGETHOSTBYADDR = function(HWindow: HWND; wMsg: u_int; addr: PChar; len, istruct: Integer; buf: PChar; buflen: Integer): THandle; stdcall;
{$ENDIF} 
  {$EXTERNALSYM LPFN_WSACANCELASYNCREQUEST}
  LPFN_WSACANCELASYNCREQUEST = function(hAsyncTaskHandle: THandle): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAASYNCSELECT}
  LPFN_WSAASYNCSELECT = function(const s: TSocket; HWindow: HWND; wMsg: u_int; lEvent: Longint): Integer; stdcall;
  {$EXTERNALSYM LPFN___WSAFDISSET}
  LPFN___WSAFDISSET = function(const s: TSocket; var FDSet: TFDSet): Bool; stdcall;

// WinSock 2 API new function prototypes
  {$EXTERNALSYM LPFN_WSAACCEPT}
  LPFN_WSAACCEPT = function(const s : TSocket; addr : PSOCKADDR; addrlen : PInteger; lpfnCondition : LPCONDITIONPROC; const dwCallbackData : DWORD): TSocket; stdcall;
  {$EXTERNALSYM LPFN_WSAENUMPROTOCOLSA}
  LPFN_WSAENUMPROTOCOLSA = function(lpiProtocols : PInteger; lpProtocolBuffer : LPWSAPROTOCOL_INFOA; var lpdwBufferLength : DWORD) : Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAENUMPROTOCOLSW}
  LPFN_WSAENUMPROTOCOLSW = function(lpiProtocols : PInteger; lpProtocolBuffer : LPWSAPROTOCOL_INFOW; var lpdwBufferLength : DWORD) : Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAGETOVERLAPPEDRESULT}
  LPFN_WSAGETOVERLAPPEDRESULT = function(const s : TSocket; AOverlapped: Pointer; lpcbTransfer : LPDWORD; fWait : BOOL; var lpdwFlags : DWORD) : WordBool; stdcall;
  {$EXTERNALSYM LPFN_WSAIOCTL}
  LPFN_WSAIOCTL = function(const s : TSocket; dwIoControlCode : DWORD; lpvInBuffer : Pointer; cbInBuffer : DWORD; lpvOutBuffer : Pointer; cbOutBuffer : DWORD;
    lpcbBytesReturned : LPDWORD; AOverlapped: Pointer; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE) : LongInt; stdcall;
  {$EXTERNALSYM LPFN_WSARECVFROM}
  LPFN_WSARECVFROM = function(const s : TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; var lpNumberOfBytesRecvd : DWORD; var lpFlags : DWORD;
    lpFrom : PSOCKADDR; lpFromlen : PInteger; AOverlapped: Pointer; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE): Integer; stdcall;
{$IFNDEF UNDER_CE} 
  {$EXTERNALSYM LPFN_TRANSMITFILE}
  LPFN_TRANSMITFILE = function(hSocket: TSocket; hFile: THandle; nNumberOfBytesToWrite, nNumberOfBytesPerSend: DWORD;
    lpOverlapped: POverlapped; lpTransmitBuffers: LPTRANSMIT_FILE_BUFFERS; dwReserved: DWORD): BOOL; stdcall;
  {$EXTERNALSYM LPFN_ACCEPTEX}
  LPFN_ACCEPTEX = function(sListenSocket, sAcceptSocket: TSocket;
    lpOutputBuffer: Pointer; dwReceiveDataLength, dwLocalAddressLength,
    dwRemoteAddressLength: DWORD; var lpdwBytesReceived: DWORD;
    lpOverlapped: POverlapped): BOOL; stdcall;
  {$EXTERNALSYM LPFN_WSACONNECTBYLIST}
  LPFN_WSACONNECTBYLIST = function(const s : TSocket; SocketAddressList : PSOCKET_ADDRESS_LIST;
    var LocalAddressLength : DWORD;  LocalAddress : LPSOCKADDR;
    var RemoteAddressLength : DWORD; RemoteAddress : LPSOCKADDR;
    timeout : Ptimeval; Reserved : LPWSAOVERLAPPED):LongBool; stdcall;
  {$EXTERNALSYM LPFN_WSACONNECTBYNAMEA}
  LPFN_WSACONNECTBYNAMEA = function(const s : TSOCKET;
    nodename : PChar; servicename : PChar;
    var LocalAddressLength : DWORD; LocalAddress : LPSOCKADDR;
    var RemoteAddressLength : DWORD; RemoteAddress : LPSOCKADDR;
    timeout : Ptimeval;  Reserved : LPWSAOVERLAPPED) : Integer; stdcall;
  {$EXTERNALSYM LPFN_WSACONNECTBYNAMEW}
  LPFN_WSACONNECTBYNAMEW = function(const s : TSOCKET;
    nodename : PWChar; servicename : PWChar;
    var LocalAddressLength : DWORD; LocalAddress : LPSOCKADDR;
    var RemoteAddressLength : DWORD; RemoteAddress : LPSOCKADDR;
    timeout : Ptimeval;  Reserved : LPWSAOVERLAPPED) : Integer; stdcall;
  {$EXTERNALSYM LPFN_WSACONNECTBYNAME}
  {$IFDEF UNICODE}
  LPFN_WSACONNECTBYNAME = LPFN_WSACONNECTBYNAMEW;
  {$ELSE}
  LPFN_WSACONNECTBYNAME = LPFN_WSACONNECTBYNAMEA;
  {$ENDIF}
{$ENDIF}

  {$EXTERNALSYM LPFN_WSAENUMPROTOCOLS}
  {$IFDEF UNICODE}
  LPFN_WSAENUMPROTOCOLS = LPFN_WSAENUMPROTOCOLSW;
  {$ELSE}
  LPFN_WSAENUMPROTOCOLS = LPFN_WSAENUMPROTOCOLSA;
  {$ENDIF}

  {$EXTERNALSYM LPFN_WSACLOSEEVENT}
  LPFN_WSACLOSEEVENT = function(const hEvent : WSAEVENT) : WordBool; stdcall;
  {$EXTERNALSYM LPFN_WSACONNECT}
  LPFN_WSACONNECT = function(const s : TSocket; const name : PSOCKADDR; const namelen : Integer; lpCallerData, lpCalleeData : LPWSABUF; lpSQOS, lpGQOS : LPQOS) : Integer; stdcall;

  {$EXTERNALSYM LPFN_WSACREATEEVENT}
  LPFN_WSACREATEEVENT  = function: WSAEVENT; stdcall;

  {$EXTERNALSYM LPFN_WSADUPLICATESOCKETA}
  LPFN_WSADUPLICATESOCKETA = function(const s : TSocket; const dwProcessId : DWORD; lpProtocolInfo : LPWSAPROTOCOL_INFOA) : Integer; stdcall;
  {$EXTERNALSYM LPFN_WSADUPLICATESOCKETW}
  LPFN_WSADUPLICATESOCKETW = function(const s : TSocket; const dwProcessId : DWORD; lpProtocolInfo : LPWSAPROTOCOL_INFOW) : Integer; stdcall;
  {$EXTERNALSYM LPFN_WSADUPLICATESOCKET}
  {$IFDEF UNICODE}
  LPFN_WSADUPLICATESOCKET = LPFN_WSADUPLICATESOCKETW;
  {$ELSE}
  LPFN_WSADUPLICATESOCKET = LPFN_WSADUPLICATESOCKETA;
  {$ENDIF}

  {$EXTERNALSYM LPFN_WSAENUMNETWORKEVENTS}
  LPFN_WSAENUMNETWORKEVENTS = function(const s : TSocket; const hEventObject : WSAEVENT; lpNetworkEvents : LPWSANETWORKEVENTS) :Integer; stdcall;

  {$EXTERNALSYM LPFN_WSAEVENTSELECT}
  LPFN_WSAEVENTSELECT = function(const s : TSocket; const hEventObject : WSAEVENT; lNetworkEvents : LongInt): Integer; stdcall;

  {$EXTERNALSYM LPFN_WSAGETQOSBYNAME}
  LPFN_WSAGETQOSBYNAME = function(const s : TSocket; lpQOSName : LPWSABUF; lpQOS : LPQOS): WordBool; stdcall;

  {$EXTERNALSYM LPFN_WSAHTONL}
  LPFN_WSAHTONL = function(const s : TSocket; hostlong : u_long; var lpnetlong : DWORD): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAHTONS}
  LPFN_WSAHTONS = function(const s : TSocket; hostshort : u_short; var lpnetshort : WORD): Integer; stdcall;

  {$EXTERNALSYM LPFN_WSAJOINLEAF}
  LPFN_WSAJOINLEAF = function(const s : TSocket; name : PSOCKADDR; namelen : Integer; lpCallerData, lpCalleeData : LPWSABUF;
      lpSQOS,lpGQOS : LPQOS; dwFlags : DWORD) : TSocket; stdcall;

  {$EXTERNALSYM LPFN_WSANTOHL}
  LPFN_WSANTOHL = function(const s : TSocket; netlong : u_long; var lphostlong : DWORD): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSANTOHS}
  LPFN_WSANTOHS = function(const s : TSocket; netshort : u_short; var lphostshort : WORD): Integer; stdcall;

  {$EXTERNALSYM LPFN_WSARECV}
  LPFN_WSARECV = function(const s : TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; var lpNumberOfBytesRecvd : DWORD; var lpFlags : DWORD;
    lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSARECVDISCONNECT}
  LPFN_WSARECVDISCONNECT = function(const s : TSocket; lpInboundDisconnectData : LPWSABUF): Integer; stdcall;

  {$EXTERNALSYM LPFN_WSARESETEVENT}
  LPFN_WSARESETEVENT = function(hEvent : WSAEVENT): WordBool; stdcall;

  {$EXTERNALSYM LPFN_WSASEND}
  LPFN_WSASEND = function(const s : TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; var lpNumberOfBytesSent : DWORD; dwFlags : DWORD;
    lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSASENDDISCONNECT}
  LPFN_WSASENDDISCONNECT = function(const s : TSocket; lpOutboundDisconnectData : LPWSABUF): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSASENDTO}
  LPFN_WSASENDTO = function(const s : TSocket; lpBuffers : LPWSABUF; dwBufferCount : DWORD; var lpNumberOfBytesSent : DWORD; dwFlags : DWORD;
    lpTo : LPSOCKADDR; iTolen : Integer; lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE): Integer; stdcall;

  {$EXTERNALSYM LPFN_WSASETEVENT}
  LPFN_WSASETEVENT = function(hEvent : WSAEVENT): WordBool; stdcall;

  {$EXTERNALSYM LPFN_WSASOCKETA}
  LPFN_WSASOCKETA = function(af, iType, protocol : Integer; lpProtocolInfo : LPWSAPROTOCOL_INFOA; g : GROUP; dwFlags : DWORD): TSocket; stdcall;
  {$EXTERNALSYM LPFN_WSASOCKETW}
  LPFN_WSASOCKETW = function(af, iType, protocol : Integer; lpProtocolInfo : LPWSAPROTOCOL_INFOW; g : GROUP; dwFlags : DWORD): TSocket; stdcall;
  {$EXTERNALSYM LPFN_WSASOCKET}
  {$IFDEF UNICODE}
  LPFN_WSASOCKET = LPFN_WSASOCKETW;
  {$ELSE}
  LPFN_WSASOCKET = LPFN_WSASOCKETA;
  {$ENDIF}

  {$EXTERNALSYM LPFN_WSAWAITFORMULTIPLEEVENTS}
  LPFN_WSAWAITFORMULTIPLEEVENTS = function(cEvents : DWORD; lphEvents : PWSAEVENT; fWaitAll : LongBool;
      dwTimeout : DWORD; fAlertable : LongBool): DWORD; stdcall;

  {$EXTERNALSYM LPFN_WSAADDRESSTOSTRINGA}
  LPFN_WSAADDRESSTOSTRINGA = function(lpsaAddress : PSOCKADDR; const dwAddressLength : DWORD; const lpProtocolInfo : LPWSAPROTOCOL_INFOA;
      const lpszAddressString : PChar; var lpdwAddressStringLength : DWORD): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAADDRESSTOSTRINGW}
  LPFN_WSAADDRESSTOSTRINGW = function(lpsaAddress : PSOCKADDR; const dwAddressLength : DWORD; const lpProtocolInfo : LPWSAPROTOCOL_INFOW;
      const lpszAddressString : PWideChar; var lpdwAddressStringLength : DWORD): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAADDRESSTOSTRING}
  {$IFDEF UNICODE}
  LPFN_WSAADDRESSTOSTRING = LPFN_WSAADDRESSTOSTRINGW;
  {$ELSE}
  LPFN_WSAADDRESSTOSTRING = LPFN_WSAADDRESSTOSTRINGA;
  {$ENDIF}

  {$EXTERNALSYM LPFN_WSASTRINGTOADDRESSA}
  LPFN_WSASTRINGTOADDRESSA = function(const AddressString : PChar; const AddressFamily: Integer; const lpProtocolInfo : LPWSAPROTOCOL_INFOA;
      var lpAddress : TSockAddr; var lpAddressLength : Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSASTRINGTOADDRESSW}
  LPFN_WSASTRINGTOADDRESSW = function(const AddressString : PWideChar; const AddressFamily: Integer; const lpProtocolInfo : LPWSAPROTOCOL_INFOW;
      var lpAddress : TSockAddr; var lpAddressLength : Integer): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSASTRINGTOADDRESS}
  {$IFDEF UNICODE}
  LPFN_WSASTRINGTOADDRESS = LPFN_WSASTRINGTOADDRESSW;
  {$ELSE}
  LPFN_WSASTRINGTOADDRESS = LPFN_WSASTRINGTOADDRESSA;
  {$ENDIF}

// Registration and Name Resolution API functions
  {$EXTERNALSYM LPFN_WSALOOKUPSERVICEBEGINA}
  LPFN_WSALOOKUPSERVICEBEGINA = function(var qsRestrictions : TWSAQuerySetA; const dwControlFlags : DWORD; var hLookup : THandle): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSALOOKUPSERVICEBEGINw}
  LPFN_WSALOOKUPSERVICEBEGINW = function(var qsRestrictions : TWSAQuerySetW; const dwControlFlags : DWORD; var hLookup : THandle): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSALOOKUPSERVICEBEGIN}
  {$IFDEF UNICODE}
  LPFN_WSALOOKUPSERVICEBEGIN = LPFN_WSALOOKUPSERVICEBEGINW;
  {$ELSE}
  LPFN_WSALOOKUPSERVICEBEGIN = LPFN_WSALOOKUPSERVICEBEGINA;
  {$ENDIF}

  {$EXTERNALSYM LPFN_WSALOOKUPSERVICENEXTA}
  LPFN_WSALOOKUPSERVICENEXTA = function(const hLookup : THandle; const dwControlFlags : DWORD; var dwBufferLength : DWORD; lpqsResults : PWSAQUERYSETA): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSALOOKUPSERVICENEXTW}
  LPFN_WSALOOKUPSERVICENEXTW = function(const hLookup : THandle; const dwControlFlags : DWORD; var dwBufferLength : DWORD; lpqsResults : PWSAQUERYSETW): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSALOOKUPSERVICENEXT}
  {$IFDEF UNICODE}
  LPFN_WSALOOKUPSERVICENEXT = LPFN_WSALOOKUPSERVICENEXTW;
  {$ELSE}
  LPFN_WSALOOKUPSERVICENEXT = LPFN_WSALOOKUPSERVICENEXTA;
  {$ENDIF}

  {$EXTERNALSYM LPFN_WSALOOKUPSERVICEEND}
  LPFN_WSALOOKUPSERVICEEND = function(const hLookup : THandle): Integer; stdcall;

  {$EXTERNALSYM LPFN_WSAINSTALLSERVICECLASSA}
  LPFN_WSAINSTALLSERVICECLASSA = function(const lpServiceClassInfo : LPWSASERVICECLASSINFOA) : Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAINSTALLSERVICECLASSW}
  LPFN_WSAINSTALLSERVICECLASSW = function(const lpServiceClassInfo : LPWSASERVICECLASSINFOW) : Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAINSTALLSERVICECLASS}
  {$IFDEF UNICODE}
  LPFN_WSAINSTALLSERVICECLASS = LPFN_WSAINSTALLSERVICECLASSW;
  {$ELSE}
  LPFN_WSAINSTALLSERVICECLASS = LPFN_WSAINSTALLSERVICECLASSA;
  {$ENDIF}

  {$EXTERNALSYM LPFN_WSAREMOVESERVICECLASS}
  LPFN_WSAREMOVESERVICECLASS = function(const lpServiceClassId : LPGUID) : Integer; stdcall;

  {$EXTERNALSYM LPFN_WSAGETSERVICECLASSINFOA}
  LPFN_WSAGETSERVICECLASSINFOA = function(const lpProviderId : LPGUID; const lpServiceClassId : LPGUID; var lpdwBufSize : DWORD;
      lpServiceClassInfo : LPWSASERVICECLASSINFOA): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAGETSERVICECLASSINFOW}
  LPFN_WSAGETSERVICECLASSINFOW = function(const lpProviderId : LPGUID; const lpServiceClassId : LPGUID; var lpdwBufSize : DWORD;
      lpServiceClassInfo : LPWSASERVICECLASSINFOW): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAGETSERVICECLASSINFO}
  {$IFDEF UNICODE}
  LPFN_WSAGETSERVICECLASSINFO = LPFN_WSAGETSERVICECLASSINFOW;
  {$ELSE}
  LPFN_WSAGETSERVICECLASSINFO = LPFN_WSAGETSERVICECLASSINFOA;
  {$ENDIF}

  {$EXTERNALSYM LPFN_WSAENUMNAMESPACEPROVIDERSA}
  LPFN_WSAENUMNAMESPACEPROVIDERSA = function(var lpdwBufferLength: DWORD; const lpnspBuffer: LPWSANAMESPACE_INFOA): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAENUMNAMESPACEPROVIDERSW}
  LPFN_WSAENUMNAMESPACEPROVIDERSW = function(var lpdwBufferLength: DWORD; const lpnspBuffer: LPWSANAMESPACE_INFOW): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAENUMNAMESPACEPROVIDERS}
{$IFDEF UNICODE}
  LPFN_WSAENUMNAMESPACEPROVIDERS = LPFN_WSAENUMNAMESPACEPROVIDERSW;
{$ELSE}
  LPFN_WSAENUMNAMESPACEPROVIDERS = LPFN_WSAENUMNAMESPACEPROVIDERSA;
{$ENDIF}

  {$EXTERNALSYM LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDA}
  LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDA = function(const lpServiceClassId: LPGUID; lpszServiceClassName: PChar; var lpdwBufferLength: DWORD): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDW}
  LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDW = function(const lpServiceClassId: LPGUID; lpszServiceClassName: PWideChar; var lpdwBufferLength: DWORD): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAGETSERVICECLASSNAMEBYCLASSID}
  {$IFDEF UNICODE}
  LPFN_WSAGETSERVICECLASSNAMEBYCLASSID = LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDW;
  {$ELSE}
  LPFN_WSAGETSERVICECLASSNAMEBYCLASSID = LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDA;
  {$ENDIF}

  {$EXTERNALSYM LPFN_WSASETSERVICEA}
  LPFN_WSASETSERVICEA = function(const lpqsRegInfo: LPWSAQUERYSETA; const essoperation: WSAESETSERVICEOP; const dwControlFlags: DWORD): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSASETSERVICEW}
  LPFN_WSASETSERVICEW = function(const lpqsRegInfo: LPWSAQUERYSETW; const essoperation: WSAESETSERVICEOP; const dwControlFlags: DWORD): Integer; stdcall;
  {$EXTERNALSYM LPFN_WSASETSERVICE}
  {$IFDEF UNICODE}
  LPFN_WSASETSERVICE = LPFN_WSASETSERVICEW;
  {$ELSE}
  LPFN_WSASETSERVICE = LPFN_WSASETSERVICEA;
  {$ENDIF}

  {$EXTERNALSYM LPFN_WSAPROVIDERCONFIGCHANGE}
  LPFN_WSAPROVIDERCONFIGCHANGE = function(var lpNotificationHandle : THandle; lpOverlapped : LPWSAOVERLAPPED; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE) : Integer; stdcall;

  //microsoft specific extension
  {$EXTERNALSYM LPFN_GETACCEPTEXSOCKADDRS}
  LPFN_GETACCEPTEXSOCKADDRS = procedure(lpOutputBuffer: Pointer;
    dwReceiveDataLength, dwLocalAddressLength, dwRemoteAddressLength: DWORD;
    var LocalSockaddr: TSockAddr; var LocalSockaddrLength: Integer;
    var RemoteSockaddr: TSockAddr; var RemoteSockaddrLength: Integer); stdcall;
  {$EXTERNALSYM LPFN_WSARECVEX}
  LPFN_WSARECVEX = function(s: TSocket; var buf; len: Integer; var flags: Integer): Integer; stdcall;

  //Windows Server 2003, Windows Vista
  {$EXTERNALSYM LPFN_CONNECTEX}
  LPFN_CONNECTEX = function(const s : TSocket; const name: PSOCKADDR; const namelen: Integer; lpSendBuffer : Pointer; dwSendDataLength : DWORD; var lpdwBytesSent : DWORD; lpOverlapped : LPWSAOVERLAPPED) : BOOL; stdcall;
  {$EXTERNALSYM LPFN_DISCONNECTEX}
  LPFN_DISCONNECTEX = function(const hSocket : TSocket; AOverlapped: Pointer; const dwFlags : DWORD; const dwReserved : DWORD) : BOOL; stdcall;
  {$EXTERNALSYM LPFN_WSARECVMSG} //XP and Server 2003 only
  LPFN_WSARECVMSG = function(const s : TSocket; lpMsg : LPWSAMSG; var lpNumberOfBytesRecvd : DWORD; AOverlapped: Pointer; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE): Integer; stdcall;
  {$EXTERNALSYM LPFN_TRANSMITPACKETS}
  LPFN_TRANSMITPACKETS = function(s: TSocket; lpPacketArray: LPTRANSMIT_PACKETS_ELEMENT; nElementCount: DWORD; nSendSize: DWORD; lpOverlapped: LPWSAOVERLAPPED; dwFlags: DWORD): BOOL; stdcall;
  //Windows Vista, Windows Server 2008
  {$EXTERNALSYM LPFN_WSASENDMSG}
  LPFN_WSASENDMSG = function(const s : TSocket; lpMsg : LPWSAMSG; const dwFlags : DWORD; var lpNumberOfBytesSent : DWORD;  lpOverlapped : LPWSAOVERLAPPED;  lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE) : Integer; stdcall;
  {$EXTERNALSYM LPFN_WSAPOLL}
  LPFN_WSAPOLL = function(fdarray : LPWSAPOLLFD; const nfds : u_long; const timeout : Integer) : Integer; stdcall;
{$ENDIF} // $IFDEF INCL_WINSOCK_API_TYPEDEFS

const
  //GUID's for Microsoft extensions
  {$EXTERNALSYM WSAID_ACCEPTEX}
  WSAID_ACCEPTEX: TGuid = (D1:$b5367df1;D2:$cbac;D3:$11cf;D4:($95,$ca,$00,$80,$5f,$48,$a1,$92));
  {$EXTERNALSYM WSAID_CONNECTEX}
  WSAID_CONNECTEX: TGuid = (D1:$25a207b9;D2:$ddf3;D3:$4660;D4:($8e,$e9,$76,$e5,$8c,$74,$06,$3e));
  {$EXTERNALSYM WSAID_DISCONNECTEX}
  WSAID_DISCONNECTEX: TGuid = (D1:$7fda2e11;D2:$8630;D3:$436f;D4:($a0,$31,$f5,$36,$a6,$ee,$c1,$57));
  {$EXTERNALSYM WSAID_GETACCEPTEXSOCKADDRS}
  WSAID_GETACCEPTEXSOCKADDRS: TGuid = (D1:$b5367df2;D2:$cbac;D3:$11cf;D4:($95,$ca,$00,$80,$5f,$48,$a1,$92));
  {$EXTERNALSYM WSAID_TRANSMITFILE}
  WSAID_TRANSMITFILE: TGuid = (D1:$b5367df0; D2:$cbac; D3:$11cf; D4:($95, $ca, $00, $80, $5f, $48, $a1, $92));
  {$EXTERNALSYM WSAID_TRANSMITPACKETS}
  WSAID_TRANSMITPACKETS: TGuid = (D1:$d9689da0;D2:$1f90;D3:$11d3;D4:($99,$71,$00,$c0,$4f,$68,$c8,$76));
  {$EXTERNALSYM WSAID_WSAPOLL}
  WSAID_WSAPOLL: TGuid = (D1:$18C76F85;D2:$DC66;D3:$4964;D4:($97,$2E,$23,$C2,$72,$38,$31,$2B));
  {$EXTERNALSYM WSAID_WSARECVMSG}
  WSAID_WSARECVMSG: TGuid = (D1:$f689d7c8;D2:$6f1f;D3:$436b;D4:($8a,$53,$e5,$4f,$e3,$51,$c3,$22));
  {$EXTERNALSYM WSAID_WSASENDMSG}
  WSAID_WSASENDMSG : TGuid = (D1:$a441e712;D2:$754f;D3:$43ca;D4:($84,$a7,$0d,$ee,$44,$cf,$60,$6d));

{$IFDEF WS2_DLL_FUNC_VARS}
var
  {$EXTERNALSYM WSAStartup}
  WSAStartup : LPFN_WSASTARTUP = nil;
  {$EXTERNALSYM WSACleanup}
  WSACleanup : LPFN_WSACLEANUP = nil;
  {$EXTERNALSYM accept}
  accept : LPFN_ACCEPT = nil;
  {$EXTERNALSYM bind}
  bind : LPFN_BIND = nil;
  {$EXTERNALSYM closesocket}
  closesocket : LPFN_CLOSESOCKET = nil;
  {$EXTERNALSYM connect}
  connect : LPFN_CONNECT = nil;
  {$EXTERNALSYM ioctlsocket}
  ioctlsocket : LPFN_IOCTLSOCKET = nil;
  {$EXTERNALSYM getpeername}
  getpeername : LPFN_GETPEERNAME = nil;
  {$EXTERNALSYM getsockname}
  getsockname : LPFN_GETSOCKNAME = nil;
  {$EXTERNALSYM getsockopt}
  getsockopt : LPFN_GETSOCKOPT = nil;
  {$EXTERNALSYM htonl}
  htonl : LPFN_HTONL = nil;
  {$EXTERNALSYM htons}
  htons : LPFN_HTONS = nil;
  {$EXTERNALSYM inet_addr}
  inet_addr : LPFN_INET_ADDR = nil;
  {$EXTERNALSYM inet_ntoa}
  inet_ntoa : LPFN_INET_NTOA = nil;
  {$EXTERNALSYM listen}
  listen : LPFN_LISTEN = nil;
  {$EXTERNALSYM ntohl}
  ntohl : LPFN_NTOHL = nil;
  {$EXTERNALSYM ntohs}
  ntohs : LPFN_NTOHS = nil;
  {$EXTERNALSYM recv}
  recv : LPFN_RECV = nil;
  {$EXTERNALSYM recvfrom}
  recvfrom : LPFN_RECVFROM = nil;
  {$EXTERNALSYM select}
  select : LPFN_SELECT = nil;
  {$EXTERNALSYM send}
  send : LPFN_SEND = nil;
  {$EXTERNALSYM sendto}
  sendto : LPFN_SENDTO = nil;
  {$EXTERNALSYM setsockopt}
  setsockopt : LPFN_SETSOCKOPT = nil;
  {$EXTERNALSYM shutdown}
  shutdown : LPFN_SHUTDOWN = nil;
  {$EXTERNALSYM socket}
  socket : LPFN_SOCKET = nil;
  {$EXTERNALSYM gethostbyaddr}
  gethostbyaddr : LPFN_GETHOSTBYADDR = nil;
  {$EXTERNALSYM gethostbyname}
  gethostbyname : LPFN_GETHOSTBYNAME = nil;
  {$EXTERNALSYM gethostname}
  gethostname : LPFN_GETHOSTNAME = nil;
  {$IFDEF UNDER_CE}
  {$EXTERNALSYM sethostname}
  sethostname : LPFN_SETHOSTNAME = nil;
  {$ENDIF}
  {$EXTERNALSYM getservbyport}
  getservbyport : LPFN_GETSERVBYPORT = nil;
  {$EXTERNALSYM getservbyname}
  getservbyname : LPFN_GETSERVBYNAME = nil;
  {$EXTERNALSYM getprotobynumber}
  getprotobynumber : LPFN_GETPROTOBYNUMBER = nil;
  {$EXTERNALSYM getprotobyname}
  getprotobyname : LPFN_GETPROTOBYNAME = nil;
  {$EXTERNALSYM WSASetLastError}
  WSASetLastError : LPFN_WSASETLASTERROR = nil;
  {$EXTERNALSYM WSAGetLastError}
  WSAGetLastError : LPFN_WSAGETLASTERROR = nil;
{$IFNDEF UNDER_CE}
  {$EXTERNALSYM WSAIsblocking}
  WSAIsBlocking : LPFN_WSAISBLOCKING = nil;
  {$EXTERNALSYM WSAUnhookBlockingHook}
  WSAUnhookBlockingHook : LPFN_WSAUNHOOKBLOCKINGHOOK = nil;
  {$EXTERNALSYM WSASetBlockingHook}
  WSASetBlockingHook : LPFN_WSASETBLOCKINGHOOK = nil;
  {$EXTERNALSYM WSACancelBlockingCall}
  WSACancelBlockingCall : LPFN_WSACANCELBLOCKINGCALL = nil;
  {$EXTERNALSYM WSAAsyncGetServByName}
  WSAAsyncGetServByName : LPFN_WSAASYNCGETSERVBYNAME = nil;
  {$EXTERNALSYM WSAAsyncGetServByPort}
  WSAAsyncGetServByPort : LPFN_WSAASYNCGETSERVBYPORT = nil;
  {$EXTERNALSYM WSAAsyncGetProtoByName}
  WSAAsyncGetProtoByName : LPFN_WSAASYNCGETPROTOBYNAME = nil;
  {$EXTERNALSYM WSAAsyncGetProtoByNumber}
  WSAAsyncGetProtoByNumber : LPFN_WSAASYNCGETPROTOBYNUMBER = nil;
  {$EXTERNALSYM WSAAsyncGetHostByName}
  WSAAsyncGetHostByName : LPFN_WSAASYNCGETHOSTBYNAME = nil;
  {$EXTERNALSYM WSAAsyncGetHostByAddr}
  WSAAsyncGetHostByAddr : LPFN_WSAASYNCGETHOSTBYADDR = nil;
  {$EXTERNALSYM WSACancelAsyncRequest}
  WSACancelAsyncRequest : LPFN_WSACANCELASYNCREQUEST = nil;
{$ENDIF}
  {$EXTERNALSYM WSAAsyncSelect}
  WSAAsyncSelect : LPFN_WSAASYNCSELECT = nil;
  {$EXTERNALSYM __WSAFDIsSet}
  __WSAFDIsSet : LPFN___WSAFDISSET = nil;
  {$EXTERNALSYM WSAAccept}
  WSAAccept : LPFN_WSAACCEPT = nil;
  {$EXTERNALSYM WSACloseEvent}
  WSACloseEvent : LPFN_WSACLOSEEVENT = nil;
  {$EXTERNALSYM WSAConnect}
  WSAConnect : LPFN_WSACONNECT = nil;
  {$EXTERNALSYM WSACreateEvent}
  WSACreateEvent : LPFN_WSACREATEEVENT = nil;
  {$EXTERNALSYM WSADuplicateSocketA}
  WSADuplicateSocketA : LPFN_WSADUPLICATESOCKETA = nil;
  {$EXTERNALSYM WSADuplicateSocketW}
  WSADuplicateSocketW : LPFN_WSADUPLICATESOCKETW = nil;
  {$EXTERNALSYM WSADuplicateSocket}
  WSADuplicateSocket : LPFN_WSADUPLICATESOCKET = nil;
  {$EXTERNALSYM WSAEnumNetworkEvents}
  WSAEnumNetworkEvents : LPFN_WSAENUMNETWORKEVENTS = nil;
  {$EXTERNALSYM WSAEnumProtocolsA}
  WSAEnumProtocolsA : LPFN_WSAENUMPROTOCOLSA = nil;
  {$EXTERNALSYM WSAEnumProtocolsW}
  WSAEnumProtocolsW : LPFN_WSAENUMPROTOCOLSW = nil;
  {$EXTERNALSYM WSAEnumProtocols}
  WSAEnumProtocols : LPFN_WSAENUMPROTOCOLS = nil;
  {$EXTERNALSYM WSAEventSelect}
  WSAEventSelect : LPFN_WSAEVENTSELECT = nil;
  {$EXTERNALSYM WSAGetOverlappedResult}
  WSAGetOverlappedResult : LPFN_WSAGETOVERLAPPEDRESULT = nil;
  {$EXTERNALSYM WSAGetQosByName}
  WSAGetQosByName : LPFN_WSAGETQOSBYNAME = nil;
  {$EXTERNALSYM WSAHtonl}
  WSAHtonl : LPFN_WSAHTONL = nil;
  {$EXTERNALSYM WSAHtons}
  WSAHtons : LPFN_WSAHTONS = nil;
  {$EXTERNALSYM WSAIoctl}
  WSAIoctl : LPFN_WSAIOCTL = nil;
  {$EXTERNALSYM WSAJoinLeaf}
  WSAJoinLeaf : LPFN_WSAJOINLEAF = nil;
  {$EXTERNALSYM WSANtohl}
  WSANtohl : LPFN_WSANTOHL = nil;
  {$EXTERNALSYM WSANtohs}
  WSANtohs : LPFN_WSANTOHS = nil;
  {$EXTERNALSYM WSARecv}
  WSARecv : LPFN_WSARECV = nil;
  {$EXTERNALSYM WSARecvDisconnect}
  WSARecvDisconnect : LPFN_WSARECVDISCONNECT = nil;
  {$EXTERNALSYM WSARecvFrom}
  WSARecvFrom : LPFN_WSARECVFROM = nil;
  {$EXTERNALSYM WSAResetEvent}
  WSAResetEvent : LPFN_WSARESETEVENT = nil;
  {$EXTERNALSYM WSASend}
  WSASend : LPFN_WSASEND = nil;
  {$EXTERNALSYM WSASendDisconnect}
  WSASendDisconnect : LPFN_WSASENDDISCONNECT = nil;
  {$EXTERNALSYM WSASendTo}
  WSASendTo : LPFN_WSASENDTO = nil;
  {$EXTERNALSYM WSASetEvent}
  WSASetEvent : LPFN_WSASETEVENT = nil;
  {$EXTERNALSYM WSASocketA}
  WSASocketA : LPFN_WSASOCKETA = nil;
  {$EXTERNALSYM WSASocketW}
  WSASocketW : LPFN_WSASOCKETW = nil;
  {$EXTERNALSYM WSASocket}
  WSASocket : LPFN_WSASOCKET = nil;
  {$EXTERNALSYM WSAWaitForMultipleEvents}
  WSAWaitForMultipleEvents : LPFN_WSAWAITFORMULTIPLEEVENTS = nil;
  {$EXTERNALSYM WSAAddressToStringA}
  WSAAddressToStringA : LPFN_WSAADDRESSTOSTRINGA = nil;
  {$EXTERNALSYM WSAAddressToStringW}
  WSAAddressToStringW : LPFN_WSAADDRESSTOSTRINGW = nil;
  {$EXTERNALSYM WSAAddressToString}
  WSAAddressToString : LPFN_WSAADDRESSTOSTRING = nil;
  {$EXTERNALSYM WSAStringToAddressA}
  WSAStringToAddressA : LPFN_WSASTRINGTOADDRESSA = nil;
  {$EXTERNALSYM WSAStringToAddressW}
  WSAStringToAddressW : LPFN_WSASTRINGTOADDRESSW = nil;
  {$EXTERNALSYM WSAStringToAddress}
  WSAStringToAddress : LPFN_WSASTRINGTOADDRESS = nil;
  {$EXTERNALSYM WSALookupServiceBeginA}
  WSALookupServiceBeginA : LPFN_WSALOOKUPSERVICEBEGINA = nil;
  {$EXTERNALSYM WSALookupServiceBeginW}
  WSALookupServiceBeginW : LPFN_WSALOOKUPSERVICEBEGINW = nil;
  {$EXTERNALSYM WSALookupServiceBegin}
  WSALookupServiceBegin : LPFN_WSALOOKUPSERVICEBEGIN = nil;
  {$EXTERNALSYM WSALookupServiceNextA}
  WSALookupServiceNextA : LPFN_WSALOOKUPSERVICENEXTA = nil;
  {$EXTERNALSYM WSALookupServiceNextW}
  WSALookupServiceNextW : LPFN_WSALOOKUPSERVICENEXTW = nil;
  {$EXTERNALSYM WSALookupServiceNext}
  WSALookupServiceNext : LPFN_WSALOOKUPSERVICENEXT = nil;
  {$EXTERNALSYM WSALookupServiceEnd}
  WSALookupServiceEnd : LPFN_WSALOOKUPSERVICEEND = nil;
  {$EXTERNALSYM WSAInstallServiceClassA}
  WSAInstallServiceClassA : LPFN_WSAINSTALLSERVICECLASSA = nil;
  {$EXTERNALSYM WSAInstallServiceClassW}
  WSAInstallServiceClassW : LPFN_WSAINSTALLSERVICECLASSW = nil;
  {$EXTERNALSYM WSAInstallServiceClass}
  WSAInstallServiceClass : LPFN_WSAINSTALLSERVICECLASS = nil;
  {$EXTERNALSYM WSARemoveServiceClass}
  WSARemoveServiceClass : LPFN_WSAREMOVESERVICECLASS = nil;
  {$EXTERNALSYM WSAGetServiceClassInfoA}
  WSAGetServiceClassInfoA : LPFN_WSAGETSERVICECLASSINFOA = nil;
  {$EXTERNALSYM WSAGetServiceClassInfoW}
  WSAGetServiceClassInfoW : LPFN_WSAGETSERVICECLASSINFOW = nil;
  {$EXTERNALSYM WSAGetServiceClassInfo}
  WSAGetServiceClassInfo : LPFN_WSAGETSERVICECLASSINFO = nil;
  {$EXTERNALSYM WSAEnumNameSpaceProvidersA}
  WSAEnumNameSpaceProvidersA : LPFN_WSAENUMNAMESPACEPROVIDERSA = nil;
  {$EXTERNALSYM WSAEnumNameSpaceProvidersW}
  WSAEnumNameSpaceProvidersW : LPFN_WSAENUMNAMESPACEPROVIDERSW = nil;
  {$EXTERNALSYM WSAEnumNameSpaceProviders}
  WSAEnumNameSpaceProviders : LPFN_WSAENUMNAMESPACEPROVIDERS = nil;
  {$EXTERNALSYM WSAGetServiceClassNameByClassIdA}
  WSAGetServiceClassNameByClassIdA : LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDA = nil;
  {$EXTERNALSYM WSAGetServiceClassNameByClassIdW}
  WSAGetServiceClassNameByClassIdW : LPFN_WSAGETSERVICECLASSNAMEBYCLASSIDW = nil;
  {$EXTERNALSYM WSAGetServiceClassNameByClassId}
  WSAGetServiceClassNameByClassId : LPFN_WSAGETSERVICECLASSNAMEBYCLASSID = nil;
  {$EXTERNALSYM WSASetServiceA}
  WSASetServiceA : LPFN_WSASETSERVICEA = nil;
  {$EXTERNALSYM WSASetServiceW}
  WSASetServiceW : LPFN_WSASETSERVICEW = nil;
  {$EXTERNALSYM WSASetService}
  WSASetService : LPFN_WSASETSERVICE = nil;
  {$EXTERNALSYM WSAProviderConfigChange}
  WSAProviderConfigChange : LPFN_WSAPROVIDERCONFIGCHANGE = nil;
{$IFNDEF UNDER_CE}
  {$EXTERNALSYM TransmitFile}
  TransmitFile : LPFN_TRANSMITFILE = nil;
  {$EXTERNALSYM AcceptEx}
  AcceptEx : LPFN_ACCEPTEX = nil;
  {$EXTERNALSYM GetAcceptExSockaddrs}
  GetAcceptExSockaddrs : LPFN_GETACCEPTEXSOCKADDRS = nil;
  {$EXTERNALSYM WSARecvEx}
  WSARecvEx : LPFN_WSARECVEX = nil;
{$ENDIF}
  {$EXTERNALSYM ConnectEx}
  ConnectEx : LPFN_CONNECTEX = nil;
  {$EXTERNALSYM DisconnectEx}
  DisconnectEx : LPFN_DISCONNECTEX = nil;
  {$EXTERNALSYM WSARecvMsg}
  WSARecvMsg : LPFN_WSARECVMSG = nil;
  {$EXTERNALSYM TransmitPackets}
  TransmitPackets : LPFN_TRANSMITPACKETS = nil;

  //Windows Vista, Windows Server 2008
  {$EXTERNALSYM WSASendMsg}
  WSASendMsg: LPFN_WSASENDMSG = nil;
  {$EXTERNALSYM WSAPoll}
  WSAPoll: LPFN_WSAPOLL = nil;
{$ENDIF} // $IFDEF WS2_DLL_FUNC_VARS

  { Macros }
  {$EXTERNALSYM WSAMakeSyncReply}
  function WSAMakeSyncReply(Buflen, Error: Word): Longint;
  {$EXTERNALSYM WSAMakeSelectReply}
  function WSAMakeSelectReply(Event, Error: Word): Longint;
  {$EXTERNALSYM WSAGetAsyncBuflen}
  function WSAGetAsyncBuflen(Param: Longint): Word;
  {$EXTERNALSYM WSAGetAsyncError}
  function WSAGetAsyncError(Param: Longint): Word;
  {$EXTERNALSYM WSAGetSelectEvent}
  function WSAGetSelectEvent(Param: Longint): Word;
  {$EXTERNALSYM WSAGetSelectError}
  function WSAGetSelectError(Param: Longint): Word;

  {$EXTERNALSYM FD_CLR}
  procedure FD_CLR(Socket: TSocket; var FDSet: TFDSet);
  {$EXTERNALSYM FD_ISSET}
  function FD_ISSET(Socket: TSocket; var FDSet: TFDSet): Boolean;
  {$EXTERNALSYM FD_SET}
  procedure FD_SET(Socket: TSocket; var FDSet: TFDSet);
  {$EXTERNALSYM FD_ZERO}
  procedure FD_ZERO(var FDSet: TFDSet);

  {$EXTERNALSYM WSA_CMSGHDR_ALIGN}
  function WSA_CMSGHDR_ALIGN(length: DWORD): DWORD;
  {$EXTERNALSYM WSA_CMSGDATA_ALIGN}
  function WSA_CMSGDATA_ALIGN(length: DWORD): DWORD;
  {$EXTERNALSYM WSA_CMSG_FIRSTHDR}
  function WSA_CMSG_FIRSTHDR(msg: LPWSAMSG): LPWSACMSGHDR;
  {$EXTERNALSYM WSA_CMSG_NXTHDR}
  function WSA_CMSG_NXTHDR(msg: LPWSAMSG; cmsg: LPWSACMSGHDR): LPWSACMSGHDR;
  {$EXTERNALSYM WSA_CMSG_DATA}
  function WSA_CMSG_DATA(cmsg: LPWSACMSGHDR): PByte;
  {$EXTERNALSYM WSA_CMSG_SPACE}
  function WSA_CMSG_SPACE(length: DWORD): DWORD;
  {$EXTERNALSYM WSA_CMSG_LEN}
  function WSA_CMSG_LEN(length: DWORD): DWORD;

//=============================================================

{
	WS2TCPIP.H - WinSock2 Extension for TCP/IP protocols

	This file contains TCP/IP specific information for use
	by WinSock2 compatible applications.

	Copyright (c) 1995-1999  Microsoft Corporation

	To provide the backward compatibility, all the TCP/IP
	specific definitions that were included in the WINSOCK.H
	file are now included in WINSOCK2.H file. WS2TCPIP.H
	file includes only the definitions  introduced in the
	"WinSock 2 Protocol-Specific Annex" document.

	Rev 0.3	Nov 13, 1995
	Rev 0.4	Dec 15, 1996
}

type
// Argument structure for IP_ADD_MEMBERSHIP and IP_DROP_MEMBERSHIP
  {$EXTERNALSYM ip_mreq}
  ip_mreq = packed record
    imr_multiaddr : TInAddr; // IP multicast address of group
    imr_interface : TInAddr; // local IP address of interface
  end;

// Argument structure for IP_ADD_SOURCE_MEMBERSHIP, IP_DROP_SOURCE_MEMBERSHIP,
// IP_BLOCK_SOURCE, and IP_UNBLOCK_SOURCE
  {$EXTERNALSYM ip_mreq_source}
  ip_mreq_source = packed record
    imr_multiaddr: TInAddr;     // IP multicast address of group
    imr_sourceaddr: TInAddr;    // IP address of source
    imr_interface: TInAddr;     // local IP address of interface
  end;

// Argument structure for SIO_{GET,SET}_MULTICAST_FILTER
  {$EXTERNALSYM ip_msfilter}
  ip_msfilter = packed record
    imsf_multiaddr: TInAddr;    // IP multicast address of group
    imsf_interface: TInAddr;    // local IP address of interface
    imsf_fmode: u_long;         // filter mode - INCLUDE or EXCLUDE
    imsf_numsrc: u_long;        // number of sources in src_list
    imsf_slist: Array[0..0] of TInAddr;
  end;

  {$EXTERNALSYM IP_MSFILTER_SIZE}
  function IP_MSFILTER_SIZE(numsrc: DWORD): DWORD;

// TCP/IP specific Ioctl codes
const
  {$EXTERNALSYM SIO_GET_INTERFACE_LIST}
  SIO_GET_INTERFACE_LIST    = IOC_OUT or ((SizeOf(u_long) and IOCPARM_MASK) shl 16) or (Ord('t') shl 8) or 127;    {Do not Localize}
// New IOCTL with address size independent address array
  {$EXTERNALSYM SIO_GET_INTERFACE_LIST_EX}
  SIO_GET_INTERFACE_LIST_EX = IOC_OUT or ((SizeOf(u_long) and IOCPARM_MASK) shl 16) or (Ord('t') shl 8) or 126;    {Do not Localize}
  {$EXTERNALSYM SIO_SET_MULTICAST_FILTER}
  SIO_SET_MULTICAST_FILTER  = IOC_IN or ((SizeOf(u_long) and IOCPARM_MASK) shl 16) or (Ord('t') shl 8) or 125;    {Do not Localize}
  {$EXTERNALSYM SIO_GET_MULTICAST_FILTER}
  SIO_GET_MULTICAST_FILTER  = IOC_IN or ((SizeOf(u_long) and IOCPARM_MASK) shl 16) or (Ord('t') shl 8) or (124 or IOC_IN);    {Do not Localize}

// Options for use with [gs]etsockopt at the IP level.
  {$EXTERNALSYM IP_OPTIONS}
  IP_OPTIONS                =  1; // set/get IP options
  {$EXTERNALSYM IP_HDRINCL}
  IP_HDRINCL                =  2; // header is included with data
  {$EXTERNALSYM IP_TOS}
  IP_TOS                    =  3; // IP type of service and preced
  {$EXTERNALSYM IP_TTL}
  IP_TTL                    =  4; // IP time to live
  {$EXTERNALSYM IP_MULTICAST_IF}
  IP_MULTICAST_IF           =  9; // set/get IP multicast i/f
  {$EXTERNALSYM IP_MULTICAST_TTL}
  IP_MULTICAST_TTL          = 10; // set/get IP multicast ttl
  {$EXTERNALSYM IP_MULTICAST_LOOP}
  IP_MULTICAST_LOOP         = 11; // set/get IP multicast loopback
  {$EXTERNALSYM IP_ADD_MEMBERSHIP}
  IP_ADD_MEMBERSHIP         = 12; // add an IP group membership
  {$EXTERNALSYM IP_DROP_MEMBERSHIP}
  IP_DROP_MEMBERSHIP        = 13; // drop an IP group membership
  {$EXTERNALSYM IP_DONTFRAGMENT}
  IP_DONTFRAGMENT           = 14; // don't fragment IP datagrams    {Do not Localize}
  {$EXTERNALSYM IP_ADD_SOURCE_MEMBERSHIP}
  IP_ADD_SOURCE_MEMBERSHIP  = 15; // join IP group/source
  {$EXTERNALSYM IP_DROP_SOURCE_MEMBERSHIP}
  IP_DROP_SOURCE_MEMBERSHIP = 16; // leave IP group/source
  {$EXTERNALSYM IP_BLOCK_SOURCE}
  IP_BLOCK_SOURCE           = 17; // block IP group/source
  {$EXTERNALSYM IP_UNBLOCK_SOURCE}
  IP_UNBLOCK_SOURCE         = 18; // unblock IP group/source
  {$EXTERNALSYM IP_PKTINFO}
  IP_PKTINFO                = 19; // receive packet information for ipv4

  {$EXTERNALSYM IP_DEFAULT_MULTICAST_TTL}
  IP_DEFAULT_MULTICAST_TTL   = 1;    // normally limit m'casts to 1 hop    {Do not Localize}
  {$EXTERNALSYM IP_DEFAULT_MULTICAST_LOOP}
  IP_DEFAULT_MULTICAST_LOOP  = 1;    // normally hear sends if a member
  {$EXTERNALSYM IP_MAX_MEMBERSHIPS}
  IP_MAX_MEMBERSHIPS         = 20;   // per socket; must fit in one mbuf

  // Option to use with [gs]etsockopt at the IPPROTO_IPV6 level
  {$EXTERNALSYM IPV6_HDRINCL}
  IPV6_HDRINCL               = 2; // Header is included with data
  {$EXTERNALSYM IPV6_UNICAST_HOPS}
  IPV6_UNICAST_HOPS          = 4; // Set/get IP unicast hop limit
  {$EXTERNALSYM IPV6_MULTICAST_IF}
  IPV6_MULTICAST_IF          = 9; // Set/get IP multicast interface
  {$EXTERNALSYM IPV6_MULTICAST_HOPS}
  IPV6_MULTICAST_HOPS        = 10; // Set/get IP multicast ttl
  {$EXTERNALSYM IPV6_MULTICAST_LOOP}
  IPV6_MULTICAST_LOOP        = 11; // Set/get IP multicast loopback
  {$EXTERNALSYM IPV6_ADD_MEMBERSHIP}
  IPV6_ADD_MEMBERSHIP        = 12; // Add an IP group membership
  {$EXTERNALSYM IPV6_DROP_MEMBERSHIP}
  IPV6_DROP_MEMBERSHIP       = 13; // Drop an IP group membership
  {$EXTERNALSYM IPV6_JOIN_GROUP}
  IPV6_JOIN_GROUP            = IPV6_ADD_MEMBERSHIP;
  {$EXTERNALSYM IPV6_LEAVE_GROUP}
  IPV6_LEAVE_GROUP           = IPV6_DROP_MEMBERSHIP;
  {$EXTERNALSYM IPV6_PKTINFO}
  IPV6_PKTINFO               = 19; // Receive packet information for ipv6
  {$EXTERNALSYM IPV6_HOPLIMIT}
  IPV6_HOPLIMIT              = 21; // Receive packet hop limit
  {$EXTERNALSYM IPV6_PROTECTION_LEVEL}
  IPV6_PROTECTION_LEVEL      = 23; // Set/get IPv6 protection level

  // Option to use with [gs]etsockopt at the IPPROTO_UDP level
  {$EXTERNALSYM UDP_NOCHECKSUM}
  UDP_NOCHECKSUM             = 1;
  {$EXTERNALSYM UDP_CHECKSUM_COVERAGE}
  UDP_CHECKSUM_COVERAGE      = 20; // Set/get UDP-Lite checksum coverage

// Option to use with [gs]etsockopt at the IPPROTO_TCP level
  {$EXTERNALSYM TCP_EXPEDITED_1122}
  TCP_EXPEDITED_1122         = $0002;

// IPv6 definitions
type
  {$EXTERNALSYM IN6_ADDR}
  IN6_ADDR = packed record
    case Integer of
      0: (s6_addr: array[0..15] of u_char);
      1: (word: array[0..7] of u_short);
  end;
  TIn6Addr   = IN6_ADDR;
  PIn6Addr   = ^TIn6Addr;
  {$EXTERNALSYM PIN6_ADDR}
  PIN6_ADDR  = ^PIn6Addr;
  {$EXTERNALSYM LPIN6_ADDR}
  LPIN6_ADDR = PIN6_ADDR;

  {$IFNDEF NOREDECLARE}
  // Argument structure for IPV6_JOIN_GROUP and IPV6_LEAVE_GROUP
  {$EXTERNALSYM ipv6_mreq}
  ipv6_mreq = packed record
    ipv6mr_multiaddr: TIn6Addr; // IPv6 multicast address
    ipv6mr_interface: u_int; // Interface index
  end;
 {$ENDIF}

  // Old IPv6 socket address structure (retained for sockaddr_gen definition below)
  {$EXTERNALSYM sockaddr_in6_old}
  sockaddr_in6_old = packed record
    sin6_family   : Smallint;         // AF_INET6
    sin6_port     : u_short;          // Transport level port number
    sin6_flowinfo : u_long;           // IPv6 flow information
    sin6_addr     : TIn6Addr;         // IPv6 address
  end;

// IPv6 socket address structure, RFC 2553
  {$EXTERNALSYM SOCKADDR_IN6}
  SOCKADDR_IN6 = packed record
    sin6_family   : Smallint;         // AF_INET6
    sin6_port     : u_short;          // Transport level port number
    sin6_flowinfo : u_long;           // IPv6 flow information
    sin6_addr     : TIn6Addr;         // IPv6 address
    sin6_scope_id : u_long;           // set of interfaces for a scope
  end;
  TSockAddrIn6   = SOCKADDR_IN6;
  PSockAddrIn6   = ^TSockAddrIn6;
  {$EXTERNALSYM PSOCKADDR_IN6}
  PSOCKADDR_IN6  = PSockAddrIn6;
  {$EXTERNALSYM LPSOCKADDR_IN6}
  LPSOCKADDR_IN6 = PSOCKADDR_IN6;

  {$EXTERNALSYM sockaddr_gen}
  sockaddr_gen = packed record
    case Integer of
      1 : ( Address : TSockAddr; );
      2 : ( AddressIn : TSockAddrIn; );
      3 : ( AddressIn6 : sockaddr_in6_old; );
  end;
  TSockAddrGen = sockaddr_gen;

// Structure to keep interface specific information
  {$EXTERNALSYM INTERFACE_INFO}
  INTERFACE_INFO = packed record
    iiFlags            : u_long;       // Interface flags
    iiAddress          : TSockAddrGen; // Interface address
    iiBroadcastAddress : TSockAddrGen; // Broadcast address
    iiNetmask          : TSockAddrGen; // Network mask
  end;
  TInterface_Info  = INTERFACE_INFO;
  {$EXTERNALSYM PINTERFACE_INFO}
  PINTERFACE_INFO = ^TInterface_Info;
  {$EXTERNALSYM LPINTERFACE_INFO}
  LPINTERFACE_INFO = PINTERFACE_INFO;

// New structure that does not have dependency on the address size
  {$EXTERNALSYM INTERFACE_INFO_EX}
  INTERFACE_INFO_EX = packed record
    iiFlags            : u_long;          // Interface flags
    iiAddress          : TSocket_Address; // Interface address
    iiBroadcastAddress : TSocket_Address; // Broadcast address
    iiNetmask          : TSocket_Address; // Network mask
  end;
  TInterface_Info_Ex  = INTERFACE_INFO_EX;
  {$EXTERNALSYM PINTERFACE_INFO_EX}
  PINTERFACE_INFO_EX = ^TInterface_Info_Ex;
  {$EXTERNALSYM LPINTERFACE_INFO_EX}
  LPINTERFACE_INFO_EX = PINTERFACE_INFO_EX;

// Macro that works for both IPv4 and IPv6
  {$EXTERNALSYM SS_PORT}
  function SS_PORT(ssp: PSockAddrIn): u_short;

  {$EXTERNALSYM IN6ADDR_ANY_INIT}
  function IN6ADDR_ANY_INIT: TIn6Addr;
  {$EXTERNALSYM IN6ADDR_LOOPBACK_INIT}
  function IN6ADDR_LOOPBACK_INIT: TIn6Addr;

  {$EXTERNALSYM IN6ADDR_SETANY}
  procedure IN6ADDR_SETANY(sa: PSockAddrIn6);
  {$EXTERNALSYM IN6ADDR_SETLOOPBACK}
  procedure IN6ADDR_SETLOOPBACK(sa: PSockAddrIn6);
  {$EXTERNALSYM IN6ADDR_ISANY}
  function IN6ADDR_ISANY(sa: PSockAddrIn6): Boolean;
  {$EXTERNALSYM IN6ADDR_ISLOOPBACK}
  function IN6ADDR_ISLOOPBACK(sa: PSockAddrIn6): Boolean;

  {$EXTERNALSYM IN6_ADDR_EQUAL}
  function IN6_ADDR_EQUAL(const a: PIn6Addr; const b: PIn6Addr): Boolean;
  {$EXTERNALSYM IN6_IS_ADDR_UNSPECIFIED}
  function IN6_IS_ADDR_UNSPECIFIED(const a: PIn6Addr): Boolean;
  {$EXTERNALSYM IN6_IS_ADDR_LOOPBACK}
  function IN6_IS_ADDR_LOOPBACK(const a: PIn6Addr): Boolean;
  {$EXTERNALSYM IN6_IS_ADDR_MULTICAST}
  function IN6_IS_ADDR_MULTICAST(const a: PIn6Addr): Boolean;
  {$EXTERNALSYM IN6_IS_ADDR_LINKLOCAL}
  function IN6_IS_ADDR_LINKLOCAL(const a: PIn6Addr): Boolean;
  {$EXTERNALSYM IN6_IS_ADDR_SITELOCAL}
  function IN6_IS_ADDR_SITELOCAL(const a: PIn6Addr): Boolean;
  {$EXTERNALSYM IN6_IS_ADDR_V4MAPPED}
  function IN6_IS_ADDR_V4MAPPED(const a: PIn6Addr): Boolean;
  {$EXTERNALSYM IN6_IS_ADDR_V4COMPAT}
  function IN6_IS_ADDR_V4COMPAT(const a: PIn6Addr): Boolean;
  {$EXTERNALSYM IN6_IS_ADDR_MC_NODELOCAL}
  function IN6_IS_ADDR_MC_NODELOCAL(const a: PIn6Addr): Boolean;
  {$EXTERNALSYM IN6_IS_ADDR_MC_LINKLOCAL}
  function IN6_IS_ADDR_MC_LINKLOCAL(const a: PIn6Addr): Boolean;
  {$EXTERNALSYM IN6_IS_ADDR_MC_SITELOCAL}
  function IN6_IS_ADDR_MC_SITELOCAL(const a: PIn6Addr): Boolean;
  {$EXTERNALSYM IN6_IS_ADDR_MC_ORGLOCAL}
  function IN6_IS_ADDR_MC_ORGLOCAL(const a: PIn6Addr): Boolean;
  {$EXTERNALSYM IN6_IS_ADDR_MC_GLOBAL}
  function IN6_IS_ADDR_MC_GLOBAL(const a: PIn6Addr): Boolean;

// Possible flags for the  iiFlags - bitmask
const
  {$EXTERNALSYM IFF_UP}
  IFF_UP           = $00000001;  // Interface is up
  {$EXTERNALSYM IFF_BROADCAST}
  IFF_BROADCAST    = $00000002;  // Broadcast is  supported
  {$EXTERNALSYM IFF_LOOPBACK}
  IFF_LOOPBACK     = $00000004;  // this is loopback interface
  {$EXTERNALSYM IFF_POINTTOPOINT}
  IFF_POINTTOPOINT = $00000008;  // this is point-to-point interface
  {$EXTERNALSYM IFF_MULTICAST}
  IFF_MULTICAST    = $00000010;  // multicast is supported

type
  {$EXTERNALSYM MULTICAST_MODE_TYPE}
  {$EXTERNALSYM MCAST_INCLUDE}
  {$EXTERNALSYM MCAST_EXCLUDE}
  MULTICAST_MODE_TYPE = (MCAST_INCLUDE, MCAST_EXCLUDE);
  {$EXTERNALSYM GROUP_FILTER}
  GROUP_FILTER = packed record
    gf_interface : PULONG;         // Interface index.
    gf_group : SOCKADDR_STORAGE;  // Multicast address.
    gf_fmode : MULTICAST_MODE_TYPE; // Filter mode.
    gf_numsrc : ULONG;            // Number of sources.
    gf_slist : SOCKADDR_STORAGE;  //gf_slist[1] : SOCKADDR_STORAGE; // Source address.
  end;
  {$EXTERNALSYM PGROUP_FILTER}
  PGROUP_FILTER = ^GROUP_FILTER;

  {$EXTERNALSYM GROUP_REQ}
  GROUP_REQ  = packed record
    gr_interface : ULONG;         // Interface index.
    gr_group : SOCKADDR_STORAGE;  // Multicast address.
  end;
  {$EXTERNALSYM PGROUP_REQ}
  PGROUP_REQ = ^GROUP_REQ;

  {$EXTERNALSYM GROUP_SOURCE_REQ}
  GROUP_SOURCE_REQ = packed record
     gsr_interface : ULONG;        // Interface index.
     gsr_group : SOCKADDR_STORAGE; // Group address.
     gsr_source : SOCKADDR_STORAGE; // Source address.
  end;
  {$EXTERNALSYM GROUP_SOURCE_REQ}
  PGROUP_SOURCE_REQ = ^GROUP_SOURCE_REQ;

function GROUP_FILTER_SIZE(numsrc : DWord) : DWord;

type
  {$EXTERNALSYM WSAQUERYSET2}
  WSAQUERYSET2 = packed record
    dwSize : DWORD;
    lpszServiceInstanceName : LPTSTR;
    lpVersion : LPWSAVERSION;
    lpszComment : LPTSTR;
    dwNameSpace : DWORD;
    lpNSProviderId : LPGUID;
    lpszContext : LPTSTR;
     dwNumberOfProtocols : DWORD;
    lpafpProtocols : LPAFPROTOCOLS;
    lpszQueryString : LPTSTR;
    dwNumberOfCsAddrs : DWORD;
    lpcsaBuffer : LPCSADDR_INFO;
    dwOutputFlags : DWORD;
    lpBlob : LPBLOB;
  end;
  {$EXTERNALSYM PWSAQUERYSET2}
  PWSAQUERYSET2 = ^WSAQUERYSET2;
  {$EXTERNALSYM LPWSAQUERYSET2}
  LPWSAQUERYSET2 = PWSAQUERYSET2;

  {$EXTERNALSYM NAPI_PROVIDER_TYPE}
  {$EXTERNALSYM PROVIDERTYPE_APPLICATION}
  {$EXTERNALSYM PROVIDERTYPE_SERVICE}
  NAPI_PROVIDER_TYPE = (ProviderType_Application=1, ProviderType_Service);
  {$EXTERNALSYM NAPI_DOMAIN_DESCRIPTION_BLOB}
  NAPI_DOMAIN_DESCRIPTION_BLOB = packed record
    AuthLevel : DWORD;
    cchDomainName : DWORD;
    OffsetNextDomainDescription : DWORD;
    OffsetThisDomainName : DWORD;
  end;
  {$EXTERNALSYM NAPI_DOMAIN_DESCRIPTION_BLOB}
  PNAPI_DOMAIN_DESCRIPTION_BLOB = ^NAPI_DOMAIN_DESCRIPTION_BLOB;

  {$EXTERNALSYM NAPI_PROVIDER_LEVEL}
  {$EXTERNALSYM PROVIDERLEVEL_NONE}
  {$EXTERNALSYM PROVIDERLEVEL_SECONDARY}
  {$EXTERNALSYM PROVIDERLEVEL_PRIMARY}
  NAPI_PROVIDER_LEVEL = (PROVIDERLEVEL_NONE, PROVIDERLEVEL_SECONDARY,PROVIDERLEVEL_PRIMARY);

  {$EXTERNALSYM NAPI_PROVIDER_INSTALLATION_BLOB}
  NAPI_PROVIDER_INSTALLATION_BLOB = packed record
    dwVersion : DWORD;
    dwProviderType : DWORD;
    fSupportsWildCard : DWORD;
    cDomains : DWORD;
    OffsetFirstDomain : DWORD;
  end;
  {$EXTERNALSYM PNAPI_PROVIDER_INSTALLATION_BLOB}
  PNAPI_PROVIDER_INSTALLATION_BLOB = ^NAPI_PROVIDER_INSTALLATION_BLOB;

  {$IFNDEF NOREDECLARE}
  {$EXTERNALSYM SERVICE_ADDRESS}
  SERVICE_ADDRESS = packed record
    dwAddressType : DWORD;
    dwAddressFlags : DWORD;
    dwAddressLength : DWORD;
    dwPrincipalLength : DWORD;
    lpAddress : PByte;
    lpPrincipal : PByte;
  end;
  {$ENDIF}
  {$EXTERNALSYM SERVICE_ADDRESS}
  PSERVICE_ADDRESS = ^SERVICE_ADDRESS;
  {$EXTERNALSYM LPSERVICE_ADDRESS}
  LPSERVICE_ADDRESS = PSERVICE_ADDRESS;
  
  {$IFNDEF NOREDECLARE}
  {$EXTERNALSYM SERVICE_ADDRESSES}
  SERVICE_ADDRESSES = packed record
    dwAddressCount : DWORD;
//#ifdef MIDL_PASS
//    [size_is(dwAddressCount)] SERVICE_ADDRESS Addressses[*];
//#else  // MIDL_PASS
//    SERVICE_ADDRESS Addresses[1] ;
//#endif // MIDL_PASS
     Addresses : SERVICE_ADDRESS;
  end;
  {$EXTERNALSYM PSERVICE_ADDRESSES}
  PSERVICE_ADDRESSES = ^SERVICE_ADDRESSES;
  {$EXTERNALSYM LPSERVICE_ADDRESSES}
  LPSERVICE_ADDRESSES = PSERVICE_ADDRESSES;
  {$ENDIF}

const
  {$EXTERNALSYM  RESOURCEDISPLAYTYPE_GENERIC}
  RESOURCEDISPLAYTYPE_GENERIC        = $00000000;
  {$EXTERNALSYM RESOURCEDISPLAYTYPE_DOMAIN}
  RESOURCEDISPLAYTYPE_DOMAIN         = $00000001;
  {$EXTERNALSYM RESOURCEDISPLAYTYPE_SERVER}
  RESOURCEDISPLAYTYPE_SERVER         = $00000002;
  {$EXTERNALSYM RESOURCEDISPLAYTYPE_SHARE}
  RESOURCEDISPLAYTYPE_SHARE          = $00000003;
  {$EXTERNALSYM RESOURCEDISPLAYTYPE_FILE}
  RESOURCEDISPLAYTYPE_FILE           = $00000004;
  {$EXTERNALSYM RESOURCEDISPLAYTYPE_GROUP}
  RESOURCEDISPLAYTYPE_GROUP          = $00000005;
  {$EXTERNALSYM RESOURCEDISPLAYTYPE_NETWORK}
  RESOURCEDISPLAYTYPE_NETWORK        = $00000006;
  {$EXTERNALSYM RESOURCEDISPLAYTYPE_NETWORK}
  RESOURCEDISPLAYTYPE_ROOT           = $00000007;
  {$EXTERNALSYM RESOURCEDISPLAYTYPE_ROOT}
  RESOURCEDISPLAYTYPE_SHAREADMIN     = $00000008;
  {$EXTERNALSYM RESOURCEDISPLAYTYPE_SHAREADMIN}
  RESOURCEDISPLAYTYPE_DIRECTORY      = $00000009;
  {$EXTERNALSYM RESOURCEDISPLAYTYPE_TREE}
  RESOURCEDISPLAYTYPE_TREE           = $0000000A;
  {$EXTERNALSYM RESOURCEDISPLAYTYPE_NDSCONTAINER}
  RESOURCEDISPLAYTYPE_NDSCONTAINER   = $0000000B;

type
  {$EXTERNALSYM SERVICE_TYPE_VALUE_ABSA}
  SERVICE_TYPE_VALUE_ABSA = packed record
    dwNameSpace : DWORD;
    dwValueType : DWORD;
    dwValueSize : DWORD;
    lpValueName : LPSTR;
    lpValue : Pointer;
  end;
  {$EXTERNALSYM PSERVICE_TYPE_VALUE_ABSA}
  PSERVICE_TYPE_VALUE_ABSA = ^SERVICE_TYPE_VALUE_ABSA;
  {$EXTERNALSYM LPSERVICE_TYPE_VALUE_ABSA}
  LPSERVICE_TYPE_VALUE_ABSA = PSERVICE_TYPE_VALUE_ABSA;

  {$EXTERNALSYM SERVICE_INFOA}
  SERVICE_INFOA = packed record
     lpServiceType : LPGUID;
     lpServiceName : PChar;
     lpComment : PChar;
     lpLocale : PChar;
     dwDisplayHint : DWORD;
     dwVersion : DWORD;
     dwTime : DWORD;
     lpMachineName : PChar;
     lpServiceAddress : LPSERVICE_ADDRESSES;
     ServiceSpecificInfo : BLOB;
  end;
  {$EXTERNALSYM SERVICE_INFOW}
  SERVICE_INFOW = packed record
     lpServiceType : LPGUID;
     lpServiceName : PWideChar;
     lpComment : PWideChar;
     lpLocale : PWideChar;
     dwDisplayHint : DWORD;
     dwVersion : DWORD;
     dwTime : DWORD;
     lpMachineName : PWideChar;
     lpServiceAddress : LPSERVICE_ADDRESSES;
     ServiceSpecificInfo : BLOB;
  end;

  SOCKET_USAGE_TYPE = (SYSTEM_CRITICAL_SOCKET = 1);
  {$IFNDEF NOREDECLARE}
  {$EXTERNALSYM SERVICE_INFO}
    {$IFDEF UNICODE}
  SERVICE_INFO = SERVICE_INFOW;
    {$ELSE}
  SERVICE_INFO = SERVICE_INFOA;
    {$ENDIF}
  {$ENDIF}
  {$EXTERNALSYM NS_SERVICE_INFOA}
  NS_SERVICE_INFOA = packed record
    dwNameSpace : DWORD;
    ServiceInfo : SERVICE_INFOA;
  end;
  {$EXTERNALSYM PNS_SERVICE_INFOA}
  PNS_SERVICE_INFOA = ^NS_SERVICE_INFOA;
  {$EXTERNALSYM LPNS_SERVICE_INFOA}
  LPNS_SERVICE_INFOA = NS_SERVICE_INFOA;
  {$EXTERNALSYM NS_SERVICE_INFOW}
  NS_SERVICE_INFOW = packed record
    dwNameSpace : DWORD;
    ServiceInfo : SERVICE_INFOW;
  end;
  {$EXTERNALSYM PNS_SERVICE_INFOW}
  PNS_SERVICE_INFOW = ^NS_SERVICE_INFOW;
  {$EXTERNALSYM LPNS_SERVICE_INFOW}
  LPNS_SERVICE_INFOW = NS_SERVICE_INFOW;
  {$IFNDEF NOREDECLARE}
  {$EXTERNALSYM NS_SERVICE_INFO}
  {$EXTERNALSYM PNS_SERVICE_INFO}
  {$EXTERNALSYM LPNS_SERVICE_INFO}
    {$IFDEF UNICODE}
   NS_SERVICE_INFO = NS_SERVICE_INFOW;
   PNS_SERVICE_INFO = PNS_SERVICE_INFOW;
   LPNS_SERVICE_INFO = LPNS_SERVICE_INFOW;
    {$ELSE}
   NS_SERVICE_INFO = NS_SERVICE_INFOA;
   PNS_SERVICE_INFO = PNS_SERVICE_INFOA;
   LPNS_SERVICE_INFO = LPNS_SERVICE_INFOA;
    {$ENDIF}
  {$ENDIF}

type
// structure for IP_PKTINFO option
  {$EXTERNALSYM IN_PKTINFO}
  IN_PKTINFO = packed record
    ipi_addr    : TInAddr;  // destination IPv4 address
    ipi_ifindex : UINT;    // received interface index
  end;
  TInPktInfo = IN_PKTINFO;
  PInPktInfo = ^IN_PKTINFO;

// structure for IPV6_PKTINFO option
  {$EXTERNALSYM IN6_PKTINFO}
  IN6_PKTINFO = packed record
    ipi6_addr       : TIn6Addr; // destination IPv6 address
    ipi6_ifindex    : UINT;     // received interface index
  end;
  TIn6PktInfo = IN6_PKTINFO;
  PIn6PktInfo = ^TIn6PktInfo;

// Error codes from getaddrinfo()
const
  {$EXTERNALSYM EAI_AGAIN}
  EAI_AGAIN             = WSATRY_AGAIN;
  {$EXTERNALSYM EAI_BADFLAGS}
  EAI_BADFLAGS          = WSAEINVAL;
  {$EXTERNALSYM EAI_FAIL}
  EAI_FAIL              = WSANO_RECOVERY;
  {$EXTERNALSYM EAI_FAMILY}
  EAI_FAMILY            = WSAEAFNOSUPPORT;
  {$EXTERNALSYM EAI_MEMORY}
  EAI_MEMORY            = WSA_NOT_ENOUGH_MEMORY;
//  {$EXTERNALSYM EAI_NODATA}
//  EAI_NODATA           = WSANO_DATA;
  {$EXTERNALSYM EAI_NONAME}
  EAI_NONAME            = WSAHOST_NOT_FOUND;
  {$EXTERNALSYM EAI_SERVICE}
  EAI_SERVICE           = WSATYPE_NOT_FOUND;
  {$EXTERNALSYM EAI_SOCKTYPE}
  EAI_SOCKTYPE          = WSAESOCKTNOSUPPORT;

//  DCR_FIX:  EAI_NODATA remove or fix
//
//  EAI_NODATA was removed from rfc2553bis
//  need to find out from the authors why and
//  determine the error for "no records of this type"
//  temporarily, we'll keep #define to avoid changing
//  code that could change back;  use NONAME
  {$EXTERNALSYM EAI_NODATA}
  EAI_NODATA            = EAI_NONAME;

// Structure used in getaddrinfo() call
type
  PAddrInfo = ^ADDRINFO;
  {$EXTERNALSYM ADDRINFO}
  ADDRINFO = packed record
    ai_flags        : Integer;      // AI_PASSIVE, AI_CANONNAME, AI_NUMERICHOST
    ai_family       : Integer;      // PF_xxx
    ai_socktype     : Integer;      // SOCK_xxx
    ai_protocol     : Integer;      // 0 or IPPROTO_xxx for IPv4 and IPv6
    ai_addrlen      : ULONG;        // Length of ai_addr
    ai_canonname    : PChar;        // Canonical name for nodename
    ai_addr         : PSOCKADDR;    // Binary address
    ai_next         : PAddrInfo;    // Next structure in linked list
  end;
  TAddrInfo = ADDRINFO;
  {$EXTERNALSYM LPADDRINFO}
  LPADDRINFO = PAddrInfo;

  PAddrInfoW = ^ADDRINFOW;
  {$EXTERNALSYM ADDRINFOW}
  ADDRINFOW = packed record
    ai_flags        : Integer;      // AI_PASSIVE, AI_CANONNAME, AI_NUMERICHOST
    ai_family       : Integer;      // PF_xxx
    ai_socktype     : Integer;      // SOCK_xxx
    ai_protocol     : Integer;      // 0 or IPPROTO_xxx for IPv4 and IPv6
    ai_addrlen      : ULONG;        // Length of ai_addr
    ai_canonname    : PWideChar;        // Canonical name for nodename
    ai_addr         : PSOCKADDR;    // Binary address
    ai_next         : PAddrInfo;    // Next structure in linked list
  end;
  TAddrInfoW = ADDRINFOW;
  {$EXTERNALSYM LPADDRINFO}
  LPADDRINFOW = PAddrInfoW;

// Flags used in "hints" argument to getaddrinfo()
const
  {$EXTERNALSYM AI_PASSIVE}
  AI_PASSIVE            = $1;   // Socket address will be used in bind() call
  {$EXTERNALSYM AI_CANONNAME}
  AI_CANONNAME          = $2;   // Return canonical name in first ai_canonname
  {$EXTERNALSYM AI_NUMERICHOST}
  AI_NUMERICHOST        = $4;   // Nodename must be a numeric address string

type
  {$EXTERNALSYM PADDRINFOEXA}
  PADDRINFOEXA = ^TAddrInfoEXA;
  {$EXTERNALSYM ADDRINFOEXA}
  ADDRINFOEXA = packed record
    ai_flags : Integer;       // AI_PASSIVE, AI_CANONNAME, AI_NUMERICHOST
    ai_family : Integer;      // PF_xxx
    ai_socktype : Integer;    // SOCK_xxx
    ai_protocol : Integer;    // 0 or IPPROTO_xxx for IPv4 and IPv6
    ai_addrlen : Integer; // size_t;     // Length of ai_addr
    ai_canonname : PChar;   // Canonical name for nodename
    ai_addr : Psockaddr;        // Binary address
    ai_blob : Pointer;
    ai_bloblen : Integer;  //size_t
    ai_provider : LPGUID;
    ai_next : PADDRINFOEXA;        // Next structure in linked list
  end;
  TAddrInfoEXA = ADDRINFOEXA;

  {$EXTERNALSYM LPADDRINFOEXA}
  LPADDRINFOEXA = PADDRINFOEXA;

  {$EXTERNALSYM PADDRINFOEXW}
  PADDRINFOEXW = ^TAddrInfoEXW;
  {$EXTERNALSYM ADDRINFOEXW}
  ADDRINFOEXW = packed record
    ai_flags : Integer;       // AI_PASSIVE, AI_CANONNAME, AI_NUMERICHOST
    ai_family : Integer;      // PF_xxx
    ai_socktype : Integer;    // SOCK_xxx
    ai_protocol : Integer;    // 0 or IPPROTO_xxx for IPv4 and IPv6
    ai_addrlen : Integer; // size_t;     // Length of ai_addr
    ai_canonname : PWideChar;   // Canonical name for nodename
    ai_addr : Psockaddr;        // Binary address
    ai_blob : Pointer;
    ai_bloblen : Integer;  //size_t
    ai_provider : LPGUID;
    ai_next : PADDRINFOEXW;        // Next structure in linked list
  end;
  TAddrInfoEXW = ADDRINFOEXA;

  {$EXTERNALSYM LPADDRINFOEXW}
  LPADDRINFOEXW = PADDRINFOEXW;

var
  {$EXTERNALSYM in6addr_any}
  in6addr_any: TIn6Addr;
  {$EXTERNALSYM in6addr_loopback}
  in6addr_loopback: TIn6Addr;

//=============================================================

{
	wsipx.h

	Microsoft Windows
	Copyright (C) Microsoft Corporation, 1992-1999.

	Windows Sockets include file for IPX/SPX.  This file contains all
	standardized IPX/SPX information.  Include this header file after
	winsock.h.

	To open an IPX socket, call socket() with an address family of
	AF_IPX, a socket type of SOCK_DGRAM, and protocol NSPROTO_IPX.
	Note that the protocol value must be specified, it cannot be 0.
	All IPX packets are sent with the packet type field of the IPX
	header set to 0.

	To open an SPX or SPXII socket, call socket() with an address
	family of AF_IPX, socket type of SOCK_SEQPACKET or SOCK_STREAM,
	and protocol of NSPROTO_SPX or NSPROTO_SPXII.  If SOCK_SEQPACKET
	is specified, then the end of message bit is respected, and
	recv() calls are not completed until a packet is received with
	the end of message bit set.  If SOCK_STREAM is specified, then
	the end of message bit is not respected, and recv() completes
	as soon as any data is received, regardless of the setting of the
	end of message bit.  Send coalescing is never performed, and sends
	smaller than a single packet are always sent with the end of
	message bit set.  Sends larger than a single packet are packetized
	with the end of message bit set on only the last packet of the
	send.
}


// This is the structure of the SOCKADDR structure for IPX and SPX.
type
  {$EXTERNALSYM SOCKADDR_IPX}
  SOCKADDR_IPX = packed record
    sa_family : u_short;
    sa_netnum : Array [0..3] of Char;
    sa_nodenum : Array [0..5] of Char;
    sa_socket : u_short;
  end;
  TSockAddrIPX = SOCKADDR_IPX;
  PSockAddrIPX = ^TSockAddrIPX;
  {$EXTERNALSYM PSOCKADDR_IPX}
  PSOCKADDR_IPX = PSockAddrIPX;
  {$EXTERNALSYM LPSOCKADDR_IPX}
  LPSOCKADDR_IPX = PSOCKADDR_IPX;

//  Protocol families used in the "protocol" parameter of the socket() API.
const
  {$EXTERNALSYM NSPROTO_IPX}
  NSPROTO_IPX   = 1000;
  {$EXTERNALSYM NSPROTO_SPX}
  NSPROTO_SPX   = 1256;
  {$EXTERNALSYM NSPROTO_SPXII}
  NSPROTO_SPXII = 1257;


//=============================================================

{
	wsnwlink.h

	Microsoft Windows
	Copyright (C) Microsoft Corporation, 1992-1999.
		Microsoft-specific extensions to the Windows NT IPX/SPX Windows
		Sockets interface.  These extensions are provided for use as
		necessary for compatibility with existing applications.  They are
		otherwise not recommended for use, as they are only guaranteed to
		work     over the Microsoft IPX/SPX stack.  An application which
		uses these     extensions may not work over other IPX/SPX
		implementations.  Include this header file after winsock.h and
		wsipx.h.

		To open an IPX socket where a particular packet type is sent in
		the IPX header, specify NSPROTO_IPX + n as the protocol parameter
		of the socket() API.  For example, to open an IPX socket that
		sets the packet type to 34, use the following socket() call:

			s = socket(AF_IPX, SOCK_DGRAM, NSPROTO_IPX + 34);
}

// Below are socket option that may be set or retrieved by specifying
// the appropriate manifest in the "optname" parameter of getsockopt()
// or setsockopt().  Use NSPROTO_IPX as the "level" argument for the
// call.
const

//	Set/get the IPX packet type.  The value specified in the
//	optval argument will be set as the packet type on every IPX
//	packet sent from this socket.  The optval parameter of
//	getsockopt()/setsockopt() points to an int.
  {$EXTERNALSYM IPX_PTYPE}
  IPX_PTYPE = $4000;

//	Set/get the receive filter packet type.  Only IPX packets with
//	a packet type equal to the value specified in the optval
//	argument will be returned; packets with a packet type that
//	does not match are discarded.  optval points to an int.
  {$EXTERNALSYM IPX_FILTERPTYPE}
  IPX_FILTERPTYPE = $4001;

//	Stop filtering on packet type set with IPX_FILTERPTYPE.
  {$EXTERNALSYM IPX_STOPFILTERPTYPE}
  IPX_STOPFILTERPTYPE = $4003;

//	Set/get the value of the datastream field in the SPX header on
//	every packet sent.  optval points to an int.
  {$EXTERNALSYM IPX_DSTYPE}
  IPX_DSTYPE = $4002;

//	Enable extended addressing.  On sends, adds the element
//	"unsigned char sa_ptype" to the SOCKADDR_IPX structure,
//	making the total length 15 bytes.  On receives, add both
//	the sa_ptype and "unsigned char sa_flags" to the SOCKADDR_IPX
//	structure, making the total length 16 bytes.  The current
//	bits defined in sa_flags are:
//		0x01 - the received frame was sent as a broadcast
//		0x02 - the received frame was sent from this machine
//	optval points to a BOOL.
  {$EXTERNALSYM IPX_EXTENDED_ADDRESS}
  IPX_EXTENDED_ADDRESS = $4004;

//	Send protocol header up on all receive packets.  optval points
//	to a BOOL.
  {$EXTERNALSYM IPX_RECVHDR}
  IPX_RECVHDR = $4005;

//	Get the maximum data size that can be sent.  Not valid with
//	setsockopt().  optval points to an int where the value is
//	returned.
  {$EXTERNALSYM IPX_MAXSIZE}
  IPX_MAXSIZE = $4006;

//	Query information about a specific adapter that IPX is bound
//	to.  In a system with n adapters they are numbered 0 through n-1.
//	Callers can issue the IPX_MAX_ADAPTER_NUM getsockopt() to find
//	out the number of adapters present, or call IPX_ADDRESS with
//	increasing values of adapternum until it fails.  Not valid
//	with setsockopt().  optval points to an instance of the
//	IPX_ADDRESS_DATA structure with the adapternum filled in.
  {$EXTERNALSYM IPX_ADDRESS}
  IPX_ADDRESS = $4007;

type
  {$EXTERNALSYM IPX_ADDRESS_DATA}
  IPX_ADDRESS_DATA = packed record
    adapternum : Integer;                 // input: 0-based adapter number
    netnum     : Array [0..3] of Byte;    // output: IPX network number
    nodenum    : Array [0..5] of Byte;    // output: IPX node address
    wan        : Boolean;                 // output: TRUE = adapter is on a wan link
    status     : Boolean;                 // output: TRUE = wan link is up (or adapter is not wan)
    maxpkt     : Integer;                 // output: max packet size, not including IPX header
    linkspeed  : ULONG;                   // output: link speed in 100 bytes/sec (i.e. 96 == 9600 bps)
  end;
  TIPXAddressData = IPX_ADDRESS_DATA;
  PIPXAddressData = ^TIPXAddressData;
  {$EXTERNALSYM PIPX_ADDRESS_DATA}
  PIPX_ADDRESS_DATA = PIPXAddressData;

const
//	Query information about a specific IPX network number.  If the
//	network is in IPX's cache it will return the information directly,    {Do not Localize}
//	otherwise it will issue RIP requests to find it.  Not valid with
//	setsockopt().  optval points to an instance of the IPX_NETNUM_DATA
//	structure with the netnum filled in.
  {$EXTERNALSYM IPX_GETNETINFO}
  IPX_GETNETINFO = $4008;

type
  {$EXTERNALSYM IPX_NETNUM_DATA}
  IPX_NETNUM_DATA = packed record
    netnum   : Array [0..3] of Byte;  // input: IPX network number
    hopcount : Word;                  // output: hop count to this network, in machine order
    netdelay : Word;                  // output: tick count to this network, in machine order
    cardnum  : Integer;               // output: 0-based adapter number used to route to this net;
                                      //         can be used as adapternum input to IPX_ADDRESS
    router   : Array [0..5] of Byte;  // output: MAC address of the next hop router, zeroed if
                                      //         the network is directly attached
  end;
  TIPXNetNumData = IPX_NETNUM_DATA;
  PIPXNetNumData = ^TIPXNetNumData;
  {$EXTERNALSYM PIPX_NETNUM_DATA}
  PIPX_NETNUM_DATA = PIPXNetNumData;

const
//	Like IPX_GETNETINFO except it  does not  issue RIP requests. If the
//	network is in IPX's cache it will return the information, otherwise    {Do not Localize}
//	it will fail (see also IPX_RERIPNETNUMBER which  always  forces a
//	re-RIP). Not valid with setsockopt().  optval points to an instance of
//	the IPX_NETNUM_DATA structure with the netnum filled in.
  {$EXTERNALSYM IPX_GETNETINFO_NORIP}
  IPX_GETNETINFO_NORIP = $4009;

//	Get information on a connected SPX socket.  optval points
//	to an instance of the IPX_SPXCONNSTATUS_DATA structure.
//  *** All numbers are in Novell (high-low) order. ***
  {$EXTERNALSYM IPX_SPXGETCONNECTIONSTATUS}
  IPX_SPXGETCONNECTIONSTATUS = $400B;

type
  {$EXTERNALSYM IPX_SPXCONNSTATUS_DATA}
  IPX_SPXCONNSTATUS_DATA = packed record
    ConnectionState         : Byte;
    WatchDogActive          : Byte;
    LocalConnectionId       : Word;
    RemoteConnectionId      : Word;
    LocalSequenceNumber     : Word;
    LocalAckNumber          : Word;
    LocalAllocNumber        : Word;
    RemoteAckNumber         : Word;
    RemoteAllocNumber       : Word;
    LocalSocket             : Word;
    ImmediateAddress        : Array [0..5] of Byte;
    RemoteNetwork           : Array [0..3] of Byte;
    RemoteNode              : Array [0..5] of Byte;
    RemoteSocket            : Word;
    RetransmissionCount     : Word;
    EstimatedRoundTripDelay : Word;                 // In milliseconds
    RetransmittedPackets    : Word;
    SuppressedPacket        : Word;
  end;
  TIPXSPXConnStatusData = IPX_SPXCONNSTATUS_DATA;
  PIPXSPXConnStatusData = ^TIPXSPXConnStatusData;
  {$EXTERNALSYM PIPX_SPXCONNSTATUS_DATA}
  PIPX_SPXCONNSTATUS_DATA = PIPXSPXConnStatusData;

const
//	Get notification when the status of an adapter that IPX is
//	bound to changes.  Typically this will happen when a wan line
//	goes up or down.  Not valid with setsockopt().  optval points
//	to a buffer which contains an IPX_ADDRESS_DATA structure
//	followed immediately by a HANDLE to an unsignaled event.
//
//	When the getsockopt() query is submitted, it will complete
//	successfully.  However, the IPX_ADDRESS_DATA pointed to by
//	optval will not be updated at that point.  Instead the
//	request is queued internally inside the transport.
//
//	When the status of an adapter changes, IPX will locate a
//	queued getsockopt() query and fill in all the fields in the
//	IPX_ADDRESS_DATA structure.  It will then signal the event
//	pointed to by the HANDLE in the optval buffer.  This handle
//	should be obtained before calling getsockopt() by calling
//	CreateEvent().  If multiple getsockopts() are submitted at
//	once, different events must be used.
//
//	The event is used because the call needs to be asynchronous
//	but currently getsockopt() does not support this.
//
//	WARNING: In the current implementation, the transport will
//	only signal one queued query for each status change.  Therefore
//	only one service which uses this query should be running at
//	once.
  {$EXTERNALSYM IPX_ADDRESS_NOTIFY}
  IPX_ADDRESS_NOTIFY = $400C;

//	Get the maximum number of adapters present.  If this call returns
//	n then the adapters are numbered 0 through n-1.  Not valid
//	with setsockopt().  optval points to an int where the value
//	is returned.
  {$EXTERNALSYM IPX_MAX_ADAPTER_NUM}
  IPX_MAX_ADAPTER_NUM = $400D;

//	Like IPX_GETNETINFO except it forces IPX to re-RIP even if the
//	network is in its cache (but not if it is directly attached to).
//	Not valid with setsockopt().  optval points to an instance of
//	the IPX_NETNUM_DATA structure with the netnum filled in.
  {$EXTERNALSYM IPX_RERIPNETNUMBER}
  IPX_RERIPNETNUMBER = $400E;

//	A hint that broadcast packets may be received.  The default is
//	TRUE.  Applications that do not need to receive broadcast packets
//	should set this sockopt to FALSE which may cause better system
//	performance (note that it does not necessarily cause broadcasts
//	to be filtered for the application).  Not valid with getsockopt().
//	optval points to a BOOL.
  {$EXTERNALSYM IPX_RECEIVE_BROADCAST}
  IPX_RECEIVE_BROADCAST = $400F;

//	On SPX connections, don't delay before sending ack.  Applications    {Do not Localize}
//	that do not tend to have back-and-forth traffic over SPX should
//	set this; it will increase the number of acks sent but will remove
//	delays in sending acks.  optval points to a BOOL.
  {$EXTERNALSYM IPX_IMMEDIATESPXACK}
  IPX_IMMEDIATESPXACK = $4010;


//=============================================================

//	wsnetbs.h
//	Copyright (c) 1994-1999, Microsoft Corp. All rights reserved.
//
//	Windows Sockets include file for NETBIOS.  This file contains all
//	standardized NETBIOS information.  Include this header file after
//	winsock.h.

//	To open a NetBIOS socket, call the socket() function as follows:
//
//		s = socket( AF_NETBIOS, {SOCK_SEQPACKET|SOCK_DGRAM}, -Lana );
//
//	where Lana is the NetBIOS Lana number of interest.  For example, to
//	open a socket for Lana 2, specify -2 as the "protocol" parameter
//	to the socket() function.


//	This is the structure of the SOCKADDR structure for NETBIOS.

const
  {$EXTERNALSYM NETBIOS_NAME_LENGTH}
  NETBIOS_NAME_LENGTH = 16;

type
  {$EXTERNALSYM SOCKADDR_NB}
  SOCKADDR_NB = packed record
    snb_family : Smallint;
    snb_type   : u_short;
    snb_name   : array[0..NETBIOS_NAME_LENGTH-1] of Char;
  end;
  TSockAddrNB  = SOCKADDR_NB;
  PSockAddrNB  = ^TSockAddrNB;
  {$EXTERNALSYM PSOCKADDR_NB}
  PSOCKADDR_NB = PSockAddrNB;
  {$EXTERNALSYM LPSOCKADDR_NB}
  LPSOCKADDR_NB = PSOCKADDR_NB;

//	Bit values for the snb_type field of SOCKADDR_NB.
const
  {$EXTERNALSYM NETBIOS_UNIQUE_NAME}
  NETBIOS_UNIQUE_NAME       = $0000;
  {$EXTERNALSYM NETBIOS_GROUP_NAME}
  NETBIOS_GROUP_NAME        = $0001;
  {$EXTERNALSYM NETBIOS_TYPE_QUICK_UNIQUE}
  NETBIOS_TYPE_QUICK_UNIQUE = $0002;
  {$EXTERNALSYM NETBIOS_TYPE_QUICK_GROUP}
  NETBIOS_TYPE_QUICK_GROUP  = $0003;

//	A macro convenient for setting up NETBIOS SOCKADDRs.
{$EXTERNALSYM SET_NETBIOS_SOCKADDR}
procedure SET_NETBIOS_SOCKADDR(snb : PSockAddrNB; const SnbType : Word; const Name : PChar; const Port : Char);


//=============================================================

//  Copyright 1997 - 1998 Microsoft Corporation
//
//  Module Name:
//
//  	ws2atm.h
//
//  Abstract:
//
//  	Winsock 2 ATM Annex definitions.

const
  {$EXTERNALSYM ATMPROTO_AALUSER}
  ATMPROTO_AALUSER = $00; // User-defined AAL
  {$EXTERNALSYM ATMPROTO_AAL1}
  ATMPROTO_AAL1    = $01; // AAL 1
  {$EXTERNALSYM ATMPROTO_AAL2}
  ATMPROTO_AAL2    = $02; // AAL 2
  {$EXTERNALSYM ATMPROTO_AAL34}
  ATMPROTO_AAL34   = $03; // AAL 3/4
  {$EXTERNALSYM ATMPROTO_AAL5}
  ATMPROTO_AAL5    = $05; // AAL 5

  {$EXTERNALSYM SAP_FIELD_ABSENT}
  SAP_FIELD_ABSENT        = $FFFFFFFE;
  {$EXTERNALSYM SAP_FIELD_ANY}
  SAP_FIELD_ANY           = $FFFFFFFF;
  {$EXTERNALSYM SAP_FIELD_ANY_AESA_SEL}
  SAP_FIELD_ANY_AESA_SEL  = $FFFFFFFA;
  {$EXTERNALSYM SAP_FIELD_ANY_AESA_REST}
  SAP_FIELD_ANY_AESA_REST = $FFFFFFFB;

  // values used for AddressType in struct ATM_ADDRESS
  {$EXTERNALSYM ATM_E164}
  ATM_E164 = $01; // E.164 addressing scheme
  {$EXTERNALSYM ATM_NSAP}
  ATM_NSAP = $02; // NSAP-style ATM Endsystem Address scheme
  {$EXTERNALSYM ATM_AESA}
  ATM_AESA = $02; // NSAP-style ATM Endsystem Address scheme

  {$EXTERNALSYM ATM_ADDR_SIZE}
  ATM_ADDR_SIZE = 20;

type
  {$EXTERNALSYM ATM_ADDRESS}
  ATM_ADDRESS = packed record
    AddressType : DWORD;                        // E.164 or NSAP-style ATM Endsystem Address
    NumofDigits : DWORD;                        // number of digits;
    Addr : Array[0..ATM_ADDR_SIZE-1] of Byte; // IA5 digits for E164, BCD encoding for NSAP
                                                // format as defined in the ATM Forum UNI 3.1
  end;

// values used for Layer2Protocol in B-LLI
const
  {$EXTERNALSYM BLLI_L2_ISO_1745}
  BLLI_L2_ISO_1745       = $01; // Basic mode ISO 1745
  {$EXTERNALSYM BLLI_L2_Q921}
  BLLI_L2_Q921           = $02; // CCITT Rec. Q.921
  {$EXTERNALSYM BLLI_L2_X25L}
  BLLI_L2_X25L           = $06; // CCITT Rec. X.25, link layer
  {$EXTERNALSYM BLLI_L2_X25M}
  BLLI_L2_X25M           = $07; // CCITT Rec. X.25, multilink
  {$EXTERNALSYM BLLI_L2_ELAPB}
  BLLI_L2_ELAPB          = $08; // Extended LAPB; for half duplex operation
  {$EXTERNALSYM BLLI_L2_HDLC_NRM}
  BLLI_L2_HDLC_NRM       = $09; // HDLC NRM (ISO 4335)
  {$EXTERNALSYM BLLI_L2_HDLC_ABM}
  BLLI_L2_HDLC_ABM       = $0A; // HDLC ABM (ISO 4335)
  {$EXTERNALSYM BLLI_L2_HDLC_ARM}
  BLLI_L2_HDLC_ARM       = $0B; // HDLC ARM (ISO 4335)
  {$EXTERNALSYM BLLI_L2_LLC}
  BLLI_L2_LLC            = $0C; // LAN logical link control (ISO 8802/2)
  {$EXTERNALSYM BLLI_L2_X75}
  BLLI_L2_X75            = $0D; // CCITT Rec. X.75, single link procedure
  {$EXTERNALSYM BLLI_L2_Q922}
  BLLI_L2_Q922           = $0E; // CCITT Rec. Q.922
  {$EXTERNALSYM BLLI_L2_USER_SPECIFIED}
  BLLI_L2_USER_SPECIFIED = $10; // User Specified
  {$EXTERNALSYM BLLI_L2_ISO_7776}
  BLLI_L2_ISO_7776       = $11; // ISO 7776 DTE-DTE operation

// values used for Layer3Protocol in B-LLI
  {$EXTERNALSYM BLLI_L3_X25}
  BLLI_L3_X25            = $06; // CCITT Rec. X.25, packet layer
  {$EXTERNALSYM BLLI_L3_ISO_8208}
  BLLI_L3_ISO_8208       = $07; // ISO/IEC 8208 (X.25 packet layer for DTE
  {$EXTERNALSYM BLLI_L3_X223}
  BLLI_L3_X223           = $08; // X.223/ISO 8878
  {$EXTERNALSYM BLLI_L3_SIO_8473}
  BLLI_L3_SIO_8473       = $09; // ISO/IEC 8473 (OSI connectionless)
  {$EXTERNALSYM BLLI_L3_T70}
  BLLI_L3_T70            = $0A; // CCITT Rec. T.70 min. network layer
  {$EXTERNALSYM BLLI_L3_ISO_TR9577}
  BLLI_L3_ISO_TR9577     = $0B; // ISO/IEC TR 9577 Network Layer Protocol ID
  {$EXTERNALSYM BLLI_L3_USER_SPECIFIED}
  BLLI_L3_USER_SPECIFIED = $10; // User Specified

// values used for Layer3IPI in B-LLI
  {$EXTERNALSYM BLLI_L3_IPI_SNAP}
  BLLI_L3_IPI_SNAP = $80; // IEEE 802.1 SNAP identifier
  {$EXTERNALSYM BLLI_L3_IPI_IP}
  BLLI_L3_IPI_IP   = $CC; // Internet Protocol (IP) identifier

type
  {$EXTERNALSYM ATM_BLLI}
  ATM_BLLI = packed record
    // Identifies the layer-two protocol.
    // Corresponds to the User information layer 2 protocol field in the B-LLI information element.
    // A value of SAP_FIELD_ABSENT indicates that this field is not used, and a value of SAP_FIELD_ANY means wildcard.
    Layer2Protocol              : DWORD; // User information layer 2 protocol
    // Identifies the user-specified layer-two protocol.
    // Only used if the Layer2Protocol parameter is set to BLLI_L2_USER_SPECIFIED.
    // The valid values range from zero-127.
    // Corresponds to the User specified layer 2 protocol information field in the B-LLI information element.
    Layer2UserSpecifiedProtocol : DWORD; // User specified layer 2 protocol information
    // Identifies the layer-three protocol.
    // Corresponds to the User information layer 3 protocol field in the B-LLI information element.
    // A value of SAP_FIELD_ABSENT indicates that this field is not used, and a value of SAP_FIELD_ANY means wildcard.
    Layer3Protocol              : DWORD; // User information layer 3 protocol
    // Identifies the user-specified layer-three protocol.
    // Only used if the Layer3Protocol parameter is set to BLLI_L3_USER_SPECIFIED.
    // The valid values range from zero-127.
    // Corresponds to the User specified layer 3 protocol information field in the B-LLI information element.
    Layer3UserSpecifiedProtocol : DWORD; // User specified layer 3 protocol information
    // Identifies the layer-three Initial Protocol Identifier.
    // Only used if the Layer3Protocol parameter is set to BLLI_L3_ISO_TR9577.
    // Corresponds to the ISO/IEC TR 9577 Initial Protocol Identifier field in the B-LLI information element.
    Layer3IPI                   : DWORD; // ISO/IEC TR 9577 Initial Protocol Identifier
    // Identifies the 802.1 SNAP identifier.
    // Only used if the Layer3Protocol parameter is set to BLLI_L3_ISO_TR9577 and Layer3IPI is set to BLLI_L3_IPI_SNAP,
    // indicating an IEEE 802.1 SNAP identifier. Corresponds to the OUI and PID fields in the B-LLI information element.
    SnapID                      : Array[0..4] of Byte; // SNAP ID consisting of OUI and PID
  end;

// values used for the HighLayerInfoType field in ATM_BHLI
const
  {$EXTERNALSYM BHLI_ISO}
  BHLI_ISO                 = $00; // ISO
  {$EXTERNALSYM BHLI_UserSpecific}
  BHLI_UserSpecific        = $01; // User Specific
  {$EXTERNALSYM BHLI_HighLayerProfile}
  BHLI_HighLayerProfile    = $02; // High layer profile (only in UNI3.0)
  {$EXTERNALSYM BHLI_VendorSpecificAppId}
  BHLI_VendorSpecificAppId = $03; // Vendor-Specific Application ID

type
  {$EXTERNALSYM ATM_BHLI}
  ATM_BHLI = packed record
    // Identifies the high layer information type field in the B-LLI information element.
    // Note that the type BHLI_HighLayerProfile has been eliminated in UNI 3.1.
    // A value of SAP_FIELD_ABSENT indicates that B-HLI is not present, and a value of SAP_FIELD_ANY means wildcard.
    HighLayerInfoType   : DWORD; // High Layer Information Type
    // Identifies the number of bytes from one to eight in the HighLayerInfo array.
    // Valid values include eight for the cases of BHLI_ISO and BHLI_UserSpecific,
    // four for BHLI_HighLayerProfile, and seven for BHLI_VendorSpecificAppId.
    HighLayerInfoLength : DWORD; // number of bytes in HighLayerInfo
    // Identifies the high layer information field in the B-LLI information element.
    // In the case of HighLayerInfoType being BHLI_VendorSpecificAppId,
    // the first 3 bytes consist of a globally-administered Organizationally Unique Identifier (OUI)
    // (as per IEEE standard 802-1990), followed by a 4-byte application identifier,
    // which is administered by the vendor identified by the OUI.
    // Value for the case of BHLI_UserSpecific is user defined and requires bilateral agreement between two end users.
    HighLayerInfo       : Array[0..7] of Byte; // the value dependent on the HighLayerInfoType field
  end;

// A new address family, AF_ATM, is introduced for native ATM services,
// and the corresponding SOCKADDR structure, sockaddr_atm, is defined in the following.
// To open a socket for native ATM services, parameters in socket should contain
// AF_ATM, SOCK_RAW, and ATMPROTO_AAL5 or ATMPROTO_AALUSER, respectively.
  {$EXTERNALSYM SOCKADDR_ATM}
  SOCKADDR_ATM = packed record
    // Identifies the address family, which is AF_ATM in this case.
    satm_family : u_short;
    // Identifies the ATM address that could be either in E.164 or NSAP-style ATM End Systems Address format.
    // This field will be mapped to the Called Party Number IE (Information Element)
    // if it is specified in bind and WSPBind for a listening socket, or in connect, WSAConnect, WSPConnect,
    // WSAJoinLeaf, or WSPJoinLeaf for a connecting socket.
    // It will be mapped to the Calling Party Number IE if specified in bind and WSPBind for a connecting socket.
    satm_number : ATM_ADDRESS;
    // Identifies the fields in the B-LLI Information Element that are used along with satm_bhli to identify an application.
    // Note that the B-LLI layer two information is treated as not present
    // if its Layer2Protocol field contains SAP_FIELD_ABSENT, or as a wildcard if it contains SAP_FIELD_ANY.
    // Similarly, the B-LLI layer three information is treated as not present
    // if its Layer3Protocol field contains SAP_FIELD_ABSENT, or as a wildcard if it contains SAP_FIELD_ANY.
    satm_blli   : ATM_BLLI;    // B-LLI
    // Identifies the fields in the B-HLI Information Element that are used along with satm_blli to identify an application.
    satm_bhli   : ATM_BHLI;    // B-HLI
  end;
  TSockAddrATM = SOCKADDR_ATM;
  PSockAddrATM = ^TSockAddrATM;
  {$EXTERNALSYM PSOCKADDR_ATM}
  PSOCKADDR_ATM = PSockAddrATM;
  {$EXTERNALSYM LPSOCKADDR_ATM}
  LPSOCKADDR_ATM = PSOCKADDR_ATM;

  {$EXTERNALSYM Q2931_IE_TYPE}
  Q2931_IE_TYPE = (IE_AALParameters, IE_TrafficDescriptor,
    IE_BroadbandBearerCapability, IE_BHLI, IE_BLLI,IE_CalledPartyNumber,
    IE_CalledPartySubaddress, IE_CallingPartyNumber, IE_CallingPartySubaddress,
    IE_Cause, IE_QOSClass, IE_TransitNetworkSelection
  );

  {$EXTERNALSYM Q2931_IE}
  Q2931_IE = record
    IEType   : Q2931_IE_TYPE;
    IELength : ULONG;
    IE       : Array[0..0] of Byte;
  end;

// manifest constants for the AALType field in struct AAL_PARAMETERS_IE
  {$EXTERNALSYM AAL_TYPE}
  AAL_TYPE = LongInt;

const
  {$EXTERNALSYM AALTYPE_5}
  AALTYPE_5    =  5; // AAL 5
  {$EXTERNALSYM AALTYPE_USER}
  AALTYPE_USER = 16; // user-defined AAL

  // values used for the Mode field in struct AAL5_PARAMETERS
  {$EXTERNALSYM AAL5_MODE_MESSAGE}
  AAL5_MODE_MESSAGE   = $01;
  {$EXTERNALSYM AAL5_MODE_STREAMING}
  AAL5_MODE_STREAMING = $02;

// values used for the SSCSType field in struct AAL5_PARAMETERS
  {$EXTERNALSYM AAL5_SSCS_NULL}
  AAL5_SSCS_NULL              = $00;
  {$EXTERNALSYM AAL5_SSCS_SSCOP_ASSURED}
  AAL5_SSCS_SSCOP_ASSURED     = $01;
  {$EXTERNALSYM AAL5_SSCS_SSCOP_NON_ASSURED}
  AAL5_SSCS_SSCOP_NON_ASSURED = $02;
  {$EXTERNALSYM AAL5_SSCS_FRAME_RELAY}
  AAL5_SSCS_FRAME_RELAY       = $04;

type
  {$EXTERNALSYM AAL5_PARAMETERS}
  AAL5_PARAMETERS = packed record
    ForwardMaxCPCSSDUSize  : ULONG;
    BackwardMaxCPCSSDUSize : ULONG;
    Mode     : Byte; // only available in UNI 3.0
    SSCSType : Byte;
  end;

  {$EXTERNALSYM AALUSER_PARAMETERS}
  AALUSER_PARAMETERS = packed record
    UserDefined : ULONG;
  end;

  {$EXTERNALSYM AAL_PARAMETERS_IE}
  AAL_PARAMETERS_IE = packed record
    AALType : AAL_TYPE;
    case Byte of
      0: ( AAL5Parameters    : AAL5_PARAMETERS );
      1: ( AALUserParameters : AALUSER_PARAMETERS );
  end;

  {$EXTERNALSYM ATM_TD}
  ATM_TD = packed record
    PeakCellRate_CLP0         : ULONG;
    PeakCellRate_CLP01        : ULONG;
    SustainableCellRate_CLP0  : ULONG;
    SustainableCellRate_CLP01 : ULONG;
    MaxBurstSize_CLP0         : ULONG;
    MaxBurstSize_CLP01        : ULONG;
    Tagging                   : LongBool;
  end;

  {$EXTERNALSYM ATM_TRAFFIC_DESCRIPTOR_IE}
  ATM_TRAFFIC_DESCRIPTOR_IE = packed record
    Forward    : ATM_TD;
    Backward   : ATM_TD;
    BestEffort : LongBool;
  end;

// values used for the BearerClass field in struct ATM_BROADBAND_BEARER_CAPABILITY_IE
const
  {$EXTERNALSYM BCOB_A}
  BCOB_A = $01; // Bearer class A
  {$EXTERNALSYM BCOB_C}
  BCOB_C = $03; // Bearer class C
  {$EXTERNALSYM BCOB_X}
  BCOB_X = $10; // Bearer class X

// values used for the TrafficType field in struct ATM_BROADBAND_BEARER_CAPABILITY_IE
  {$EXTERNALSYM TT_NOIND}
  TT_NOIND = $00; // No indication of traffic type
  {$EXTERNALSYM TT_CBR}
  TT_CBR   = $04; // Constant bit rate
  {$EXTERNALSYM TT_VBR}
  TT_VBR   = $06; // Variable bit rate

// values used for the TimingRequirements field in struct ATM_BROADBAND_BEARER_CAPABILITY_IE
  {$EXTERNALSYM TR_NOIND}
  TR_NOIND         = $00; // No timing requirement indication
  {$EXTERNALSYM TR_END_TO_END}
  TR_END_TO_END    = $01; // End-to-end timing required
  {$EXTERNALSYM TR_NO_END_TO_END}
  TR_NO_END_TO_END = $02; // End-to-end timing not required

// values used for the ClippingSusceptability field in struct ATM_BROADBAND_BEARER_CAPABILITY_IE
  {$EXTERNALSYM CLIP_NOT}
  CLIP_NOT = $00; // Not susceptible to clipping
  {$EXTERNALSYM CLIP_SUS}
  CLIP_SUS = $20; // Susceptible to clipping

// values used for the UserPlaneConnectionConfig field in struct ATM_BROADBAND_BEARER_CAPABILITY_IE
  {$EXTERNALSYM UP_P2P}
  UP_P2P  = $00; // Point-to-point connection
  {$EXTERNALSYM UP_P2MP}
  UP_P2MP = $01; // Point-to-multipoint connection

type
  {$EXTERNALSYM ATM_BROADBAND_BEARER_CAPABILITY_IE}
  ATM_BROADBAND_BEARER_CAPABILITY_IE = packed record
    BearerClass : Byte;
    TrafficType : Byte;
    TimingRequirements        : Byte;
    ClippingSusceptability    : Byte;
    UserPlaneConnectionConfig : Byte;
  end;
  {$EXTERNALSYM ATM_BHLI_IE}
  ATM_BHLI_IE = ATM_BHLI;

// values used for the Layer2Mode field in struct ATM_BLLI_IE
const
  {$EXTERNALSYM BLLI_L2_MODE_NORMAL}
  BLLI_L2_MODE_NORMAL = $40;
  {$EXTERNALSYM BLLI_L2_MODE_EXT}
  BLLI_L2_MODE_EXT    = $80;

// values used for the Layer3Mode field in struct ATM_BLLI_IE
  {$EXTERNALSYM BLLI_L3_MODE_NORMAL}
  BLLI_L3_MODE_NORMAL = $40;
  {$EXTERNALSYM BLLI_L3_MODE_EXT}
  BLLI_L3_MODE_EXT    = $80;

// values used for the Layer3DefaultPacketSize field in struct ATM_BLLI_IE
  {$EXTERNALSYM BLLI_L3_PACKET_16}
  BLLI_L3_PACKET_16   = $04;
  {$EXTERNALSYM BLLI_L3_PACKET_32}
  BLLI_L3_PACKET_32   = $05;
  {$EXTERNALSYM BLLI_L3_PACKET_64}
  BLLI_L3_PACKET_64   = $06;
  {$EXTERNALSYM BLLI_L3_PACKET_128}
  BLLI_L3_PACKET_128  = $07;
  {$EXTERNALSYM BLLI_L3_PACKET_256}
  BLLI_L3_PACKET_256  = $08;
  {$EXTERNALSYM BLLI_L3_PACKET_512}
  BLLI_L3_PACKET_512  = $09;
  {$EXTERNALSYM BLLI_L3_PACKET_1024}
  BLLI_L3_PACKET_1024 = $0A;
  {$EXTERNALSYM BLLI_L3_PACKET_2048}
  BLLI_L3_PACKET_2048 = $0B;
  {$EXTERNALSYM BLLI_L3_PACKET_4096}
  BLLI_L3_PACKET_4096 = $0C;

type
  {$EXTERNALSYM ATM_BLLI_IE}
  ATM_BLLI_IE = record
    Layer2Protocol              : DWORD; // User information layer 2 protocol
    Layer2Mode                  : Byte;
    Layer2WindowSize            : Byte;
    Layer2UserSpecifiedProtocol : DWORD; // User specified layer 2 protocol information
    Layer3Protocol              : DWORD; // User information layer 3 protocol
    Layer3Mode                  : Byte;
    Layer3DefaultPacketSize     : Byte;
    Layer3PacketWindowSize      : Byte;
    Layer3UserSpecifiedProtocol : DWORD; // User specified layer 3 protocol information
    Layer3IPI                   : DWORD; // ISO/IEC TR 9577 Initial Protocol Identifier
    SnapID       : Array[0..4] of Byte;  // SNAP ID consisting of OUI and PID
  end;
  {$EXTERNALSYM ATM_CALLED_PARTY_NUMBER_IE}
  ATM_CALLED_PARTY_NUMBER_IE = ATM_ADDRESS;
  {$EXTERNALSYM ATM_CALLED_PARTY_SUBADDRESS_IE}
  ATM_CALLED_PARTY_SUBADDRESS_IE = ATM_ADDRESS;

// values used for the Presentation_Indication field in struct ATM_CALLING_PARTY_NUMBER_IE
const
  {$EXTERNALSYM PI_ALLOWED}
  PI_ALLOWED              = $00;
  {$EXTERNALSYM PI_RESTRICTED}
  PI_RESTRICTED           = $40;
  {$EXTERNALSYM PI_NUMBER_NOT_AVAILABLE}
  PI_NUMBER_NOT_AVAILABLE = $80;

// values used for the Screening_Indicator field in struct ATM_CALLING_PARTY_NUMBER_IE
  {$EXTERNALSYM SI_USER_NOT_SCREENED}
  SI_USER_NOT_SCREENED = $00;
  {$EXTERNALSYM SI_USER_PASSED}
  SI_USER_PASSED       = $01;
  {$EXTERNALSYM SI_USER_FAILED}
  SI_USER_FAILED       = $02;
  {$EXTERNALSYM SI_NETWORK}
  SI_NETWORK           = $03;

type
  {$EXTERNALSYM ATM_CALLING_PARTY_NUMBER_IE}
  ATM_CALLING_PARTY_NUMBER_IE = record
    ATM_Number              : ATM_ADDRESS;
    Presentation_Indication : Byte;
    Screening_Indicator     : Byte;
  end;
  {$EXTERNALSYM ATM_CALLING_PARTY_SUBADDRESS_IE}
  ATM_CALLING_PARTY_SUBADDRESS_IE = ATM_ADDRESS;

// values used for the Location field in struct ATM_CAUSE_IE
const
  {$EXTERNALSYM CAUSE_LOC_USER}
  CAUSE_LOC_USER                  = $00;
  {$EXTERNALSYM CAUSE_LOC_PRIVATE_LOCAL}
  CAUSE_LOC_PRIVATE_LOCAL         = $01;
  {$EXTERNALSYM CAUSE_LOC_PUBLIC_LOCAL}
  CAUSE_LOC_PUBLIC_LOCAL          = $02;
  {$EXTERNALSYM CAUSE_LOC_TRANSIT_NETWORK}
  CAUSE_LOC_TRANSIT_NETWORK       = $03;
  {$EXTERNALSYM CAUSE_LOC_PUBLIC_REMOTE}
  CAUSE_LOC_PUBLIC_REMOTE         = $04;
  {$EXTERNALSYM CAUSE_LOC_PRIVATE_REMOTE}
  CAUSE_LOC_PRIVATE_REMOTE        = $05;
  {$EXTERNALSYM CAUSE_LOC_INTERNATIONAL_NETWORK}
  CAUSE_LOC_INTERNATIONAL_NETWORK = $06;
  {$EXTERNALSYM CAUSE_LOC_BEYOND_INTERWORKING}
  CAUSE_LOC_BEYOND_INTERWORKING   = $0A;

// values used for the Cause field in struct ATM_CAUSE_IE
  {$EXTERNALSYM CAUSE_UNALLOCATED_NUMBER}
  CAUSE_UNALLOCATED_NUMBER                = $01;
  {$EXTERNALSYM CAUSE_NO_ROUTE_TO_TRANSIT_NETWORK}
  CAUSE_NO_ROUTE_TO_TRANSIT_NETWORK       = $02;
  {$EXTERNALSYM CAUSE_NO_ROUTE_TO_DESTINATION}
  CAUSE_NO_ROUTE_TO_DESTINATION           = $03;
  {$EXTERNALSYM CAUSE_VPI_VCI_UNACCEPTABLE}
  CAUSE_VPI_VCI_UNACCEPTABLE              = $0A;
  {$EXTERNALSYM CAUSE_NORMAL_CALL_CLEARING}
  CAUSE_NORMAL_CALL_CLEARING              = $10;
  {$EXTERNALSYM CAUSE_USER_BUSY}
  CAUSE_USER_BUSY                         = $11;
  {$EXTERNALSYM CAUSE_NO_USER_RESPONDING}
  CAUSE_NO_USER_RESPONDING                = $12;
  {$EXTERNALSYM CAUSE_CALL_REJECTED}
  CAUSE_CALL_REJECTED                     = $15;
  {$EXTERNALSYM CAUSE_NUMBER_CHANGED}
  CAUSE_NUMBER_CHANGED                    = $16;
  {$EXTERNALSYM CAUSE_USER_REJECTS_CLIR}
  CAUSE_USER_REJECTS_CLIR                 = $17;
  {$EXTERNALSYM CAUSE_DESTINATION_OUT_OF_ORDER}
  CAUSE_DESTINATION_OUT_OF_ORDER          = $1B;
  {$EXTERNALSYM CAUSE_INVALID_NUMBER_FORMAT}
  CAUSE_INVALID_NUMBER_FORMAT             = $1C;
  {$EXTERNALSYM CAUSE_STATUS_ENQUIRY_RESPONSE}
  CAUSE_STATUS_ENQUIRY_RESPONSE           = $1E;
  {$EXTERNALSYM CAUSE_NORMAL_UNSPECIFIED}
  CAUSE_NORMAL_UNSPECIFIED                = $1F;
  {$EXTERNALSYM CAUSE_VPI_VCI_UNAVAILABLE}
  CAUSE_VPI_VCI_UNAVAILABLE               = $23;
  {$EXTERNALSYM CAUSE_NETWORK_OUT_OF_ORDER}
  CAUSE_NETWORK_OUT_OF_ORDER              = $26;
  {$EXTERNALSYM CAUSE_TEMPORARY_FAILURE}
  CAUSE_TEMPORARY_FAILURE                 = $29;
  {$EXTERNALSYM CAUSE_ACCESS_INFORMAION_DISCARDED}
  CAUSE_ACCESS_INFORMAION_DISCARDED       = $2B;
  {$EXTERNALSYM CAUSE_NO_VPI_VCI_AVAILABLE}
  CAUSE_NO_VPI_VCI_AVAILABLE              = $2D;
  {$EXTERNALSYM CAUSE_RESOURCE_UNAVAILABLE}
  CAUSE_RESOURCE_UNAVAILABLE              = $2F;
  {$EXTERNALSYM CAUSE_QOS_UNAVAILABLE}
  CAUSE_QOS_UNAVAILABLE                   = $31;
  {$EXTERNALSYM CAUSE_USER_CELL_RATE_UNAVAILABLE}
  CAUSE_USER_CELL_RATE_UNAVAILABLE        = $33;
  {$EXTERNALSYM CAUSE_BEARER_CAPABILITY_UNAUTHORIZED}
  CAUSE_BEARER_CAPABILITY_UNAUTHORIZED    = $39;
  {$EXTERNALSYM CAUSE_BEARER_CAPABILITY_UNAVAILABLE}
  CAUSE_BEARER_CAPABILITY_UNAVAILABLE     = $3A;
  {$EXTERNALSYM CAUSE_OPTION_UNAVAILABLE}
  CAUSE_OPTION_UNAVAILABLE                = $3F;
  {$EXTERNALSYM CAUSE_BEARER_CAPABILITY_UNIMPLEMENTED}
  CAUSE_BEARER_CAPABILITY_UNIMPLEMENTED   = $41;
  {$EXTERNALSYM CAUSE_UNSUPPORTED_TRAFFIC_PARAMETERS}
  CAUSE_UNSUPPORTED_TRAFFIC_PARAMETERS    = $49;
  {$EXTERNALSYM CAUSE_INVALID_CALL_REFERENCE}
  CAUSE_INVALID_CALL_REFERENCE            = $51;
  {$EXTERNALSYM CAUSE_CHANNEL_NONEXISTENT}
  CAUSE_CHANNEL_NONEXISTENT               = $52;
  {$EXTERNALSYM CAUSE_INCOMPATIBLE_DESTINATION}
  CAUSE_INCOMPATIBLE_DESTINATION          = $58;
  {$EXTERNALSYM CAUSE_INVALID_ENDPOINT_REFERENCE}
  CAUSE_INVALID_ENDPOINT_REFERENCE        = $59;
  {$EXTERNALSYM CAUSE_INVALID_TRANSIT_NETWORK_SELECTION}
  CAUSE_INVALID_TRANSIT_NETWORK_SELECTION = $5B;
  {$EXTERNALSYM CAUSE_TOO_MANY_PENDING_ADD_PARTY}
  CAUSE_TOO_MANY_PENDING_ADD_PARTY        = $5C;
  {$EXTERNALSYM CAUSE_AAL_PARAMETERS_UNSUPPORTED}
  CAUSE_AAL_PARAMETERS_UNSUPPORTED        = $5D;
  {$EXTERNALSYM CAUSE_MANDATORY_IE_MISSING}
  CAUSE_MANDATORY_IE_MISSING              = $60;
  {$EXTERNALSYM CAUSE_UNIMPLEMENTED_MESSAGE_TYPE}
  CAUSE_UNIMPLEMENTED_MESSAGE_TYPE        = $61;
  {$EXTERNALSYM CAUSE_UNIMPLEMENTED_IE}
  CAUSE_UNIMPLEMENTED_IE                  = $63;
  {$EXTERNALSYM CAUSE_INVALID_IE_CONTENTS}
  CAUSE_INVALID_IE_CONTENTS               = $64;
  {$EXTERNALSYM CAUSE_INVALID_STATE_FOR_MESSAGE}
  CAUSE_INVALID_STATE_FOR_MESSAGE         = $65;
  {$EXTERNALSYM CAUSE_RECOVERY_ON_TIMEOUT}
  CAUSE_RECOVERY_ON_TIMEOUT               = $66;
  {$EXTERNALSYM CAUSE_INCORRECT_MESSAGE_LENGTH}
  CAUSE_INCORRECT_MESSAGE_LENGTH          = $68;
  {$EXTERNALSYM CAUSE_PROTOCOL_ERROR}
  CAUSE_PROTOCOL_ERROR                    = $6F;

// values used for the Condition portion of the Diagnostics field
// in struct ATM_CAUSE_IE, for certain Cause values
  {$EXTERNALSYM CAUSE_COND_UNKNOWN}
  CAUSE_COND_UNKNOWN   = $00;
  {$EXTERNALSYM CAUSE_COND_PERMANENT}
  CAUSE_COND_PERMANENT = $01;
  {$EXTERNALSYM CAUSE_COND_TRANSIENT}
  CAUSE_COND_TRANSIENT = $02;

// values used for the Rejection Reason portion of the Diagnostics field
// in struct ATM_CAUSE_IE, for certain Cause values
  {$EXTERNALSYM CAUSE_REASON_USER}
  CAUSE_REASON_USER            = $00;
  {$EXTERNALSYM CAUSE_REASON_IE_MISSING}
  CAUSE_REASON_IE_MISSING      = $04;
  {$EXTERNALSYM CAUSE_REASON_IE_INSUFFICIENT}
  CAUSE_REASON_IE_INSUFFICIENT = $08;

// values used for the P-U flag of the Diagnostics field
// in struct ATM_CAUSE_IE, for certain Cause values
  {$EXTERNALSYM CAUSE_PU_PROVIDER}
  CAUSE_PU_PROVIDER = $00;
  {$EXTERNALSYM CAUSE_PU_USER}
  CAUSE_PU_USER     = $08;

// values used for the N-A flag of the Diagnostics field
// in struct ATM_CAUSE_IE, for certain Cause values
  {$EXTERNALSYM CAUSE_NA_NORMAL}
  CAUSE_NA_NORMAL = $00;
  {$EXTERNALSYM CAUSE_NA_ABNORMAL}
  CAUSE_NA_ABNORMAL = $04;

type
  {$EXTERNALSYM ATM_CAUSE_IE}
  ATM_CAUSE_IE = record
    Location          : Byte;
    Cause             : Byte;
    DiagnosticsLength : Byte;
    Diagnostics       : Array[0..3] of Byte;
  end;

// values used for the QOSClassForward and QOSClassBackward
// field in struct ATM_QOS_CLASS_IE
const
  {$EXTERNALSYM QOS_CLASS0}
  QOS_CLASS0 = $00;
  {$EXTERNALSYM QOS_CLASS1}
  QOS_CLASS1 = $01;
  {$EXTERNALSYM QOS_CLASS2}
  QOS_CLASS2 = $02;
  {$EXTERNALSYM QOS_CLASS3}
  QOS_CLASS3 = $03;
  {$EXTERNALSYM QOS_CLASS4}
  QOS_CLASS4 = $04;

type
  {$EXTERNALSYM ATM_QOS_CLASS_IE}
  ATM_QOS_CLASS_IE = packed record
    QOSClassForward  : Byte;
    QOSClassBackward : Byte;
  end;

// values used for the TypeOfNetworkId field in struct ATM_TRANSIT_NETWORK_SELECTION_IE
const
  {$EXTERNALSYM TNS_TYPE_NATIONAL}
  TNS_TYPE_NATIONAL = $40;

// values used for the NetworkIdPlan field in struct ATM_TRANSIT_NETWORK_SELECTION_IE
  {$EXTERNALSYM TNS_PLAN_CARRIER_ID_CODE}
  TNS_PLAN_CARRIER_ID_CODE = $01;

type
  {$EXTERNALSYM ATM_TRANSIT_NETWORK_SELECTION_IE}
  ATM_TRANSIT_NETWORK_SELECTION_IE = record
    TypeOfNetworkId : Byte;
    NetworkIdPlan   : Byte;
    NetworkIdLength : Byte;
    NetworkId : Array[0..0] of Byte;
  end;

// ATM specific Ioctl codes
const
  {$EXTERNALSYM SIO_GET_NUMBER_OF_ATM_DEVICES}
  SIO_GET_NUMBER_OF_ATM_DEVICES = $50160001;
  {$EXTERNALSYM SIO_GET_ATM_ADDRESS}
  SIO_GET_ATM_ADDRESS           = $d0160002;
  {$EXTERNALSYM SIO_ASSOCIATE_PVC}
  SIO_ASSOCIATE_PVC             = $90160003;
  {$EXTERNALSYM SIO_GET_ATM_CONNECTION_ID}
  SIO_GET_ATM_CONNECTION_ID     = $50160004;

// ATM Connection Identifier
type
  {$EXTERNALSYM ATM_CONNECTION_ID}
  ATM_CONNECTION_ID = packed record
    DeviceNumber : DWORD;
    VPI          : DWORD;
    VCI          : DWORD;
  end;

// Input buffer format for SIO_ASSOCIATE_PVC
  {$EXTERNALSYM ATM_PVC_PARAMS}
  ATM_PVC_PARAMS = packed record
    PvcConnectionId : ATM_CONNECTION_ID;
    PvcQos          : QOS;
  end;

  procedure InitializeWinSock;
  procedure UninitializeWinSock;
  function Winsock2Loaded: Boolean;
  function WinsockHandle : THandle;

//JPM
{
I made these symbols up so to prevent range check warnings in FreePascal.
SizeOf is a smallInt when an expression is evaluated at run-time.  This
run-time evaluation makes no sense because the compiler knows these when compiling
so it should give us the numbers.  

}
const
 {$EXTERNALSYM SIZE_WSACMSGHDR}
  SIZE_WSACMSGHDR = DWORD(SizeOf(WSACMSGHDR));
  {$EXTERNALSYM SIZE_FARPROC}
  SIZE_FARPROC = DWORD(SizeOf(FARPROC));
  {$EXTERNALSYM MAX_NATURAL_ALIGNMENT_SUB_1}
  MAX_NATURAL_ALIGNMENT_SUB_1 = DWORD(MAX_NATURAL_ALIGNMENT - 1);
  {$EXTERNALSYM SIZE_IP_MSFILTER}
  SIZE_IP_MSFILTER = DWORD(SizeOf(ip_msfilter));
  {$EXTERNALSYM SIZE_TINADDR}
  SIZE_TINADDR = DWORD(SizeOf(TInAddr));
  {$EXTERNALSYM SIZE_TIN6ADDR}
  SIZE_TIN6ADDR = DWORD(SizeOf(TIn6Addr));
  {$EXTERNALSYM SIZE_GROUP_FILTER}
  SIZE_GROUP_FILTER = DWORD(SizeOf(GROUP_FILTER));
  {$EXTERNALSYM SIZE_SOCKADDR_STORAGE}
  SIZE_SOCKADDR_STORAGE = DWORD(sizeof(SOCKADDR_STORAGE));
  {$EXTERNALSYM SIZE_GUID}
  SIZE_GUID = DWORD(SizeOf(TGuid));

//=============================================================
implementation
//=============================================================

uses
  IdResourceStrings;
  // (c) March 2001,  "Alex Konshin"<alexk@mtgroup.ru>

var
  hWinSockDll : THandle = 0; // WS2_32.DLL handle
  hMSWSockDll : THandle = 0; // MSWSOCK.DLL handle

function WinsockHandle : THandle;
begin
  Result := hWinSockDll;
end;

function Winsock2Loaded : Boolean;
begin
  Result := hWinSockDll <> 0;
end;

procedure InitializeWinSock;
var
  LData: TWSAData;
  LError: DWORD;
begin
  if hWinSockDll = 0 then begin
    hWinSockDll := Windows.LoadLibrary(WINSOCK2_DLL);
    if hWinSockDll <> 0 then begin
      LError := WSAStartup($202, LData);
      if LError = 0 then begin
        Exit;
      end;
      Windows.FreeLibrary(hWinSockDll);
      hWinSockDll := 0;
    end else begin
      LError := Windows.GetLastError;
    end;
    raise EIdWinsockStubError.Build(LError, RSWinsockLoadError, [WINSOCK2_DLL]);
  end;
end;

procedure LoadMSWSock;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if hMSWSockDll = 0 then begin
    hMSWSockDll := Windows.LoadLibrary(MSWSOCK_DLL);
    if hMSWSockDll = 0 then begin
      raise EIdWinsockStubError.Build(Windows.GetLastError, RSWinsockLoadError, [MSWSOCK_DLL]);
    end;
  end;
end;

procedure UninitializeWinSock;
begin
  if hMSWSockDll <> 0 then
  begin
    FreeLibrary(hMSWSockDll);
    hMSWSockDll := 0;
  end;
  if hWinSockDll <> 0 then
  begin
    WSACleanup;
    FreeLibrary(hWinSockDll);
    hWinSockDll := 0;
  end;
end;

constructor EIdWinsockStubError.Build(AWin32Error: DWORD; const ATitle: String; AArgs: array of const);
begin
  FTitle := IndyFormat(ATitle, AArgs);
  FWin32Error := AWin32Error;
  if AWin32Error = 0 then begin
    inherited Create(FTitle);
  end else
  begin
    FWin32ErrorMessage := SysUtils.SysErrorMessage(AWin32Error);
    inherited Create(FTitle + ': ' + FWin32ErrorMessage);    {Do not Localize}
  end;
end;

function FixupStub(hDll: THandle; const AName: string): Pointer;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if hDll = 0 then begin
    raise EIdWinsockStubError.Build(WSANOTINITIALISED, RSWinsockCallError, [AName]);
  end;
  Result := Windows.GetProcAddress(hDll, PChar(AName));
  if Result = nil then begin
    raise EIdWinsockStubError.Build(WSAEINVAL, RSWinsockCallError, [AName]);
  end;
end;

function FixupStubEx(hSocket: TSocket; const AName: string; const AGuid: TGUID): Pointer;
var
  LStatus: LongInt;
  LBytesSend: DWORD;
begin
  LStatus := WSAIoctl(hSocket, SIO_GET_EXTENSION_FUNCTION_POINTER, @AGuid, LongWord(SIZE_GUID),
    @Result, SIZE_FARPROC, @LBytesSend, nil, nil);
  if LStatus <> 0 then begin
    raise EIdWinsockStubError.Build(WSAGetLastError, RSWinsockCallError, [AName]);
  end;
end;

function Stub_WSAStartup(const wVersionRequired: word; out WSData: TWSAData): Integer; stdcall;
begin
  @WSAStartup := FixupStub(hWinSockDll, 'WSAStartup'); {Do not Localize}
  Result := WSAStartup(wVersionRequired, WSData);
end;

function Stub_WSACleanup: Integer; stdcall;
begin
  @WSACleanup := FixupStub(hWinSockDll, 'WSACleanup'); {Do not Localize}
  Result := WSACleanup;
end;

function Stub_accept(const s: TSocket; addr: PSockAddr; addrlen: PInteger): TSocket; stdcall;
begin
  @accept := FixupStub(hWinSockDll, 'accept'); {Do not Localize}
  Result := accept(s, addr, addrlen);
end;

function Stub_bind(const s: TSocket; const name: PSockAddr; const namelen: Integer): Integer; stdcall;
begin
  @bind := FixupStub(hWinSockDll, 'bind'); {Do not Localize}
  Result := bind(s, name, namelen);
end;

function Stub_closesocket(const s: TSocket): Integer; stdcall;
begin
  @closesocket := FixupStub(hWinSockDll, 'closesocket'); {Do not Localize}
  Result := closesocket(s);
end;

function Stub_connect(const s: TSocket; const name: PSockAddr; const namelen: Integer): Integer; stdcall;
begin
  @connect := FixupStub(hWinSockDll, 'connect'); {Do not Localize}
  Result := connect(s, name, namelen);
end;

function Stub_ioctlsocket(const s: TSocket; const cmd: DWORD; var arg: u_long): Integer; stdcall;
begin
  @ioctlsocket := FixupStub(hWinSockDll, 'ioctlsocket'); {Do not Localize}
  Result := ioctlsocket(s, cmd, arg);
end;

function Stub_getpeername(const s: TSocket; const name: PSockAddr; var namelen: Integer): Integer; stdcall;
begin
  @getpeername := FixupStub(hWinSockDll, 'getpeername'); {Do not Localize}
  Result := getpeername(s, name, namelen);
end;

function Stub_getsockname(const s: TSocket; const name: PSockAddr; var namelen: Integer): Integer; stdcall;
begin
  @getsockname := FixupStub(hWinSockDll, 'getsockname'); {Do not Localize}
  Result := getsockname(s, name, namelen);
end;

function Stub_getsockopt(const s: TSocket; const level, optname: Integer; optval: PChar; var optlen: Integer): Integer; stdcall;
begin
  @getsockopt := FixupStub(hWinSockDll, 'getsockopt'); {Do not Localize}
  Result := getsockopt(s, level, optname, optval, optlen);
end;

function Stub_htonl(hostlong: u_long): u_long; stdcall;
begin
  @htonl := FixupStub(hWinSockDll, 'htonl'); {Do not Localize}
  Result := htonl(hostlong);
end;

function Stub_htons(hostshort: u_short): u_short; stdcall;
begin
  @htons := FixupStub(hWinSockDll, 'htons'); {Do not Localize}
  Result := htons(hostshort);
end;

function Stub_inet_addr(cp: PChar): u_long; stdcall;
begin
  @inet_addr := FixupStub(hWinSockDll, 'inet_addr'); {Do not Localize}
  Result := inet_addr(cp);
end;

function Stub_inet_ntoa(inaddr: TInAddr): PChar; stdcall;
begin
  @inet_ntoa := FixupStub(hWinSockDll, 'inet_ntoa'); {Do not Localize}
  Result := inet_ntoa(inaddr);
end;

function Stub_listen(const s: TSocket; backlog: Integer): Integer; stdcall;
begin
  @listen := FixupStub(hWinSockDll, 'listen'); {Do not Localize}
  Result := listen(s, backlog);
end;

function Stub_ntohl(netlong: u_long): u_long; stdcall;
begin
  @ntohl := FixupStub(hWinSockDll, 'ntohl'); {Do not Localize}
  Result := ntohl(netlong);
end;

function Stub_ntohs(netshort: u_short): u_short; stdcall;
begin
  @ntohs := FixupStub(hWinSockDll, 'ntohs'); {Do not Localize}
  Result := ntohs(netshort);
end;

function Stub_recv(const s: TSocket; var Buf; len, flags: Integer): Integer; stdcall;
begin
  @recv := FixupStub(hWinSockDll, 'recv'); {Do not Localize}
  Result := recv(s, Buf, len, flags);
end;

function Stub_recvfrom(const s: TSocket; var Buf; len, flags: Integer; from: PSockAddr; fromlen: PInteger): Integer; stdcall;
begin
  @recvfrom := FixupStub(hWinSockDll, 'recvfrom'); {Do not Localize}
  Result := recvfrom(s, Buf, len, flags, from, fromlen);
end;

function Stub_select(nfds: Integer; readfds, writefds, exceptfds: PFDSet; timeout: PTimeVal): Integer; stdcall;
begin
  @select := FixupStub(hWinSockDll, 'select'); {Do not Localize}
  Result := select(nfds, readfds, writefds, exceptfds, timeout);
end;

function Stub_send(const s: TSocket; const Buf; len, flags: Integer): Integer; stdcall;
begin
  @send := FixupStub(hWinSockDll, 'send'); {Do not Localize}
  Result := send(s, Buf, len, flags);
end;

function Stub_sendto(const s: TSocket; const Buf; const len, flags: Integer; const addrto: PSockAddr; const tolen: Integer): Integer; stdcall;
begin
  @sendto := FixupStub(hWinSockDll, 'sendto'); {Do not Localize}
  Result := sendto(s, Buf, len, flags, addrto, tolen);
end;

function Stub_setsockopt(const s: TSocket; const level, optname: Integer; optval: PChar; const optlen: Integer): Integer; stdcall;
begin
  @setsockopt := FixupStub(hWinSockDll, 'setsockopt'); {Do not Localize}
  Result := setsockopt(s, level, optname, optval, optlen);
end;

function Stub_shutdown(const s: TSocket; const how: Integer): Integer; stdcall;
begin
  @shutdown := FixupStub(hWinSockDll, 'shutdown'); {Do not Localize}
  Result := shutdown(s, how);
end;

function Stub_socket(const af, istruct, protocol: Integer): TSocket; stdcall;
begin
  @socket := FixupStub(hWinSockDll, 'socket'); {Do not Localize}
  Result := socket(af, istruct, protocol);
end;

function Stub_gethostbyaddr(addr: Pointer; const len, addrtype: Integer): PHostEnt; stdcall;
begin
  @gethostbyaddr := FixupStub(hWinSockDll, 'gethostbyaddr'); {Do not Localize}
  Result := gethostbyaddr(addr, len, addrtype);
end;

function Stub_gethostbyname(name: PChar): PHostEnt; stdcall;
begin
  @gethostbyname := FixupStub(hWinSockDll, 'gethostbyname'); {Do not Localize}
  Result := gethostbyname(name);
end;

{$IFDEF UNDER_CE}
function Stub_sethostname(pName : PChar; cName : Integer) : Integer; stdcall;
begin
  @sethostname := FixupStub(hWinSockDll, 'sethostname'); {Do not Localize}
  Result := sethostname(pName, cName);  
end;
{$ENDIF}

function Stub_gethostname(name: PChar; len: Integer): Integer; stdcall;
begin
  @gethostname := FixupStub(hWinSockDll, 'gethostname'); {Do not Localize}
  Result := gethostname(name, len);
end;

function Stub_getservbyport(const port: Integer; const proto: PChar): PServEnt; stdcall;
begin
  @getservbyport := FixupStub(hWinSockDll, 'getservbyport'); {Do not Localize}
  Result := getservbyport(port, proto);
end;

function Stub_getservbyname(const name, proto: PChar): PServEnt; stdcall;
begin
  @getservbyname := FixupStub(hWinSockDll, 'getservbyname'); {Do not Localize}
  Result := getservbyname(name, proto);
end;

function Stub_getprotobynumber(const proto: Integer): PProtoEnt; stdcall;
begin
  @getprotobynumber := FixupStub(hWinSockDll, 'getprotobynumber'); {Do not Localize}
  Result := getprotobynumber(proto);
end;

function Stub_getprotobyname(const name: PChar): PProtoEnt; stdcall;
begin
  @getprotobyname := FixupStub(hWinSockDll, 'getprotobyname'); {Do not Localize}
  Result := getprotobyname(name);
end;

procedure Stub_WSASetLastError(const iError: Integer); stdcall;
begin
  @WSASetLastError := FixupStub(hWinSockDll, 'WSASetLastError'); {Do not Localize}
  WSASetLastError(iError);
end;

function Stub_WSAGetLastError: Integer; stdcall;
begin
  @WSAGetLastError := FixupStub(hWinSockDll, 'WSAGetLastError'); {Do not Localize}
  Result := WSAGetLastError;
end;

{$IFNDEF UNDER_CE}
function Stub_WSAIsBlocking: BOOL; stdcall;
begin
  @WSAIsBlocking := FixupStub(hWinSockDll, 'WSAIsBlocking'); {Do not Localize}
  Result := WSAIsBlocking;
end;

function Stub_WSAUnhookBlockingHook: Integer; stdcall;
begin
  @WSAUnhookBlockingHook := FixupStub(hWinSockDll, 'WSAUnhookBlockingHook'); {Do not Localize}
  Result := WSAUnhookBlockingHook;
end;

function Stub_WSASetBlockingHook(lpBlockFunc: TFarProc): TFarProc; stdcall;
begin
  @WSASetBlockingHook := FixupStub(hWinSockDll, 'WSASetBlockingHook'); {Do not Localize}
  Result := WSASetBlockingHook(lpBlockFunc);
end;

function Stub_WSACancelBlockingCall: Integer; stdcall;
begin
  @WSACancelBlockingCall := FixupStub(hWinSockDll, 'WSACancelBlockingCall'); {Do not Localize}
  Result := WSACancelBlockingCall;
end;

function Stub_WSAAsyncGetServByName(HWindow: HWND; wMsg: u_int; name, proto, buf: PChar; buflen: Integer): THandle; stdcall;
begin
  @WSAAsyncGetServByName := FixupStub(hWinSockDll, 'WSAAsyncGetServByName'); {Do not Localize}
  Result := WSAAsyncGetServByName(HWindow, wMsg, name, proto, buf, buflen);
end;

function Stub_WSAAsyncGetServByPort(HWindow: HWND; wMsg, port: u_int; proto, buf: PChar; buflen: Integer): THandle; stdcall;
begin
  @WSAAsyncGetServByPort := FixupStub(hWinSockDll, 'WSAAsyncGetServByPort'); {Do not Localize}
  Result := WSAAsyncGetServByPort(HWindow, wMsg, port, proto, buf, buflen);
end;

function Stub_WSAAsyncGetProtoByName(HWindow: HWND; wMsg: u_int; name, buf: PChar; buflen: Integer): THandle; stdcall;
begin
  @WSAAsyncGetProtoByName := FixupStub(hWinSockDll, 'WSAAsyncGetProtoByName'); {Do not Localize}
  Result := WSAAsyncGetProtoByName(HWindow, wMsg, name, buf, buflen);
end;

function Stub_WSAAsyncGetProtoByNumber(HWindow: HWND; wMsg: u_int; number: Integer; buf: PChar; buflen: Integer): THandle; stdcall;
begin
  @WSAAsyncGetProtoByNumber := FixupStub(hWinSockDll, 'WSAAsyncGetProtoByNumber'); {Do not Localize}
  Result := WSAAsyncGetProtoByNumber(HWindow, wMsg, number, buf, buflen);
end;

function Stub_WSAAsyncGetHostByName(HWindow: HWND; wMsg: u_int; name, buf: PChar; buflen: Integer): THandle; stdcall;
begin
  @WSAAsyncGetHostByName := FixupStub(hWinSockDll, 'WSAAsyncGetHostByName'); {Do not Localize}
  Result := WSAAsyncGetHostByName(HWindow, wMsg, name, buf, buflen);
end;

function Stub_WSAAsyncGetHostByAddr(HWindow: HWND; wMsg: u_int; addr: PChar; len, istruct: Integer; buf: PChar; buflen: Integer): THandle; stdcall;
begin
  @WSAAsyncGetHostByAddr := FixupStub(hWinSockDll, 'WSAAsyncGetHostByAddr'); {Do not Localize}
  Result := WSAAsyncGetHostByAddr(HWindow, wMsg, addr, len, istruct, buf, buflen);
end;

function Stub_WSACancelAsyncRequest(hAsyncTaskHandle: THandle): Integer; stdcall;
begin
  @WSACancelAsyncRequest := FixupStub(hWinSockDll, 'WSACancelAsyncRequest'); {Do not Localize}
  Result := WSACancelAsyncRequest(hAsyncTaskHandle);
end;
{$ENDIF}

function Stub_WSAAsyncSelect(const s: TSocket; HWindow: HWND; wMsg: u_int; lEvent: Longint): Integer; stdcall;
begin
  @WSAAsyncSelect := FixupStub(hWinSockDll, 'WSAAsyncSelect'); {Do not Localize}
  Result := WSAAsyncSelect(s, HWindow, wMsg, lEvent);
end;

function Stub___WSAFDIsSet(const s: TSocket; var FDSet: TFDSet): Bool; stdcall;
begin
  @__WSAFDIsSet := FixupStub(hWinSockDll, '__WSAFDIsSet'); {Do not Localize}
  Result := __WSAFDIsSet(s, FDSet);
end;

function Stub_WSAAccept(const s: TSocket; addr: PSockAddr; addrlen: PInteger; lpfnCondition: LPCONDITIONPROC; const dwCallbackData: DWORD): TSocket; stdcall;
begin
  @WSAAccept := FixupStub(hWinSockDll, 'WSAAccept'); {Do not Localize}
  Result := WSAAccept(s, addr, addrlen, lpfnCondition, dwCallbackData);
end;

function Stub_WSACloseEvent(const hEvent: wsaevent): WordBool; stdcall;
begin
  @WSACloseEvent := FixupStub(hWinSockDll, 'WSACloseEvent'); {Do not Localize}
  Result := WSACloseEvent(hEvent);
end;

function Stub_WSAConnect(const s: TSocket; const name: PSockAddr; const namelen: Integer; lpCallerData, lpCalleeData: LPWSABUF; lpSQOS, lpGQOS: LPQOS): Integer; stdcall;
begin
  @WSAConnect := FixupStub(hWinSockDll, 'WSAConnect'); {Do not Localize}
  Result := WSAConnect(s, name, namelen, lpCallerData, lpCalleeData, lpSQOS, lpGQOS);
end;

function Stub_WSACreateEvent: wsaevent; stdcall;
begin
  @WSACreateEvent := FixupStub(hWinSockDll, 'WSACreateEvent'); {Do not Localize}
  Result := WSACreateEvent;
end;

function Stub_WSADuplicateSocketA(const s: TSocket; const dwProcessId: DWORD; lpProtocolInfo: LPWSAPROTOCOL_INFOA): Integer; stdcall;
begin
  @WSADuplicateSocketA := FixupStub(hWinSockDll, 'WSADuplicateSocketA'); {Do not Localize}
  Result := WSADuplicateSocketA(s, dwProcessId, lpProtocolInfo);
end;

function Stub_WSADuplicateSocketW(const s: TSocket; const dwProcessId: DWORD; lpProtocolInfo: LPWSAPROTOCOL_INFOW): Integer; stdcall;
begin
  @WSADuplicateSocketW := FixupStub(hWinSockDll, 'WSADuplicateSocketW'); {Do not Localize}
  Result := WSADuplicateSocketW(s, dwProcessId, lpProtocolInfo);
end;

function Stub_WSADuplicateSocket(const s: TSocket; const dwProcessId: DWORD; lpProtocolInfo: LPWSAPROTOCOL_INFO): Integer; stdcall;
begin
  {$IFDEF UNICODE}
  @WSADuplicateSocket := FixupStub(hWinSockDll, 'WSADuplicateSocketW'); {Do not Localize}
  {$ELSE}
  @WSADuplicateSocket := FixupStub(hWinSockDll, 'WSADuplicateSocketA'); {Do not Localize}
  {$ENDIF}
  Result := WSADuplicateSocket(s, dwProcessId, lpProtocolInfo);
end;

function Stub_WSAEnumNetworkEvents(const s: TSocket; const hEventObject: WSAEVENT; lpNetworkEvents: LPWSANETWORKEVENTS): Integer; stdcall;
begin
  @WSAEnumNetworkEvents := FixupStub(hWinSockDll, 'WSAEnumNetworkEvents'); {Do not Localize}
  Result := WSAEnumNetworkEvents(s, hEventObject, lpNetworkEvents);
end;

function Stub_WSAEnumProtocolsA(lpiProtocols: PInteger; lpProtocolBuffer: LPWSAPROTOCOL_INFOA; var lpdwBufferLength: DWORD): Integer; stdcall;
begin
  @WSAEnumProtocolsA := FixupStub(hWinSockDll, 'WSAEnumProtocolsA'); {Do not Localize}
  Result := WSAEnumProtocolsA(lpiProtocols, lpProtocolBuffer, lpdwBufferLength);
end;

function Stub_WSAEnumProtocolsW(lpiProtocols: PInteger; lpProtocolBuffer: LPWSAPROTOCOL_INFOW; var lpdwBufferLength: DWORD): Integer; stdcall;
begin
  @WSAEnumProtocolsW := FixupStub(hWinSockDll, 'WSAEnumProtocolsW'); {Do not Localize}
  Result := WSAEnumProtocolsW(lpiProtocols, lpProtocolBuffer, lpdwBufferLength);
end;

function Stub_WSAEnumProtocols(lpiProtocols: PInteger; lpProtocolBuffer: LPWSAPROTOCOL_INFO; var lpdwBufferLength: DWORD): Integer; stdcall;
begin
  {$IFDEF UNICODE}
  @WSAEnumProtocols := FixupStub(hWinSockDll, 'WSAEnumProtocolsW'); {Do not Localize}
  {$ELSE}
  @WSAEnumProtocols := FixupStub(hWinSockDll, 'WSAEnumProtocolsA'); {Do not Localize}
  {$ENDIF}
  Result := WSAEnumProtocols(lpiProtocols, lpProtocolBuffer, lpdwBufferLength);
end;

function Stub_WSAEventSelect(const s: TSocket; const hEventObject: WSAEVENT; lNetworkEvents: LongInt): Integer; stdcall;
begin
  @WSAEventSelect := FixupStub(hWinSockDll, 'WSAEventSelect'); {Do not Localize}
  Result := WSAEventSelect(s, hEventObject, lNetworkEvents);
end;

function Stub_WSAGetOverlappedResult(const s: TSocket; AOverlapped: Pointer; lpcbTransfer: LPDWORD; fWait: BOOL; var lpdwFlags: DWORD): WordBool; stdcall;
begin
  @WSAGetOverlappedResult := FixupStub(hWinSockDll, 'WSAGetOverlappedResult'); {Do not Localize}
  Result := WSAGetOverlappedResult(s, AOverlapped, lpcbTransfer, fWait, lpdwFlags);
end;

function Stub_WSAGetQOSByName(const s: TSocket; lpQOSName: LPWSABUF; lpQOS: LPQOS): WordBool; stdcall;
begin
  @WSAGetQOSByName := FixupStub(hWinSockDll, 'WSAGetQOSByName'); {Do not Localize}
  Result := WSAGetQOSByName(s, lpQOSName, lpQOS);
end;

function Stub_WSAHtonl(const s: TSocket; hostlong: u_long; var lpnetlong: DWORD): Integer; stdcall;
begin
  @WSAHtonl := FixupStub(hWinSockDll, 'WSAHtonl'); {Do not Localize}
  Result := WSAHtonl(s, hostlong, lpnetlong);
end;

function Stub_WSAHtons(const s: TSocket; hostshort: u_short; var lpnetshort: WORD): Integer; stdcall;
begin
  @WSAHtons := FixupStub(hWinSockDll, 'WSAHtons'); {Do not Localize}
  Result := WSAHtons(s, hostshort, lpnetshort);
end;

function Stub_WSAIoctl(const s: TSocket; dwIoControlCode: DWORD; lpvInBuffer: Pointer; cbInBuffer: DWORD; lpvOutBuffer: Pointer; cbOutBuffer: DWORD; lpcbBytesReturned: LPDWORD; AOverlapped: Pointer; lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): Integer; stdcall;
begin
  @WSAIoctl := FixupStub(hWinSockDll, 'WSAIoctl'); {Do not Localize}
  Result := WSAIoctl(s, dwIoControlCode, lpvInBuffer, cbInBuffer, lpvOutBuffer, cbOutBuffer, lpcbBytesReturned, AOverlapped, lpCompletionRoutine);
end;

function Stub_WSAJoinLeaf(const s: TSocket; name: PSockAddr; namelen: Integer; lpCallerData, lpCalleeData: LPWSABUF; lpSQOS, lpGQOS: LPQOS; dwFlags: DWORD): TSocket; stdcall;
begin
  @WSAJoinLeaf := FixupStub(hWinSockDll, 'WSAJoinLeaf'); {Do not Localize}
  Result := WSAJoinLeaf(s, name, namelen, lpCallerData, lpCalleeData, lpSQOS, lpGQOS, dwFlags);
end;

function Stub_WSANtohl(const s: TSocket; netlong: u_long; var lphostlong: DWORD): Integer; stdcall;
begin
  @WSANtohl := FixupStub(hWinSockDll, 'WSANtohl'); {Do not Localize}
  Result := WSANtohl(s, netlong, lphostlong);
end;

function Stub_WSANtohs(const s: TSocket; netshort: u_short; var lphostshort: WORD): Integer; stdcall;
begin
  @WSANtohs := FixupStub(hWinSockDll, 'WSANtohs'); {Do not Localize}
  Result := WSANtohs(s, netshort, lphostshort);
end;

function Stub_WSARecv(const s: TSocket; lpBuffers: LPWSABUF; dwBufferCount: DWORD; var lpNumberOfBytesRecvd: DWORD; var lpFlags: DWORD; AOverlapped: LPWSAOVERLAPPED; lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): Integer; stdcall;
begin
  @WSARecv := FixupStub(hWinSockDll, 'WSARecv'); {Do not Localize}
  Result := WSARecv(s, lpBuffers, dwBufferCount, lpNumberOfBytesRecvd, lpFlags, AOverlapped, lpCompletionRoutine);
end;

function Stub_WSARecvDisconnect(const s: TSocket; lpInboundDisconnectData: LPWSABUF): Integer; stdcall;
begin
  @WSARecvDisconnect := FixupStub(hWinSockDll, 'WSARecvDisconnect'); {Do not Localize}
  Result := WSARecvDisconnect(s, lpInboundDisconnectData);
end;

function Stub_WSARecvFrom(const s: TSocket; lpBuffers: LPWSABUF; dwBufferCount: DWORD; var lpNumberOfBytesRecvd: DWORD; var lpFlags: DWORD; lpFrom: PSockAddr; lpFromlen: PInteger; AOverlapped: Pointer; lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): Integer; stdcall;
begin
  @WSARecvFrom := FixupStub(hWinSockDll, 'WSARecvFrom'); {Do not Localize}
  Result := WSARecvFrom(s, lpBuffers, dwBufferCount, lpNumberOfBytesRecvd, lpFlags, lpFrom, lpFromlen, AOverlapped, lpCompletionRoutine);
end;

function Stub_WSAResetEvent(hEvent: wsaevent): WordBool; stdcall;
begin
  @WSAResetEvent := FixupStub(hWinSockDll, 'WSAResetEvent'); {Do not Localize}
  Result := WSAResetEvent(hEvent);
end;

function Stub_WSASend(const s: TSocket; lpBuffers: LPWSABUF; dwBufferCount: DWORD; var lpNumberOfBytesSent: DWORD; dwFlags: DWORD; AOverlapped: LPWSAOVERLAPPED; lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): Integer; stdcall;
begin
  @WSASend := FixupStub(hWinSockDll, 'WSASend'); {Do not Localize}
  Result := WSASend(s, lpBuffers, dwBufferCount, lpNumberOfBytesSent, dwFlags, AOverlapped, lpCompletionRoutine);
end;

function Stub_WSASendDisconnect(const s: TSocket; lpOutboundDisconnectData: LPWSABUF): Integer; stdcall;
begin
  @WSASendDisconnect := FixupStub(hWinSockDll, 'WSASendDisconnect'); {Do not Localize}
  Result := WSASendDisconnect(s, lpOutboundDisconnectData);
end;

function Stub_WSASendTo(const s: TSocket; lpBuffers: LPWSABUF; dwBufferCount: DWORD; var lpNumberOfBytesSent: DWORD; dwFlags: DWORD; lpTo: PSOCKADDR; iTolen: Integer; AOverlapped: LPWSAOVERLAPPED; lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): Integer; stdcall;
begin
  @WSASendTo := FixupStub(hWinSockDll, 'WSASendTo'); {Do not Localize}
  Result := WSASendTo(s, lpBuffers, dwBufferCount, lpNumberOfBytesSent, dwFlags, lpTo, iTolen, AOverlapped, lpCompletionRoutine);
end;

function Stub_WSASetEvent(hEvent: WSAEVENT): WordBool; stdcall;
begin
  @WSASetEvent := FixupStub(hWinSockDll, 'WSASetEvent'); {Do not Localize}
  Result := WSASetEvent(hEvent);
end;

function Stub_WSASocketA(af, iType, protocol: Integer; lpProtocolInfo: LPWSAPROTOCOL_INFOA; g: GROUP; dwFlags: DWORD): TSocket; stdcall;
begin
  @WSASocketA := FixupStub(hWinSockDll, 'WSASocketA'); {Do not Localize}
  Result := WSASocketA(af, iType, protocol, lpProtocolInfo, g, dwFlags);
end;

function Stub_WSASocketW(af, iType, protocol: Integer; lpProtocolInfo: LPWSAPROTOCOL_INFOW; g: GROUP; dwFlags: DWORD): TSocket; stdcall;
begin
  @WSASocketW := FixupStub(hWinSockDll, 'WSASocketW'); {Do not Localize}
  Result := WSASocketW(af, iType, protocol, lpProtocolInfo, g, dwFlags);
end;

function Stub_WSASocket(af, iType, protocol: Integer; lpProtocolInfo: LPWSAPROTOCOL_INFO; g: GROUP; dwFlags: DWORD): TSocket; stdcall;
begin
  {$IFDEF UNICODE}
  @WSASocket := FixupStub(hWinSockDll, 'WSASocketW'); {Do not Localize}
  {$ELSE}
  @WSASocket := FixupStub(hWinSockDll, 'WSASocketA'); {Do not Localize}
  {$ENDIF}
  Result := WSASocket(af, iType, protocol, lpProtocolInfo, g, dwFlags);
end;

function Stub_WSAWaitForMultipleEvents(cEvents: DWORD; lphEvents: Pwsaevent; fWaitAll: LongBool; dwTimeout: DWORD; fAlertable: LongBool): DWORD; stdcall;
begin
  @WSAWaitForMultipleEvents := FixupStub(hWinSockDll, 'WSAWaitForMultipleEvents'); {Do not Localize}
  Result := WSAWaitForMultipleEvents(cEvents, lphEvents, fWaitAll, dwTimeout, fAlertable);
end;

function Stub_WSAAddressToStringA(lpsaAddress: PSockAddr; const dwAddressLength: DWORD; const lpProtocolInfo: LPWSAPROTOCOL_INFOA; const lpszAddressString: PChar; var lpdwAddressStringLength: DWORD): Integer; stdcall;
begin
  @WSAAddressToStringA := FixupStub(hWinSockDll, 'WSAAddressToStringA'); {Do not Localize}
  Result := WSAAddressToStringA(lpsaAddress, dwAddressLength, lpProtocolInfo, lpszAddressString, lpdwAddressStringLength);
end;

function Stub_WSAAddressToStringW(lpsaAddress: PSockAddr; const dwAddressLength: DWORD; const lpProtocolInfo: LPWSAPROTOCOL_INFOW; const lpszAddressString: PWideChar; var lpdwAddressStringLength: DWORD): Integer; stdcall;
begin
  @WSAAddressToStringW := FixupStub(hWinSockDll, 'WSAAddressToStringW'); {Do not Localize}
  Result := WSAAddressToStringW(lpsaAddress, dwAddressLength, lpProtocolInfo, lpszAddressString, lpdwAddressStringLength);
end;

function Stub_WSAAddressToString(lpsaAddress: PSockAddr; const dwAddressLength: DWORD; const lpProtocolInfo: LPWSAPROTOCOL_INFO;
  const lpszAddressString: {$IFDEF UNICODE}PWideChar{$ELSE}PChar{$ENDIF};
  var lpdwAddressStringLength: DWORD): Integer; stdcall;
begin
  {$IFDEF UNICODE}
  @WSAAddressToString := FixupStub(hWinSockDll, 'WSAAddressToStringW'); {Do not Localize}
  {$ELSE}
  @WSAAddressToString := FixupStub(hWinSockDll, 'WSAAddressToStringA'); {Do not Localize}
  {$ENDIF}
  Result := WSAAddressToString(lpsaAddress, dwAddressLength, lpProtocolInfo, lpszAddressString, lpdwAddressStringLength);
end;

function Stub_WSAStringToAddressA(const AddressString: PChar; const AddressFamily: Integer; const lpProtocolInfo: LPWSAPROTOCOL_INFOA; var lpAddress: TSockAddr; var lpAddressLength: Integer): Integer; stdcall;
begin
  @WSAStringToAddressA := FixupStub(hWinSockDll, 'WSAStringToAddressA'); {Do not Localize}
  Result := WSAStringToAddressA(AddressString, AddressFamily, lpProtocolInfo, lpAddress, lpAddressLength);
end;

function Stub_WSAStringToAddressW(const AddressString: PWideChar; const AddressFamily: Integer; const lpProtocolInfo: LPWSAPROTOCOL_INFOW; var lpAddress: TSockAddr; var lpAddressLength: Integer): Integer; stdcall;
begin
  @WSAStringToAddressW := FixupStub(hWinSockDll, 'WSAStringToAddressW'); {Do not Localize}
  Result := WSAStringToAddressW(AddressString, AddressFamily, lpProtocolInfo, lpAddress, lpAddressLength);
end;

function Stub_WSAStringToAddress (const AddressString: {$IFDEF UNICODE}PWideChar{$ELSE}PChar{$ENDIF};
  const AddressFamily: Integer; const lpProtocolInfo: LPWSAProtocol_Info; var lpAddress: TSockAddr;
  var lpAddressLength: Integer): Integer; stdcall;
begin
  {$IFDEF UNICODE}
  @WSAStringToAddress := FixupStub(hWinSockDll, 'WSAStringToAddressW'); {Do not Localize}
  {$ELSE}
  @WSAStringToAddress := FixupStub(hWinSockDll, 'WSAStringToAddressA'); {Do not Localize}
  {$ENDIF}
  Result := WSAStringToAddress(AddressString, AddressFamily, lpProtocolInfo, lpAddress, lpAddressLength);
end;

function Stub_WSALookupServiceBeginA(var qsRestrictions: TWSAQuerySetA; const dwControlFlags: DWORD; var hLookup: THandle): Integer; stdcall;
begin
  @WSALookupServiceBeginA := FixupStub(hWinSockDll, 'WSALookupServiceBeginA'); {Do not Localize}
  Result := WSALookupServiceBeginA(qsRestrictions, dwControlFlags, hLookup);
end;

function Stub_WSALookupServiceBeginW(var qsRestrictions: TWSAQuerySetW; const dwControlFlags: DWORD; var hLookup: THandle): Integer; stdcall;
begin
  @WSALookupServiceBeginW := FixupStub(hWinSockDll, 'WSALookupServiceBeginW'); {Do not Localize}
  Result := WSALookupServiceBeginW(qsRestrictions, dwControlFlags, hLookup);
end;

function Stub_WSALookupServiceBegin(var qsRestrictions: TWSAQuerySet; const dwControlFlags: DWORD; var hLookup: THandle): Integer; stdcall;
begin
  {$IFDEF UNICODE}
  @WSALookupServiceBegin := FixupStub(hWinSockDll, 'WSALookupServiceBeginW'); {Do not Localize}
  {$ELSE}
  @WSALookupServiceBegin := FixupStub(hWinSockDll, 'WSALookupServiceBeginA'); {Do not Localize}
  {$ENDIF}
  Result := WSALookupServiceBegin(qsRestrictions, dwControlFlags, hLookup);
end;

function Stub_WSALookupServiceNextA(const hLookup: THandle; const dwControlFlags: DWORD; var dwBufferLength: DWORD; lpqsResults: LPWSAQUERYSETA): Integer; stdcall;
begin
  @WSALookupServiceNextA := FixupStub(hWinSockDll, 'WSALookupServiceNextA'); {Do not Localize}
  Result := WSALookupServiceNextA(hLookup, dwControlFlags, dwBufferLength, lpqsResults);
end;

function Stub_WSALookupServiceNextW(const hLookup: THandle; const dwControlFlags: DWORD; var dwBufferLength: DWORD; lpqsResults: LPWSAQUERYSETW): Integer; stdcall;
begin
  @WSALookupServiceNextW := FixupStub(hWinSockDll, 'WSALookupServiceNextW'); {Do not Localize}
  Result := WSALookupServiceNextW(hLookup, dwControlFlags, dwBufferLength, lpqsResults);
end;

function Stub_WSALookupServiceNext(const hLookup: THandle; const dwControlFlags: DWORD; var dwBufferLength: DWORD; lpqsResults: LPWSAQUERYSET): Integer; stdcall;
begin
  {$IFDEF UNICODE}
  @WSALookupServiceNext := FixupStub(hWinSockDll, 'WSALookupServiceNextW'); {Do not Localize}
  {$ELSE}
  @WSALookupServiceNext := FixupStub(hWinSockDll, 'WSALookupServiceNextA'); {Do not Localize}
  {$ENDIF}
  Result := WSALookupServiceNext(hLookup, dwControlFlags, dwBufferLength, lpqsResults);
end;

function Stub_WSALookupServiceEnd(const hLookup: THandle): Integer; stdcall;
begin
  @WSALookupServiceEnd := FixupStub(hWinSockDll, 'WSALookupServiceEnd'); {Do not Localize}
  Result := WSALookupServiceEnd(hLookup);
end;

function Stub_WSAInstallServiceClassA(const lpServiceClassInfo: LPWSASERVICECLASSINFOA): Integer; stdcall;
begin
  @WSAInstallServiceClassA := FixupStub(hWinSockDll, 'WSAInstallServiceClassA'); {Do not Localize}
  Result := WSAInstallServiceClassA(lpServiceClassInfo);
end;

function Stub_WSAInstallServiceClassW(const lpServiceClassInfo: LPWSASERVICECLASSINFOW): Integer; stdcall;
begin
  @WSAInstallServiceClassW := FixupStub(hWinSockDll, 'WSAInstallServiceClassW'); {Do not Localize}
  Result := WSAInstallServiceClassW(lpServiceClassInfo);
end;

function Stub_WSAInstallServiceClass(const lpServiceClassInfo: LPWSASERVICECLASSINFO): Integer; stdcall;
begin
  {$IFDEF UNICODE}
  @WSAInstallServiceClass := FixupStub(hWinSockDll, 'WSAInstallServiceClassW'); {Do not Localize}
  {$ELSE}
  @WSAInstallServiceClass := FixupStub(hWinSockDll, 'WSAInstallServiceClassA'); {Do not Localize}
  {$ENDIF}
  Result := WSAInstallServiceClass(lpServiceClassInfo);
end;

function Stub_WSARemoveServiceClass(const lpServiceClassId: PGUID): Integer; stdcall;
begin
  @WSARemoveServiceClass := FixupStub(hWinSockDll, 'WSARemoveServiceClass'); {Do not Localize}
  Result := WSARemoveServiceClass(lpServiceClassId);
end;

function Stub_WSAGetServiceClassInfoA(const lpProviderId: PGUID; const lpServiceClassId: PGUID; var lpdwBufSize: DWORD; lpServiceClassInfo: LPWSASERVICECLASSINFOA): Integer; stdcall;
begin
  @WSAGetServiceClassInfoA := FixupStub(hWinSockDll, 'WSAGetServiceClassInfoA'); {Do not Localize}
  Result := WSAGetServiceClassInfoA(lpProviderId, lpServiceClassId, lpdwBufSize, lpServiceClassInfo);
end;

function Stub_WSAGetServiceClassInfoW(const lpProviderId: PGUID; const lpServiceClassId: PGUID; var lpdwBufSize: DWORD; lpServiceClassInfo: LPWSASERVICECLASSINFOW): Integer; stdcall;
begin
  @WSAGetServiceClassInfoW := FixupStub(hWinSockDll, 'WSAGetServiceClassInfoW'); {Do not Localize}
  Result := WSAGetServiceClassInfoW(lpProviderId, lpServiceClassId, lpdwBufSize, lpServiceClassInfo);
end;

function Stub_WSAGetServiceClassInfo(const lpProviderId: PGUID; const lpServiceClassId: PGUID; var lpdwBufSize: DWORD; lpServiceClassInfo: LPWSASERVICECLASSINFO): Integer; stdcall;
begin
  {$IFDEF UNICODE}
  @WSAGetServiceClassInfo := FixupStub(hWinSockDll, 'WSAGetServiceClassInfoW'); {Do not Localize}
  {$ELSE}
  @WSAGetServiceClassInfo := FixupStub(hWinSockDll, 'WSAGetServiceClassInfoA'); {Do not Localize}
  {$ENDIF}
  Result := WSAGetServiceClassInfo(lpProviderId, lpServiceClassId, lpdwBufSize, lpServiceClassInfo);
end;

function Stub_WSAEnumNameSpaceProvidersA(var lpdwBufferLength: DWORD; const lpnspBuffer: LPWSANAMESPACE_INFOA): Integer; stdcall;
begin
  @WSAEnumNameSpaceProvidersA := FixupStub(hWinSockDll, 'WSAEnumNameSpaceProvidersA'); {Do not Localize}
  Result := WSAEnumNameSpaceProvidersA(lpdwBufferLength, lpnspBuffer);
end;

function Stub_WSAEnumNameSpaceProvidersW(var lpdwBufferLength: DWORD; const lpnspBuffer: LPWSANAMESPACE_INFOW): Integer; stdcall;
begin
  @WSAEnumNameSpaceProvidersW := FixupStub(hWinSockDll, 'WSAEnumNameSpaceProvidersW'); {Do not Localize}
  Result := WSAEnumNameSpaceProvidersW(lpdwBufferLength, lpnspBuffer);
end;

function Stub_WSAEnumNameSpaceProviders(var lpdwBufferLength: DWORD; const lpnspBuffer: LPWSANAMESPACE_INFO): Integer; stdcall;
begin
  {$IFDEF UNICODE}
  @WSAEnumNameSpaceProviders := FixupStub(hWinSockDll, 'WSAEnumNameSpaceProvidersW'); {Do not Localize}
  {$ELSE}
  @WSAEnumNameSpaceProviders := FixupStub(hWinSockDll, 'WSAEnumNameSpaceProvidersA'); {Do not Localize}
  {$ENDIF}
  Result := WSAEnumNameSpaceProviders(lpdwBufferLength, lpnspBuffer);
end;

function Stub_WSAGetServiceClassNameByClassIdA(const lpServiceClassId: PGUID; lpszServiceClassName: PChar; var lpdwBufferLength: DWORD): Integer; stdcall;
begin
  @WSAGetServiceClassNameByClassIdA := FixupStub(hWinSockDll, 'WSAGetServiceClassNameByClassIdA'); {Do not Localize}
  Result := WSAGetServiceClassNameByClassIdA(lpServiceClassId, lpszServiceClassName, lpdwBufferLength);
end;

function Stub_WSAGetServiceClassNameByClassIdW(const lpServiceClassId: PGUID; lpszServiceClassName: PWideChar; var lpdwBufferLength: DWORD): Integer; stdcall;
begin
  @WSAGetServiceClassNameByClassIdW := FixupStub(hWinSockDll, 'WSAGetServiceClassNameByClassIdW'); {Do not Localize}
  Result := WSAGetServiceClassNameByClassIdW(lpServiceClassId, lpszServiceClassName, lpdwBufferLength);
end;

function Stub_WSAGetServiceClassNameByClassId(const lpServiceClassId: PGUID;
  lpszServiceClassName: {$IFDEF UNICODE}PWideChar{$ELSE}PChar{$ENDIF};
  var lpdwBufferLength: DWORD): Integer; stdcall;
begin
  {$IFDEF UNICODE}
  @WSAGetServiceClassNameByClassId := FixupStub(hWinSockDll, 'WSAGetServiceClassNameByClassIdW'); {Do not Localize}
  {$ELSE}
  @WSAGetServiceClassNameByClassId := FixupStub(hWinSockDll, 'WSAGetServiceClassNameByClassIdA'); {Do not Localize}
  {$ENDIF}
  Result := WSAGetServiceClassNameByClassId(lpServiceClassId, lpszServiceClassName, lpdwBufferLength);
end;

function Stub_WSASetServiceA(const lpqsRegInfo: LPWSAQUERYSETA; const essoperation: WSAESETSERVICEOP; const dwControlFlags: DWORD): Integer; stdcall;
begin
  @WSASetServiceA := FixupStub(hWinSockDll, 'WSASetServiceA'); {Do not Localize}
  Result := WSASetServiceA(lpqsRegInfo, essoperation, dwControlFlags);
end;

function Stub_WSASetServiceW(const lpqsRegInfo: LPWSAQUERYSETW; const essoperation: WSAESETSERVICEOP; const dwControlFlags: DWORD): Integer; stdcall;
begin
  @WSASetServiceW := FixupStub(hWinSockDll, 'WSASetServiceW'); {Do not Localize}
  Result := WSASetServiceW(lpqsRegInfo, essoperation, dwControlFlags);
end;

function Stub_WSASetService(const lpqsRegInfo: LPWSAQUERYSET; const essoperation: WSAESETSERVICEOP; const dwControlFlags: DWORD): Integer; stdcall;
begin
  {$IFDEF UNICODE}
  @WSASetService := FixupStub(hWinSockDll, 'WSASetServiceW'); {Do not Localize}
  {$ELSE}
  @WSASetService := FixupStub(hWinSockDll, 'WSASetServiceA'); {Do not Localize}
  {$ENDIF}
  Result := WSASetService(lpqsRegInfo, essoperation, dwControlFlags);
end;

function Stub_WSAProviderConfigChange(var lpNotificationHandle: THandle; AOverlapped: LPWSAOVERLAPPED; lpCompletionRoutine: LPWSAOVERLAPPED_COMPLETION_ROUTINE): Integer; stdcall;
begin
  @WSAProviderConfigChange := FixupStub(hWinSockDll, 'WSAProviderConfigChange'); {Do not Localize}
  Result := WSAProviderConfigChange(lpNotificationHandle, AOverlapped, lpCompletionRoutine);
end;

function Stub_TransmitFile(hSocket: TSocket; hFile: THandle; nNumberOfBytesToWrite: DWORD;
  nNumberOfBytesPerSend: DWORD; lpOverlapped: POverlapped;
  lpTransmitBuffers: LPTRANSMIT_FILE_BUFFERS; dwReserved: DWORD): BOOL; stdcall;
begin
  @TransmitFile := FixupStubEx(hSocket, 'TransmitFile', WSAID_TRANSMITFILE); {Do not localize}
  Result := TransmitFile(hSocket, hFile, nNumberOfBytesToWrite, nNumberOfBytesPerSend, lpOverlapped, lpTransmitBuffers, dwReserved);
end;

{RLebeau 1/26/2006 - loading GetAcceptExSockaddrs() at the same time as AcceptEx().
This is because GetAcceptExSockaddrs() is not passed a SOCKET that can be passed to
WSAIoCtrl() to get the function pointer. Also, GetAcceptExSockaddrs() is needed to
parse AcceptEx()'s return data, so there is no point in calling AcceptEx() unless
its data can be parsed afterwards.}

function Stub_AcceptEx(sListenSocket, sAcceptSocket: TSocket;
  lpOutputBuffer: Pointer; dwReceiveDataLength, dwLocalAddressLength,
  dwRemoteAddressLength: DWORD; var lpdwBytesReceived: DWORD;
  lpOverlapped: POverlapped): BOOL; stdcall;
begin
  {RLebeau - loading GetAcceptExSockaddrs() first in case it fails}
  @GetAcceptExSockaddrs := FixupStubEx(sListenSocket, 'GetAcceptExSockaddrs', WSAID_GETACCEPTEXSOCKADDRS); {Do not localize}
  @AcceptEx := FixupStubEx(sListenSocket, 'AcceptEx', WSAID_ACCEPTEX); {Do not localize}
  Result := AcceptEx(sListenSocket, sAcceptSocket, lpOutputBuffer, dwReceiveDataLength,
    dwLocalAddressLength, dwRemoteAddressLength, lpdwBytesReceived, lpOverlapped);
end;

function Stub_WSARecvEx(s: TSocket; var buf; len: Integer; var flags: Integer): Integer; stdcall;
begin
  LoadMSWSock;
  @WSARecvEx := FixupStub(hMSWSockDll, 'WSARecvEx'); {Do not localize}
  Result := WSARecvEx(s, buf, len, flags);
end;

function Stub_ConnectEx(const s : TSocket; const name: PSockAddr; const namelen: Integer; lpSendBuffer : Pointer;
  dwSendDataLength : DWORD; var lpdwBytesSent : DWORD; lpOverlapped : LPWSAOVERLAPPED) : BOOL;  stdcall;
begin
  @ConnectEx := FixupStubEx(s, 'ConnectEx', WSAID_CONNECTEX); {Do not localize}
  Result := ConnectEx(s, name, namelen, lpSendBuffer, dwSendDataLength, lpdwBytesSent, lpOverlapped);
end;

function Stub_DisconnectEx(const s : TSocket; AOverlapped: Pointer; const dwFlags : DWord; const dwReserved : DWORD) : BOOL;  stdcall;
begin
  @DisconnectEx := FixupStubEx(s, 'DisconnectEx', WSAID_DISCONNECTEX); {Do not localize}
  Result := DisconnectEx(s, AOverlapped, dwFlags, dwReserved);
end;

function Stub_WSARecvMsg(const s : TSocket; lpMsg : LPWSAMSG; var lpNumberOfBytesRecvd : DWORD; AOverlapped: Pointer; lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE): Integer;  stdcall;
begin
  @WSARecvMsg := FixupStubEx(s, 'WSARecvMsg', WSAID_WSARECVMSG); {Do not localize}
  Result := WSARecvMsg(s, lpMsg, lpNumberOfBytesRecvd, AOverlapped, lpCompletionRoutine);
end;

function Stub_TransmitPackets(s: TSocket; lpPacketArray: LPTRANSMIT_PACKETS_ELEMENT;
  nElementCount: DWORD; nSendSize: DWORD; lpOverlapped: LPWSAOVERLAPPED; dwFlags: DWORD): BOOL; stdcall;
begin
  @TransmitPackets := FixupStubEx(s, 'TransmitPackets', WSAID_TRANSMITPACKETS); {Do not localize}
  Result := TransmitPackets(s, lpPacketArray, nElementCount, nSendSize, lpOverlapped, dwFlags);
end;

function Stub_WSASendMsg(const s : TSocket; lpMsg : LPWSAMSG; const dwFlags : DWORD; var lpNumberOfBytesSent : DWORD;  lpOverlapped : LPWSAOVERLAPPED;  lpCompletionRoutine : LPWSAOVERLAPPED_COMPLETION_ROUTINE) : Integer; stdcall;
begin
  @WSASendMsg := FixupStubEx(s, 'WSASendMsg', WSAID_WSASENDMSG); {Do not localize}
  Result := WSASendMsg(s, lpMsg, dwFlags, lpNumberOfBytesSent, lpOverlapped, lpCompletionRoutine);
end;

function Stub_WSAPoll(fdarray : LPWSAPOLLFD; const nfds : u_long; const timeout : Integer) : Integer; stdcall;
begin
  @WSAPoll := FixupStubEx(fdarray.fd, 'WSAPoll', WSAID_WSAPOLL); {Do not localize}
  Result := WSAPoll(fdarray, nfds, timeout);
end;

procedure InitializeStubs;
begin
  WSAStartup                       := Stub_WSAStartup;
  WSACleanup                       := Stub_WSACleanup;
  accept                           := Stub_accept;
  bind                             := Stub_bind;
  closesocket                      := Stub_closesocket;
  connect                          := Stub_connect;
  ioctlsocket                      := Stub_ioctlsocket;
  getpeername                      := Stub_getpeername;
  getsockname                      := Stub_getsockname;
  getsockopt                       := Stub_getsockopt;
  htonl                            := Stub_htonl;
  htons                            := Stub_htons;
  inet_addr                        := Stub_inet_addr;
  inet_ntoa                        := Stub_inet_ntoa;
  listen                           := Stub_listen;
  ntohl                            := Stub_ntohl;
  ntohs                            := Stub_ntohs;
  recv                             := Stub_recv;
  recvfrom                         := Stub_recvfrom;
  select                           := Stub_select;
  send                             := Stub_send;
  sendto                           := Stub_sendto;
  setsockopt                       := Stub_setsockopt;
  shutdown                         := Stub_shutdown;
  socket                           := Stub_socket;
  gethostbyaddr                    := Stub_gethostbyaddr;
  gethostbyname                    := Stub_gethostbyname;
  gethostname                      := Stub_gethostname;
  {$IFDEF UNDER_CE}
  sethostname                      := Stub_sethostname;
  {$ENDIF}
  getservbyport                    := Stub_getservbyport;
  getservbyname                    := Stub_getservbyname;
  getprotobynumber                 := Stub_getprotobynumber;
  getprotobyname                   := Stub_getprotobyname;
  WSASetLastError                  := Stub_WSASetLastError;
  WSAGetLastError                  := Stub_WSAGetLastError;
  {$IFNDEF UNDER_CE}
  WSAIsBlocking                    := Stub_WSAIsBlocking;
  WSAUnhookBlockingHook            := Stub_WSAUnhookBlockingHook;
  WSASetBlockingHook               := Stub_WSASetBlockingHook;
  WSACancelBlockingCall            := Stub_WSACancelBlockingCall;
  WSAAsyncGetServByName            := Stub_WSAAsyncGetServByName;
  WSAAsyncGetServByPort            := Stub_WSAAsyncGetServByPort;
  WSAAsyncGetProtoByName           := Stub_WSAAsyncGetProtoByName;
  WSAAsyncGetProtoByNumber         := Stub_WSAAsyncGetProtoByNumber;
  WSAAsyncGetHostByName            := Stub_WSAAsyncGetHostByName;
  WSAAsyncGetHostByAddr            := Stub_WSAAsyncGetHostByAddr;
  WSACancelAsyncRequest            := Stub_WSACancelAsyncRequest;
  {$ENDIF}
  WSAAsyncSelect                   := Stub_WSAAsyncSelect;
  __WSAFDIsSet                     := Stub___WSAFDIsSet;
  WSAAccept                        := Stub_WSAAccept;
  WSACloseEvent                    := Stub_WSACloseEvent;
  WSAConnect                       := Stub_WSAConnect;
  WSACreateEvent                   := Stub_WSACreateEvent;
  WSADuplicateSocketA              := Stub_WSADuplicateSocketA;
  WSADuplicateSocketW              := Stub_WSADuplicateSocketW;
  WSADuplicateSocket               := Stub_WSADuplicateSocket;
  WSAEnumNetworkEvents             := Stub_WSAEnumNetworkEvents;
  WSAEnumProtocolsA                := Stub_WSAEnumProtocolsA;
  WSAEnumProtocolsW                := Stub_WSAEnumProtocolsW;
  WSAEnumProtocols                 := Stub_WSAEnumProtocols;
  WSAEventSelect                   := Stub_WSAEventSelect;
  WSAGetOverlappedResult           := Stub_WSAGetOverlappedResult;
  WSAGetQOSByName                  := Stub_WSAGetQOSByName;
  WSAHtonl                         := Stub_WSAHtonl;
  WSAHtons                         := Stub_WSAHtons;
  WSAIoctl                         := Stub_WSAIoctl;
  WSAJoinLeaf                      := Stub_WSAJoinLeaf;
  WSANtohl                         := Stub_WSANtohl;
  WSANtohs                         := Stub_WSANtohs;
  WSARecv                          := Stub_WSARecv;
  WSARecvDisconnect                := Stub_WSARecvDisconnect;
  WSARecvFrom                      := Stub_WSARecvFrom;
  WSAResetEvent                    := Stub_WSAResetEvent;
  WSASend                          := Stub_WSASend;
  WSASendDisconnect                := Stub_WSASendDisconnect;
  WSASendTo                        := Stub_WSASendTo;
  WSASetEvent                      := Stub_WSASetEvent;
  WSASocketA                       := Stub_WSASocketA;
  WSASocketW                       := Stub_WSASocketW;
  WSASocket                        := Stub_WSASocket;
  WSAWaitForMultipleEvents         := Stub_WSAWaitForMultipleEvents;
  WSAAddressToStringA              := Stub_WSAAddressToStringA;
  WSAAddressToStringW              := Stub_WSAAddressToStringW;
  WSAAddressToString               := Stub_WSAAddressToString;
  WSAStringToAddressA              := Stub_WSAStringToAddressA;
  WSAStringToAddressW              := Stub_WSAStringToAddressW;
  WSAStringToAddress               := Stub_WSAStringToAddress;
  WSALookupServiceBeginA           := Stub_WSALookupServiceBeginA;
  WSALookupServiceBeginW           := Stub_WSALookupServiceBeginW;
  WSALookupServiceBegin            := Stub_WSALookupServiceBegin;
  WSALookupServiceNextA            := Stub_WSALookupServiceNextA;
  WSALookupServiceNextW            := Stub_WSALookupServiceNextW;
  WSALookupServiceNext             := Stub_WSALookupServiceNext;
  WSALookupServiceEnd              := Stub_WSALookupServiceEnd;
  WSAInstallServiceClassA          := Stub_WSAInstallServiceClassA;
  WSAInstallServiceClassW          := Stub_WSAInstallServiceClassW;
  WSAInstallServiceClass           := Stub_WSAInstallServiceClass;
  WSARemoveServiceClass            := Stub_WSARemoveServiceClass;
  WSAGetServiceClassInfoA          := Stub_WSAGetServiceClassInfoA;
  WSAGetServiceClassInfoW          := Stub_WSAGetServiceClassInfoW;
  WSAGetServiceClassInfo           := Stub_WSAGetServiceClassInfo;
  WSAEnumNameSpaceProvidersA       := Stub_WSAEnumNameSpaceProvidersA;
  WSAEnumNameSpaceProvidersW       := Stub_WSAEnumNameSpaceProvidersW;
  WSAEnumNameSpaceProviders        := Stub_WSAEnumNameSpaceProviders;
  WSAGetServiceClassNameByClassIdA := Stub_WSAGetServiceClassNameByClassIdA;
  WSAGetServiceClassNameByClassIdW := Stub_WSAGetServiceClassNameByClassIdW;
  WSAGetServiceClassNameByClassId  := Stub_WSAGetServiceClassNameByClassId;
  WSASetServiceA                   := Stub_WSASetServiceA;
  WSASetServiceW                   := Stub_WSASetServiceW;
  WSASetService                    := Stub_WSASetService;
  WSAProviderConfigChange          := Stub_WSAProviderConfigChange;
{$IFNDEF UNDER_CE}
  AcceptEx                         := Stub_AcceptEx;
  //GetAcceptExSockaddrs is loaded by Stub_AcceptEx
  WSARecvEx                        := Stub_WSARecvEx;
  ConnectEx                        := Stub_ConnectEx;
  DisconnectEx                     := Stub_DisconnectEx;
  TransmitFile                     := Stub_TransmitFile;
  TransmitPackets                  := Stub_TransmitPackets;
  WSAPoll                          := Stub_WSAPoll;
  WSARecvMsg                       := Stub_WSARecvMsg;
  WSASendMsg                       := Stub_WSASendMsg;
{$ENDIF}
end;

function WSAMakeSyncReply(Buflen, Error: Word): Longint;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := MakeLong(Buflen, Error);
end;

function WSAMakeSelectReply(Event, Error: Word): Longint;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := MakeLong(Event, Error);
end;

function WSAGetAsyncBuflen(Param: Longint): Word;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := LOWORD(Param);
end;

function WSAGetAsyncError(Param: Longint): Word;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := HIWORD(Param);
end;

function WSAGetSelectEvent(Param: Longint): Word;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := LOWORD(Param);
end;

function WSAGetSelectError(Param: Longint): Word;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  WSAGetSelectError := HIWORD(Param);
end;

procedure FD_CLR(Socket: TSocket; var FDSet: TFDSet);
var
  i: u_int;
begin
  i := 0;
  while i < FDSet.fd_count do
  begin
    if FDSet.fd_array[i] = Socket then
    begin
      while i < FDSet.fd_count - 1 do
      begin
        FDSet.fd_array[i] := FDSet.fd_array[i+1];
        Inc(i);
      end;
      Dec(FDSet.fd_count);
      Break;
    end;
    Inc(i);
  end;
end;

function FD_ISSET(Socket: TSocket; var FDSet: TFDSet): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := __WSAFDIsSet(Socket, FDSet);
end;

procedure FD_SET(Socket: TSocket; var FDSet: TFDSet);
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if FDSet.fd_count < fd_setsize then
  begin
    FDSet.fd_array[FDSet.fd_count] := Socket;
    Inc(FDSet.fd_count);
  end;
end;

procedure FD_ZERO(var FDSet: TFDSet);
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  FDSet.fd_count := 0;
end;

function WSA_CMSGHDR_ALIGN(length: DWORD): DWORD;
type
  TempRec = record
    x: Char;
    test: WSACMSGHDR;
  end;
var
  Alignment: PtrUInt;
  Tmp: ^TempRec;
begin
  Tmp := nil;
  Alignment := PtrUInt(@(Tmp^.test));
  Result := (length + (Alignment-1)) and not (Alignment-1);
end;

function WSA_CMSGDATA_ALIGN(length: DWORD): DWORD;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := DWORD(length + MAX_NATURAL_ALIGNMENT_SUB_1) and not (MAX_NATURAL_ALIGNMENT_SUB_1);
end;

function WSA_CMSG_FIRSTHDR(msg: LPWSAMSG): LPWSACMSGHDR;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if (msg <> nil) and (msg^.Control.len >= SIZE_WSACMSGHDR) then begin
    Result := LPWSACMSGHDR(msg^.Control.buf);
  end else begin
    Result := nil;
  end;
end;

function WSA_CMSG_NXTHDR(msg: LPWSAMSG; cmsg: LPWSACMSGHDR): LPWSACMSGHDR;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if cmsg = nil then begin
    Result := WSA_CMSG_FIRSTHDR(msg);
  end else begin
    if (PtrUInt(cmsg) + WSA_CMSGHDR_ALIGN(cmsg^.cmsg_len) + SIZE_WSACMSGHDR) > (PtrUInt(msg^.Control.buf) + msg^.Control.len) then begin
      Result := nil;
    end else begin
      Result := LPWSACMSGHDR(PtrUInt(cmsg) + WSA_CMSGHDR_ALIGN(cmsg^.cmsg_len));
    end;
  end;
end;

function WSA_CMSG_DATA(cmsg: LPWSACMSGHDR): PByte;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := PByte(PtrUInt(cmsg) + WSA_CMSGDATA_ALIGN(SIZE_WSACMSGHDR));
end;

function WSA_CMSG_SPACE(length: DWORD): DWORD;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := WSA_CMSGDATA_ALIGN(DWORD(SIZE_WSACMSGHDR + WSA_CMSGHDR_ALIGN(length)));
end;

function WSA_CMSG_LEN(length: DWORD): DWORD;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := DWORD(WSA_CMSGDATA_ALIGN(SIZE_WSACMSGHDR) + length);
end;

function IP_MSFILTER_SIZE(numsrc: DWORD): DWORD;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := SIZE_IP_MSFILTER - SIZE_TINADDR + (numsrc*SIZE_TINADDR);
end;

function SS_PORT(ssp: PSockAddrIn): u_short;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if ssp <> nil then begin
    Result := ssp^.sin_port;
  end else begin
    Result := 0;
  end;
end;

function IN6ADDR_ANY_INIT: TIn6Addr;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  with Result do begin
    System.FillChar(s6_addr, SIZE_TIN6ADDR, 0);    {Do not Localize}
  end;
end;

function IN6ADDR_LOOPBACK_INIT: TIn6Addr;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  with Result do begin
    System.FillChar(s6_addr, SIZE_TIN6ADDR, 0);    {Do not Localize}
    s6_addr[15] := 1;
  end;
end;

procedure IN6ADDR_SETANY(sa: PSockAddrIn6);
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if sa <> nil then begin
    with sa^ do begin
      sin6_family := AF_INET6;
      sin6_port := 0;
      sin6_flowinfo := 0;
      PULONG(@sin6_addr.s6_addr[0])^ := 0;
      PULONG(@sin6_addr.s6_addr[4])^ := 0;
      PULONG(@sin6_addr.s6_addr[8])^ := 0;
      PULONG(@sin6_addr.s6_addr[12])^ := 0;
    end;
  end;
end;

procedure IN6ADDR_SETLOOPBACK(sa: PSockAddrIn6);
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if sa <> nil then begin
    with sa^ do begin
      sin6_family := AF_INET6;
      sin6_port := 0;
      sin6_flowinfo := 0;
      PULONG(@sin6_addr.s6_addr[0])^ := 0;
      PULONG(@sin6_addr.s6_addr[4])^ := 0;
      PULONG(@sin6_addr.s6_addr[8])^ := 0;
      PULONG(@sin6_addr.s6_addr[12])^ := 1;
    end;
  end;
end;

function IN6ADDR_ISANY(sa: PSockAddrIn6): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if sa <> nil then begin
    with sa^ do begin
      Result := (sin6_family = AF_INET6) and
                (PULONG(@sin6_addr.s6_addr[0])^ = 0) and
                (PULONG(@sin6_addr.s6_addr[4])^ = 0) and
                (PULONG(@sin6_addr.s6_addr[8])^ = 0) and
                (PULONG(@sin6_addr.s6_addr[12])^ = 0);
    end;
  end else begin
    Result := False;
  end;
end;

function IN6ADDR_ISLOOPBACK(sa: PSockAddrIn6): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if sa <> nil then begin
    with sa^ do begin
      Result := (sin6_family = AF_INET6) and
                (PULONG(@sin6_addr.s6_addr[0])^ = 0) and
                (PULONG(@sin6_addr.s6_addr[4])^ = 0) and
                (PULONG(@sin6_addr.s6_addr[8])^ = 0) and
                (PULONG(@sin6_addr.s6_addr[12])^ = 1);
    end;
  end else begin
    Result := False;
  end;
end;

function IN6_ADDR_EQUAL(const a: PIn6Addr; const b: PIn6Addr): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := SysUtils.CompareMem(a, b, SIZE_TIN6ADDR);
end;

function IN6_IS_ADDR_UNSPECIFIED(const a: PIn6Addr): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := IN6_ADDR_EQUAL(a, @in6addr_any);
end;

function IN6_IS_ADDR_LOOPBACK(const a: PIn6Addr): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  Result := IN6_ADDR_EQUAL(a, @in6addr_loopback);
end;

function IN6_IS_ADDR_MULTICAST(const a: PIn6Addr): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if a <> nil then begin
    Result := (a^.s6_addr[0] = $FF);
  end else begin
    Result := False;
  end;
end;

function IN6_IS_ADDR_LINKLOCAL(const a: PIn6Addr): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if a <> nil then begin
    Result := (a^.s6_addr[0] = $FE) and ((a^.s6_addr[1] and $C0) = $80);
  end else begin
    Result := False;
  end;
end;

function IN6_IS_ADDR_SITELOCAL(const a: PIn6Addr): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if a <> nil then begin
    Result := (a^.s6_addr[0] = $FE) and ((a^.s6_addr[1] and $C0) = $C0);
  end else begin
    Result := False;
  end;
end;

function IN6_IS_ADDR_V4MAPPED(const a: PIn6Addr): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if a <> nil then begin
    with a^ do begin
      Result := (word[0] = 0) and
                (word[1] = 0) and
                (word[2] = 0) and
                (word[3] = 0) and
                (word[4] = 0) and
                (word[5] = $FFFF);
    end;
  end else begin
    Result := False;
  end;
end;

function IN6_IS_ADDR_V4COMPAT(const a: PIn6Addr): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if a <> nil then begin
    with a^ do begin
      Result := (word[0] = 0) and
                (word[1] = 0) and
                (word[2] = 0) and
                (word[3] = 0) and
                (word[4] = 0) and
                (word[5] = 0) and
                not ((word[6] = 0) and (s6_addr[14] = 0) and
                ((s6_addr[15] = 0) or (s6_addr[15] = 1)));
    end;
  end else begin
    Result := False;
  end;
end;

function IN6_IS_ADDR_MC_NODELOCAL(const a: PIn6Addr): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if a <> nil then begin
    Result := IN6_IS_ADDR_MULTICAST(a) and ((a^.s6_addr[1] and $F) = 1);
  end else begin
    Result := False;
  end;
end;

function IN6_IS_ADDR_MC_LINKLOCAL(const a: PIn6Addr): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if a <> nil then begin
    Result := IN6_IS_ADDR_MULTICAST(a) and ((a^.s6_addr[1] and $F) = 2);
  end else begin
    Result := False;
  end;
end;

function IN6_IS_ADDR_MC_SITELOCAL(const a: PIn6Addr): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if a <> nil then begin
    Result := IN6_IS_ADDR_MULTICAST(a) and ((a^.s6_addr[1] and $F) = 5);
  end else begin
    Result := False;
  end;
end;

function IN6_IS_ADDR_MC_ORGLOCAL(const a: PIn6Addr): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if a <> nil then begin
    Result := IN6_IS_ADDR_MULTICAST(a) and ((a^.s6_addr[1] and $F) = 8);
  end else begin
    Result := False;
  end;
end;

function IN6_IS_ADDR_MC_GLOBAL(const a: PIn6Addr): Boolean;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
  if a <> nil then begin
    Result := IN6_IS_ADDR_MULTICAST(a) and ((a^.s6_addr[1] and $F) = $E);
  end else begin
    Result := False;
  end;
end;

//  A macro convenient for setting up NETBIOS SOCKADDRs.
procedure SET_NETBIOS_SOCKADDR(snb : PSockAddrNB; const SnbType : Word; const Name : PChar; const Port : Char);
var
  len : DWORD;
begin
  if snb <> nil then begin
    with snb^ do begin
      snb_family := AF_NETBIOS;
      snb_type := SnbType;
      len := StrLen(Name);
      if len >= NETBIOS_NAME_LENGTH-1 then begin
        System.Move(Name^, snb_name, NETBIOS_NAME_LENGTH-1)
      end else begin
        if len > 0 then begin
          System.Move(Name^, snb_name, len);
        end;
        System.FillChar((PChar(@snb_name)+len)^, NETBIOS_NAME_LENGTH-1-len, ' ');    {Do not Localize}
      end;
      snb_name[NETBIOS_NAME_LENGTH-1] := Port;
    end;
  end;
end;

function GROUP_FILTER_SIZE(numsrc : DWord) : DWord;
{$IFDEF USEINLINE}inline;{$ENDIF}
begin
   Result := (SIZE_GROUP_FILTER - SIZE_SOCKADDR_STORAGE) +
     (numsrc * SIZE_SOCKADDR_STORAGE);
end;

initialization
  in6addr_any := IN6ADDR_ANY_INIT;
  in6addr_loopback := IN6ADDR_LOOPBACK_INIT;
  InitializeStubs;

end.

