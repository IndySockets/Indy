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
  Rev 1.0    2004.02.07 12:25:16 PM  czhower
  Recheckin to fix case of filename

  Rev 1.1    2/7/2004 5:20:06 AM  JPMugaas
  Added some constants that were pasted from other places.  DotNET uses the
  standard Winsock 2 error consstants.  We don't want to link to IdWInsock or
  Windows though because that causes other problems.

  Rev 1.0    2004.02.03 3:14:44 PM  czhower
  Move and updates

  Rev 1.12    2003.12.28 6:53:46 PM  czhower
  Added some consts.

  Rev 1.11    10/28/2003 9:14:54 PM  BGooijen
  .net

  Rev 1.10    10/19/2003 10:46:18 PM  BGooijen
  Added more consts

  Rev 1.9    10/19/2003 9:15:28 PM  BGooijen
  added some SocketOptionName consts for dotnet

  Rev 1.8    10/19/2003 5:21:30 PM  BGooijen
  SetSocketOption

  Rev 1.7    10/2/2003 7:31:18 PM  BGooijen
  .net

  Rev 1.6    2003.10.02 10:16:32 AM  czhower
  .Net

  Rev 1.5    2003.10.01 5:05:18 PM  czhower
  .Net

  Rev 1.4    2003.10.01 1:12:40 AM  czhower
  .Net

  Rev 1.3    2003.09.30 12:09:38 PM  czhower
  DotNet changes.

  Rev 1.2    9/29/2003 10:28:30 PM  BGooijen
  Added constants for DotNet

  Rev 1.1    12-14-2002 14:58:34  BGooijen
  Added definition for Id_SOCK_RDM and Id_SOCK_SEQPACKET

  Rev 1.0    11/13/2002 08:59:14 AM  JPMugaas
}

unit IdStackConsts;

interface

{$I IdCompilerDefines.inc}

{
IMPORTANT!!!

The new Posix units have platform specific stuff.  Since this code and
the definitions are not intented to be compiled in non-Unix-like operating
systems, platform warnings are not going to be too helpful.
}
{$IFDEF USE_VCL_POSIX}
  {$I IdSymbolPlatformOff.inc}
{$ENDIF}

{ This should be the only unit except OS Stack units that reference
  Winsock or lnxsock }

uses
  //TODO:  I'm not really sure how other platforms are supported with asockets header
  //Do I use the sockets unit or do something totally different for each platform
  {$IFDEF WINDOWS}
  IdWship6, //for some constants that supplement IdWinsock
  IdWinsock2;
  {$ENDIF}
  {$IFDEF OS2}
  pmwsock;
  {$ENDIF}
  {$IFDEF SOCKETTYPE_IS_CINT}
  IdCTypes,
  {$ENDIF}
  {$IFDEF NETWARE_CLIB}
  winsock; //not sure if this is correct
  {$ENDIF}
  {$IFDEF NETWARE_LIBC}
  winsock;  //not sure if this is correct
  {$ENDIF}
  {$IFDEF MACOS_CLASSIC}
  {$ENDIF}
  {$IFDEF UNIX}
    {$IF DEFINED(USE_VCL_POSIX)}
    {
    IMPORTANT!!!

    The new Posix units have platform specific stuff.  Since this code and
    the definitions are not intented to be compiled in non-Unix-like operating
    systems, platform warnings are not going to be too helpful.
    }
    {$I IdSymbolPlatformOff.inc}
    IdVCLPosixSupplemental,
    Posix.Errno, Posix.NetDB, Posix.NetinetIn, Posix.SysSocket;
    {$ELSEIF DEFINED(KYLIXCOMPAT)}
    libc;
    {$ELSEIF DEFINED(USE_BASEUNIX)}
    Sockets, BaseUnix, Unix; // FPC "native" Unix units.
     //Marco may want to change the socket interface unit
     //so we don't use the libc header.
    {$IFEND}
  {$ENDIF}

type
  {$IFDEF USE_BASEUNIX}
  TSocket = cint;  // TSocket is afaik not POSIX, so we have to add it
                   // (Socket() returns a C int according to opengroup)
  {$ENDIF}

  TIdStackSocketHandle = {$IFDEF USE_VCL_POSIX}Integer{$ELSE}TSocket{$ENDIF};

var
  Id_SO_True: Integer = 1;
  Id_SO_False: Integer = 0;

const
  {$IFDEF UNIX}
  Id_IPV6_UNICAST_HOPS   = IPV6_UNICAST_HOPS;
  Id_IPV6_MULTICAST_IF   = IPV6_MULTICAST_IF;
  Id_IPV6_MULTICAST_HOPS = IPV6_MULTICAST_HOPS;
  Id_IPV6_MULTICAST_LOOP = IPV6_MULTICAST_LOOP;
    {$IFDEF LINUX}
    // These are probably leftovers from the non-final IPV6 KAME standard
    // in Linux. They only seem to exist in Linux, others use
    // the standarised versions.
    // Probably the JOIN_GROUP ones replaced these,
    // but they have different numbers in Linux, and possibly
    // also different behaviour?
      {$IFDEF USE_BASEUNIX}
      //In Linux, the libc.pp header maps the old values to new ones,
      //probably for consistancy.  I'm doing this because we can't link
      //to Libc for Basic Unix stuff and some people may want to use this API
      //in Linux instead of the libc API.
      IPV6_ADD_MEMBERSHIP  = IPV6_JOIN_GROUP;
      IPV6_DROP_MEMBERSHIP = IPV6_LEAVE_GROUP;
      {$ENDIF}
    {$ELSE}
    // FIXME: Android compiler is using these definitions, but maybe some
    //        EXTERNALSYM-work is needed above.
      IPV6_ADD_MEMBERSHIP  = IPV6_JOIN_GROUP;
      {$EXTERNALSYM IPV6_ADD_MEMBERSHIP}
      IPV6_DROP_MEMBERSHIP = IPV6_LEAVE_GROUP;
      {$EXTERNALSYM IPV6_DROP_MEMBERSHIP}
      {$IFNDEF USE_VCL_POSIX}
      IPV6_CHECKSUM        = 26;
      {$ENDIF}
    {$ENDIF}
  Id_IPV6_ADD_MEMBERSHIP  = IPV6_ADD_MEMBERSHIP;
  Id_IPV6_DROP_MEMBERSHIP = IPV6_DROP_MEMBERSHIP;
  Id_IPV6_PKTINFO         = IPV6_PKTINFO;
  Id_IPV6_HOPLIMIT        = IPV6_HOPLIMIT;
  Id_IP_MULTICAST_TTL     = IP_MULTICAST_TTL; // TODO integrate into IdStackConsts
  Id_IP_MULTICAST_LOOP    = IP_MULTICAST_LOOP; // TODO integrate into IdStackConsts
  Id_IP_ADD_MEMBERSHIP    = IP_ADD_MEMBERSHIP; // TODO integrate into IdStackConsts
  Id_IP_DROP_MEMBERSHIP   = IP_DROP_MEMBERSHIP; // TODO integrate into IdStackConsts

  //In Windows CE 4.2, IP_HDRINCL may not be supported.
  Id_IP_HDR_INCLUDED      = IP_HDRINCL; // TODO integrate into IdStackConsts
  {$ENDIF}

  {$IFDEF WINDOWS}
  Id_IPV6_HDRINCL         = IPV6_HDRINCL;
  Id_IPV6_UNICAST_HOPS    = IPV6_UNICAST_HOPS;
  Id_IPV6_MULTICAST_IF    = IPV6_MULTICAST_IF;
  Id_IPV6_MULTICAST_HOPS  = IPV6_MULTICAST_HOPS;
  Id_IPV6_MULTICAST_LOOP  = IPV6_MULTICAST_LOOP;
  Id_IPV6_ADD_MEMBERSHIP  = IPV6_ADD_MEMBERSHIP;
  Id_IPV6_DROP_MEMBERSHIP = IPV6_DROP_MEMBERSHIP;
  Id_IPV6_PKTINFO         = IPV6_PKTINFO;
  Id_IPV6_HOPLIMIT        = IPV6_HOPLIMIT;
  Id_IP_MULTICAST_TTL     = 10; // TODO integrate into IdStackConsts FIX ERROR in IdWinsock
  Id_IP_MULTICAST_LOOP    = 11; // TODO integrate into IdStackConsts FIX ERROR in IdWinsock
  Id_IP_ADD_MEMBERSHIP    = 12; // TODO integrate into IdStackConsts FIX ERROR in IdWinsock
  Id_IP_DROP_MEMBERSHIP   = 13; // TODO integrate into IdStackConsts FIX ERROR in IdWinsock
  Id_IP_HDR_INCLUDED      = 2; // TODO integrate into IdStackConsts FIX ERROR in IdWinsock
  {$ENDIF}

(*
  There seems to be an error in the correct values of multicast values in IdWinsock
  The values should be:

  ip_options          = 1;  //* set/get IP options */
  ip_hdrincl          = 2;  //* header is included with data */
  ip_tos              = 3;  //* IP type of service and preced*/
  ip_ttl              = 4;  //* IP time to live */
  ip_multicast_if     = 9;  //* set/get IP multicast i/f  */
  ip_multicast_ttl    = 10; //* set/get IP multicast ttl */
  ip_multicast_loop   = 11; //*set/get IP multicast loopback */
  ip_add_membership   = 12; //* add an IP group membership */
  ip_drop_membership  = 13; //* drop an IP group membership */
  ip_dontfragment     = 14; //* don't fragment IP datagrams */    {Do not Localize}
*)
  {$IFDEF UNIX}
  TCP_NODELAY = 1;
  {$ENDIF}

  // Protocol Family

  {$IFDEF USE_VCL_POSIX}
  Id_PF_INET4 = AF_INET;
  Id_PF_INET6 = AF_INET6;
  {$ELSE}
  Id_PF_INET4 = PF_INET;
  Id_PF_INET6 = PF_INET6;
  {$ENDIF}

  {$IFDEF USE_BASEUNIX}
  // These constants are actually WinSock specific, not std TCP/IP
  // FPC doesn't emulate WinSock.
  INVALID_SOCKET = -1;
  SOCKET_ERROR   = -1;
  {$ENDIF}

type
  // Socket Type
  {$IF DEFINED(SOCKETTYPE_IS_CINT)}
  TIdSocketType = TIdC_INT;
  {$ELSEIF DEFINED(SOCKETTYPE_IS___SOCKETTYPE)}
  TIdSocketType = __socket_type;
  {$ELSEIF DEFINED(SOCKETTYPE_IS_LONGINT)}
  TIdSocketType = Integer;
  {$IFEND}

const
//  {$IFDEF KYLIXCOMPAT}
//  Id_SOCK_STREAM     = TIdSocketType(SOCK_STREAM);      //1               /* stream socket */
//  Id_SOCK_DGRAM      = TIdSocketType(SOCK_DGRAM);       //2               /* datagram socket */
//  Id_SOCK_RAW        = TIdSocketType(SOCK_RAW);         //3               /* raw-protocol interface */
//  Id_SOCK_RDM        = TIdSocketType(SOCK_RDM);         //4               /* reliably-delivered message */
//  Id_SOCK_SEQPACKET  = SOCK_SEQPACKET;   //5               /* sequenced packet stream */
//  {$ELSE}
//  Id_SOCK_STREAM     = SOCK_STREAM;      //1               /* stream socket */
//  Id_SOCK_DGRAM      = SOCK_DGRAM;       //2               /* datagram socket */
//  Id_SOCK_RAW        = SOCK_RAW;         //3               /* raw-protocol interface */
//  Id_SOCK_RDM        = SOCK_RDM;         //4               /* reliably-delivered message */
//  Id_SOCK_SEQPACKET  = SOCK_SEQPACKET;   //5               /* sequenced packet stream */
//  {$ENDIF}
  Id_SOCK_UNKNOWN    = TIdSocketType(0);
  Id_SOCK_STREAM     = TIdSocketType(SOCK_STREAM);      //1               /* stream socket */
  Id_SOCK_DGRAM      = TIdSocketType(SOCK_DGRAM);       //2               /* datagram socket */
  Id_SOCK_RAW        = TIdSocketType(SOCK_RAW);         //3               /* raw-protocol interface */
     {$IFNDEF USE_VCL_POSIX}
  Id_SOCK_RDM        = TIdSocketType(SOCK_RDM);         //4               /* reliably-delivered message */
     {$ENDIF}
  Id_SOCK_SEQPACKET  = SOCK_SEQPACKET;   //5               /* sequenced packet stream */

type
  // IP Protocol type
  TIdSocketProtocol     = Integer;
  TIdSocketOption       = Integer;
  TIdSocketOptionLevel  = Integer;



const
  {$IFDEF OS2}
  Id_IPPROTO_GGP    = IPPROTO_GGP; //OS/2 does something strange and we might wind up
  //supporting it later for all we know.
  {$ELSE}
  Id_IPPROTO_GGP    = 3;// IPPROTO_GGP; may not be defined in some headers in FPC
  {$ENDIF}
  Id_IPPROTO_ICMP   = IPPROTO_ICMP;
  Id_IPPROTO_ICMPV6 = IPPROTO_ICMPV6;
  {$IFNDEF USE_VCL_POSIX}
  Id_IPPROTO_IDP    = IPPROTO_IDP;

  Id_IPPROTO_IGMP   = IPPROTO_IGMP;
  {$ENDIF}
  Id_IPPROTO_IP     = IPPROTO_IP;
  Id_IPPROTO_IPv6   = IPPROTO_IPV6;
  Id_IPPROTO_ND     = 77; //IPPROTO_ND; is not defined in some headers in FPC
  Id_IPPROTO_PUP    = IPPROTO_PUP;
  Id_IPPROTO_RAW    = IPPROTO_RAW;
  Id_IPPROTO_TCP    = IPPROTO_TCP;
  Id_IPPROTO_UDP    = IPPROTO_UDP;
  Id_IPPROTO_MAX    = IPPROTO_MAX;



  // Socket Option level
  Id_SOL_SOCKET = SOL_SOCKET;
  Id_SOL_IP     = IPPROTO_IP;
  Id_SOL_IPv6   = IPPROTO_IPV6;
  Id_SOL_TCP    = IPPROTO_TCP;
  Id_SOL_UDP    = IPPROTO_UDP;

  // Socket options
  {$IFNDEF WINDOWS}
  SO_DONTLINGER          =  not SO_LINGER;
  {$EXTERNALSYM SO_DONTLINGER}
  {$ENDIF}
  Id_SO_BROADCAST        =  SO_BROADCAST;
  Id_SO_DEBUG            =  SO_DEBUG;
  Id_SO_DONTLINGER       =  SO_DONTLINGER;
  Id_SO_DONTROUTE        =  SO_DONTROUTE;
  Id_SO_ERROR            =  SO_ERROR;
  Id_SO_KEEPALIVE        =  SO_KEEPALIVE;
  Id_SO_LINGER	         =  SO_LINGER;
  Id_SO_OOBINLINE        =  SO_OOBINLINE;
  Id_SO_RCVBUF           =  SO_RCVBUF;
  Id_SO_REUSEADDR        =  SO_REUSEADDR;
  {$IFDEF LINUX}
   // SO_REUSEPORT has different values on different platforms, but for
   // right now we are only interested in it on Linux (it is 512 on BSD)...
  Id_SO_REUSEPORT        =  15;//SO_REUSEPORT; is not defined in some headers in FPC
  {$ENDIF}
  Id_SO_SNDBUF           =  SO_SNDBUF;
  Id_SO_TYPE             =  SO_TYPE;
  {$IFDEF WINDOWS}
  Id_SO_UPDATE_ACCEPT_CONTEXT  = SO_UPDATE_ACCEPT_CONTEXT;
  Id_SO_UPDATE_CONNECT_CONTEXT = SO_UPDATE_CONNECT_CONTEXT;
  {$ENDIF}

  // Additional socket options
  Id_SO_RCVTIMEO         = SO_RCVTIMEO;
  Id_SO_SNDTIMEO         = SO_SNDTIMEO;

  Id_SO_IP_TTL              = IP_TTL;

  {for some reason, the compiler doesn't accept  INADDR_ANY below saying a constant is expected. }
  {$IFDEF USE_VCL_POSIX}
  Id_INADDR_ANY  = 0;// INADDR_ANY;
  Id_INADDR_NONE = $ffffffff;// INADDR_NONE;
  {$ELSE}
  Id_INADDR_ANY  = INADDR_ANY;
  Id_INADDR_NONE = INADDR_NONE;
  {$ENDIF}

  // TCP Options
  {$IFDEF USE_VCL_POSIX}
  INVALID_SOCKET           = -1;
  SOCKET_ERROR             = -1;
  {$ENDIF}
  Id_TCP_NODELAY           = TCP_NODELAY;
  Id_INVALID_SOCKET        = INVALID_SOCKET;
  Id_SOCKET_ERROR          = SOCKET_ERROR;
  Id_SOCKETOPTIONLEVEL_TCP = Id_IPPROTO_TCP; // BGO: rename to Id_SOL_TCP
  {$IFDEF HAS_TCP_CORK}
  Id_TCP_CORK = TCP_CORK;
  {$ENDIF}
  {$IFDEF HAS_TCP_NOPUSH}
  Id_TCP_NOPUSH = TCP_NOPUSH;
  {$ENDIF}
  {$IFDEF HAS_TCP_KEEPIDLE}
  Id_TCP_KEEPIDLE          = TCP_KEEPIDLE;
  {$ENDIF}
  {$IFDEF HAS_TCP_KEEPINTVL}
  Id_TCP_KEEPINTVL         = TCP_KEEPINTVL;
  {$ENDIF}

  {$IFDEF USE_VCL_POSIX}
  // Shutdown Options
  Id_SD_Recv = SHUT_RD;
  Id_SD_Send = SHUT_WR;
  Id_SD_Both = SHUT_RDWR;
  //
  //Temp defines.  They should be in Delphi's Posix.Errno.pas
  ESOCKTNOSUPPORT	= 44;		//* Socket type not supported */
  {$EXTERNALSYM ESOCKTNOSUPPORT}
  EPFNOSUPPORT = 46;		//* Protocol family not supported */
  {$EXTERNALSYM EPFNOSUPPORT}
  ESHUTDOWN = 58;		//* Can't send after socket shutdown */
  {$EXTERNALSYM ESHUTDOWN}
  ETOOMANYREFS = 59;		//* Too many references: can't splice */
  {$EXTERNALSYM ETOOMANYREFS}
  EHOSTDOWN = 64;		//* Host is down */
  {$EXTERNALSYM EHOSTDOWN}
  //
  Id_WSAEINTR           = EINTR;
  Id_WSAEBADF           = EBADF;
  Id_WSAEACCES          = EACCES;
  Id_WSAEFAULT          = EFAULT;
  Id_WSAEINVAL          = EINVAL;
  Id_WSAEMFILE          = EMFILE;
  Id_WSAEWOULDBLOCK     = EWOULDBLOCK;
  Id_WSAEINPROGRESS     = EINPROGRESS;
  Id_WSAEALREADY        = EALREADY;
  Id_WSAENOTSOCK        = ENOTSOCK;
  Id_WSAEDESTADDRREQ    = EDESTADDRREQ;
  Id_WSAEMSGSIZE        = EMSGSIZE;
  Id_WSAEPROTOTYPE      = EPROTOTYPE;
  Id_WSAENOPROTOOPT     = ENOPROTOOPT;
  Id_WSAEPROTONOSUPPORT = EPROTONOSUPPORT;
  Id_WSAESOCKTNOSUPPORT = ESOCKTNOSUPPORT;
  Id_WSAEOPNOTSUPP      = EOPNOTSUPP;
  Id_WSAEPFNOSUPPORT    = EPFNOSUPPORT;
  Id_WSAEAFNOSUPPORT    = EAFNOSUPPORT;
  Id_WSAEADDRINUSE      = EADDRINUSE;
  Id_WSAEADDRNOTAVAIL   = EADDRNOTAVAIL;
  Id_WSAENETDOWN        = ENETDOWN;
  Id_WSAENETUNREACH     = ENETUNREACH;
  Id_WSAENETRESET       = ENETRESET;
  Id_WSAECONNABORTED    = ECONNABORTED;
  Id_WSAECONNRESET      = ECONNRESET;
  Id_WSAENOBUFS         = ENOBUFS;
  Id_WSAEISCONN         = EISCONN;
  Id_WSAENOTCONN        = ENOTCONN;
  Id_WSAESHUTDOWN       = ESHUTDOWN;
  Id_WSAETOOMANYREFS    = ETOOMANYREFS;
  Id_WSAETIMEDOUT       = ETIMEDOUT;
  Id_WSAECONNREFUSED    = ECONNREFUSED;
  Id_WSAELOOP           = ELOOP;
  Id_WSAENAMETOOLONG    = ENAMETOOLONG;
  Id_WSAEHOSTDOWN       = EHOSTDOWN;
  Id_WSAEHOSTUNREACH    = EHOSTUNREACH;
  Id_WSAENOTEMPTY       = ENOTEMPTY;
  {$ENDIF}

  {$IFDEF KYLIXCOMPAT}
  // Shutdown Options
  Id_SD_Recv = SHUT_RD;
  Id_SD_Send = SHUT_WR;
  Id_SD_Both = SHUT_RDWR;
  //
  Id_WSAEINTR           = EINTR;
  Id_WSAEBADF           = EBADF;
  Id_WSAEACCES          = EACCES;
  Id_WSAEFAULT          = EFAULT;
  Id_WSAEINVAL          = EINVAL;
  Id_WSAEMFILE          = EMFILE;
  Id_WSAEWOULDBLOCK     = EWOULDBLOCK;
  Id_WSAEINPROGRESS     = EINPROGRESS;
  Id_WSAEALREADY        = EALREADY;
  Id_WSAENOTSOCK        = ENOTSOCK;
  Id_WSAEDESTADDRREQ    = EDESTADDRREQ;
  Id_WSAEMSGSIZE        = EMSGSIZE;
  Id_WSAEPROTOTYPE      = EPROTOTYPE;
  Id_WSAENOPROTOOPT     = ENOPROTOOPT;
  Id_WSAEPROTONOSUPPORT = EPROTONOSUPPORT;
  Id_WSAESOCKTNOSUPPORT = ESOCKTNOSUPPORT;
  Id_WSAEOPNOTSUPP      = EOPNOTSUPP;
  Id_WSAEPFNOSUPPORT    = EPFNOSUPPORT;
  Id_WSAEAFNOSUPPORT    = EAFNOSUPPORT;
  Id_WSAEADDRINUSE      = EADDRINUSE;
  Id_WSAEADDRNOTAVAIL   = EADDRNOTAVAIL;
  Id_WSAENETDOWN        = ENETDOWN;
  Id_WSAENETUNREACH     = ENETUNREACH;
  Id_WSAENETRESET       = ENETRESET;
  Id_WSAECONNABORTED    = ECONNABORTED;
  Id_WSAECONNRESET      = ECONNRESET;
  Id_WSAENOBUFS         = ENOBUFS;
  Id_WSAEISCONN         = EISCONN;
  Id_WSAENOTCONN        = ENOTCONN;
  Id_WSAESHUTDOWN       = ESHUTDOWN;
  Id_WSAETOOMANYREFS    = ETOOMANYREFS;
  Id_WSAETIMEDOUT       = ETIMEDOUT;
  Id_WSAECONNREFUSED    = ECONNREFUSED;
  Id_WSAELOOP           = ELOOP;
  Id_WSAENAMETOOLONG    = ENAMETOOLONG;
  Id_WSAEHOSTDOWN       = EHOSTDOWN;
  Id_WSAEHOSTUNREACH    = EHOSTUNREACH;
  Id_WSAENOTEMPTY       = ENOTEMPTY;
  {$ENDIF}

  {$IFDEF USE_BASEUNIX}
  // Shutdown Options
  Id_SD_Recv = SHUT_RD;
  Id_SD_Send = SHUT_WR;
  Id_SD_Both = SHUT_RDWR;
    {$IFDEF BEOS}
  {work around incomplete definitions in BeOS FPC compiler.}
  EDESTADDRREQ = (B_POSIX_ERROR_BASE + 48);
  {$EXTERNALSYM EDESTADDRREQ}
  EHOSTDOWN = (B_POSIX_ERROR_BASE + 45);
  {$EXTERNALSYM EHOSTDOWN}
  ESysENOTSOCK = ENOTSOCK;
  ESysEDESTADDRREQ = EDESTADDRREQ;
  ESysEMSGSIZE = EMSGSIZE;
  ESysEOPNOTSUPP = EOPNOTSUPP;
  ESysEHOSTDOWN = EHOSTDOWN;
    {$ENDIF}
  //
  Id_WSAEINTR           = ESysEINTR;
  Id_WSAEBADF           = ESysEBADF;
  Id_WSAEACCES          = ESysEACCES;
  Id_WSAEFAULT          = ESysEFAULT;
  Id_WSAEINVAL          = ESysEINVAL;
  Id_WSAEMFILE          = ESysEMFILE;
  Id_WSAEWOULDBLOCK     = ESysEWOULDBLOCK;
  Id_WSAEINPROGRESS     = ESysEINPROGRESS;
  Id_WSAEALREADY        = ESysEALREADY;
  Id_WSAENOTSOCK        = ESysENOTSOCK;
  Id_WSAEDESTADDRREQ    = ESysEDESTADDRREQ;
  Id_WSAEMSGSIZE        = ESysEMSGSIZE;
  Id_WSAEPROTOTYPE      = ESysEPROTOTYPE;
  Id_WSAENOPROTOOPT     = ESysENOPROTOOPT;
  Id_WSAEPROTONOSUPPORT = ESysEPROTONOSUPPORT;
  {$IFNDEF BEOS}
  Id_WSAESOCKTNOSUPPORT = ESysESOCKTNOSUPPORT;
  {$ENDIF}
  Id_WSAEOPNOTSUPP      = ESysEOPNOTSUPP;
  Id_WSAEPFNOSUPPORT    = ESysEPFNOSUPPORT;
  Id_WSAEAFNOSUPPORT    = ESysEAFNOSUPPORT;
  Id_WSAEADDRINUSE      = ESysEADDRINUSE;
  Id_WSAEADDRNOTAVAIL   = ESysEADDRNOTAVAIL;
  Id_WSAENETDOWN        = ESysENETDOWN;
  Id_WSAENETUNREACH     = ESysENETUNREACH;
  Id_WSAENETRESET       = ESysENETRESET;
  Id_WSAECONNABORTED    = ESysECONNABORTED;
  Id_WSAECONNRESET      = ESysECONNRESET;
  Id_WSAENOBUFS         = ESysENOBUFS;
  Id_WSAEISCONN         = ESysEISCONN;
  Id_WSAENOTCONN        = ESysENOTCONN;
  Id_WSAESHUTDOWN       = ESysESHUTDOWN;
  {$IFNDEF BEOS}
  Id_WSAETOOMANYREFS    = ESysETOOMANYREFS;
  {$ENDIF}
  Id_WSAETIMEDOUT       = ESysETIMEDOUT;
  Id_WSAECONNREFUSED    = ESysECONNREFUSED;
  Id_WSAELOOP           = ESysELOOP;
  Id_WSAENAMETOOLONG    = ESysENAMETOOLONG;
  Id_WSAEHOSTDOWN       = ESysEHOSTDOWN;
  Id_WSAEHOSTUNREACH    = ESysEHOSTUNREACH;
  Id_WSAENOTEMPTY       = ESysENOTEMPTY;
  {$ENDIF}

  {$IFDEF WINDOWS}
  // Shutdown Options
  Id_SD_Recv = 0;
  Id_SD_Send = 1;
  Id_SD_Both = 2;
  //
  Id_WSAEINTR           = WSAEINTR;
  Id_WSAEBADF           = WSAEBADF;
  Id_WSAEACCES          = WSAEACCES;
  Id_WSAEFAULT          = WSAEFAULT;
  Id_WSAEINVAL          = WSAEINVAL;
  Id_WSAEMFILE          = WSAEMFILE;
  Id_WSAEWOULDBLOCK     = WSAEWOULDBLOCK;
  Id_WSAEINPROGRESS     = WSAEINPROGRESS;
  Id_WSAEALREADY        = WSAEALREADY;
  Id_WSAENOTSOCK        = WSAENOTSOCK;
  Id_WSAEDESTADDRREQ    = WSAEDESTADDRREQ;
  Id_WSAEMSGSIZE        = WSAEMSGSIZE;
  Id_WSAEPROTOTYPE      = WSAEPROTOTYPE;
  Id_WSAENOPROTOOPT     = WSAENOPROTOOPT;
  Id_WSAEPROTONOSUPPORT = WSAEPROTONOSUPPORT;
  Id_WSAESOCKTNOSUPPORT = WSAESOCKTNOSUPPORT;
  Id_WSAEOPNOTSUPP      = WSAEOPNOTSUPP;
  Id_WSAEPFNOSUPPORT    = WSAEPFNOSUPPORT;
  Id_WSAEAFNOSUPPORT    = WSAEAFNOSUPPORT;
  Id_WSAEADDRINUSE      = WSAEADDRINUSE;
  Id_WSAEADDRNOTAVAIL   = WSAEADDRNOTAVAIL;
  Id_WSAENETDOWN        = WSAENETDOWN;
  Id_WSAENETUNREACH     = WSAENETUNREACH;
  Id_WSAENETRESET       = WSAENETRESET;
  Id_WSAECONNABORTED    = WSAECONNABORTED;
  Id_WSAECONNRESET      = WSAECONNRESET;
  Id_WSAENOBUFS         = WSAENOBUFS;
  Id_WSAEISCONN         = WSAEISCONN;
  Id_WSAENOTCONN        = WSAENOTCONN;
  Id_WSAESHUTDOWN       = WSAESHUTDOWN;
  Id_WSAETOOMANYREFS    = WSAETOOMANYREFS;
  Id_WSAETIMEDOUT       = WSAETIMEDOUT;
  Id_WSAECONNREFUSED    = WSAECONNREFUSED;
  Id_WSAELOOP           = WSAELOOP;
  Id_WSAENAMETOOLONG    = WSAENAMETOOLONG;
  Id_WSAEHOSTDOWN       = WSAEHOSTDOWN;
  Id_WSAEHOSTUNREACH    = WSAEHOSTUNREACH;
  Id_WSAENOTEMPTY       = WSAENOTEMPTY;
  {$ENDIF}

implementation

{$IFDEF USE_VCL_POSIX}
  {$I IdSymbolPlatformOn.inc}
{$ENDIF}

end.
