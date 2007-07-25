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
  Rev 1.3    2/8/2004 12:59:40 PM  JPMugaas
  Start on DotNET port.

  Rev 1.2    10/16/2003 11:05:38 PM  SPerry
  Reorganization

  Rev 1.1    2003.09.30 1:23:02 PM  czhower
  Stack split for DotNet

  Rev 1.0    11/13/2002 08:45:44 AM  JPMugaas
}

unit IdRawHeaders;

interface

{$I IdCompilerDefines.inc}

uses
  {$IFDEF DOTNET}
  System.Net,
  {$ENDIF}
  IdGlobal,
  IdStruct;
// TODO: research subtypes of ICMP header

type
//RFC 3542 definitions
//IPv6 Extension Headers
   uint32_t = LongWord;
   uint16_t = Word;
   uint8_t = Byte;
  // types redeclared to avoid dependencies on stack declarations

  TIdSunB = class(TIdStruct)
  protected
    Fs_b1,
    Fs_b2,
    Fs_b3,
    Fs_b4: Byte;
    function GetBytesLen: Integer; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;

    property s_b1 : Byte read Fs_b1 write Fs_b1;
    property s_b2 : Byte read Fs_b2 write Fs_b2;
    property s_b3 : Byte read Fs_b3 write Fs_b3;
    property s_b4 : Byte read Fs_b4 write Fs_b4;
  end;

  TIdSunW = class(TIdStruct)
  protected
    Fs_w1, Fs_w2: Word;
    function GetBytesLen: Integer; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;

    property s_w1 : Word read Fs_w1 write Fs_w1;
    property s_w2 : Word read Fs_w2 write Fs_w2;
  end;

  TIdInAddr = class(TIdLongWord)
  public
    procedure CopyFrom(const ASource : TIdInAddr);
  end;
{ PIdInAddr = ^TIdInAddr;
  TIdInAddr = record
    case integer of
      0: (S_un_b: TIdSunB);
      1: (S_un_w: TIdSunW);
      2: (S_addr: longword);
  end;    }

  TIdNetTime = LongWord;                  // network byte order

const
//header sizes----------------------------------------------------------------//
  Id_ARP_HSIZE            = $1C;      // ARP header:             28 bytes
  Id_DNS_HSIZE            = $0C;      // DNS header base:        12 bytes
  Id_ETH_HSIZE            = $0E;      // Etherner header:        14 bytes
  Id_ICMP_HSIZE           = $04;      // ICMP header base:        4 bytes
  Id_ICMP_ECHO_HSIZE      = $08;      // ICMP_ECHO header:      8 bytes
  Id_ICMP6_ECHO_HSIZE     = $08;      // ICMPv6_ECHO header:    8 bytes icmp echo header len excluding time */
  Id_ICMP_MASK_HSIZE      = $0C;      // ICMP_MASK header:       12 bytes
  Id_ICMP_UNREACH_HSIZE   = $08;      // ICMP_UNREACH header:     8 bytes
  Id_ICMP_TIMEXCEED_HSIZE = $08;      // ICMP_TIMXCEED header:    8 bytes
  Id_ICMP_REDIRECT_HSIZE  = $08;      // ICMP_REDIRECT header:    8 bytes
  Id_ICMP_TS_HSIZE        = $14;      // ICMP_TIMESTAMP header:  20 bytes
  Id_IGMP_HSIZE           = $08;      // IGMP header:             8 bytes
  Id_IP_HSIZE             = $14;      // IP header:              20 bytes
  Id_IPv6_HSIZE           = $28;      // IPv6 header
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
  Id_ICMP_TRACEROUTE      = 30; // RFC1393 Traceroute
  Id_ICMP_DATAGRAM_CONV   = 31; // RFC1475
  Id_ICMP_MOB_HOST_REDIR  = 32; // Mobile Host Redirect
  Id_ICMP_IPv6_WHERE_ARE_YOU = 33;
  Id_ICMP_IPv6_I_AM_HERE  = 34;
  Id_ICMP_MOB_REG_REQ     = 35;
  Id_ICMP_MOB_REG_REPLY   = 36;
  Id_ICMP_SKIP            = 39;
  Id_ICMP_PHOTURIS        = 40; // Photuris  [RFC2521]

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

  // RFC 1393
  Id_ICMP_TRACEROUTE_PACKET_FORWARDED = 0;
  Id_ICMP_TRACEROUTE_NO_ROUTE       = 1;

  Id_ICMP_BAD_SPI                   = 0; //security parameter error 40
  Id_ICMP_AUTH_FAILED               = 1;
  Id_ICMP_DECOMPRESS_FAILED         = 2;
  Id_ICMP_DECRYPTION_FAILED         = 3;
  Id_ICMP_NEED_AUTHENTICATION       = 4;
  Id_ICMP_NEED_AUTHORIZATION        = 5;

  // RFC 1475 error codes
  // The type for Conversion Failed is 31
  Id_ICMP_CONV_UNSPEC               = 0;
  Id_ICMP_CONV_DONTCONV_OPTION      = 1;
  Id_ICMP_CONV_UNKNOWN_MAN_OPTION   = 2;
  Id_ICMP_CONV_UNKNWON_UNSEP_OPTION = 3;
  Id_ICMP_CONV_UNSEP_TRANSPORT      = 4;
  Id_ICMP_CONV_OVERALL_LENGTH_EXCEEDED = 5;
  Id_ICMP_CONV_IP_HEADER_LEN_EXCEEDED  = 6;
  Id_ICMP_CONV_TRANS_PROT_255       = 7; // transport protocol > 255
  Id_ICMP_CONV_PORT_OUT_OF_RANGE    = 8;
  Id_ICMP_CONV_TRANS_HEADER_LEN_EXCEEDED = 9;
  Id_ICMP_CONV_32BIT_ROLLOVER_AND_ACK    = 10;  // 32 Bit Rollover missing and ACK set
  Id_ICMP_CONV_UNKNOWN_MAN_TRANS_OPTION  = 11;

  ICMP_MIN                          = 8;

//ICMPv6 types----------------------------------------------------------------//
  ICMP6_DST_UNREACH            = 1;
  ICMP6_PACKET_TOO_BIG         = 2;
  ICMP6_TIME_EXCEEDED          = 3;
  ICMP6_PARAM_PROB             = 4;

  // Informational Messages
  ICMP6_INFOMSG_MASK          = $80;    //* all informational messages */
  ICMP6_ECHO_REQUEST          = 128;
  ICMP6_ECHO_REPLY            = 129;

  ICMP6_MEMBERSHIP_QUERY     = 130;
  ICMP6_MEMBERSHIP_REPORT    = 131;
  ICMP6_MEMBERSHIP_REDUCTION = 132;

//ICMPv6 codes----------------------------------------------------------------//
  ICMP6_DST_UNREACH_NOROUTE     = 0; //* no route to destination */
  ICMP6_DST_UNREACH_ADMIN       = 1; //* communication with */
                                          //* destination */
                                          //* administratively */
                                          //* prohibited */
  ICMP6_DST_UNREACH_NOTNEIGHBOR = 2; //* not a neighbor */
  ICMP6_DST_UNREACH_ADDR        = 3; //* address unreachable */
  ICMP6_DST_UNREACH_NOPORT      = 4; //* bad port */
  ICMP6_DST_UNREACH_SOURCE_FILTERING = 5;  //source address failed ingress/egress policy
  ICMP6_DST_UNREACH_REJCT_DST   = 6; //reject route to destination

  ICMP6_TIME_EXCEED_TRANSIT     = 0; //* Hop Limit == 0 in transit */
  ICMP6_TIME_EXCEED_REASSEMBLY  = 1; //* Reassembly time out */

  ICMP6_PARAMPROB_HEADER        = 0; //* erroneous header field */
  ICMP6_PARAMPROB_NEXTHEADER    = 1; //* unrecognized Next Header */
  ICMP6_PARAMPROB_OPTION        = 2; //* unrecognized IPv6 option */

  // ICMPv6 Neighbor Discovery Definitions
  ND_ROUTER_SOLICIT          = 133;
  ND_ROUTER_ADVERT           = 134;
  ND_NEIGHBOR_SOLICIT        = 135;
  ND_NEIGHBOR_ADVERT         = 136;
  ND_REDIRECT                = 137;

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

  TIdICMPEcho = class(TIdStruct)
  protected
    Fid: Word;                 // identifier to match requests with replies
    Fseq: Word;                // sequence number to match requests with replies
    function GetBytesLen: Integer; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;
    property id: Word read Fid write FId;                 // identifier to match requests with replies
    property seq: Word read Fseq write FSeq;                // sequence number to match requests with replies
  end;

  TIdICMPFrag = class(TIdStruct)
  protected
    Fpad: Word;
    Fmtu: Word;
    function GetBytesLen: Integer; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;
    property pad: Word read Fpad write Fpad;
    property mtu: Word read Fmtu write Fmtu;
  end;

  TIdICMPTs = class(TIdStruct)
  protected
    Fotime: TIdNetTime;        // time message was sent, to calc roundtrip time
    Frtime: TIdNetTime;
    Fttime: TIdNetTime;
    function GetBytesLen: Integer; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;
    property otime: TIdNetTime read Fotime write Fotime;        // time message was sent, to calc roundtrip time
    property rtime: TIdNetTime read Frtime write Frtime;
    property ttime: TIdNetTime read Fttime write Fttime;
  end;

  { packet header }
  TIdicmp_hun = class(TIdUnion)
  protected
    function Getecho_id: Word;
    function Getecho_seq: Word;
    function Getfrag_mtu: Word;
    function Getfrag_pad: Word;
    function Getgateway_s_b1: Byte;
    function Getgateway_s_b2: Byte;
    function Getgateway_s_b3: Byte;
    function Getgateway_s_b4: Byte;
    function Getgateway_s_l: LongWord;
    function Getgateway_s_w1: Word;
    function Getgateway_s_w2: Word;
    procedure Setecho_id(const Value: Word);
    procedure Setecho_seq(const Value: Word);
    procedure Setfrag_mtu(const Value: Word);
    procedure Setfrag_pad(const Value: Word);
    procedure Setgateway_s_b1(const Value: Byte);
    procedure Setgateway_s_b2(const Value: Byte);
    procedure Setgateway_s_b3(const Value: Byte);
    procedure Setgateway_s_b4(const Value: Byte);
    procedure Setgateway_s_l(const Value: LongWord);
    procedure Setgateway_s_w1(const Value: Word);
    procedure Setgateway_s_w2(const Value: Word);
  public
    constructor Create; override;
    property echo_id: word read Getecho_id write Setecho_id;                 // identifier to match requests with replies
    property echo_seq: word read Getecho_seq write Setecho_seq;
    property gateway_s_b1 : Byte read Getgateway_s_b1 write Setgateway_s_b1;
    property gateway_s_b2 : Byte read Getgateway_s_b2 write Setgateway_s_b2;
    property gateway_s_b3 : Byte read Getgateway_s_b3 write Setgateway_s_b3;
    property gateway_s_b4 : Byte read Getgateway_s_b4 write Setgateway_s_b4;
    property gateway_s_w1 : Word read Getgateway_s_w1 write Setgateway_s_w1;
    property gateway_s_w2 : Word read Getgateway_s_w2 write Setgateway_s_w2;
    property gateway_s_l  : LongWord read Getgateway_s_l write Setgateway_s_l;
    property frag_pad: Word read Getfrag_pad write Setfrag_pad;
    property frag_mtu: Word read Getfrag_mtu write Setfrag_mtu;
  end;

  TIdicmp_dun = class(TIdUnion)
  protected
    function Getdata: Byte;
    function Getmask: LongWord;
    procedure setdata(const Value: Byte);
    procedure Setmask(const Value: LongWord);
    function Getts_otime: TIdNetTime;
    function Getts_rtime: TIdNetTime;
    function Getts_ttime: TIdNetTime;
    procedure Setts_otime(const Value: TIdNetTime);
    procedure Setts_rtime(const Value: TIdNetTime);
    procedure Setts_ttime(const Value: TIdNetTime);
  public
    constructor Create; override;
    property ts_otime: TIdNetTime read Getts_otime write Setts_otime;        // time message was sent, to calc roundtrip time
    property ts_rtime: TIdNetTime read Getts_rtime write Setts_rtime;
    property ts_ttime: TIdNetTime read Getts_ttime write Setts_ttime;
    property mask : LongWord read Getmask write Setmask;
    property data : Byte read Getdata write setdata;
  end;

  TIdICMPHdr = class(TIdStruct)
  protected
    Ficmp_type: Byte;          // message type
    Ficmp_code: Byte;          // error code
    Ficmp_sum: Word;           // one's complement checksum    {Do not Localize}
    Ficmp_hun: TIdicmp_hun;
    Ficmp_dun: TIdicmp_dun;
    function GetBytesLen: Integer; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;
    property icmp_type: Byte read Ficmp_type write Ficmp_type;          // message type
    property icmp_code: Byte read Ficmp_code write Ficmp_code;          // error code
    property icmp_sum: Word read Ficmp_sum write Ficmp_sum;             // one's complement checksum
    property icmp_hun: TIdicmp_hun read Ficmp_hun;
    property icmp_dun: TIdicmp_dun read Ficmp_dun;
  end;

  //ICMPv6
  TIdicmp6_un = class(TIdUnion)
  protected
    function Geticmp6_data16: uint16_t;
    function Geticmp6_data8: uint8_t;
    procedure Seticmp6_data16(const Value: uint16_t);
    procedure Seticmp6_data8(const Value: uint8_t);
    function Geticmp6_seq: uint16_t;
    procedure Seticmp6_seq(const Value: uint16_t);
    function Geticmp6_un_data16(Index: Integer): uint16_t;
    function Geticmp6_un_data32: uint32_t;
    function Geticmp6_un_data8(Index: Integer): uint8_t;
    procedure Seticmp6_un_data16(Index: Integer; const Value: uint16_t);
    procedure Seticmp6_un_data32(const Value: uint32_t);
    procedure Seticmp6_un_data8(Index: Integer; const Value: uint8_t);
{
    Ficmp6_un_data32 : uint32_t; //* type-specific field */
    Ficmp6_un_data16 : array[0..1] of uint16_t; //* type-specific field */
    icmp6_un_data8 : array[0..3] of uint8_t);  //* type-specific field */
}
  public
    constructor Create; override;
    property icmp6_un_data32 : uint32_t read Geticmp6_un_data32 write Seticmp6_un_data32; //* type-specific field */
    property icmp6_un_data16[Index:Integer] : uint16_t read Geticmp6_un_data16 write Seticmp6_un_data16; //array 0-1 * type-specific field */
    property icmp6_un_data8[Index:Integer] : uint8_t read Geticmp6_un_data8 write Seticmp6_un_data8;  //array[0-3] * type-specific field */
    property icmp6_data32 : uint32_t read Geticmp6_un_data32 write Seticmp6_un_data32;
    property icmp6_data16 : uint16_t read Geticmp6_data16 write Seticmp6_data16;
    property icmp6_data8  : uint8_t read Geticmp6_data8 write Seticmp6_data8;
    property icmp6_pptr : uint32_t read Geticmp6_un_data32 write Seticmp6_un_data32;
    property icmp6_mtu : uint32_t read Geticmp6_un_data32 write Seticmp6_un_data32;
    property icmp6_id : uint16_t read Geticmp6_data16 write Seticmp6_data16;
    property icmp6_seq : uint16_t read Geticmp6_seq write Seticmp6_seq;
    property icmp6_maxdelay : uint16_t read Geticmp6_data16 write Seticmp6_data16;
  end;

  TIdicmp6_hdr = class(TIdStruct)
  protected
    Ficmp6_type : uint8_t;   //* type field */
    FIcmp6_code : uint8_t;   //* code field */
    Ficmp6_cksum : uint16_t;  //* checksum field */
    Fdata : TIdicmp6_un;
    function GetBytesLen: Integer; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer);  override;

    property icmp6_type : uint8_t read Ficmp6_type write Ficmp6_type;     //* type field */
    property icmp6_code : uint8_t read Ficmp6_code write Ficmp6_code;     //* code field */
    property icmp6_cksum : uint16_t read Ficmp6_cksum write Ficmp6_cksum; //* checksum field */
    property data : TIdicmp6_un read Fdata;
{        case Integer of
          1: (icmp6_un_data32 : uint32_t); //* type-specific field */
          2: (icmp6_un_data16 : array[0..1] of uint16_t); //* type-specific field */
          3: (icmp6_un_data8 : array[0..3] of uint8_t);  //* type-specific field */
}
   end;
   
////////////////////////////////////////////////////////////////////////////////
//IP////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { options struct }
  TIdIPOptions = class(TIdUnion)
  public
    constructor Create; override;

    //Delphi outputs warnings such as:
    //[Hint] H2368 Visibility of property accessor method TIdIPOptions.get_ipopt_list should match property TIdIPOptions.ipopt_list
    //[Hint] H2368 Visibility of property accessor method TIdIPOptions.set_ipopt_list should match property TIdIPOptions.ipopt_list
    //if these aren't public
    function get_ipopt_list(Index: Integer): Byte;
    procedure set_ipopt_list(Index: Integer; const Value: Byte);

    property ipopt_list[Index : Integer] : Byte read get_ipopt_list write set_ipopt_list; default; //options proper
  end;

  { packet header }
  TIdIPHdr = class(TIdStruct)
  protected
    Fip_verlen: Byte;        // 1st nibble version, 2nd nibble header length div 4 (little-endian)
    Fip_tos: Byte;           // type of service
    Fip_len: Word;           // total length
    Fip_id: Word;            // identification
    Fip_off: Word;           // 1st nibble flags, next 3 nibbles fragment offset (little-endian)
    Fip_ttl: Byte;           // time to live
    Fip_p: Byte;             // protocol
    Fip_sum: Word;           // checksum
    Fip_src: TIdInAddr;      // source address
    Fip_dst: TIdInAddr;      // dest address
    Fip_options: LongWord;   // options + padding
    function GetBytesLen: Integer; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;
    procedure CopyFrom(const ASource : TIdIPHdr);
    property ip_verlen: Byte read Fip_verlen write Fip_verlen;  // 1st nibble version, 2nd nibble header length div 4 (little-endian)
    property ip_tos: Byte read Fip_tos write Fip_tos;           // type of service
    property ip_len: Word read Fip_len write Fip_len;           // total length
    property ip_id: Word read Fip_id write Fip_id;              // identification
    property ip_off: Word read Fip_off write Fip_off;           // 1st nibble flags, next 3 nibbles fragment offset (little-endian)
    property ip_ttl: Byte read Fip_ttl write Fip_ttl;           // time to live
    property ip_p: Byte read Fip_p write Fip_p;                 // protocol
    property ip_sum: Word read Fip_sum write Fip_sum;           // checksum
    property ip_src: TIdInAddr read Fip_src;                    // source address
    property ip_dst: TIdInAddr read Fip_dst;                    // dest address
    property ip_options: LongWord read Fip_options write Fip_options;   // options + padding
  end;

////////////////////////////////////////////////////////////////////////////////
//TCP///////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { options structure }
  TIdTCPOptions = class(TIdUnion)
  public
    constructor Create; override;

    //Delphi outputs warnings such as:
    //[Hint] H2368 Visibility of property accessor method TIdTCPOptions.gettcpopt_list should match property TIdTCPOptions.tcpopt_list
    //[Hint] H2368 Visibility of property accessor method TIdIPOptions.settcpopt_list should match property TIdTCPOptions.tcpopt_list
    //if these aren't public
    function gettcpopt_list(Index: Integer): Byte;
    procedure settcpopt_list(Index: Integer; const Value: Byte);

    property tcpopt_list[Index : Integer] : Byte read gettcpopt_list write settcpopt_list; default;
  end;

  { packet header }
  TIdTCPHdr =  class(TIdStruct)
  protected
    Ftcp_sport: Word;        // source port
    Ftcp_dport: Word;        // destination port
    Ftcp_seq: LongWord;      // sequence number
    Ftcp_ack: LongWord;      // acknowledgement number
    Ftcp_x2off: Byte;        // data offset
    Ftcp_flags: Byte;        // control flags
    Ftcp_win: Word;          // window
    Ftcp_sum: Word;          // checksum
    Ftcp_urp: Word;          // urgent pointer
    function GetBytesLen: Integer; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;

    property tcp_sport: Word read Ftcp_sport write Ftcp_sport;    // source port
    property tcp_dport: Word read Ftcp_dport write Ftcp_dport;    // destination port
    property tcp_seq: Longword read Ftcp_seq write Ftcp_seq;      // sequence number
    property tcp_ack: Longword read Ftcp_ack write Ftcp_ack;      // acknowledgement number
    property tcp_x2off: Byte read Ftcp_x2off write Ftcp_x2off;    // data offset
    property tcp_flags: Byte read Ftcp_flags write Ftcp_flags;    // control flags
    property tcp_win: Word read Ftcp_win write Ftcp_win;          // window
    property tcp_sum: Word read Ftcp_sum write Ftcp_sum;          // checksum
    property tcp_urp: Word read Ftcp_urp write Ftcp_urp;          // urgent pointer
  end;

////////////////////////////////////////////////////////////////////////////////
//UDP///////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { packet header }
  TIdUDPHdr = class(TIdStruct)
  protected
    Fudp_sport: Word;        // source port
    Fudp_dport: Word;        // destination port
    Fudp_ulen: Word;         // length
    Fudp_sum: Word;          // checksum
    function GetBytesLen: Integer; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;
    property udp_sport: Word read Fudp_sport write Fudp_sport;    // source port
    property udp_dport: Word read Fudp_dport write Fudp_dport;    // destination port
    property udp_ulen: Word read Fudp_ulen write Fudp_ulen;       // length
    property udp_sum: Word read Fudp_sum write Fudp_sum;          // checksum
  end;

////////////////////////////////////////////////////////////////////////////////
//IGMP//////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { packet header }

  TIdIGMPHdr = class(TIdStruct)
  protected
    Figmp_type: Byte;
    Figmp_code: Byte;
    Figmp_sum: Word;
    Figmp_group: TIdInAddr;
    function GetBytesLen: Integer; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;

    property igmp_type: Byte read Figmp_type write Figmp_type;
    property igmp_code: Byte read Figmp_code write Figmp_code;
    property igmp_sum: Word read Figmp_sum write Figmp_sum;
    property igmp_group: TIdInAddr read Figmp_group;
  end;

////////////////////////////////////////////////////////////////////////////////
//ETHERNET//////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  TIdEtherAddr = class(TIdUnion)
  public
    constructor Create; override;

    procedure CopyFrom(const ASource : TIdEtherAddr);
    procedure SetData(const Value: TIdBytes);

    //Delphi outputs warnings such as:
    //[Hint] H2368 Visibility of property accessor method TIdEtherAddr.getether_addr_octet should match property TIdEtherAddr.ether_addr_octet
    //[Hint] H2368 Visibility of property accessor method TIdEtherAddr.setether_addr_octet should match property TIdEtherAddr.ether_addr_octet
    //if these aren't public
    function getether_addr_octet(Index: Integer): Byte;
    procedure setether_addr_octet(Index: Integer; const Value: Byte);

    property ether_addr_octet[Index: Integer] : Byte read getether_addr_octet write setether_addr_octet; default;
    property Data: TIdBytes read FBuffer write SetData;
  end;

  { packet header }
  TIdEthernetHdr = class(TIdStruct)
  protected
    Fether_dhost: TIdEtherAddr;            // destination ethernet address
    Fether_shost: TIdEtherAddr;            // source ethernet address
    Fether_type: Word;                     // packet type ID
    function GetBytesLen: Integer; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure CopyFrom(const ASource : TIdEthernetHdr);
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;

    property ether_dhost: TIdEtherAddr read Fether_dhost;            // destination ethernet address
    property ether_shost: TIdEtherAddr read Fether_shost;            // source ethernet address
    property ether_type: Word read Fether_type write Fether_type;    // packet type ID
  end;

////////////////////////////////////////////////////////////////////////////////
//ARP///////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { packet header }
  TIdARPHdr = class(TIdStruct)
  protected
    Farp_hrd: Word;                        // format of hardware address
    Farp_pro: Word;                        // format of protocol address
    Farp_hln: Byte;                        // length of hardware address
    Farp_pln: Byte;                        // length of protocol addres
    Farp_op: Word;                         // operation type
    // following hardcoded for ethernet/IP
    Farp_sha: TIdEtherAddr;                // sender hardware address
    Farp_spa: TIdInAddr;                   // sender protocol address
    Farp_tha: TIdEtherAddr;                // target hardware address
    Farp_tpa: TIdInAddr;                   // target protocol address
    function GetBytesLen: Integer; override;
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;

    property arp_hrd: Word read Farp_hrd write Farp_hrd;         // format of hardware address
    property arp_pro: Word read Farp_pro write Farp_pro;         // format of protocol address
    property arp_hln: Byte read Farp_hln write Farp_hln;         // length of hardware address
    property arp_pln: Byte read Farp_pln write Farp_pln;         // length of protocol addres
    property arp_op: Word read Farp_op write Farp_op;            // operation type
    // following hardcoded for ethernet/IP
    property arp_sha: TIdEtherAddr read Farp_sha;                // sender hardware address
    property arp_spa: TIdInAddr read Farp_spa;                   // sender protocol address
    property arp_tha: TIdEtherAddr read Farp_tha;                // target hardware address
    property arp_tpa: TIdInAddr read Farp_tpa;                   // target protocol address
  end;

////////////////////////////////////////////////////////////////////////////////
//DNS///////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { header }

  TIdDNSHdr = class(TIdStruct)
  protected
    Fdns_id: Word;                         // DNS packet ID
    Fdns_flags: Word;                      // DNS flags
    Fdns_num_q: Word;                      // number of questions
    Fdns_num_answ_rr: Word;                // number of answer resource records
    Fdns_num_auth_rr: Word;                // number of authority resource records
    Fdns_num_addi_rr: Word;                // number of additional resource records
    function GetBytesLen: Integer; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;

    property dns_id: Word read Fdns_id write Fdns_id;                            // DNS packet ID
    property dns_flags: Word read Fdns_flags write Fdns_flags;                   // DNS flags
    property dns_num_q: Word read Fdns_num_q write Fdns_num_q;                   // number of questions
    property dns_num_answ_rr: Word read Fdns_num_answ_rr write Fdns_num_answ_rr; // number of answer resource records
    property dns_num_auth_rr: Word read Fdns_num_auth_rr write Fdns_num_auth_rr; // number of authority resource records
    property dns_num_addi_rr: Word read Fdns_num_addi_rr write Fdns_num_addi_rr; // number of additional resource records
  end;

////////////////////////////////////////////////////////////////////////////////
//RIP///////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

  { header }
  TIdRIPHdr = class(TIdStruct)
  protected
    Frip_cmd: Byte;            // RIP command
    Frip_ver: Byte;            // RIP version
    Frip_rd: Word;             // zero (v1) or routing domain (v2)
    Frip_af: Word;             // address family
    Frip_rt: Word;             // zero (v1) or route tag (v2)
    Frip_addr: LongWord;       // IP address
    Frip_mask: LongWord;       // zero (v1) or subnet mask (v2)
    Frip_next_hop: LongWord;   // zero (v1) or next hop IP address (v2)
    Frip_metric: LongWord;     // metric
    function GetBytesLen: Integer; override;
  public
    procedure ReadStruct(const ABytes : TIdBytes; var VIndex : Integer); override;
    procedure WriteStruct(var VBytes : TIdBytes; var VIndex : Integer); override;

    property rip_cmd: Byte read Frip_cmd write Frip_cmd;                    // RIP command
    property rip_ver: Byte read Frip_ver write Frip_ver;                    // RIP version
    property rip_rd: Word read Frip_rd write Frip_rd;                       // zero (v1) or routing domain (v2)
    property rip_af: Word read Frip_af write Frip_af;                       // address family
    property rip_rt: Word read Frip_rt write Frip_rt;                       // zero (v1) or route tag (v2)
    property rip_addr: LongWord read Frip_addr write Frip_addr;             // IP address
    property rip_mask: LongWord read Frip_mask write Frip_mask;             // zero (v1) or subnet mask (v2)
    property rip_next_hop: LongWord read Frip_next_hop write Frip_next_hop; // zero (v1) or next hop IP address (v2)
    property rip_metric: LongWord read Frip_metric write Frip_metric;       // metric
  end;


////////////////////////////////////////////////////////////////////////////////

implementation

uses
  SysUtils;

{ TIdSunB }

function TIdSunB.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 4;
end;

procedure TIdSunB.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Fs_b1 := ABytes[VIndex];
  Inc(VIndex);
  Fs_b2 := ABytes[VIndex];
  Inc(VIndex);
  Fs_b3 := ABytes[VIndex];
  Inc(VIndex);
  Fs_b4 := ABytes[VIndex];
  Inc(VIndex);
end;

procedure TIdSunB.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited WriteStruct(VBytes, VIndex);
  VBytes[VIndex] := Fs_b1;
  Inc(VIndex);
  VBytes[VIndex] := Fs_b2;
  Inc(VIndex);
  VBytes[VIndex] := Fs_b3;
  Inc(VIndex);
  VBytes[VIndex] := Fs_b4;
  Inc(VIndex);
end;

{ TIdSunW }

function TIdSunW.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 4;
end;

procedure TIdSunW.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Fs_w1 := BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  Fs_w2 := BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
end;

procedure TIdSunW.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited WriteStruct(VBytes, VIndex);
  CopyTIdWord(HostToLittleEndian(Fs_w1), VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdWord(HostToLittleEndian(Fs_w2), VBytes, VIndex);
  Inc(VIndex, 2);
end;

{ TIdICMPEcho }

function TIdICMPEcho.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 4;
end;

procedure TIdICMPEcho.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Fid := BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  seq := BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
end;

procedure TIdICMPEcho.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited WriteStruct(VBytes, VIndex);
  CopyTIdWord(HostToLittleEndian(Fid), VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdWord(HostToLittleEndian(seq), VBytes, VIndex);
  Inc(VIndex, 2);
end;

{ TIdICMPFrag }

function TIdICMPFrag.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 4;
end;

procedure TIdICMPFrag.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Fpad := BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  Fmtu := BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
end;

procedure TIdICMPFrag.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited WriteStruct(VBytes, VIndex);
  CopyTIdWord(HostToLittleEndian(Fpad), VBytes, VIndex);
  Inc(VIndex, 2);
  CopyTIdWord(HostToLittleEndian(Fmtu), VBytes, VIndex);
  Inc(VIndex, 2);
end;

{ TIdICMPTs }

function TIdICMPTs.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 12;
end;

procedure TIdICMPTs.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Fotime := BytesToLongWord(ABytes, VIndex);        // time message was sent, to calc roundtrip time
  Inc(VIndex, 4);
  Frtime := BytesToLongWord(ABytes, VIndex);
  Inc(VIndex, 4);
  Fttime := BytesToLongWord(ABytes, VIndex);
  Inc(VIndex, 4);
end;

procedure TIdICMPTs.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited WriteStruct(VBytes, VIndex);
  CopyTIdWord(HostToLittleEndian(Fotime), VBytes, VIndex);        // time message was sent, to calc roundtrip time
  Inc(VIndex, 4);
  CopyTIdWord(HostToLittleEndian(Frtime), VBytes, VIndex);
  Inc(VIndex, 4);
  CopyTIdWord(HostToLittleEndian(Fttime), VBytes, VIndex);
  Inc(VIndex, 4);
end;

{ TIdicmp_hun }

constructor TIdicmp_hun.Create;
begin
  inherited Create;
  SetBytesLen(4);
end;

function TIdicmp_hun.Getecho_id: word;
begin
  Result := Getgateway_s_w1;
end;

procedure TIdicmp_hun.Setecho_id(const Value: word);
begin
  Setgateway_s_w1(Value);
end;

function TIdicmp_hun.Getecho_seq: word;
begin
  Result := Getgateway_s_w2;
end;

procedure TIdicmp_hun.Setecho_seq(const Value: word);
begin
  Setgateway_s_w2(Value);
end;

function TIdicmp_hun.Getgateway_s_w1: word;
begin
  Result := BytesToLongWord(FBuffer, 0);
end;

procedure TIdicmp_hun.Setgateway_s_w1(const Value: word);
begin
  CopyTIdLongWord(Value, FBuffer, 0);
end;

function TIdicmp_hun.Getgateway_s_w2: word;
begin
  Result := BytesToWord(FBuffer, 2);
end;

procedure TIdicmp_hun.Setgateway_s_w2(const Value: word);
begin
  CopyTIdWord(HostToLittleEndian(Value), FBuffer, 2);
end;

function TIdicmp_hun.Getgateway_s_b1: Byte;
begin
  Result := FBuffer[0];
end;

procedure TIdicmp_hun.Setgateway_s_b1(const Value: Byte);
begin
  FBuffer[0] := Value;
end;

function TIdicmp_hun.Getgateway_s_b2: Byte;
begin
  Result := FBuffer[1];
end;

procedure TIdicmp_hun.Setgateway_s_b2(const Value: Byte);
begin
  FBuffer[1] := Value;
end;

function TIdicmp_hun.Getgateway_s_b3: Byte;
begin
  Result := FBuffer[2];
end;

procedure TIdicmp_hun.Setgateway_s_b3(const Value: Byte);
begin
  FBuffer[2] := Value;
end;

function TIdicmp_hun.Getgateway_s_b4: Byte;
begin
  Result := FBuffer[3];
end;

procedure TIdicmp_hun.Setgateway_s_b4(const Value: Byte);
begin
  FBuffer[3] := Value;
end;

function TIdicmp_hun.Getgateway_s_l: LongWord;
begin
  Result := BytesToLongWord(FBuffer, 0);
end;

procedure TIdicmp_hun.Setgateway_s_l(const Value: LongWord);
begin
  CopyTIdLongWord(Value, FBuffer, 0);
end;

function TIdicmp_hun.Getfrag_pad: word;
begin
  Result := Getgateway_s_w1;
end;

procedure TIdicmp_hun.Setfrag_pad(const Value: word);
begin
  Setgateway_s_w1(Value);
end;

function TIdicmp_hun.Getfrag_mtu: word;
begin
  Result := Getgateway_s_w2;
end;

procedure TIdicmp_hun.Setfrag_mtu(const Value: word);
begin
  Setgateway_s_w2(Value);
end;

{ TIdicmp_dun }

constructor TIdicmp_dun.Create;
begin
  inherited Create;
  SetBytesLen(12);
end;

function TIdicmp_dun.Getts_otime: TIdNetTime;
begin
  Result := BytesToLongWord(FBuffer, 0);
end;

procedure TIdicmp_dun.Setts_otime(const Value: TIdNetTime);
begin
  CopyTIdLongWord(Value, FBuffer, 0);
end;

function TIdicmp_dun.Getts_rtime: TIdNetTime;
begin
  Result := BytesToLongWord(FBuffer, 4);
end;

procedure TIdicmp_dun.Setts_rtime(const Value: TIdNetTime);
begin
  CopyTIdLongWord(Value, FBuffer, 4);
end;

function TIdicmp_dun.Getts_ttime: TIdNetTime;
begin
  Result := BytesToLongWord(FBuffer, 4);
end;

procedure TIdicmp_dun.Setts_ttime(const Value: TIdNetTime);
begin
  CopyTIdLongWord(Value, FBuffer, 8);
end;

function TIdicmp_dun.Getmask: LongWord;
begin
  Result := Getts_otime;
end;

procedure TIdicmp_dun.Setmask(const Value: LongWord);
begin
  Setts_otime(Value);
end;

function TIdicmp_dun.Getdata: Byte;
begin
  Result := FBuffer[0];
end;

procedure TIdicmp_dun.setdata(const Value: Byte);
begin
  FBuffer[0] := Value;
end;

{ TIdICMPHdr }

constructor TIdICMPHdr.Create;
begin
  inherited Create;
  Ficmp_hun := TIdicmp_hun.Create;
  Ficmp_dun := TIdicmp_dun.Create;
end;

destructor TIdICMPHdr.Destroy;
begin
  FreeAndNil(Ficmp_hun);
  FreeAndNil(Ficmp_dun);
  inherited Destroy;
end;

function TIdICMPHdr.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 4 + Ficmp_hun.BytesLen + Ficmp_dun.BytesLen;
end;

procedure TIdICMPHdr.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Ficmp_type := ABytes[VIndex];
  Inc(VIndex);
  Ficmp_code := ABytes[Vindex];
  Inc(VIndex);
  Ficmp_sum := BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  Ficmp_hun.ReadStruct(ABytes, VIndex);
  Ficmp_dun.ReadStruct(ABytes, VIndex);
end;

procedure TIdICMPHdr.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited WriteStruct(VBytes, VIndex);
  VBytes[VIndex] := Ficmp_type;
  Inc(VIndex);
  VBytes[Vindex] := Ficmp_code;
  Inc(VIndex);
  CopyTIdWord(Ficmp_sum, VBytes, VIndex);
  Inc(VIndex, 2);
  Ficmp_hun.WriteStruct(VBytes, VIndex);
  Ficmp_dun.WriteStruct(VBytes, VIndex);
end;

{ TIdIPOptions }

constructor TIdIPOptions.Create;
begin
  inherited Create;
  SetBytesLen(Id_MAX_IPOPTLEN);
end;

function TIdIPOptions.get_ipopt_list(Index: Integer): byte;
begin
  Assert(Index < Id_MAX_IPOPTLEN, 'Out of range'); {do not localize}
  Result := FBuffer[Index];
end;

procedure TIdIPOptions.set_ipopt_list(Index: Integer; const Value: byte);
begin
  Assert(Index < Id_MAX_IPOPTLEN, 'Out of range'); {do not localize}
  FBuffer[Index] := Value;
end;

{ TIdIPHdr }

constructor TIdIPHdr.Create;
begin
  inherited Create;
  Fip_src := TIdInAddr.Create;
  Fip_dst := TIdInAddr.Create;
end;

destructor TIdIPHdr.Destroy;
begin
  FreeAndNil(Fip_src);
  FreeAndNil(Fip_dst);
  inherited Destroy;
end;

function TIdIPHdr.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 12 + Fip_src.BytesLen + Fip_dst.BytesLen + 4);
end;

procedure TIdIPHdr.CopyFrom(const ASource: TIdIPHdr);
begin
  Fip_verlen := ASource.ip_verlen;
  Fip_tos := ASource.ip_tos;
  Fip_len := ASource.ip_len;
  Fip_id := ASource.ip_id;
  Fip_off := ASource.ip_off;
  Fip_ttl := ASource.ip_ttl;
  Fip_p := ASource.ip_p;
  Fip_sum := ASource.ip_sum;
  Fip_src.CopyFrom(ASource.ip_src);
  Fip_dst.CopyFrom(ASource.ip_dst);
  Fip_options := ASource.ip_options;
end;

procedure TIdIPHdr.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Fip_verlen := ABytes[VIndex];      // 1st nibble version, 2nd nibble header length div 4 (little-endian)
  Inc(VIndex);
  Fip_tos := ABytes[VIndex];         // type of service
  Inc(VIndex);
  Fip_len := BytesToWord(ABytes, VIndex);     // total length
  Inc(VIndex, 2);
  Fip_id := BytesToWord(ABytes, VIndex);          // identification
  Inc(VIndex, 2);
  Fip_off := BytesToWord(ABytes, VIndex);          // 1st nibble flags, next 3 nibbles fragment offset (little-endian)
  Inc(VIndex, 2);
  Fip_ttl := ABytes[VIndex];         // time to live
  Inc(VIndex);
  Fip_p := ABytes[VIndex];             // protocol
  Inc(VIndex);
  Fip_sum := BytesToWord(ABytes, VIndex);          // checksum
  Inc(VIndex, 2);
  Fip_src.ReadStruct(ABytes, VIndex);    // source address
  Fip_dst.ReadStruct(ABytes, VIndex);      // dest address
  Fip_options := BytesToLongWord(ABytes, VIndex); // options + padding
  Inc(VIndex, 4);
end;

procedure TIdIPHdr.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
var
  LMinLen : Integer;
begin
  inherited WriteStruct(VBytes, VIndex);
  VBytes[VIndex] := Fip_verlen;      // 1st nibble version, 2nd nibble header length div 4 (little-endian)
  Inc(VIndex);
  VBytes[VIndex] := Fip_tos;        // type of service
  Inc(VIndex);
  CopyTIdWord(Fip_len, VBytes, VIndex);      // total length
  Inc(VIndex, 2);
  CopyTIdWord(Fip_id, VBytes, VIndex);         // identification
  Inc(VIndex, 2);
  CopyTIdWord(Fip_off, VBytes, VIndex);           // 1st nibble flags, next 3 nibbles fragment offset (little-endian)
  Inc(VIndex, 2);
  Fip_ttl := VBytes[VIndex];          // time to live
  Inc(VIndex);
  Fip_p := VBytes[VIndex];             // protocol
  Inc(VIndex);
  CopyTIdWord(Fip_sum, VBytes, VIndex);           // checksum
  Inc(VIndex, 2);
  Fip_src.WriteStruct(VBytes, VIndex);     // source address
  Fip_dst.WriteStruct(VBytes, VIndex);       // dest address
  CopyTIdLongWord(Fip_options, VBytes, VIndex);  // options + padding
  Inc(VIndex, 4);
end;

{ TIdTCPOptions }

constructor TIdTCPOptions.Create;
begin
  inherited Create;
  SetBytesLen(Id_MAX_IPOPTLEN);
end;

function TIdTCPOptions.gettcpopt_list(Index: Integer): Byte;
begin
  Assert(Index < Id_MAX_IPOPTLEN, 'Out of range');
  Result := FBuffer[Index];
end;

procedure TIdTCPOptions.settcpopt_list(Index: Integer; const Value: Byte);
begin
  Assert(Index < Id_MAX_IPOPTLEN, 'Out of range');
  FBuffer[Index] := Value;
end;

{ TIdTCPHdr }

function TIdTCPHdr.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 20;
end;

procedure TIdTCPHdr.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Ftcp_sport := BytesToWord(ABytes, VIndex);       // source port
  Inc(VIndex, 2);
  Ftcp_dport := BytesToWord(ABytes, VIndex);        // destination port
  Inc(VIndex, 2);
  Ftcp_seq := BytesToLongWord(ABytes, VIndex);      // sequence number
  Inc(VIndex, 4);
  Ftcp_ack := BytesToLongWord(ABytes, VIndex);       // acknowledgement number
  Inc(VIndex, 4);
  Ftcp_x2off := ABytes[VIndex];        // data offset
  Inc(VIndex);
  Ftcp_flags := ABytes[VIndex];        // control flags
  Inc(VIndex);
  Ftcp_win := BytesToWord(ABytes, VIndex);          // window
  Inc(VIndex, 2);
  Ftcp_sum := BytesToWord(ABytes, VIndex);          // checksum
  Inc(VIndex, 2);
  Ftcp_urp := BytesToWord(ABytes, VIndex);          // urgent pointer
  Inc(VIndex, 2);
end;

procedure TIdTCPHdr.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited WriteStruct(VBytes, VIndex);
  CopyTIdWord(Ftcp_sport, VBytes, VIndex);        // source port
  Inc(VIndex, 2);
  CopyTIdWord(Ftcp_dport, VBytes, VIndex);        // destination port
  Inc(VIndex, 2);
  CopyTIdLongWord(Ftcp_seq, VBytes, VIndex);       // sequence number
  Inc(VIndex, 4);
  CopyTIdLongWord(Ftcp_ack, VBytes, VIndex);      // acknowledgement number
  Inc(VIndex, 4);
  VBytes[VIndex] := Ftcp_x2off;         // data offset
  Inc(VIndex);
  VBytes[VIndex] := Ftcp_flags;        // control flags
  Inc(VIndex);
  CopyTIdWord(Ftcp_win, VBytes, VIndex);          // window
  Inc(VIndex, 2);
  CopyTIdWord(Ftcp_sum, VBytes, VIndex);           // checksum
  Inc(VIndex, 2);
  CopyTIdWord(Ftcp_urp, VBytes, VIndex);           // urgent pointer
  Inc(VIndex, 2);
end;

{ TIdUDPHdr }

function TIdUDPHdr.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 8;
end;

procedure TIdUDPHdr.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Fudp_sport := BytesToWord(ABytes, VIndex);        // source port
  Inc(VIndex, 2);
  Fudp_dport := BytesToWord(ABytes, VIndex);        // destination port
  Inc(VIndex, 2);
  Fudp_ulen := BytesToWord(ABytes, VIndex);        // length
  Inc(VIndex, 2);
  Fudp_sum := BytesToWord(ABytes, VIndex);         // checksum
  Inc(VIndex, 2);
end;

procedure TIdUDPHdr.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited WriteStruct(VBytes, VIndex);
  CopyTIdWord(Fudp_sport, VBytes, VIndex);        // source port
  Inc(VIndex, 2);
  CopyTIdWord(Fudp_dport, VBytes, VIndex);         // destination port
  Inc(VIndex, 2);
  CopyTIdWord(Fudp_ulen, VBytes, VIndex);          // length
  Inc(VIndex, 2);
  CopyTIdWord(Fudp_sum, VBytes, VIndex);           // checksum
  Inc(VIndex, 2);
end;

{ TIdIGMPHdr }

constructor TIdIGMPHdr.Create;
begin
  inherited Create;
  Figmp_group := TIdInAddr.Create;
end;

destructor TIdIGMPHdr.Destroy;
begin
  FreeAndNil(Figmp_group);
  inherited Destroy;
end;

function TIdIGMPHdr.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 4 + Figmp_group.BytesLen;
end;

procedure TIdIGMPHdr.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Figmp_type := ABytes[VIndex];
  Inc(VIndex);
  Figmp_code := ABytes[VIndex];
  Inc(VIndex);
  Figmp_sum := BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  Figmp_group.ReadStruct(ABytes, VIndex);
end;

procedure TIdIGMPHdr.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited WriteStruct(VBytes, VIndex);
  VBytes[VIndex] := Figmp_type;
  Inc(VIndex);
  VBytes[VIndex] := Figmp_code;
  Inc(VIndex);
  CopyTIdWord(Figmp_sum, VBytes, VIndex);
  Inc(VIndex, 2);
  Figmp_group.WriteStruct(VBytes, VIndex);
end;

{ TIdEtherAddr }

constructor TIdEtherAddr.Create;
begin
  inherited Create;
  SetBytesLen(Id_ETHER_ADDR_LEN);
end;

procedure TIdEtherAddr.setether_addr_octet(Index: Integer; const Value: Byte);
begin
  Assert(Index < Id_ETHER_ADDR_LEN, 'Out of range');
  FBuffer[Index] := Value;
end;

function TIdEtherAddr.getether_addr_octet(Index: Integer): Byte;
begin
  Assert(Index < Id_ETHER_ADDR_LEN, 'Out of range');
  Result := FBuffer[Index];
end;

procedure TIdEtherAddr.CopyFrom(const ASource: TIdEtherAddr);
begin
  SetData(ASource.Data);
end;

procedure TIdEtherAddr.SetData(const Value: TIdBytes);
begin
  CopyTIdBytes(Value, 0, FBuffer, 0, Id_ETHER_ADDR_LEN);
end;

{ TIdEthernetHdr }

constructor TIdEthernetHdr.Create;
begin
  inherited Create;
  Fether_dhost := TIdEtherAddr.Create;
  Fether_shost := TIdEtherAddr.Create;
end;

destructor TIdEthernetHdr.Destroy;
begin
  FreeAndNil(Fether_dhost);
  FreeAndNil(Fether_shost);
  inherited Destroy;
end;

function TIdEthernetHdr.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + Fether_dhost.BytesLen + Fether_shost.BytesLen + 2;
end;

procedure TIdEthernetHdr.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Fether_dhost.ReadStruct(ABytes, VIndex);            // destination ethernet address
  Fether_shost.ReadStruct(ABytes, VIndex);            // source ethernet address
  Fether_type := BytesToWord(ABytes, VIndex);         // packet type ID
  Inc(VIndex, 2);
end;

procedure TIdEthernetHdr.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
var
  Len : Integer;
begin
  inherited WriteStruct(VBytes, VIndex);
  Fether_dhost.WriteStruct(VBytes, VIndex);            // destination ethernet address
  Fether_shost.WriteStruct(VBytes, VIndex);            // source ethernet address
  CopyTIdWord(Fether_type, VBytes, VIndex);            // packet type ID
  Inc(VIndex, 2);
end;

procedure TIdEthernetHdr.CopyFrom(const ASource: TIdEthernetHdr);
begin
  Fether_dhost.CopyFrom(ASource.Fether_dhost);
  Fether_shost.CopyFrom(ASource.Fether_shost);
  Fether_type := ASource.Fether_type;
end;

{ TIdARPHdr }

constructor TIdARPHdr.Create;
begin
  inherited Create;
  Farp_sha := TIdEtherAddr.Create;                // sender hardware address
  Farp_spa := TIdInAddr.Create;                   // sender protocol address
  Farp_tha := TIdEtherAddr.Create;                // target hardware address
  Farp_tpa := TIdInAddr.Create;                   // target protocol address
end;

destructor TIdARPHdr.Destroy;
begin
  FreeAndNil(Farp_sha);
  FreeAndNil(Farp_spa);
  FreeAndNil(Farp_tha);
  FreeAndNil(Farp_tpa);
  inherited Destroy;
end;

function TIdARPHdr.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 8 + Farp_sha.BytesLen + Farp_spa.BytesLen + Farp_tha.BytesLen + Farp_tpa.BytesLen;
end;

procedure TIdARPHdr.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Farp_hrd := BytesToWord(ABytes, VIndex);  // format of hardware address
  Inc(VIndex, 2);
  Farp_pro := BytesToWord(ABytes, VIndex); // format of protocol address
  Inc(VIndex, 2);
  Farp_hln := ABytes[VIndex];             // length of hardware address
  Inc(VIndex);
  Farp_pln := ABytes[VIndex];              // length of protocol addres
  Inc(VIndex);
  Farp_op := BytesToWord(ABytes, VIndex);   // operation type
  Inc(VIndex, 2);
  // following hardcoded for ethernet/IP
  Farp_sha.ReadStruct(ABytes, VIndex);    // sender hardware address
  Farp_spa.ReadStruct(ABytes, VIndex);    // sender protocol address
  Farp_tha.ReadStruct(ABytes, VIndex);    // target hardware address
  Farp_tpa.ReadStruct(ABytes, VIndex);    // target protocol address
end;

procedure TIdARPHdr.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited WriteStruct(VBytes, VIndex);
  CopyTIdWord(Farp_hrd, VBytes, VIndex);  // format of hardware address
  Inc(VIndex, 2);
  CopyTIdWord(Farp_pro, VBytes, VIndex); // format of protocol address
  Inc(VIndex, 2);
  VBytes[VIndex] := Farp_hln;             // length of hardware address
  Inc(VIndex);
  VBytes[VIndex] := Farp_pln;              // length of protocol addres
  Inc(VIndex);
  CopyTIdWord(Farp_op, VBytes, VIndex);   // operation type
  Inc(VIndex, 2);
  // following hardcoded for ethernet/IP
  Farp_sha.WriteStruct(VBytes, VIndex);    // sender hardware address
  Farp_spa.WriteStruct(VBytes, VIndex);    // sender protocol address
  Farp_tha.WriteStruct(VBytes, VIndex);    // target hardware address
  Farp_tpa.WriteStruct(VBytes, VIndex);    // target protocol address
end;

{ TIdDNSHdr }

function TIdDNSHdr.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 12;
end;

procedure TIdDNSHdr.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Fdns_id := BytesToWord(ABytes, VIndex);      // DNS packet ID
  Inc(VIndex, 2);
  Fdns_flags := BytesToWord(ABytes, VIndex);  // DNS flags
  Inc(VIndex, 2);
  Fdns_num_q := BytesToWord(ABytes, VIndex);  // number of questions
  Inc(VIndex, 2);
  Fdns_num_answ_rr := BytesToWord(ABytes, VIndex);// number of answer resource records
  Inc(VIndex, 2);
  Fdns_num_auth_rr := BytesToWord(ABytes, VIndex); // number of authority resource records
  Inc(VIndex, 2);
  Fdns_num_addi_rr := BytesToWord(ABytes, VIndex); // number of additional resource records
  Inc(VIndex, 2);
end;

procedure TIdDNSHdr.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited WriteStruct(VBytes, VIndex);
  CopyTIdWord(Fdns_id, VBytes, VIndex);     // DNS packet ID
  Inc(VIndex, 2);
  CopyTIdWord(Fdns_flags, VBytes, VIndex);  // DNS flags
  Inc(VIndex, 2);
  CopyTIdWord(Fdns_num_q, VBytes, VIndex);   // number of questions
  Inc(VIndex, 2);
  CopyTIdWord(Fdns_num_answ_rr, VBytes, VIndex); // number of answer resource records
  Inc(VIndex, 2);
  CopyTIdWord(Fdns_num_auth_rr, VBytes, VIndex); // number of authority resource records
  Inc(VIndex, 2);
  CopyTIdWord(Fdns_num_addi_rr, VBytes, VIndex); // number of additional resource records
  Inc(VIndex, 2);
end;

{ TIdRIPHdr }

function TIdRIPHdr.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 24;
end;

procedure TIdRIPHdr.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Frip_cmd := ABytes[VIndex];            // RIP command
  Inc(VIndex);
  Frip_ver := ABytes[VIndex];            // RIP version
  Inc(VIndex);
  Frip_rd := BytesToWord(ABytes, VIndex);            // zero (v1) or routing domain (v2)
  Inc(VIndex, 2);
  Frip_af := BytesToWord(ABytes, VIndex);              // address family
  Inc(VIndex, 2);
  Frip_rt := BytesToWord(ABytes, VIndex);              // zero (v1) or route tag (v2)
  Inc(VIndex, 2);
  Frip_addr := BytesToLongWord(ABytes, VIndex);        // IP address
  Inc(VIndex, 4);
  Frip_mask := BytesToLongWord(ABytes, VIndex);      // zero (v1) or subnet mask (v2)
  Inc(VIndex, 4);
  Frip_next_hop := BytesToLongWord(ABytes, VIndex); // zero (v1) or next hop IP address (v2)
  Inc(VIndex, 4);
  Frip_metric := BytesToLongWord(ABytes, VIndex);     // metric
  Inc(VIndex, 4);
end;

procedure TIdRIPHdr.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited WriteStruct(VBytes, VIndex);
  VBytes[VIndex] := Frip_cmd;            // RIP command
  Inc(VIndex);
  VBytes[VIndex] := Frip_ver;            // RIP version
  Inc(VIndex);
  CopyTIdWord(Frip_rd, VBytes, VIndex);              // zero (v1) or routing domain (v2)
  Inc(VIndex, 2);
  CopyTIdWord(Frip_af, VBytes, VIndex);             // address family
  Inc(VIndex, 2);
  CopyTIdWord(Frip_rt, VBytes, VIndex);              // zero (v1) or route tag (v2)
  Inc(VIndex, 2);
  CopyTIdLongWord(Frip_addr, VBytes, VIndex);        // IP address
  Inc(VIndex, 4);
  CopyTIdLongWord(Frip_mask, VBytes, VIndex);        // zero (v1) or subnet mask (v2)
  Inc(VIndex, 4);
  CopyTIdLongWord(Frip_next_hop, VBytes, VIndex);    // zero (v1) or next hop IP address (v2)
  Inc(VIndex, 4);
  CopyTIdLongWord(Frip_metric, VBytes, VIndex);      // metric
  Inc(VIndex, 4);
end;

{ TIdInAddr }

procedure TIdInAddr.CopyFrom(const ASource: TIdInAddr);
begin
  s_l := ASource.s_l;
end;

{ TIdicmp6_un }

constructor TIdicmp6_un.Create;
begin
  inherited Create;
  SetBytesLen(4);
end;

function TIdicmp6_un.Geticmp6_un_data16(Index: Integer): uint16_t;
begin
  Result := 0;
  case Index of
    0 : Result := BytesToWord(FBuffer, 0);
    1 : Result := BytesToWord(FBuffer, 2);
  end;
end;

procedure TIdicmp6_un.Seticmp6_un_data16(Index: Integer; const Value: uint16_t);
begin
  case Index of
    0 : CopyTIdWord(Value, FBuffer, 0);
    1 : CopyTIdWord(Value, FBuffer, 2);
  end;
end;

function TIdicmp6_un.Geticmp6_un_data32: uint32_t;
begin
  Result := BytesToLongWord(FBuffer, 0);
end;

procedure TIdicmp6_un.Seticmp6_un_data32(const Value: uint32_t);
begin
  CopyTIdLongWord(Value, FBuffer, 0);
end;

function TIdicmp6_un.Geticmp6_un_data8(Index: Integer): uint8_t;
begin
  Assert((Index>-1) and (Index<4), 'Out of range');
  Result := FBuffer[Index];
end;

procedure TIdicmp6_un.Seticmp6_un_data8(Index: Integer; const Value: uint8_t);
begin
  Assert((Index>-1) and (Index<4), 'Out of range');
  FBuffer[Index] := Value;
end;

function TIdicmp6_un.Geticmp6_data8: uint8_t;
begin
  Result := FBuffer[0];
end;

procedure TIdicmp6_un.Seticmp6_data8(const Value: uint8_t);
begin
  FBuffer[0] := Value;
end;

function TIdicmp6_un.Geticmp6_data16: uint16_t;
begin
  Result := BytesToWord(FBuffer, 0);
end;

procedure TIdicmp6_un.Seticmp6_data16(const Value: uint16_t);
begin
  CopyTIdWord(Value, FBuffer, 0);
end;

function TIdicmp6_un.Geticmp6_seq: uint16_t;
begin
  Result := Geticmp6_un_data16(1);
end;

procedure TIdicmp6_un.Seticmp6_seq(const Value: uint16_t);
begin
  Seticmp6_un_data16(1, Value);
end;

{ TIdicmp6_hdr }

constructor TIdicmp6_hdr.Create;
begin
  inherited Create;
  Fdata := TIdicmp6_un.Create;
end;

destructor TIdicmp6_hdr.Destroy;
begin
  FreeAndNil(Fdata);
  inherited Destroy;
end;

function TIdicmp6_hdr.GetBytesLen: Integer;
begin
  Result := inherited GetBytesLen + 4 + Fdata.BytesLen;
end;

procedure TIdicmp6_hdr.ReadStruct(const ABytes: TIdBytes; var VIndex: Integer);
begin
  inherited ReadStruct(ABytes, VIndex);
  Ficmp6_type := ABytes[VIndex];
  Inc(VIndex);
  FIcmp6_code := ABytes[VIndex];
  Inc(VIndex);
  Ficmp6_cksum := BytesToWord(ABytes, VIndex);
  Inc(VIndex, 2);
  Fdata.ReadStruct(ABytes, VIndex);
end;

procedure TIdicmp6_hdr.WriteStruct(var VBytes: TIdBytes; var VIndex: Integer);
begin
  inherited WriteStruct(VBytes, VIndex);
  VBytes[VIndex] := Ficmp6_type;
  Inc(VIndex);
  VBytes[VIndex] := FIcmp6_code;
  Inc(VIndex);
  CopyTIdWord(Ficmp6_cksum, VBytes, VIndex);
  Inc(VIndex, 2);
  Fdata.WriteStruct(VBytes, VIndex);
end;

end.

