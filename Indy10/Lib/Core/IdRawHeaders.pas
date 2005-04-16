{ $HDR$}
{**********************************************************************}
{ Unit archived using Team Coherence                                   }
{ Team Coherence is Copyright 2002 by Quality Software Components      }
{                                                                      }
{ For further information / comments, visit our WEB site at            }
{ http://www.TeamCoherence.com                                         }
{**********************************************************************}
{}
{ $Log:  11960: IdRawHeaders.pas
{
{   Rev 1.3    2/8/2004 12:59:40 PM  JPMugaas
{ Start on DotNET port.
}
{
{   Rev 1.2    10/16/2003 11:05:38 PM  SPerry
{ Reorganization
}
{
{   Rev 1.1    2003.09.30 1:23:02 PM  czhower
{ Stack split for DotNet
}
{
{   Rev 1.0    11/13/2002 08:45:44 AM  JPMugaas
}
unit IdRawHeaders;

interface
{$I IdCompilerDefines.inc}
{$IFNDEF DOTNET}
uses
  IdStackBSDBase;
{$ELSE}
uses
  System.Net;
{$ENDIF}

// TODO: research subtypes of ICMP header

type
  // types redeclared to avoid dependencies on stack declarations
{
  TIdSunB = packed record
    s_b1, s_b2, s_b3, s_b4: byte;
  end;

  TIdSunW = packed record
    s_w1, s_w2: word;
  end;

  PIdInAddr = ^TIdInAddr;
  TIdInAddr = record
    case integer of
      0: (S_un_b: TIdSunB);
      1: (S_un_w: TIdSunW);
      2: (S_addr: longword);
  end;
}

  TIdNetTime = longword;                  // network byte order

const
//header sizes----------------------------------------------------------------//
  Id_ARP_HSIZE            = $1C;      // ARP header:             28 bytes
  Id_DNS_HSIZE            = $0C;      // DNS header base:        12 bytes
  Id_ETH_HSIZE            = $0E;      // Etherner header:        14 bytes
  Id_ICMP_HSIZE           = $04;      // ICMP header base:        4 bytes
  Id_ICMP_ECHO_HSIZE      = $08;      // ICMP_ECHO header:        8 bytes
  Id_ICMP_MASK_HSIZE      = $0C;      // ICMP_MASK header:       12 bytes
  Id_ICMP_UNREACH_HSIZE   = $08;      // ICMP_UNREACH header:     8 bytes
  Id_ICMP_TIMEXCEED_HSIZE = $08;      // ICMP_TIMXCEED header:    8 bytes
  Id_ICMP_REDIRECT_HSIZE  = $08;      // ICMP_REDIRECT header:    8 bytes
  Id_ICMP_TS_HSIZE        = $14;      // ICMP_TIMESTAMP header:  20 bytes
  Id_IGMP_HSIZE           = $08;      // IGMP header:             8 bytes
  Id_IP_HSIZE             = $14;      // IP header:              20 bytes
  Id_RIP_HSIZE            = $18;      // RIP header base:        24 bytes
  Id_TCP_HSIZE            = $14;      // TCP header:             20 bytes
  Id_UDP_HSIZE            = $08;      // UDP header:              8 bytes

//fragmentation flags---------------------------------------------------------//
  Id_IP_RF                = $8000;    // reserved fragment flag
  Id_IP_DF                = $4000;    // dont fragment flag
  Id_IP_MF                = $2000;    // more fragments flag
  Id_IP_OFFMASK           = $1FFF;    // mask for fragmenting bits

//TCP control flags-----------------------------------------------------------//
  Id_TCP_FIN              = $01;
  Id_TCP_SYN              = $02;
  Id_TCP_RST              = $04;
  Id_TCP_PUSH             = $08;
  Id_TCP_ACK              = $10;
  Id_TCP_URG              = $20;

//ICMP types------------------------------------------------------------------//
  Id_ICMP_ECHOREPLY       = 0;
  Id_ICMP_UNREACH         = 3;
  Id_ICMP_SOURCEQUENCH    = 4;
  Id_ICMP_REDIRECT        = 5;
  Id_ICMP_ECHO            = 8;
  Id_ICMP_ROUTERADVERT    = 9;
  Id_ICMP_ROUTERSOLICIT   = 10;
  Id_ICMP_TIMXCEED        = 11;
  Id_ICMP_PARAMPROB       = 12;
  Id_ICMP_TSTAMP          = 13;
  Id_ICMP_TSTAMPREPLY     = 14;
  Id_ICMP_IREQ            = 15;
  Id_ICMP_IREQREPLY       = 16;
  Id_ICMP_MASKREQ         = 17;
  Id_ICMP_MASKREPLY       = 18;

//ICMP codes------------------------------------------------------------------//
  Id_ICMP_UNREACH_NET               = 0;
  Id_ICMP_UNREACH_HOST              = 1;
  Id_ICMP_UNREACH_PROTOCOL          = 2;
  Id_ICMP_UNREACH_PORT              = 3;
  Id_ICMP_UNREACH_NEEDFRAG          = 4;
  Id_ICMP_UNREACH_SRCFAIL           = 5;
  Id_ICMP_UNREACH_NET_UNKNOWN       = 6;
  Id_ICMP_UNREACH_HOST_UNKNOWN      = 7;
  Id_ICMP_UNREACH_ISOLATED          = 8;
  Id_ICMP_UNREACH_NET_PROHIB        = 9;
  Id_ICMP_UNREACH_HOST_PROHIB       = 10;
  Id_ICMP_UNREACH_TOSNET            = 11;
  Id_ICMP_UNREACH_TOSHOST           = 12;
  Id_ICMP_UNREACH_FILTER_PROHIB     = 13;
  Id_ICMP_UNREACH_HOST_PRECEDENCE   = 14;
  Id_ICMP_UNREACH_PRECEDENCE_CUTOFF = 15;
  Id_ICMP_REDIRECT_NET              = 0;
  Id_ICMP_REDIRECT_HOST             = 1;
  Id_ICMP_REDIRECT_TOSNET           = 2;
  Id_ICMP_REDIRECT_TOSHOST          = 3;
  Id_ICMP_TIMXCEED_INTRANS          = 0;
  Id_ICMP_TIMXCEED_REASS            = 1;
  Id_ICMP_PARAMPROB_OPTABSENT       = 1;

  ICMP_MIN                          = 8;

//IGMP types------------------------------------------------------------------//
  Id_IGMP_MEMBERSHIP_QUERY          = $11;    // membership query
  Id_IGMP_V1_MEMBERSHIP_REPORT      = $12;    // v1 membership report
  Id_IGMP_V2_MEMBERSHIP_REPORT      = $16;    // v2 membership report
  Id_IGMP_LEAVE_GROUP               = $17;    // leave-group message

//ethernet packet types-------------------------------------------------------//
  Id_ETHERTYPE_PUP                  = $0200;    // PUP protocol
  Id_ETHERTYPE_IP                   = $0800;    // IP protocol
  Id_ETHERTYPE_ARP                  = $0806;    // ARP protocol
  Id_ETHERTYPE_REVARP               = $8035;    // reverse ARP protocol
  Id_ETHERTYPE_VLAN                 = $8100;    // IEEE 802.1Q VLAN tagging
  Id_ETHERTYPE_LOOPBACK             = $9000;    // used to test interfaces

//hardware address formats----------------------------------------------------//
  Id_ARPHRD_ETHER                   = 1;        // ethernet hardware format

//ARP operation types---------------------------------------------------------//
  Id_ARPOP_REQUEST                  = 1;        // req to resolve address
  Id_ARPOP_REPLY                    = 2;        // resp to previous request
  Id_ARPOP_REVREQUEST               = 3;        // req protocol address given hardware
  Id_ARPOP_REVREPLY                 = 4;        // resp giving protocol address
  Id_ARPOP_INVREQUEST               = 8;        // req to identify peer
  Id_ARPOP_INVREPLY                 = 9;        // resp identifying peer

//RIP commands----------------------------------------------------------------//
  Id_RIPCMD_REQUEST                 = 1;        // want info
  Id_RIPCMD_RESPONSE                = 2;        // responding to request
  Id_RIPCMD_TRACEON                 = 3;        // turn tracing on
  Id_RIPCMD_TRACEOFF                = 4;        // turn it off
  Id_RIPCMD_POLL                    = 5;        // like request, but anyone answers
  Id_RIPCMD_POLLENTRY               = 6;        // like poll, but for entire entry
  Id_RIPCMD_MAX                     = 7;

//RIP versions----------------------------------------------------------------//
  Id_RIPVER_0                       = 0;
  Id_RIPVER_1                       = 1;
  Id_RIPVER_2                       = 2;

//----------------------------------------------------------------------------//
  Id_MAX_IPOPTLEN                   = 40;
  Id_IP_MAXPACKET                   = 65535;
  Id_ETHER_ADDR_LEN                 = 6;


type
////////////////////////////////////////////////////////////////////////////////
//ICMP//////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  PIdICMPEcho = ^TIdICMPEcho;
  TIdICMPEcho = packed record
    id: word;                 // identifier to match requests with replies
    seq: word;                // sequence number to match requests with replies
  end;

  PIdICMPFrag = ^TIdICMPFrag;
  TIdICMPFrag = packed record
    pad: word;
    mtu: word;
  end;

  PIdICMPTs = ^TIdICMPTs;
  TIdICMPTs = packed record
    otime: TIdNetTime;        // time message was sent, to calc roundtrip time
    rtime: TIdNetTime;
    ttime: TIdNetTime;
  end;

  { packet header }
  PIdICMPHdr = ^TIdICMPHdr;
  TIdICMPHdr = packed record
    icmp_type: byte;          // message type
    icmp_code: byte;          // error code
    icmp_sum: word;           // one's complement checksum    {Do not Localize}
    icmp_hun: packed record
      case integer of
        0: (echo: TIdICMPEcho);
        1: (gateway: TIdInAddr);
        2: (frag: TIdICMPFrag);
      end;

    icmp_dun: packed record
      case integer of
        0: (ts: TIdIcmpTs);
        1: (mask: longword);
        2: (data: char);
      end;
  end;

////////////////////////////////////////////////////////////////////////////////
//IP////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { options struct }
  TIdIPOptions = packed record
    {$IFDEF LINUX}
    //ipopt_dst: TIdInAddr; // first-hop dst if source routed (Linux only)
    {$ENDIF}
    ipopt_list: array[0..Id_MAX_IPOPTLEN - 1] of char; //options proper
  end;

  { packet header }
  PIdIPHdr = ^TIdIPHdr;
  TIdIPHdr = packed record
    ip_verlen: byte;        // 1st nibble version, 2nd nibble header length div 4 (little-endian)
    ip_tos: byte;           // type of service
    ip_len: word;           // total length
    ip_id: word;            // identification
    ip_off: word;           // 1st nibble flags, next 3 nibbles fragment offset (little-endian)
    ip_ttl: byte;           // time to live
    ip_p: byte;             // protocol
    ip_sum: word;           // checksum
    ip_src: TIdInAddr;      // source address
    ip_dst: TIdInAddr;      // dest address
    ip_options: longword;   // options + padding
  end;

////////////////////////////////////////////////////////////////////////////////
//TCP///////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { options structure }
  TIdTCPOptions = packed record
    tcpopt_list: array[0..Id_MAX_IPOPTLEN - 1] of byte;
  end;

  { packet header }
  PIdTCPHdr = ^TIdTCPHdr;
  TIdTCPHdr = packed record
    tcp_sport: word;        // source port
    tcp_dport: word;        // destination port
    tcp_seq: longword;      // sequence number
    tcp_ack: longword;      // acknowledgement number
    tcp_x2off: byte;        // data offset
    tcp_flags: byte;        // control flags
    tcp_win: word;          // window
    tcp_sum: word;          // checksum
    tcp_urp: word;          // urgent pointer
  end;

////////////////////////////////////////////////////////////////////////////////
//UDP///////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { packet header }
  PIdUDPHdr = ^TIdUDPHdr;
  TIdUDPHdr = packed record
    udp_sport: word;        // source port
    udp_dport: word;        // destination port
    udp_ulen: word;         // length
    udp_sum: word;          // checksum
  end;

////////////////////////////////////////////////////////////////////////////////
//IGMP//////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { packet header }
  PIdIGMPHdr = ^TIdIGMPHdr;
  TIdIGMPHdr = packed record
    igmp_type: byte;
    igmp_code: byte;
    igmp_sum: word;
    igmp_group: TIdInAddr;
  end;

////////////////////////////////////////////////////////////////////////////////
//ETHERNET//////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  TIdEtherAddr = packed record
    ether_addr_octet: array [0..Id_ETHER_ADDR_LEN-1] of byte;
  end;

  { packet header }
  PIdEthernetHdr = ^TIdEthernetHdr;
  TIdEthernetHdr = packed record
    ether_dhost: TIdEtherAddr;            // destination ethernet address
    ether_shost: TIdEtherAddr;            // source ethernet address
    ether_type: word;                     // packet type ID
  end;

////////////////////////////////////////////////////////////////////////////////
//ARP///////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { packet header }
  PIdARPHdr = ^TIdARPHdr;
  TIdARPHdr = packed record
    arp_hrd: word;                        // format of hardware address
    arp_pro: word;                        // format of protocol address
    arp_hln: byte;                        // length of hardware address
    arp_pln: byte;                        // length of protocol addres
    arp_op: word;                         // operation type
    // following hardcoded for ethernet/IP
    arp_sha: TIdEtherAddr;                // sender hardware address
    arp_spa: TIdInAddr;                   // sender protocol address
    arp_tha: TIdEtherAddr;                // target hardware address
    arp_tpa: TIdInAddr;                   // target protocol address
  end;

////////////////////////////////////////////////////////////////////////////////
//DNS///////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { header }
  PIdDNSHdr = ^TIdDNSHdr;
  TIdDNSHdr = packed record
    dns_id: word;                         // DNS packet ID
    dns_flags: word;                      // DNS flags
    dns_num_q: word;                      // number of questions
    dns_num_answ_rr: word;                // number of answer resource records
    dns_num_auth_rr: word;                // number of authority resource records
    dns_num_addi_rr: word;                // number of additional resource records
  end;

////////////////////////////////////////////////////////////////////////////////
//RIP///////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { header }
  PIdRIPHdr = ^TIdRIPHdr;
  TIdRIPHdr = packed record
    rip_cmd: byte;            // RIP command
    rip_ver: byte;            // RIP version
    rip_rd: word;             // zero (v1) or routing domain (v2)
    rip_af: word;             // address family
    rip_rt: word;             // zero (v1) or route tag (v2)
    rip_addr: longword;       // IP address
    rip_mask: longword;       // zero (v1) or subnet mask (v2)
    rip_next_hop: longword;   // zero (v1) or next hop IP address (v2)
    rip_metric: longword;     // metric
  end;

////////////////////////////////////////////////////////////////////////////////

implementation

end.

