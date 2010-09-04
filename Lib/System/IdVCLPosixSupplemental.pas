unit IdVCLPosixSupplemental;

interface
{$I IdCompilerDefines.inc}

uses IdCTypes;

//tcp.hh
type
{Supplemental stuff from netinet/tcp.h}
  {$EXTERNALSYM tcp_seq}
  tcp_seq = TIdC_UINT32;
  {$EXTERNALSYM tcp_cc}
  tcp_cc  = TIdC_UINT32;		//* connection count per rfc1644 */
  {$EXTERNALSYM tcp6_seq}
  tcp6_seq = tcp_seq;	//* for KAME src sync over BSD*'s */' +


{stuff that may be needed for various socket functions.  Much of this may be
platform specific.  Defined in netinet/tcp.h}
const
  {$IFDEF BSD}
  //for BSD-based operating systems such as FreeBSD and Mac OS X
  {$EXTERNALSYM TCP_MAXSEG}
	TCP_MAXSEG              = $02;    //* set maximum segment size */
  {$EXTERNALSYM TCP_NOPUSH}
  TCP_NOPUSH              = $04 platform;   //* don't push last block of write */
  {$EXTERNALSYM TCP_NOOPT}
  TCP_NOOPT               = $08;    //* don't use TCP options */
  {$ENDIF}

  {$IFDEF FREEBSD}
  //specific to FreeBSD
  {$EXTERNALSYM TCP_MD5SIG}
  TCP_MD5SIG              = $10 platform;    //* use MD5 digests (RFC2385) */
  {$EXTERNALSYM TCP_INFO}
  TCP_INFO                = $20 platform;  //* retrieve tcp_info structure */
  {$EXTERNALSYM TCP_CONGESTION}
  TCP_CONGESTION          = $40 platform;   //* get/set congestion control algorithm */
  {$ENDIF}

  {$IFDEF DARWIN}
  //specific to Mac OS X
  {$EXTERNALSYM TCP_KEEPALIVE}
  TCP_KEEPALIVE           = $10 platform;    //* idle time used when SO_KEEPALIVE is enabled */
  {$EXTERNALSYM TCP_CONNECTIONTIMEOUT}
  TCP_CONNECTIONTIMEOUT   = $20 platform;    //* connection timeout */

  {$EXTERNALSYM TCPOPT_EOL}
  TCPOPT_EOL	=	0 platform;
  {$EXTERNALSYM TCPOPT_NOP}
  TCPOPT_NOP	=	1 platform;
  {$EXTERNALSYM TCPOPT_MAXSEG}
  TCPOPT_MAXSEG	 = 2 platform;
  {$EXTERNALSYM TCPOLEN_MAXSEG}
  TCPOLEN_MAXSEG	 = 4 platform;
  {$EXTERNALSYM TCPOPT_WINDOW}
  TCPOPT_WINDOW	 = 3 platform;
  {$EXTERNALSYM TCPOLEN_WINDOW}
  TCPOLEN_WINDOW = 3 platform;
  {$EXTERNALSYM TCPOPT_SACK_PERMITTED}
  TCPOPT_SACK_PERMITTED	= 4 platform;		//* Experimental */
  {$EXTERNALSYM TCPOLEN_SACK_PERMITTED}
  TCPOLEN_SACK_PERMITTED = 2 platform;
  {$EXTERNALSYM TCPOPT_SACK}
  TCPOPT_SACK	  = 5 platform;		//* Experimental */
  {$EXTERNALSYM TCPOLEN_SACK}
  TCPOLEN_SACK  =	8 platform;		//* len of sack block */
  {$EXTERNALSYM TCPOPT_TIMESTAMP}
  TCPOPT_TIMESTAMP = 8 platform;
  {$EXTERNALSYM TCPOLEN_TIMESTAMP}
  TCPOLEN_TIMESTAMP = 10 platform;
  {$EXTERNALSYM TCPOLEN_TSTAMP_APPA}
  TCPOLEN_TSTAMP_APPA	=	(TCPOLEN_TIMESTAMP+2) platform; //* appendix A */
  {$EXTERNALSYM TCPOPT_TSTAMP_HDR}
  TCPOPT_TSTAMP_HDR	=
    ((TCPOPT_NOP shl 24) or
    (TCPOPT_NOP shl 16) or
    (TCPOPT_TIMESTAMP shl 8) or
    (TCPOLEN_TIMESTAMP)) platform;
  {$EXTERNALSYM MAX_TCPOPTLEN}
  MAX_TCPOPTLEN	 =	40 platform;	//* Absolute maximum TCP options len */
  {$EXTERNALSYM TCPOPT_CC}
  TCPOPT_CC	 =	11 platform;		//* CC options: RFC-1644 */
  {$EXTERNALSYM TCPOPT_CCNEW}
  TCPOPT_CCNEW = 12 platform;
  {$EXTERNALSYM TCPOPT_CCECHO}
  TCPOPT_CCECHO	=	13 platform;
  {$EXTERNALSYM TCPOLEN_CC}
  TCPOLEN_CC		=	6 platform;
  {$EXTERNALSYM TCPOLEN_CC_APPA}
  TCPOLEN_CC_APPA	=	(TCPOLEN_CC+2);

  {$EXTERNALSYM TCPOPT_CC_HDR}
 function TCPOPT_CC_HDR(const ccopt : Integer)	: Integer; inline;

const
  {$EXTERNALSYM TCPOPT_SIGNATURE}
	TCPOPT_SIGNATURE	 =	19 platform;	//* Keyed MD5: RFC 2385 */
  {$EXTERNALSYM TCPOLEN_SIGNATURE}
  TCPOLEN_SIGNATURE	 = 18 platform;

//* Option definitions */
  {$EXTERNALSYM TCPOPT_SACK_PERMIT_HDR}
  TCPOPT_SACK_PERMIT_HDR	=
    ((TCPOPT_NOP shl 24) or
     (TCPOPT_NOP shl 16) or
     (TCPOPT_SACK_PERMITTED shl 8) or
      TCPOLEN_SACK_PERMITTED) platform;
  {$EXTERNALSYM TCPOPT_SACK_HDR}
  TCPOPT_SACK_HDR = ((TCPOPT_NOP shl 24) or (TCPOPT_NOP shl 16) or (TCPOPT_SACK shl 8)) platform;
//* Miscellaneous constants */
  {$EXTERNALSYM MAX_SACK_BLKS}
  MAX_SACK_BLKS	= 6 platform; //* Max # SACK blocks stored at sender side */
  {$EXTERNALSYM TCP_MAX_SACK}
  TCP_MAX_SACK	= 3 platform;	//* MAX # SACKs sent in any segment */


// /*
// * Default maximum segment size for TCP.
// * With an IP MTU of 576, this is 536,
// * but 512 is probably more convenient.
// * This should be defined as MIN(512, IP_MSS - sizeof (struct tcpiphdr)).
// */
  {$EXTERNALSYM TCP_MSS}
  TCP_MSS	= 512 platform;

// /*
// * TCP_MINMSS is defined to be 216 which is fine for the smallest
// * link MTU (256 bytes, SLIP interface) in the Internet.
// * However it is very unlikely to come across such low MTU interfaces
// * these days (anno dato 2004).
// * Probably it can be set to 512 without ill effects. But we play safe.
// * See tcp_subr.c tcp_minmss SYSCTL declaration for more comments.
// * Setting this to "0" disables the minmss check.
// */
  {$EXTERNALSYM TCP_MINMSS}
  TCP_MINMSS = 216 platform;

// /*
// * TCP_MINMSSOVERLOAD is defined to be 1000 which should cover any type
// * of interactive TCP session.
// * See tcp_subr.c tcp_minmssoverload SYSCTL declaration and tcp_input.c
// * for more comments.
// * Setting this to "0" disables the minmssoverload check.
// */
  {$EXTERNALSYM TCP_MINMSSOVERLOAD}
  TCP_MINMSSOVERLOAD = 1000 platform;

// *
// * Default maximum segment size for TCP6.
// * With an IP6 MSS of 1280, this is 1220,
// * but 1024 is probably more convenient. (xxx kazu in doubt)
// * This should be defined as MIN(1024, IP6_MSS - sizeof (struct tcpip6hdr))
// */
  {$EXTERNALSYM TCP6_MSS}
  TCP6_MSS = 1024 platform;
  {$EXTERNALSYM TCP_MAXWIN}
  TCP_MAXWIN =	65535 platform;	//* largest value for (unscaled) window */
  {$EXTERNALSYM TTCP_CLIENT_SND_WND}
  TTCP_CLIENT_SND_WND	= 4096 platform;	//* dflt send window for T/TCP client */
  {$EXTERNALSYM TCP_MAX_WINSHIFT}
  TCP_MAX_WINSHIFT =	14 platform;	//* maximum window shift */
  {$EXTERNALSYM TCP_MAXBURST}
  TCP_MAXBURST	 =	4 platform;	//* maximum segments in a burst */
  {$EXTERNALSYM TCP_MAXHLEN}
  TCP_MAXHLEN    = ($f shl 2) platform;	//* max length of header in bytes */
  {$ENDIF}

  {$IFDEF LINUX}
  //specific to Linux
  {$EXTERNALSYM TCP_MAXSEG}
  TCP_MAXSEG             = 2;       //* Limit MSS */
  {$EXTERNALSYM TCP_CORK}
  TCP_CORK               = 3 platform;   //* Never send partially complete segments */
  {$EXTERNALSYM TCP_KEEPIDLE}
  TCP_KEEPIDLE           = 4 platform    //* Start keeplives after this period */
  {$EXTERNALSYM TCP_KEEPINTVL}
  TCP_KEEPINTVL          = 5 platform;   //* Interval between keepalives */
  {$EXTERNALSYM TCP_KEEPCNT}
  TCP_KEEPCNT            = 6 platform;   //* Number of keepalives before death */
  {$EXTERNALSYM TCP_SYNCNT}
  TCP_SYNCNT             = 7 platform;   //* Number of SYN retransmits */
  {$EXTERNALSYM TCP_LINGER2}
  TCP_LINGER2             = 8 platform;   //* Life time of orphaned FIN-WAIT-2 state */
  {$EXTERNALSYM TCP_DEFER_ACCEPT}
  TCP_DEFER_ACCEPT       = 9 platform;      //* Wake up listener only when data arrive */
  {$EXTERNALSYM TCP_WINDOW_CLAMP}
  TCP_WINDOW_CLAMP       = 10 platform;     //* Bound advertised window */
  {$EXTERNALSYM TCP_WINDOW_CLAMP}
  TCP_INFO               = 11 platform;      //* Information about this connection. */
  {$EXTERNALSYM TCP_QUICKACK}
  TCP_QUICKACK           = 12 platform;     //* Block/reenable quick acks */
  {$EXTERNALSYM TCP_CONGESTION}
  TCP_CONGESTION         = 13 platform;     //* Congestion control algorithm */
  {$EXTERNALSYM TCP_MD5SIG}
  TCP_MD5SIG             = 14 platform;     //* TCP MD5 Signature (RFC2385) */
  {$EXTERNALSYM TCP_COOKIE_TRANSACTIONS}
  TCP_COOKIE_TRANSACTIONS = 15 platform;     //* TCP Cookie Transactions */
  {$EXTERNALSYM TCP_THIN_LINEAR_TIMEOUTS}
  TCP_THIN_LINEAR_TIMEOUTS = 16 platform;     //* Use linear timeouts for thin streams*/
  {$EXTERNALSYM TCP_THIN_DUPACK}
  TCP_THIN_DUPACK        = 17 platform;      //* Fast retrans. after 1 dupack */

  {$EXTERNALSYM TCPI_OPT_TIMESTAMPS}
  TCPI_OPT_TIMESTAMPS	= 1;
  {$EXTERNALSYM TCPI_OPT_SACK}
  TCPI_OPT_SACK	 = 2;
  {$EXTERNALSYM TCPI_OPT_WSCALE}
  TCPI_OPT_WSCALE	= 4;
  {$EXTERNALSYM TCPI_OPT_ECN}
  TCPI_OPT_ECN	  = 8;
  {$ENDIF}
//udp.h

  {$IFDEF DARWIN}
  {$EXTERNALSYM UDP_NOCKSUM}
  UDP_NOCKSUM            = $01;    //* don't checksum outbound payloads */
  {$ENDIF}

  {$IFDEF LINUX}
  //* UDP socket options */
  {$EXTERNALSYM UDP_CORK}
  UDP_CORK	= 1;	//* Never send partially complete segments */
  {$EXTERNALSYM UDP_ENCAP}
  UDP_ENCAP	= 100;	//* Set the socket to accept encapsulated packets */

//* UDP encapsulation types */
  {$EXTERNALSYM UDP_ENCAP_ESPINUDP_NON_IKE}
  UDP_ENCAP_ESPINUDP_NON_IKE =	1; //* draft-ietf-ipsec-nat-t-ike-00/01 */
    {$EXTERNALSYM UDP_ENCAP_ESPINUDP}
  UDP_ENCAP_ESPINUDP	= 2; //* draft-ietf-ipsec-udp-encaps-06 */
  {$ENDIF}

implementation

  {$IFDEF DARWIN}
function  TCPOPT_CC_HDR(const ccopt : Integer) : Integer; inline;
begin
    Result := (TCPOPT_NOP shl 24) or
      (TCPOPT_NOP shl 16) or
      (ccopt shl 8) or
      TCPOLEN_CC;
end;
  {$ENDIF}

end.
