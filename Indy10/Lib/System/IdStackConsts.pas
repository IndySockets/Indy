{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  56965: IdStackConsts.pas 
{
{   Rev 1.0    2004.02.07 12:25:16 PM  czhower
{ Recheckin to fix case of filename
}
{
{   Rev 1.1    2/7/2004 5:20:06 AM  JPMugaas
{ Added some constants that were pasted from other places.  DotNET uses the
{ standard Winsock 2 error consstants.  We don't want to link to IdWInsock or
{ Windows though because that causes other problems.
}
{
{   Rev 1.0    2004.02.03 3:14:44 PM  czhower
{ Move and updates
}
{
{   Rev 1.12    2003.12.28 6:53:46 PM  czhower
{ Added some consts.
}
{
{   Rev 1.11    10/28/2003 9:14:54 PM  BGooijen
{ .net
}
{
{   Rev 1.10    10/19/2003 10:46:18 PM  BGooijen
{ Added more consts
}
{
{   Rev 1.9    10/19/2003 9:15:28 PM  BGooijen
{ added some SocketOptionName consts for dotnet
}
{
{   Rev 1.8    10/19/2003 5:21:30 PM  BGooijen
{ SetSocketOption
}
{
{   Rev 1.7    10/2/2003 7:31:18 PM  BGooijen
{ .net
}
{
{   Rev 1.6    2003.10.02 10:16:32 AM  czhower
{ .Net
}
{
{   Rev 1.5    2003.10.01 5:05:18 PM  czhower
{ .Net
}
{
{   Rev 1.4    2003.10.01 1:12:40 AM  czhower
{ .Net
}
{
{   Rev 1.3    2003.09.30 12:09:38 PM  czhower
{ DotNet changes.
}
{
{   Rev 1.2    9/29/2003 10:28:30 PM  BGooijen
{ Added constants for DotNet
}
{
{   Rev 1.1    12-14-2002 14:58:34  BGooijen
{ Added definition for Id_SOCK_RDM and Id_SOCK_SEQPACKET
}
{
{   Rev 1.0    11/13/2002 08:59:14 AM  JPMugaas
}
unit IdStackConsts;

{$I IdCompilerDefines.inc}

interface

{This should be the only unit except OS Stack units that reference
Winsock or lnxsock}
uses
 {$IFDEF LINUX}
  Libc;
 {$ENDIF}
 {$IFDEF MSWINDOWS}
  IdWinsock2;
 {$ENDIF}
 {$IFDEF DOTNET}
  System.Net.Sockets;
 {$ENDIF}

type
  TIdStackSocketHandle = {$IFDEF DOTNET} Socket; {$ELSE} TSocket; {$ENDIF}

var
  Id_SO_True: Integer = 1;
  Id_SO_False: Integer = 0;

const
  {$IFDEF LINUX}
    Id_IP_MULTICAST_TTL = IP_MULTICAST_TTL; // TODO integrate into IdStackConsts
    Id_IP_MULTICAST_LOOP = IP_MULTICAST_LOOP; // TODO integrate into IdStackConsts
    Id_IP_ADD_MEMBERSHIP = IP_ADD_MEMBERSHIP; // TODO integrate into IdStackConsts
    Id_IP_DROP_MEMBERSHIP = IP_DROP_MEMBERSHIP; // TODO integrate into IdStackConsts
  {$ELSE}
    Id_IP_MULTICAST_TTL = 10; // TODO integrate into IdStackConsts FIX ERROR in IdWinsock
    Id_IP_MULTICAST_LOOP = 11; // TODO integrate into IdStackConsts FIX ERROR in IdWinsock
    Id_IP_ADD_MEMBERSHIP = 12; // TODO integrate into IdStackConsts FIX ERROR in IdWinsock
    Id_IP_DROP_MEMBERSHIP = 13; // TODO integrate into IdStackConsts FIX ERROR in IdWinsock
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
  {$IFDEF LINUX}
  TCP_NODELAY = 1;
  {$ENDIF}

  // Protocol Family

  {$ifndef DOTNET}
  Id_PF_INET4 = PF_INET;
  Id_PF_INET6 = PF_INET6;
  {$else}
  Id_PF_INET4 = ProtocolFamily.InterNetwork;
  Id_PF_INET6 = ProtocolFamily.InterNetworkV6;
  {$endif}

  // Socket Type
type
  TIdSocketType = {$IFDEF DotNet} SocketType; {$ELSE} Integer; {$ENDIF}
const
  {$IFNDEF DOTNET}
  Id_SOCK_STREAM     = SOCK_STREAM;      //1               /* stream socket */
  Id_SOCK_DGRAM      = SOCK_DGRAM;       //2               /* datagram socket */
  Id_SOCK_RAW        = SOCK_RAW;         //3               /* raw-protocol interface */
  Id_SOCK_RDM        = SOCK_RDM;         //4               /* reliably-delivered message */
  Id_SOCK_SEQPACKET  = SOCK_SEQPACKET;   //5               /* sequenced packet stream */
  {$ELSE}
  Id_SOCK_STREAM     = SocketType.Stream;         // /* stream socket */
  Id_SOCK_DGRAM      = SocketType.Dgram;          // /* datagram socket */
  Id_SOCK_RAW        = SocketType.Raw;            // /* raw-protocol interface */
  Id_SOCK_RDM        = SocketType.Rdm;            // /* reliably-delivered message */
  Id_SOCK_SEQPACKET  = SocketType.Seqpacket;      // /* sequenced packet stream */
  {$ENDIF}

  // IP Protocol type
type
  TIdSocketProtocol     = {$IFDEF DotNet} ProtocolType; {$ELSE} Integer; {$ENDIF}
  TIdSocketOption       = {$IFDEF DotNet} SocketOptionName; {$ELSE} Integer; {$ENDIF}
  TIdSocketOptionLevel  = {$IFDEF DotNet} SocketOptionLevel; {$ELSE} Integer; {$ENDIF}
  
const
  {$ifndef DOTNET}
  Id_IPPROTO_IP = IPPROTO_IP;
  Id_IPPROTO_ICMP = IPPROTO_ICMP;
  Id_IPPROTO_IGMP = IPPROTO_IGMP;
  Id_IPPROTO_TCP = IPPROTO_TCP;
  Id_IPPROTO_UDP = IPPROTO_UDP;
  Id_IPPROTO_RAW = IPPROTO_RAW;
  Id_IPPROTO_MAX = IPPROTO_MAX;
  {$else}
  Id_IPPROTO_IP = ProtocolType.IP;
  Id_IPPROTO_ICMP = ProtocolType.Icmp;
  Id_IPPROTO_IGMP = ProtocolType.Igmp;
  Id_IPPROTO_TCP = ProtocolType.Tcp;
  Id_IPPROTO_UDP = ProtocolType.Udp;
  Id_IPPROTO_RAW = ProtocolType.Raw;
//  Id_IPPROTO_MAX = ProtocolType.; ?????????????????????
  {$endif}

  // Socket Option level
  {$ifndef DOTNET}
  Id_SOL_SOCKET = SOL_SOCKET;
  Id_SOL_IP  = IPPROTO_IP;
  {$else}
  Id_SOL_SOCKET = SocketOptionLevel.Socket;
  Id_SOL_IP = SocketOptionLevel.Ip;
  {$endif}

  // Socket options
  {$ifndef DOTNET}
  Id_SO_BROADCAST        =  SO_BROADCAST;
  Id_SO_DEBUG            =  SO_DEBUG;
  Id_SO_DONTROUTE        =  SO_DONTROUTE;
  Id_SO_KEEPALIVE        =  SO_KEEPALIVE;
  Id_SO_LINGER	         =  SO_LINGER;
  Id_SO_OOBINLINE        =  SO_OOBINLINE;
  Id_SO_RCVBUF           =  SO_RCVBUF;
  Id_SO_REUSEADDR        =  SO_REUSEADDR;
  Id_SO_SNDBUF           =  SO_SNDBUF;
  {$else}
{
SocketOptionName.AcceptConnection;// Socket is listening.
SocketOptionName.AddMembership;//  Add an IP group membership.
SocketOptionName.AddSourceMembership;//  Join a source group.
SocketOptionName.BlockSource;//  Block data from a source.
}
  Id_SO_BROADCAST        =  SocketOptionName.Broadcast;//  Permit sending broadcast messages on the socket.
{
SocketOptionName.BsdUrgent;//  Use urgent data as defined in RFC-1222. This option can be set only once, and once set, cannot be turned off.
SocketOptionName.ChecksumCoverage;//  Set or get UDP checksum coverage.
SocketOptionName.Debug;//  Record debugging information.
SocketOptionName.DontFragment;//  Do not fragment IP datagrams.
SocketOptionName.DontLinger;//  Close socket gracefully without lingering.
SocketOptionName.DontRoute;//  Do not route; send directly to interface addresses.
SocketOptionName.DropMembership;//  Drop an IP group membership.
SocketOptionName.DropSourceMembership;//  Drop a source group.
SocketOptionName.Error;//  Get error status and clear.
SocketOptionName.ExclusiveAddressUse;//  Enables a socket to be bound for exclusive access.
SocketOptionName.Expedited;//  Use expedited data as defined in RFC-1222. This option can be set only once, and once set, cannot be turned off.
SocketOptionName.HeaderIncluded;//  Indicates application is providing the IP header for outgoing datagrams.
SocketOptionName.IPOptions;//  Specifies IP options to be inserted into outgoing datagrams.
SocketOptionName.KeepAlive;//  Send keep-alives.
SocketOptionName.Linger;//  Linger on close if unsent data is present.
SocketOptionName.MaxConnections;//  Maximum queue length that can be specified by Listen.
SocketOptionName.MulticastInterface;//  Set the interface for outgoing multicast packets.
SocketOptionName.MulticastLoopback;//  IP multicast loopback.
SocketOptionName.MulticastTimeToLive;//  IP multicast time to live.
SocketOptionName.NoChecksum;//  Send UDP datagrams with checksum set to zero.
SocketOptionName.NoDelay;//  Disables the Nagle algorithm for send coalescing.
SocketOptionName.OutOfBandInline;//  Receives out-of-band data in the normal data stream.
SocketOptionName.PacketInformation;//  Return information about received packets.
SocketOptionName.ReceiveBuffer;//  Send low water mark.
SocketOptionName.ReceiveLowWater;//  Receive low water mark.
SocketOptionName.ReceiveTimeout;//  Receive time out. This option applies only to synchronous methods; it has no effect on asynchronous methods such as BeginSend.
}
  Id_SO_REUSEADDR        =  SocketOptionName.ReuseAddress;//  Allows the socket to be bound to an address that is already in use.
{
SocketOptionName.SendBuffer;//  Specifies the total per-socket buffer space reserved for sends. This is unrelated to the maximum message size or the size of a TCP window.
SocketOptionName.SendLowWater;//  Specifies the total per-socket buffer space reserved for receives. This is unrelated to the maximum message size or the size of a TCP window.
SocketOptionName.SendTimeout;//  Send timeout. This option applies only to synchronous methods; it has no effect on asynchronous methods such as BeginSend.
SocketOptionName.Type;//  Get socket type.
SocketOptionName.TypeOfService;//  Change the IP header type of service field.
SocketOptionName.UnblockSource;//  Unblock a previously blocked source.
SocketOptionName.UseLoopback;//  Bypass hardware when possible.
}
  {$endif}

  // Additional socket options
  {$ifndef DOTNET}
  Id_SO_RCVTIMEO         = SO_RCVTIMEO;
  Id_SO_SNDTIMEO         = SO_SNDTIMEO;
  {$else}
  {$endif}

  {$ifndef DOTNET}
  Id_IP_TTL              = IP_TTL;
  {$else}
  Id_IP_TTL              = SocketOptionName.IpTimeToLive; //  Set the IP header time-to-live field.
  {$endif}

  //
  {$ifndef DOTNET}
  Id_INADDR_ANY = INADDR_ANY;
  Id_INADDR_NONE = INADDR_NONE;
  {$else}
  {$endif}

  // TCP Options
  {$ifndef DOTNET}
  Id_TCP_NODELAY = TCP_NODELAY;
  Id_INVALID_SOCKET = INVALID_SOCKET;
  Id_SOCKET_ERROR = SOCKET_ERROR;
  
  Id_SOCKETOPTIONLEVEL_TCP = Id_IPPROTO_TCP; // BGO: rename to Id_SOL_TCP
  {$else}
  Id_TCP_NODELAY = SocketOptionName.NoDelay;
  Id_INVALID_SOCKET = nil;
  Id_SOCKETOPTIONLEVEL_TCP = SocketOptionLevel.TCP; // BGO: rename to Id_SOL_TCP
  {$endif}
  //
  {$IFDEF LINUX}
  // Shutdown Options
  Id_SD_Recv = SHUT_RD;
  Id_SD_Send = SHUT_WR;
  Id_SD_Both = SHUT_RDWR;
  //
  Id_WSAEINTR = EINTR;
  Id_WSAEBADF = EBADF;
  Id_WSAEACCES = EACCES;
  Id_WSAEFAULT = EFAULT;
  Id_WSAEINVAL = EINVAL;
  Id_WSAEMFILE = EMFILE;
  Id_WSAEWOULDBLOCK = EWOULDBLOCK;
  Id_WSAEINPROGRESS = EINPROGRESS;
  Id_WSAEALREADY = EALREADY;
  Id_WSAENOTSOCK = ENOTSOCK;
  Id_WSAEDESTADDRREQ = EDESTADDRREQ;
  Id_WSAEMSGSIZE = EMSGSIZE;
  Id_WSAEPROTOTYPE = EPROTOTYPE;
  Id_WSAENOPROTOOPT = ENOPROTOOPT;
  Id_WSAEPROTONOSUPPORT = EPROTONOSUPPORT;
  Id_WSAESOCKTNOSUPPORT = ESOCKTNOSUPPORT;

  Id_WSAEOPNOTSUPP = EOPNOTSUPP;
  Id_WSAEPFNOSUPPORT = EPFNOSUPPORT;
  Id_WSAEAFNOSUPPORT = EAFNOSUPPORT;
  Id_WSAEADDRINUSE = EADDRINUSE;
  Id_WSAEADDRNOTAVAIL = EADDRNOTAVAIL;
  Id_WSAENETDOWN = ENETDOWN;
  Id_WSAENETUNREACH = ENETUNREACH;
  Id_WSAENETRESET = ENETRESET;
  Id_WSAECONNABORTED = ECONNABORTED;
  Id_WSAECONNRESET = ECONNRESET;
  Id_WSAENOBUFS = ENOBUFS;
  Id_WSAEISCONN = EISCONN;
  Id_WSAENOTCONN = ENOTCONN;
  Id_WSAESHUTDOWN = ESHUTDOWN;
  Id_WSAETOOMANYREFS = ETOOMANYREFS;
  Id_WSAETIMEDOUT = ETIMEDOUT;
  Id_WSAECONNREFUSED = ECONNREFUSED;
  Id_WSAELOOP = ELOOP;
  Id_WSAENAMETOOLONG = ENAMETOOLONG;
  Id_WSAEHOSTDOWN = EHOSTDOWN;
  Id_WSAEHOSTUNREACH = EHOSTUNREACH;
  Id_WSAENOTEMPTY = ENOTEMPTY;
  {$endif}
  {$ifdef MSWINDOWS}
  // Shutdown Options
  Id_SD_Recv = 0;
  Id_SD_Send = 1;
  Id_SD_Both = 2;
  //
  Id_WSAEINTR = WSAEINTR;
  Id_WSAEBADF = WSAEBADF;
  Id_WSAEACCES = WSAEACCES;
  Id_WSAEFAULT = WSAEFAULT;
  Id_WSAEINVAL = WSAEINVAL;
  Id_WSAEMFILE = WSAEMFILE;
  Id_WSAEWOULDBLOCK = WSAEWOULDBLOCK;
  Id_WSAEINPROGRESS = WSAEINPROGRESS;
  Id_WSAEALREADY = WSAEALREADY;
  Id_WSAENOTSOCK = WSAENOTSOCK;
  Id_WSAEDESTADDRREQ = WSAEDESTADDRREQ;
  Id_WSAEMSGSIZE = WSAEMSGSIZE;
  Id_WSAEPROTOTYPE = WSAEPROTOTYPE;
  Id_WSAENOPROTOOPT = WSAENOPROTOOPT;
  Id_WSAEPROTONOSUPPORT = WSAEPROTONOSUPPORT;
  Id_WSAESOCKTNOSUPPORT = WSAESOCKTNOSUPPORT;

  Id_WSAEOPNOTSUPP = WSAEOPNOTSUPP;
  Id_WSAEPFNOSUPPORT = WSAEPFNOSUPPORT;
  Id_WSAEAFNOSUPPORT = WSAEAFNOSUPPORT;
  Id_WSAEADDRINUSE = WSAEADDRINUSE;
  Id_WSAEADDRNOTAVAIL = WSAEADDRNOTAVAIL;
  Id_WSAENETDOWN = WSAENETDOWN;
  Id_WSAENETUNREACH = WSAENETUNREACH;
  Id_WSAENETRESET = WSAENETRESET;
  Id_WSAECONNABORTED = WSAECONNABORTED;
  Id_WSAECONNRESET = WSAECONNRESET;
  Id_WSAENOBUFS = WSAENOBUFS;
  Id_WSAEISCONN = WSAEISCONN;
  Id_WSAENOTCONN = WSAENOTCONN;
  Id_WSAESHUTDOWN = WSAESHUTDOWN;
  Id_WSAETOOMANYREFS = WSAETOOMANYREFS;
  Id_WSAETIMEDOUT = WSAETIMEDOUT;
  Id_WSAECONNREFUSED = WSAECONNREFUSED;
  Id_WSAELOOP = WSAELOOP;
  Id_WSAENAMETOOLONG = WSAENAMETOOLONG;
  Id_WSAEHOSTDOWN = WSAEHOSTDOWN;
  Id_WSAEHOSTUNREACH = WSAEHOSTUNREACH;
  Id_WSAENOTEMPTY = WSAENOTEMPTY;
  {$ENDIF}
  {$ifdef DOTNET}
//In DotNET, the constants are the same as in Winsock2.

//Ripped from IdWinsock2 - don't use that in DotNET.

    wsabaseerr              = 10000;

// Windows Sockets definitions of regular Microsoft C error constants

  wsaeintr                = wsabaseerr+  4;
  wsaebadf                = wsabaseerr+  9;
  wsaeacces               = wsabaseerr+ 13;
  wsaefault               = wsabaseerr+ 14;
  wsaeinval               = wsabaseerr+ 22;
  wsaemfile               = wsabaseerr+ 24;

// Windows Sockets definitions of regular Berkeley error constants

  wsaewouldblock          = wsabaseerr+ 35;
  wsaeinprogress          = wsabaseerr+ 36;
  wsaealready             = wsabaseerr+ 37;
  wsaenotsock             = wsabaseerr+ 38;
  wsaedestaddrreq         = wsabaseerr+ 39;
  wsaemsgsize             = wsabaseerr+ 40;
  wsaeprototype           = wsabaseerr+ 41;
  wsaenoprotoopt          = wsabaseerr+ 42;
  wsaeprotonosupport      = wsabaseerr+ 43;
  wsaesocktnosupport      = wsabaseerr+ 44;
  wsaeopnotsupp           = wsabaseerr+ 45;
  wsaepfnosupport         = wsabaseerr+ 46;
  wsaeafnosupport         = wsabaseerr+ 47;
  wsaeaddrinuse           = wsabaseerr+ 48;
  wsaeaddrnotavail        = wsabaseerr+ 49;
  wsaenetdown             = wsabaseerr+ 50;
  wsaenetunreach          = wsabaseerr+ 51;
  wsaenetreset            = wsabaseerr+ 52;
  wsaeconnaborted         = wsabaseerr+ 53;
  wsaeconnreset           = wsabaseerr+ 54;
  wsaenobufs              = wsabaseerr+ 55;
  wsaeisconn              = wsabaseerr+ 56;
  wsaenotconn             = wsabaseerr+ 57;
  wsaeshutdown            = wsabaseerr+ 58;
  wsaetoomanyrefs         = wsabaseerr+ 59;
  wsaetimedout            = wsabaseerr+ 60;
  wsaeconnrefused         = wsabaseerr+ 61;
  wsaeloop                = wsabaseerr+ 62;
  wsaenametoolong         = wsabaseerr+ 63;
  wsaehostdown            = wsabaseerr+ 64;
  wsaehostunreach         = wsabaseerr+ 65;
  wsaenotempty            = wsabaseerr+ 66;
  wsaeproclim             = wsabaseerr+ 67;
  wsaeusers               = wsabaseerr+ 68;
  wsaedquot               = wsabaseerr+ 69;
  wsaestale               = wsabaseerr+ 70;
  wsaeremote              = wsabaseerr+ 71;

// Extended Windows Sockets error constant definitions

  wsasysnotready          = wsabaseerr+ 91;
  wsavernotsupported      = wsabaseerr+ 92;
  wsanotinitialised       = wsabaseerr+ 93;
  wsaediscon              = wsabaseerr+101;
  wsaenomore              = wsabaseerr+102;
  wsaecancelled           = wsabaseerr+103;
  wsaeinvalidproctable    = wsabaseerr+104;
  wsaeinvalidprovider     = wsabaseerr+105;
  wsaeproviderfailedinit  = wsabaseerr+106;
  wsasyscallfailure       = wsabaseerr+107;
  wsaservice_not_found    = wsabaseerr+108;
  wsatype_not_found       = wsabaseerr+109;
  wsa_e_no_more           = wsabaseerr+110;
  wsa_e_cancelled         = wsabaseerr+111;
  wsaerefused             = wsabaseerr+112;


{ Error return codes from gethostbyname() and gethostbyaddr()
  (when using the resolver). Note that these errors are
  retrieved via WSAGetLastError() and must therefore follow
  the rules for avoiding clashes with error numbers from
  specific implementations or language run-time systems.
  For this reason the codes are based at WSABASEERR+1001.
  Note also that [WSA]NO_ADDRESS is defined only for
  compatibility purposes. }

// Authoritative Answer: Host not found
  wsahost_not_found        = wsabaseerr+1001;
  host_not_found           = wsahost_not_found;

// Non-Authoritative: Host not found, or SERVERFAIL
  wsatry_again             = wsabaseerr+1002;
  try_again                = wsatry_again;

// Non recoverable errors, FORMERR, REFUSED, NOTIMP
  wsano_recovery           = wsabaseerr+1003;
  no_recovery              = wsano_recovery;

// Valid name, no data record of requested type
  wsano_data               = wsabaseerr+1004;
  no_data                  = wsano_data;

// no address, look for MX record
  wsano_address            = wsano_data;
  no_address               = wsano_address;

// Define QOS related error return codes

  wsa_qos_receivers          = wsabaseerr+1005; // at least one reserve has arrived
  wsa_qos_senders            = wsabaseerr+1006; // at least one path has arrived
  wsa_qos_no_senders         = wsabaseerr+1007; // there are no senders
  wsa_qos_no_receivers       = wsabaseerr+1008; // there are no receivers
  wsa_qos_request_confirmed  = wsabaseerr+1009; // reserve has been confirmed
  wsa_qos_admission_failure  = wsabaseerr+1010; // error due to lack of resources
  wsa_qos_policy_failure     = wsabaseerr+1011; // rejected for administrative reasons - bad credentials
  wsa_qos_bad_style          = wsabaseerr+1012; // unknown or conflicting style
  wsa_qos_bad_object         = wsabaseerr+1013; // problem with some part of the filterspec or providerspecific buffer in general
  wsa_qos_traffic_ctrl_error = wsabaseerr+1014; // problem with some part of the flowspec
  wsa_qos_generic_error      = wsabaseerr+1015; // general error
  wsa_qos_eservicetype       = wsabaseerr+1016; // invalid service type in flowspec
  wsa_qos_eflowspec          = wsabaseerr+1017; // invalid flowspec
  wsa_qos_eprovspecbuf       = wsabaseerr+1018; // invalid provider specific buffer
  wsa_qos_efilterstyle       = wsabaseerr+1019; // invalid filter style
  wsa_qos_efiltertype        = wsabaseerr+1020; // invalid filter type
  wsa_qos_efiltercount       = wsabaseerr+1021; // incorrect number of filters
  wsa_qos_eobjlength         = wsabaseerr+1022; // invalid object length
  wsa_qos_eflowcount         = wsabaseerr+1023; // incorrect number of flows
  wsa_qos_eunkownpsobj       = wsabaseerr+1024; // unknown object in provider specific buffer
  wsa_qos_epolicyobj         = wsabaseerr+1025; // invalid policy object in provider specific buffer
  wsa_qos_eflowdesc          = wsabaseerr+1026; // invalid flow descriptor in the list
  wsa_qos_epsflowspec        = wsabaseerr+1027; // inconsistent flow spec in provider specific buffer
  wsa_qos_epsfilterspec      = wsabaseerr+1028; // invalid filter spec in provider specific buffer
  wsa_qos_esdmodeobj         = wsabaseerr+1029; // invalid shape discard mode object in provider specific buffer
  wsa_qos_eshaperateobj      = wsabaseerr+1030; // invalid shaping rate object in provider specific buffer
  wsa_qos_reserved_petype    = wsabaseerr+1031; // reserved policy element in provider specific buffer

  {This section defines error constants used in Winsock 2 indirectly.  These
  are from Borland's header.}
  { The handle is invalid. }
  ERROR_INVALID_HANDLE = 6;

  { Not enough storage is available to process this command. }
  ERROR_NOT_ENOUGH_MEMORY = 8;   { dderror }

  { The parameter is incorrect. }
  ERROR_INVALID_PARAMETER = 87;   { dderror }

  { The I/O operation has been aborted because of either a thread exit }
  { or an application request. }
  ERROR_OPERATION_ABORTED = 995;

  { Overlapped I/O event is not in a signalled state. }
  ERROR_IO_INCOMPLETE = 996;

  { Overlapped I/O operation is in progress. }
  ERROR_IO_PENDING = 997;   { dderror }

{ WinSock 2 extension -- new error codes and type definition }
  wsa_io_pending          = error_io_pending;
  wsa_io_incomplete       = error_io_incomplete;
  wsa_invalid_handle      = error_invalid_handle;
  wsa_invalid_parameter   = error_invalid_parameter;
  wsa_not_enough_memory   = error_not_enough_memory;
  wsa_operation_aborted   = error_operation_aborted;

  //TODO: Map these to .net constants. Unfortunately .net does not seem to
  //define these anywhere.


  Id_WSAEINTR = WSAEINTR;
  Id_WSAEBADF = WSAEBADF;
  Id_WSAEACCES = WSAEACCES;
  Id_WSAEFAULT = WSAEFAULT;
  Id_WSAEINVAL = WSAEINVAL;
  Id_WSAEMFILE = WSAEMFILE;
  Id_WSAEWOULDBLOCK = WSAEWOULDBLOCK;
  Id_WSAEINPROGRESS = WSAEINPROGRESS;
  Id_WSAEALREADY = WSAEALREADY;
  Id_WSAENOTSOCK = WSAENOTSOCK;
  Id_WSAEDESTADDRREQ = WSAEDESTADDRREQ;
  Id_WSAEMSGSIZE = WSAEMSGSIZE;
  Id_WSAEPROTOTYPE = WSAEPROTOTYPE;
  Id_WSAENOPROTOOPT = WSAENOPROTOOPT;
  Id_WSAEPROTONOSUPPORT = WSAEPROTONOSUPPORT;
  Id_WSAESOCKTNOSUPPORT = WSAESOCKTNOSUPPORT;

  Id_WSAEOPNOTSUPP = WSAEOPNOTSUPP;
  Id_WSAEPFNOSUPPORT = WSAEPFNOSUPPORT;
  Id_WSAEAFNOSUPPORT = WSAEAFNOSUPPORT;
  Id_WSAEADDRINUSE = WSAEADDRINUSE;
  Id_WSAEADDRNOTAVAIL = WSAEADDRNOTAVAIL;
  Id_WSAENETDOWN = WSAENETDOWN;
  Id_WSAENETUNREACH = WSAENETUNREACH;
  Id_WSAENETRESET = WSAENETRESET;
  Id_WSAECONNABORTED = WSAECONNABORTED;
  Id_WSAECONNRESET = WSAECONNRESET;
  Id_WSAENOBUFS = WSAENOBUFS;
  Id_WSAEISCONN = WSAEISCONN;
  Id_WSAENOTCONN = WSAENOTCONN;
  Id_WSAESHUTDOWN = WSAESHUTDOWN;
  Id_WSAETOOMANYREFS = WSAETOOMANYREFS;
  Id_WSAETIMEDOUT = WSAETIMEDOUT;
  Id_WSAECONNREFUSED = WSAECONNREFUSED;
  Id_WSAELOOP = WSAELOOP;
  Id_WSAENAMETOOLONG = WSAENAMETOOLONG;
  Id_WSAEHOSTDOWN = WSAEHOSTDOWN;
  Id_WSAEHOSTUNREACH = WSAEHOSTUNREACH;
  Id_WSAENOTEMPTY = WSAENOTEMPTY;
  Id_SD_Recv = SocketShutdown.Receive;
  Id_SD_Send = SocketShutdown.Send;
  Id_SD_Both = SocketShutdown.Both;
  {$endif}
                       
implementation

end.
