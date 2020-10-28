{******************************************************************************}
{                                                                              }
{            Indy (Internet Direct) - Internet Protocols Simplified            }
{                                                                              }
{            https://www.indyproject.org/                                      }
{            https://gitter.im/IndySockets/Indy                                }
{                                                                              }
{******************************************************************************}
{                                                                              }
{  This file is part of the Indy (Internet Direct) project, and is offered     }
{  under the dual-licensing agreement described on the Indy website.           }
{  (https://www.indyproject.org/license/)                                      }
{                                                                              }
{  Copyright:                                                                  }
{   (c) 1993-2020, Chad Z. Hower and the Indy Pit Crew. All rights reserved.   }
{                                                                              }
{******************************************************************************}
{                                                                              }
{        Originally written by: Fabian S. Biehn                                }
{                               fbiehn@aagon.com (German & English)            }
{                                                                              }
{        Contributers:                                                         }
{                               Here could be your name                        }
{                                                                              }
{******************************************************************************}

// This File is auto generated!
// Any change to this file should be made in the
// corresponding unit in the folder "intermediate"!

// Generation date: 28.10.2020 15:24:13

unit IdOpenSSLHeaders_bio;

interface

// Headers for OpenSSL 1.1.1
// bio.h

{$i IdCompilerDefines.inc}

uses
  Classes,
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSlHeaders_ossl_typ;

{$MINENUMSIZE 4}

const
  (* There are the classes of BIOs *)
  BIO_TYPE_DESCRIPTOR = $0100;
  BIO_TYPE_FILTER = $0200;
  BIO_TYPE_SOURCE_SINK = $0400;

  (* These are the 'types' of BIOs *)
  BIO_TYPE_NONE = 0;
  BIO_TYPE_MEM =  1 or BIO_TYPE_SOURCE_SINK;
  BIO_TYPE_FILE =  2 or BIO_TYPE_SOURCE_SINK;

  BIO_TYPE_FD          =  4 or BIO_TYPE_SOURCE_SINK or BIO_TYPE_DESCRIPTOR;
  BIO_TYPE_SOCKET      =  5 or BIO_TYPE_SOURCE_SINK or BIO_TYPE_DESCRIPTOR;
  BIO_TYPE_NULL        =  6 or BIO_TYPE_SOURCE_SINK;
  BIO_TYPE_SSL         =  7 or BIO_TYPE_FILTER;
  BIO_TYPE_MD          =  8 or BIO_TYPE_FILTER;
  BIO_TYPE_BUFFER      =  9 or BIO_TYPE_FILTER;
  BIO_TYPE_CIPHER      = 10 or BIO_TYPE_FILTER;
  BIO_TYPE_BASE64      = 11 or BIO_TYPE_FILTER;
  BIO_TYPE_CONNECT     = 12 or BIO_TYPE_SOURCE_SINK or BIO_TYPE_DESCRIPTOR;
  BIO_TYPE_ACCEPT      = 13 or BIO_TYPE_SOURCE_SINK or BIO_TYPE_DESCRIPTOR;

  BIO_TYPE_NBIO_TEST   = 16 or BIO_TYPE_FILTER;
  BIO_TYPE_NULL_FILTER = 17 or BIO_TYPE_FILTER;
  BIO_TYPE_BIO         = 19 or BIO_TYPE_SOURCE_SINK;
  BIO_TYPE_LINEBUFFER  = 20 or BIO_TYPE_FILTER;
  BIO_TYPE_DGRAM       = 21 or BIO_TYPE_SOURCE_SINK or BIO_TYPE_DESCRIPTOR;
  BIO_TYPE_ASN1        = 22 or BIO_TYPE_FILTER;
  BIO_TYPE_COMP        = 23 or BIO_TYPE_FILTER;
  BIO_TYPE_DGRAM_SCTP  = 24 or BIO_TYPE_SOURCE_SINK or BIO_TYPE_DESCRIPTOR;

  BIO_TYPE_START = 128;

  (*
   * BIO_FILENAME_READ|BIO_CLOSE to open or close on free.
   * BIO_set_fp(in,stdin,BIO_NOCLOSE);
   *)
  BIO_NOCLOSE = $00;
  BIO_CLOSE   = $01;

  (*
   * These are used in the following macros and are passed to BIO_ctrl()
   *)
  BIO_CTRL_RESET        = 1;(* opt - rewind/zero etc *)
  BIO_CTRL_EOF          = 2;(* opt - are we at the eof *)
  BIO_CTRL_INFO         = 3;(* opt - extra tit-bits *)
  BIO_CTRL_SET          = 4;(* man - set the 'IO' type *)
  BIO_CTRL_GET          = 5;(* man - get the 'IO' type *)
  BIO_CTRL_PUSH         = 6;(* opt - internal, used to signify change *)
  BIO_CTRL_POP          = 7;(* opt - internal, used to signify change *)
  BIO_CTRL_GET_CLOSE    = 8;(* man - set the 'close' on free *)
  BIO_CTRL_SET_CLOSE    = 9;(* man - set the 'close' on free *)
  // Added "_const" to prevent naming clashes
  BIO_CTRL_PENDING_const      = 10;(* opt - is their more data buffered *)
  BIO_CTRL_FLUSH        = 11;(* opt - 'flush' buffered output *)
  BIO_CTRL_DUP          = 12;(* man - extra stuff for 'duped' BIO *)
  // Added "_const" to prevent naming clashes
  BIO_CTRL_WPENDING_const     = 13;(* opt - number of bytes still to write *)
  BIO_CTRL_SET_CALLBACK = 14;(* opt - set callback function *)
  BIO_CTRL_GET_CALLBACK = 15;(* opt - set callback function *)

  BIO_CTRL_PEEK         = 29;(* BIO_f_buffer special *)
  BIO_CTRL_SET_FILENAME = 30;(* BIO_s_file special *)

  (* dgram BIO stuff *)
  BIO_CTRL_DGRAM_CONNECT       = 31;(* BIO dgram special *)
  BIO_CTRL_DGRAM_SET_CONNECTED = 32;(* allow for an externally connected
                                           * socket to be passed in *)
  BIO_CTRL_DGRAM_SET_RECV_TIMEOUT = 33;(* setsockopt, essentially *)
  BIO_CTRL_DGRAM_GET_RECV_TIMEOUT = 34;(* getsockopt, essentially *)
  BIO_CTRL_DGRAM_SET_SEND_TIMEOUT = 35;(* setsockopt, essentially *)
  BIO_CTRL_DGRAM_GET_SEND_TIMEOUT = 36;(* getsockopt, essentially *)

  BIO_CTRL_DGRAM_GET_RECV_TIMER_EXP = 37;(* flag whether the last *)
  BIO_CTRL_DGRAM_GET_SEND_TIMER_EXP = 38;(* I/O operation tiemd out *)

  BIO_CTRL_DGRAM_MTU_DISCOVER     = 39;(* set DF bit on egress packets *)

  BIO_CTRL_DGRAM_QUERY_MTU        = 40;(* as kernel for current MTU *)
  BIO_CTRL_DGRAM_GET_FALLBACK_MTU = 47;
  BIO_CTRL_DGRAM_GET_MTU          = 41;(* get cached value for MTU *)
  BIO_CTRL_DGRAM_SET_MTU          = 42;(* set cached value for MTU.
                                                * want to use this if asking
                                                * the kernel fails *)

  BIO_CTRL_DGRAM_MTU_EXCEEDED     = 43;(* check whether the MTU was
                                                * exceed in the previous write
                                                * operation *)

  BIO_CTRL_DGRAM_GET_PEER         = 46;
  BIO_CTRL_DGRAM_SET_PEER         = 44;(* Destination for the data *)

  BIO_CTRL_DGRAM_SET_NEXT_TIMEOUT = 45;(* Next DTLS handshake timeout
                                                * to adjust socket timeouts *)
  BIO_CTRL_DGRAM_SET_DONT_FRAG    = 48;

  BIO_CTRL_DGRAM_GET_MTU_OVERHEAD = 49;

  (* Deliberately outside of OPENSSL_NO_SCTP - used in bss_dgram.c *)
  BIO_CTRL_DGRAM_SCTP_SET_IN_HANDSHAKE  = 50;
  (* SCTP stuff *)
  BIO_CTRL_DGRAM_SCTP_ADD_AUTH_KEY      = 51;
  BIO_CTRL_DGRAM_SCTP_NEXT_AUTH_KEY     = 52;
  BIO_CTRL_DGRAM_SCTP_AUTH_CCS_RCVD     = 53;
  BIO_CTRL_DGRAM_SCTP_GET_SNDINFO       = 60;
  BIO_CTRL_DGRAM_SCTP_SET_SNDINFO       = 61;
  BIO_CTRL_DGRAM_SCTP_GET_RCVINFO       = 62;
  BIO_CTRL_DGRAM_SCTP_SET_RCVINFO       = 63;
  BIO_CTRL_DGRAM_SCTP_GET_PRINFO        = 64;
  BIO_CTRL_DGRAM_SCTP_SET_PRINFO        = 65;
  BIO_CTRL_DGRAM_SCTP_SAVE_SHUTDOWN     = 70;

  BIO_CTRL_DGRAM_SET_PEEK_MODE          = 71;

  (* modifiers *)
  BIO_FP_READ            = $02;
  BIO_FP_WRITE           = $04;
  BIO_FP_APPEND          = $08;
  BIO_FP_TEXT            = $10;

  BIO_FLAGS_READ         = $01;
  BIO_FLAGS_WRITE        = $02;
  BIO_FLAGS_IO_SPECIAL   = $04;
  BIO_FLAGS_RWS          = BIO_FLAGS_READ or BIO_FLAGS_WRITE or BIO_FLAGS_IO_SPECIAL;
  BIO_FLAGS_SHOULD_RETRY = $08;

  BIO_FLAGS_BASE64_NO_NL = $100;

  (*
   * This is used with memory BIOs:
   * BIO_FLAGS_MEM_RDONLY means we shouldn't free up or change the data in any way;
   * BIO_FLAGS_NONCLEAR_RST means we shouldn't clear data on reset.
   *)
  BIO_FLAGS_MEM_RDONLY   = $200;
  BIO_FLAGS_NONCLEAR_RST = $400;

  BIO_RR_SSL_X509_LOOKUP = $01;
  (* Returned from the connect BIO when a connect would have blocked *)
  BIO_RR_CONNECT         = $02;
  (* Returned from the accept BIO when an accept would have blocked *)
  BIO_RR_ACCEPT          = $03;

  (* These are passed by the BIO callback *)
  BIO_CB_FREE  = $01;
  BIO_CB_READ  = $02;
  BIO_CB_WRITE = $03;
  BIO_CB_PUTS  = $04;
  BIO_CB_GETS  = $05;
  BIO_CB_CTRL  = $06;
///*
// * The callback is called before and after the underling operation, The
// * BIO_CB_RETURN flag indicates if it is after the call
// */
//# define BIO_CB_RETURN   0x80
//# define BIO_CB_return(a) ((a)|BIO_CB_RETURN)
//# define BIO_cb_pre(a)   (!((a)&BIO_CB_RETURN))
//# define BIO_cb_post(a)  ((a)&BIO_CB_RETURN)

  BIO_C_SET_CONNECT                 = 100;
  BIO_C_DO_STATE_MACHINE            = 101;
  BIO_C_SET_NBIO                    = 102;
  (* BIO_C_SET_PROXY_PARAM            = 103 *)
  BIO_C_SET_FD                      = 104;
  BIO_C_GET_FD                      = 105;
  BIO_C_SET_FILE_PTR                = 106;
  BIO_C_GET_FILE_PTR                = 107;
  BIO_C_SET_FILENAME                = 108;
  BIO_C_SET_SSL                     = 109;
  BIO_C_GET_SSL                     = 110;
  BIO_C_SET_MD                      = 111;
  BIO_C_GET_MD                      = 112;
  BIO_C_GET_CIPHER_STATUS           = 113;
  BIO_C_SET_BUF_MEM                 = 114;
  BIO_C_GET_BUF_MEM_PTR             = 115;
  BIO_C_GET_BUFF_NUM_LINES          = 116;
  BIO_C_SET_BUFF_SIZE               = 117;
  BIO_C_SET_ACCEPT                  = 118;
  BIO_C_SSL_MODE                    = 119;
  BIO_C_GET_MD_CTX                  = 120;
  (* BIO_C_GET_PROXY_PARAM             = 121 *)
  BIO_C_SET_BUFF_READ_DATA          = 122;(* data to read first *)
  BIO_C_GET_CONNECT                 = 123;
  BIO_C_GET_ACCEPT                  = 124;
  BIO_C_SET_SSL_RENEGOTIATE_BYTES   = 125;
  BIO_C_GET_SSL_NUM_RENEGOTIATES    = 126;
  BIO_C_SET_SSL_RENEGOTIATE_TIMEOUT = 127;
  BIO_C_FILE_SEEK                   = 128;
  BIO_C_GET_CIPHER_CTX              = 129;
  BIO_C_SET_BUF_MEM_EOF_RETURN      = 130;(* return end of input
                                                       * value *)
  BIO_C_SET_BIND_MODE               = 131;
  BIO_C_GET_BIND_MODE               = 132;
  BIO_C_FILE_TELL                   = 133;
  BIO_C_GET_SOCKS                   = 134;
  BIO_C_SET_SOCKS                   = 135;

  BIO_C_SET_WRITE_BUF_SIZE          = 136;(* for BIO_s_bio *)
  BIO_C_GET_WRITE_BUF_SIZE          = 137;
  BIO_C_MAKE_BIO_PAIR               = 138;
  BIO_C_DESTROY_BIO_PAIR            = 139;
  BIO_C_GET_WRITE_GUARANTEE         = 140;
  BIO_C_GET_READ_REQUEST            = 141;
  BIO_C_SHUTDOWN_WR                 = 142;
  BIO_C_NREAD0                      = 143;
  BIO_C_NREAD                       = 144;
  BIO_C_NWRITE0                     = 145;
  BIO_C_NWRITE                      = 146;
  BIO_C_RESET_READ_REQUEST          = 147;
  BIO_C_SET_MD_CTX                  = 148;

  BIO_C_SET_PREFIX                  = 149;
  BIO_C_GET_PREFIX                  = 150;
  BIO_C_SET_SUFFIX                  = 151;
  BIO_C_GET_SUFFIX                  = 152;

  BIO_C_SET_EX_ARG                  = 153;
  BIO_C_GET_EX_ARG                  = 154;

  BIO_C_SET_CONNECT_MODE            = 155;

  BIO_SOCK_REUSEADDR = $01;
  BIO_SOCK_V6_ONLY   = $02;
  BIO_SOCK_KEEPALIVE = $04;
  BIO_SOCK_NONBLOCK  = $08;
  BIO_SOCK_NODELAY   = $10;

type
  BIO_ADDR = Pointer; // bio_addr_st
  PBIO_ADDR = ^BIO_ADDR;
  BIO_ADDRINFO = Pointer; // bio_addrinfo_st
  PBIO_ADDRINFO = ^BIO_ADDRINFO;
  PPBIO_ADDRINFO = ^PBIO_ADDRINFO;
  BIO_callback_fn = function(b: PBIO; oper: TIdC_INT; const argp: PIdAnsiChar; 
    argi: TIdC_INT; argl: TIdC_LONG; ret: TIdC_LONG): TIdC_LONG;
  BIO_callback_fn_ex = function(b: PBIO; oper: TIdC_INT; const argp: PIdAnsiChar; len: TIdC_SIZET; argi: TIdC_INT; argl: TIdC_LONG; ret: TIdC_INT; processed: PIdC_SIZET): TIdC_LONG;
  BIO_METHOD = Pointer; // bio_method_st
  PBIO_METHOD = ^BIO_METHOD;
  BIO_info_cb = function(v1: PBIO; v2: TIdC_INT; v3: TIdC_INT): TIdC_INT;
  PBIO_info_cb = ^BIO_info_cb;
  asn1_ps_func = function(b: PBIO; pbuf: PPIdAnsiChar; plen: PIdC_INT; parg: Pointer): TIdC_INT;

  bio_dgram_sctp_sndinfo = record
    snd_sid: TIdC_UINT16;
    snd_flags: TIdC_UINT16;
    snd_ppid: TIdC_UINT32;
    snd_context: TIdC_UINT32;
  end;

  bio_dgram_sctp_rcvinfo = record
    rcv_sid: TIdC_UINT16;
    rcv_ssn: TIdC_UINT16;
    rcv_flags: TIdC_UINT16;
    rcv_ppid: TIdC_UINT32;
    rcv_tsn: TIdC_UINT32;
    rcv_cumtsn: TIdC_UINT32;
    rcv_context: TIdC_UINT32;
  end;

  bio_dgram_sctp_prinfo = record
    pr_policy: TIdC_UINT16;
    pr_value: TIdC_UINT32;
  end;

  BIO_hostserv_priorities = (BIO_PARSE_PRIO_HOST, BIO_PARSE_PRIO_SERV);

  BIO_lookup_type = (BIO_LOOKUP_CLIENT, BIO_LOOKUP_SERVER);

  BIO_sock_info_u = record
    addr: PBIO_ADDR;
  end;
  PBIO_sock_info_u = ^BIO_sock_info_u;

  BIO_sock_info_type = (BIO_SOCK_INFO_ADDRESS);

function BIO_get_flags(const b: PBIO): TIdC_INT;
procedure BIO_set_retry_special(b: PBIO);
procedure BIO_set_retry_read(b: PBIO);
procedure BIO_set_retry_write(b: PBIO);

(* These are normally used internally in BIOs *)
procedure BIO_clear_retry_flags(b: PBIO);
function BIO_get_retry_flags(b: PBIO): TIdC_INT;

(* These should be used by the application to tell why we should retry *)
function BIO_should_read(b: PBIO): TIdC_INT;
function BIO_should_write(b: PBIO): TIdC_INT;
function BIO_should_io_special(b: PBIO): TIdC_INT;
function BIO_retry_type(b: PBIO): TIdC_INT;
function BIO_should_retry(b: PBIO): TIdC_INT;

(* BIO_s_accept() and BIO_s_connect() *)
function BIO_do_connect(b: PBIO): TIdC_LONG;
function BIO_do_accept(b: PBIO): TIdC_LONG;
function BIO_do_handshake(b: PBIO): TIdC_LONG;

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  BIO_get_new_index: function: TIdC_INT cdecl = nil;
  BIO_set_flags: procedure(b: PBIO; flags: TIdC_INT) cdecl = nil;
  BIO_test_flags: function(const b: PBIO; flags: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_clear_flags: procedure(b: PBIO; flags: TIdC_INT) cdecl = nil;

  BIO_get_callback: function(b: PBIO): BIO_callback_fn cdecl = nil;
  BIO_set_callback: procedure(b: PBIO; callback: BIO_callback_fn) cdecl = nil;

  BIO_get_callback_ex: function(b: PBIO): BIO_callback_fn_ex cdecl = nil;
  BIO_set_callback_ex: procedure(b: PBIO; callback: BIO_callback_fn_ex) cdecl = nil;

  BIO_get_callback_arg: function(const b: PBIO): PIdAnsiChar cdecl = nil;
  BIO_set_callback_arg: procedure(var b: PBIO; arg: PIdAnsiChar) cdecl = nil;

  BIO_method_name: function(const b: PBIO): PIdAnsiChar cdecl = nil;
  BIO_method_type: function(const b: PBIO): TIdC_INT cdecl = nil;

//  {$HPPEMIT '# define BIO_set_app_data(s,arg)         BIO_set_ex_data(s,0,arg)'}
//  {$HPPEMIT '# define BIO_get_app_data(s)             BIO_get_ex_data(s,0)'}
//
//  {$HPPEMIT '# define BIO_set_nbio(b,n)             BIO_ctrl(b,BIO_C_SET_NBIO,(n),NULL)'}
//
//  {$HPPEMIT '# ifndef OPENSSL_NO_SOCK'}
//  (* IP families we support, for BIO_s_connect() and BIO_s_accept() *)
//  (* Note: the underlying operating system may not support some of them *)
//  {$HPPEMIT '#  define BIO_FAMILY_IPV4                         4'}
//  {$HPPEMIT '#  define BIO_FAMILY_IPV6                         6'}
//  {$HPPEMIT '#  define BIO_FAMILY_IPANY                        256'}
//
//  (* BIO_s_connect() *)
//  {$HPPEMIT '#  define BIO_set_conn_hostname(b,name) BIO_ctrl(b,BIO_C_SET_CONNECT,0,'}
//                                                   (char (name))
//  {$HPPEMIT '#  define BIO_set_conn_port(b,port)     BIO_ctrl(b,BIO_C_SET_CONNECT,1,'}
//                                                   (char (port))
//  {$HPPEMIT '#  define BIO_set_conn_address(b,addr)  BIO_ctrl(b,BIO_C_SET_CONNECT,2,'}
//                                                   (char (addr))
//  {$HPPEMIT '#  define BIO_set_conn_ip_family(b,f)   BIO_int_ctrl(b,BIO_C_SET_CONNECT,3,f)'}
//  {$HPPEMIT '#  define BIO_get_conn_hostname(b)      (( char )BIO_ptr_ctrl(b,BIO_C_GET_CONNECT,0))'}
//  {$HPPEMIT '#  define BIO_get_conn_port(b)          (( char )BIO_ptr_ctrl(b,BIO_C_GET_CONNECT,1))'}
//  {$HPPEMIT '#  define BIO_get_conn_address(b)       (( PBIO_ADDR )BIO_ptr_ctrl(b,BIO_C_GET_CONNECT,2))'}
//  {$HPPEMIT '#  define BIO_get_conn_ip_family(b)     BIO_ctrl(b,BIO_C_GET_CONNECT,3,NULL)'}
//  {$HPPEMIT '#  define BIO_set_conn_mode(b,n)        BIO_ctrl(b,BIO_C_SET_CONNECT_MODE,(n),NULL)'}
//
//  (* BIO_s_accept() *)
//  {$HPPEMIT '#  define BIO_set_accept_name(b,name)   BIO_ctrl(b,BIO_C_SET_ACCEPT,0,'}
//  {$EXTERNALSYM PBIO}
//                                                   (char (name))
//  {$HPPEMIT '#  define BIO_set_accept_port(b,port)   BIO_ctrl(b,BIO_C_SET_ACCEPT,1,'}
//                                                   (char (port))
//  {$HPPEMIT '#  define BIO_get_accept_name(b)        (( char )BIO_ptr_ctrl(b,BIO_C_GET_ACCEPT,0))'}
//  {$HPPEMIT '#  define BIO_get_accept_port(b)        (( char )BIO_ptr_ctrl(b,BIO_C_GET_ACCEPT,1))'}
//  {$HPPEMIT '#  define BIO_get_peer_name(b)          (( char )BIO_ptr_ctrl(b,BIO_C_GET_ACCEPT,2))'}
//  {$HPPEMIT '#  define BIO_get_peer_port(b)          (( char )BIO_ptr_ctrl(b,BIO_C_GET_ACCEPT,3))'}
//  (* #define BIO_set_nbio(b,n)    BIO_ctrl(b,BIO_C_SET_NBIO,(n),NULL) *)
//  {$HPPEMIT '#  define BIO_set_nbio_accept(b,n)      #  define BIO_set_nbio_accept(b,n)      BIO_ctrl(b,BIO_C_SET_ACCEPT,2,(n)?(procedure )'a':NULL)  BIO_ctrl(b,BIO_C_SET_ACCEPT,3,'}
//                                                   (char (bio))
//  {$HPPEMIT '#  define BIO_set_accept_ip_family(b,f) BIO_int_ctrl(b,BIO_C_SET_ACCEPT,4,f)'}
//  {$HPPEMIT '#  define BIO_get_accept_ip_family(b)   BIO_ctrl(b,BIO_C_GET_ACCEPT,4,NULL)'}
//
//  (* Aliases kept for backward compatibility *)
//  {$HPPEMIT '#  define BIO_BIND_NORMAL                 0'}
//  {$HPPEMIT '#  define BIO_BIND_REUSEADDR              BIO_SOCK_REUSEADDR'}
//  {$HPPEMIT '#  define BIO_BIND_REUSEADDR_IF_UNUSED    BIO_SOCK_REUSEADDR'}
//  {$HPPEMIT '#  define BIO_set_bind_mode(b,mode) BIO_ctrl(b,BIO_C_SET_BIND_MODE,mode,NULL)'}
//  {$HPPEMIT '#  define BIO_get_bind_mode(b)    BIO_ctrl(b,BIO_C_GET_BIND_MODE,0,NULL)'}
//
//  (* BIO_s_accept() and BIO_s_connect() *)
//  {$HPPEMIT '#  define BIO_do_connect(b)       BIO_do_handshake(b)'}
//  {$HPPEMIT '#  define BIO_do_accept(b)        BIO_do_handshake(b)'}
//  {$HPPEMIT '# endif'}	(* OPENSSL_NO_SOCK *)
//
//  {$HPPEMIT '# define BIO_do_handshake(b)     BIO_ctrl(b,BIO_C_DO_STATE_MACHINE,0,NULL)'}
//
//  (* BIO_s_datagram(), BIO_s_fd(), BIO_s_socket(), BIO_s_accept() and BIO_s_connect() *)
//  {$HPPEMIT '# define BIO_set_fd(b,fd,c)      BIO_int_ctrl(b,BIO_C_SET_FD,c,fd)'}
//  {$HPPEMIT '# define BIO_get_fd(b,c)         BIO_ctrl(b,BIO_C_GET_FD,0,(char (c))'}
//
//  (* BIO_s_file() *)
//  {$HPPEMIT '# define BIO_set_fp(b,fp,c)      BIO_ctrl(b,BIO_C_SET_FILE_PTR,c,(char (fp))'}
//  {$HPPEMIT '# define BIO_get_fp(b,fpp)       BIO_ctrl(b,BIO_C_GET_FILE_PTR,0,(char (fpp))'}
//
//  (* BIO_s_fd() and BIO_s_file() *)
//  {$HPPEMIT '# define BIO_seek(b,ofs(int)BIO_ctrl(b,BIO_C_FILE_SEEK,ofs,NULL)'}
//  {$HPPEMIT '# define BIO_tell(b)     (int)BIO_ctrl(b,BIO_C_FILE_TELL,0,NULL)'}
//
//  (*
//   * name is cast to lose , but might be better to route through a
//   * cFunction so we can do it safely
//   *)
//  {$HPPEMIT '# ifdef CONST_STRICT'}
//  (*
//   * If you are wondering why this isn't defined, its because CONST_STRICT is
//   * purely a compile-time kludge to allow  to be checked.
//   *)
////  function BIO_read_filename(b: PBIO; const name: PIdAnsiChar): TIdC_INT;
//  {$HPPEMIT '# define BIO_write_filename(b,name(int)BIO_ctrl(b,BIO_C_SET_FILENAME,'}
//                  BIO_CLOSE or BIO_FP_WRITE,name)
//  {$HPPEMIT '# define BIO_append_filename(b,name(int)BIO_ctrl(b,BIO_C_SET_FILENAME,'}
//                  BIO_CLOSE or BIO_FP_APPEND,name)
//  {$HPPEMIT '# define BIO_rw_filename(b,name(int)BIO_ctrl(b,BIO_C_SET_FILENAME,'}
//                  BIO_CLOSE or BIO_FP_READ or BIO_FP_WRITE,name)
//
//  (*
//   * WARNING WARNING, this ups the reference count on the read bio of the SSL
//   * structure.  This is because the ssl read PBIO is now pointed to by the
//   * next_bio field in the bio.  So when you free the PBIO, make sure you are
//   * doing a BIO_free_all() to catch the underlying PBIO.
//   *)
//  {$HPPEMIT '# define BIO_set_ssl(b,ssl,c)    BIO_ctrl(b,BIO_C_SET_SSL,c,(char (ssl))'}
//  {$HPPEMIT '# define BIO_get_ssl(b,sslp)     BIO_ctrl(b,BIO_C_GET_SSL,0,(char (sslp))'}
//  {$HPPEMIT '# define BIO_set_ssl_mode(b,client)      BIO_ctrl(b,BIO_C_SSL_MODE,client,NULL)'}
//  {$HPPEMIT '# define BIO_set_ssl_renegotiate_bytes(b,num)'}
//          BIO_ctrl(b,BIO_C_SET_SSL_RENEGOTIATE_BYTES,num,0)
//  {$HPPEMIT '# define BIO_get_num_renegotiates(b)'}
//          BIO_ctrl(b,BIO_C_GET_SSL_NUM_RENEGOTIATES,0,0)
//  {$HPPEMIT '# define BIO_set_ssl_renegotiate_timeout(b,seconds)'}
//          BIO_ctrl(b,BIO_C_SET_SSL_RENEGOTIATE_TIMEOUT,seconds,0)
//
//  (* defined in evp.h *)
//  (* #define BIO_set_md(b,md)     BIO_ctrl(b,BIO_C_SET_MD,1,(char )(md)) *)
//
//  {$HPPEMIT '# define BIO_get_mem_data(b,pp)  BIO_ctrl(b,BIO_CTRL_INFO,0,(char (pp))'}
//  {$HPPEMIT '# define BIO_set_mem_buf(b,bm,c) BIO_ctrl(b,BIO_C_SET_BUF_MEM,c,(char (bm))'}
//  {$HPPEMIT '# define BIO_get_mem_ptr(b,pp)   BIO_ctrl(b,BIO_C_GET_BUF_MEM_PTR,0,'}
//                                            (char (pp))
//  {$HPPEMIT '# define BIO_set_mem_eof_return(b,v)'}
//                                  BIO_ctrl(b,BIO_C_SET_BUF_MEM_EOF_RETURN,v,0)
//
//  (* For the BIO_f_buffer() type *)
//  {$HPPEMIT '# define BIO_get_buffer_num_lines(b)     BIO_ctrl(b,BIO_C_GET_BUFF_NUM_LINES,0,NULL)'}
//  {$HPPEMIT '# define BIO_set_buffer_size(b,size)     BIO_ctrl(b,BIO_C_SET_BUFF_SIZE,size,NULL)'}
//  {$HPPEMIT '# define BIO_set_read_buffer_size(b,size) BIO_int_ctrl(b,BIO_C_SET_BUFF_SIZE,size,0)'}
//  {$HPPEMIT '# define BIO_set_write_buffer_size(b,size) BIO_int_ctrl(b,BIO_C_SET_BUFF_SIZE,size,1)'}
//  {$HPPEMIT '# define BIO_set_buffer_read_data(b,buf,num) BIO_ctrl(b,BIO_C_SET_BUFF_READ_DATA,num,buf)'}
//
//  (* Don't use the next one unless you know what you are doing :-) */
//  {$HPPEMIT '# define BIO_dup_state(b,ret)    BIO_ctrl(b,BIO_CTRL_DUP,0,(char (ret))'}
//
//  {$HPPEMIT '# define BIO_reset(b)            (int)BIO_ctrl(b,BIO_CTRL_RESET,0,NULL)'}
//  {$HPPEMIT '# define BIO_eof(b)              (int)BIO_ctrl(b,BIO_CTRL_EOF,0,NULL)'}
//  {$HPPEMIT '# define BIO_set_close(b,c)      (int)BIO_ctrl(b,BIO_CTRL_SET_CLOSE,(c),NULL)'}
//  {$HPPEMIT '# define BIO_get_close(b)        (int)BIO_ctrl(b,BIO_CTRL_GET_CLOSE,0,NULL)'}
//  {$HPPEMIT '# define BIO_pending(b)          (int)BIO_ctrl(b,BIO_CTRL_PENDING,0,NULL)'}
//  {$HPPEMIT '# define BIO_wpending(b)         (int)BIO_ctrl(b,BIO_CTRL_WPENDING,0,NULL)'}
  (* ...pending macros have inappropriate return type *)
  BIO_ctrl_pending: function(b: PBIO): TIdC_SIZET cdecl = nil;
  BIO_ctrl_wpending: function(b: PBIO): TIdC_SIZET cdecl = nil;
//  {$HPPEMIT '# define BIO_flush(b)            (int)BIO_ctrl(b,BIO_CTRL_FLUSH,0,NULL)'}
//  {$HPPEMIT '# define BIO_get_info_callback(b,cbp(int)BIO_ctrl(b,BIO_CTRL_GET_CALLBACK,0,'}
//                                                     cbp)
//  {$HPPEMIT '# define BIO_set_info_callback(b,cb(int)BIO_callback_ctrl(b,BIO_CTRL_SET_CALLBACK,cb)'}
//
//  (* For the BIO_f_buffer() type *)
//  {$HPPEMIT '# define BIO_buffer_get_num_lines(b) BIO_ctrl(b,BIO_CTRL_GET,0,NULL)'}
//  {$HPPEMIT '# define BIO_buffer_peek(b,s,l) BIO_ctrl(b,BIO_CTRL_PEEK,(l),(s))'}
//
//  (* For BIO_s_bio() *)
//  {$HPPEMIT '# define BIO_set_write_buf_size(b,size(int)BIO_ctrl(b,BIO_C_SET_WRITE_BUF_SIZE,size,NULL)'}
//  {$HPPEMIT '# define BIO_get_write_buf_size(b,size(TIdC_SIZET)BIO_ctrl(b,BIO_C_GET_WRITE_BUF_SIZE,size,NULL)'}
//  {$HPPEMIT '# define BIO_make_bio_pair(b1,b2)   (int)BIO_ctrl(b1,BIO_C_MAKE_BIO_PAIR,0,b2)'}
//  {$HPPEMIT '# define BIO_destroy_bio_pair(b)    (int)BIO_ctrl(b,BIO_C_DESTROY_BIO_PAIR,0,NULL)'}
//  {$HPPEMIT '# define BIO_shutdown_wr(b(int)BIO_ctrl(b, BIO_C_SHUTDOWN_WR, 0, NULL)'}
//  (* macros with inappropriate type -- but ...pending macros use int too: *)
//  {$HPPEMIT '# define BIO_get_write_guarantee(b(int)BIO_ctrl(b,BIO_C_GET_WRITE_GUARANTEE,0,NULL)'}
//  {$HPPEMIT '# define BIO_get_read_request(b)    (int)BIO_ctrl(b,BIO_C_GET_READ_REQUEST,0,NULL)'}
  BIO_ctrl_get_write_guarantee: function(b: PBIO): TIdC_SIZET cdecl = nil;
  BIO_ctrl_get_read_request: function(b: PBIO): TIdC_SIZET cdecl = nil;
  BIO_ctrl_reset_read_request: function(b: PBIO): TIdC_INT cdecl = nil;

  (* ctrl macros for dgram *)
//  {$HPPEMIT '# define BIO_ctrl_dgram_connect(b,peer)'}
//                       (TIdC_INT)BIO_ctrl(b,BIO_CTRL_DGRAM_CONNECT,0, (char (peer))
//  {$HPPEMIT '# define BIO_ctrl_set_connected(b,peer)'}
//           (TIdC_INT)BIO_ctrl(b, BIO_CTRL_DGRAM_SET_CONNECTED, 0, (char (peer))
//  {$HPPEMIT '# define BIO_dgram_recv_timedout(b)'}
//           (TIdC_INT)BIO_ctrl(b, BIO_CTRL_DGRAM_GET_RECV_TIMER_EXP, 0, 0)
//  {$HPPEMIT '# define BIO_dgram_send_timedout(b)'}
//           (TIdC_INT)BIO_ctrl(b, BIO_CTRL_DGRAM_GET_SEND_TIMER_EXP, 0, 0)
//  {$HPPEMIT '# define BIO_dgram_get_peer(b,peer)'}
//           (TIdC_INT)BIO_ctrl(b, BIO_CTRL_DGRAM_GET_PEER, 0, (char (peer))
//  {$HPPEMIT '# define BIO_dgram_set_peer(b,peer)'}
//           (TIdC_INT)BIO_ctrl(b, BIO_CTRL_DGRAM_SET_PEER, 0, (char (peer))
//  {$HPPEMIT '# define BIO_dgram_get_mtu_overhead(b)'}
//           (Cardinal)BIO_ctrl((b), BIO_CTRL_DGRAM_GET_MTU_OVERHEAD, 0, 0)

//#define BIO_get_ex_new_index(l, p, newf, dupf, freef) \
//    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_BIO, l, p, newf, dupf, freef)

  BIO_set_ex_data: function(bio: PBIO; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl = nil;
  BIO_get_ex_data: function(bio: PBIO; idx: TIdC_INT): Pointer cdecl = nil;
  BIO_number_read: function(bio: PBIO): TIdC_UINT64 cdecl = nil;
  BIO_number_written: function(bio: PBIO): TIdC_UINT64 cdecl = nil;

  (* For BIO_f_asn1() *)
//  function BIO_asn1_set_prefix(b: PBIO; prefix: ^asn1_ps_func; prefix_free: ^asn1_ps_func): TIdC_INT;
//  function BIO_asn1_get_prefix(b: PBIO; pprefix: ^^asn1_ps_func; pprefix_free: ^^asn1_ps_func): TIdC_INT;
//  function BIO_asn1_set_suffix(b: PBIO; suffix: ^asn1_ps_func; suffix_free: ^asn1_ps_func): TIdC_INT;
//  function BIO_asn1_get_suffix(b: PBIO; psuffix: ^asn1_ps_func; psuffix_free: ^^asn1_ps_func): TIdC_INT;

  BIO_s_file: function: PBIO_METHOD cdecl = nil;
  BIO_new_file: function(const filename: PIdAnsiChar; const mode: PIdAnsiChar): PBIO cdecl = nil;
//  function BIO_new_fp(stream: cFile; close_flag: TIdC_INT): PBIO;
  BIO_new: function(const cType: PBIO_METHOD): PBIO cdecl = nil;
  BIO_free: function(a: PBIO): TIdC_INT cdecl = nil;
  BIO_set_data: procedure(a: PBIO; ptr: Pointer) cdecl = nil;
  BIO_get_data: function(a: PBIO): Pointer cdecl = nil;
  BIO_set_init: procedure(a: PBIO; init: TIdC_INT) cdecl = nil;
  BIO_get_init: function(a: PBIO): TIdC_INT cdecl = nil;
  BIO_set_shutdown: procedure(a: PBIO; shut: TIdC_INT) cdecl = nil;
  BIO_get_shutdown: function(a: PBIO): TIdC_INT cdecl = nil;
  BIO_vfree: procedure(a: PBIO) cdecl = nil;
  BIO_up_ref: function(a: PBIO): TIdC_INT cdecl = nil;
  BIO_read: function(b: PBIO; data: Pointer; dlen: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_read_ex: function(b: PBIO; data: Pointer; dlen: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT cdecl = nil;
  BIO_gets: function( bp: PBIO; buf: PIdAnsiChar; size: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_write: function(b: PBIO; const data: Pointer; dlen: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_write_ex: function(b: PBIO; const data: Pointer; dlen: TIdC_SIZET; written: PIdC_SIZET): TIdC_INT cdecl = nil;
  BIO_puts: function(bp: PBIO; const buf: PIdAnsiChar): TIdC_INT cdecl = nil;
  BIO_indent: function(b: PBIO; indent: TIdC_INT; max: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_ctrl: function(bp: PBIO; cmd: TIdC_INT; larg: TIdC_LONG; parg: Pointer): TIdC_LONG cdecl = nil;
  BIO_callback_ctrl: function(b: PBIO; cmd: TIdC_INT; fp: PBIO_info_cb): TIdC_LONG cdecl = nil;
  BIO_ptr_ctrl: function(bp: PBIO; cmd: TIdC_INT; larg: TIdC_LONG): Pointer cdecl = nil;
  BIO_int_ctrl: function(bp: PBIO; cmd: TIdC_INT; larg: TIdC_LONG; iarg: TIdC_INT): TIdC_LONG cdecl = nil;
  BIO_push: function(b: PBIO; append: PBIO): PBIO cdecl = nil;
  BIO_pop: function(b: PBIO): PBIO cdecl = nil;
  BIO_free_all: procedure(a: PBIO) cdecl = nil;
  BIO_find_type: function(b: PBIO; bio_type: TIdC_INT): PBIO cdecl = nil;
  BIO_next: function(b: PBIO): PBIO cdecl = nil;
  BIO_set_next: procedure(b: PBIO; next: PBIO) cdecl = nil;
  BIO_get_retry_BIO: function(bio: PBIO; reason: TIdC_INT): PBIO cdecl = nil;
  BIO_get_retry_reason: function(bio: PBIO): TIdC_INT cdecl = nil;
  BIO_set_retry_reason: procedure(bio: PBIO; reason: TIdC_INT) cdecl = nil;
  BIO_dup_chain: function(&in: PBIO): PBIO cdecl = nil;

  BIO_nread0: function(bio: PBIO; buf: PPIdAnsiChar): TIdC_INT cdecl = nil;
  BIO_nread: function(bio: PBIO; buf: PPIdAnsiChar; num: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_nwrite0: function(bio: PBIO; buf: PPIdAnsiChar): TIdC_INT cdecl = nil;
  BIO_nwrite: function(bio: PBIO; buf: PPIdAnsiChar; num: TIdC_INT): TIdC_INT cdecl = nil;

  BIO_debug_callback: function(bio: PBIO; cmd: TIdC_INT; const argp: PIdAnsiChar; argi: TIdC_INT; argl: TIdC_LONG; ret: TIdC_LONG): TIdC_LONG cdecl = nil;

  BIO_s_mem: function: BIO_METHOD cdecl = nil;
  BIO_s_secmem: function: BIO_METHOD cdecl = nil;
  BIO_new_mem_buf: function(const buf: Pointer; len: TIdC_INT): PBIO cdecl = nil;

  BIO_s_socket: function: BIO_METHOD cdecl = nil;
  BIO_s_connect: function: BIO_METHOD cdecl = nil;
  BIO_s_accept: function: BIO_METHOD cdecl = nil;

  BIO_s_fd: function: BIO_METHOD cdecl = nil;
  BIO_s_log: function: BIO_METHOD cdecl = nil;
  BIO_s_bio: function: BIO_METHOD cdecl = nil;
  BIO_s_null: function: BIO_METHOD cdecl = nil;
  BIO_f_null: function: BIO_METHOD cdecl = nil;
  BIO_f_buffer: function: BIO_METHOD cdecl = nil;
  BIO_f_linebuffer: function: BIO_METHOD cdecl = nil;
  BIO_f_nbio_test: function: BIO_METHOD cdecl = nil;
  BIO_s_datagram: function: BIO_METHOD cdecl = nil;
  BIO_dgram_non_fatal_error: function(error: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_new_dgram: function(fd: TIdC_INT; close_flag: TIdC_INT): PBIO cdecl = nil;

  BIO_s_datagram_sctp: function: BIO_METHOD cdecl = nil;
  BIO_new_dgram_sctp: function(fd: TIdC_INT; close_flag: TIdC_INT): PBIO cdecl = nil;
  BIO_dgram_is_sctp: function(bio: PBIO): TIdC_INT cdecl = nil;
//  function BIO_dgram_sctp_notification_cb(bio: PBIO; handle_notifications(PBIO;
//    context: Pointer;
//    buf: Pointer): TIdC_INT, Pointer context);
  BIO_dgram_sctp_wait_for_dry: function(b: PBIO): TIdC_INT cdecl = nil;
  BIO_dgram_sctp_msg_waiting: function(b: PBIO): TIdC_INT cdecl = nil;

  BIO_sock_should_retry: function(i: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_sock_non_fatal_error: function(error: TIdC_INT): TIdC_INT cdecl = nil;

  BIO_fd_should_retry: function(i: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_fd_non_fatal_error: function(error: TIdC_INT): TIdC_INT cdecl = nil;
//  function BIO_dump_cb(
//    Pointer data: cb(;
//    len: TIdC_SIZET;
//    function: Pointer): u: TIdC_INT, Pointer function ,  PIdAnsiChar s, TIdC_INT len): u;
//  function BIO_dump_indent_cb(TIdC_INT (cb( Pointer data, TIdC_SIZET len, Pointer function ): u: TIdC_INT, Pointer function ,  PIdAnsiChar s, TIdC_INT len, TIdC_INT indent): u;
  BIO_dump: function(b: PBIO; const bytes: PIdAnsiChar; len: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_dump_indent: function(b: PBIO; const bytes: PIdAnsiChar; len: TIdC_INT; indent: TIdC_INT): TIdC_INT cdecl = nil;

//  function BIO_dump_fp(fp: cFile; const s: PByte; len: TIdC_INT): TIdC_INT;
//  function BIO_dump_indent_fp(fp: cFile; const s: PByte; len: TIdC_INT; indent: TIdC_INT): TIdC_INT;

  BIO_hex_string: function(&out: PBIO; indent: TIdC_INT; width: TIdC_INT; data: PByte; datalen: TIdC_INT): TIdC_INT cdecl = nil;

  BIO_ADDR_new: function: PBIO_ADDR cdecl = nil;
  BIO_ADDR_rawmake: function(ap: PBIO_ADDR; familiy: TIdC_INT; const where: Pointer; wherelen: TIdC_SIZET; port: TIdC_SHORT): TIdC_INT cdecl = nil;
  BIO_ADDR_free: procedure(a: PBIO_ADDR) cdecl = nil;
  BIO_ADDR_clear: procedure(ap: PBIO_ADDR) cdecl = nil;
  BIO_ADDR_family: function(const ap: PBIO_ADDR): TIdC_INT cdecl = nil;
  BIO_ADDR_rawaddress: function(const ap: PBIO_ADDR; p: Pointer; l: PIdC_SIZET): TIdC_INT cdecl = nil;
  BIO_ADDR_rawport: function(const ap: PBIO_ADDR): TIdC_SHORT cdecl = nil;
  BIO_ADDR_hostname_string: function(const ap: PBIO_ADDR; numeric: TIdC_INT): PIdAnsiChar cdecl = nil;
  BIO_ADDR_service_string: function(const ap: PBIO_ADDR; numeric: TIdC_INT): PIdAnsiChar cdecl = nil;
  BIO_ADDR_path_string: function(const ap: PBIO_ADDR): PIdAnsiChar cdecl = nil;

  BIO_ADDRINFO_next: function(const bai: PBIO_ADDRINFO): PBIO_ADDRINFO cdecl = nil;
  BIO_ADDRINFO_family: function(const bai: PBIO_ADDRINFO): TIdC_INT cdecl = nil;
  BIO_ADDRINFO_socktype: function(const bai: PBIO_ADDRINFO): TIdC_INT cdecl = nil;
  BIO_ADDRINFO_protocol: function(const bai: PBIO_ADDRINFO): TIdC_INT cdecl = nil;
  BIO_ADDRINFO_address: function(const bai: PBIO_ADDRINFO): PBIO_ADDR cdecl = nil;
  BIO_ADDRINFO_free: procedure(bai: PBIO_ADDRINFO) cdecl = nil;

  BIO_parse_hostserv: function(const hostserv: PIdAnsiChar; host: PPIdAnsiChar; service: PPIdAnsiChar; hostserv_prio: BIO_hostserv_priorities): TIdC_INT cdecl = nil;

  BIO_lookup: function(const host: PIdAnsiChar; const service: PIdAnsiChar; lookup_type: BIO_lookup_type; family: TIdC_INT; socktype: TIdC_INT; res: PPBIO_ADDRINFO): TIdC_INT cdecl = nil;
  BIO_lookup_ex: function(const host: PIdAnsiChar; const service: PIdAnsiChar; lookup_type: TIdC_INT; family: TIdC_INT; socktype: TIdC_INT; protocol: TIdC_INT; res: PPBIO_ADDRINFO): TIdC_INT cdecl = nil;
  BIO_sock_error: function(sock: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_socket_ioctl: function(fd: TIdC_INT; cType: TIdC_LONG; arg: Pointer): TIdC_INT cdecl = nil;
  BIO_socket_nbio: function(fd: TIdC_INT; mode: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_sock_init: function: TIdC_INT cdecl = nil;

  BIO_set_tcp_ndelay: function(sock: TIdC_INT; turn_on: TIdC_INT): TIdC_INT cdecl = nil;

  BIO_sock_info: function(sock: TIdC_INT; type_: BIO_sock_info_type; info: PBIO_sock_info_u): TIdC_INT cdecl = nil;

  BIO_socket: function(domain: TIdC_INT; socktype: TIdC_INT; protocol: TIdC_INT; options: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_connect: function(sock: TIdC_INT; const addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_bind: function(sock: TIdC_INT; const addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_listen: function(sock: TIdC_INT; const addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_accept_ex: function(accept_sock: TIdC_INT; addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT cdecl = nil;
  BIO_closesocket: function(sock: TIdC_INT): TIdC_INT cdecl = nil;

  BIO_new_socket: function(sock: TIdC_INT; close_flag: TIdC_INT): PBIO cdecl = nil;
  BIO_new_connect: function(const host_port: PIdAnsiChar): PBIO cdecl = nil;
  BIO_new_accept: function(const host_port: PIdAnsiChar): PBIO cdecl = nil;

  BIO_new_fd: function(fd: TIdC_INT; close_flag: TIdC_INT): PBIO cdecl = nil;

  BIO_new_bio_pair: function(bio1: PPBIO; writebuf1: TIdC_SIZET; bio2: PPBIO; writebuf2: TIdC_SIZET): TIdC_INT cdecl = nil;
  (*
   * If successful, returns 1 and in *bio1, *bio2 two BIO pair endpoints.
   * Otherwise returns 0 and sets *bio1 and *bio2 to NULL. Size 0 uses default
   * value.
   *)

  BIO_copy_next_retry: procedure(b: PBIO) cdecl = nil;

//  BIO_METHOD *BIO_meth_new(int type, const char *name);
//  void BIO_meth_free(BIO_METHOD *biom);
//  int (*BIO_meth_get_write(const BIO_METHOD *biom)) (BIO *, const char *, int);
//  int (*BIO_meth_get_write_ex(const BIO_METHOD *biom)) (BIO *, const char *, TIdC_SIZET,
//                                                  TIdC_SIZET *);
//  int BIO_meth_set_write(BIO_METHOD *biom,
//                         int (*write) (BIO *, const char *, int));
//  int BIO_meth_set_write_ex(BIO_METHOD *biom,
//                         int (*bwrite) (BIO *, const char *, TIdC_SIZET, TIdC_SIZET *));
//  int (*BIO_meth_get_read(const BIO_METHOD *biom)) (BIO *, char *, int);
//  int (*BIO_meth_get_read_ex(const BIO_METHOD *biom)) (BIO *, char *, TIdC_SIZET, TIdC_SIZET *);
//  int BIO_meth_set_read(BIO_METHOD *biom,
//                        int (*read) (BIO *, char *, int));
//  int BIO_meth_set_read_ex(BIO_METHOD *biom,
//                           int (*bread) (BIO *, char *, TIdC_SIZET, TIdC_SIZET *));
//  int (*BIO_meth_get_puts(const BIO_METHOD *biom)) (BIO *, const char *);
//  int BIO_meth_set_puts(BIO_METHOD *biom,
//                        int (*puts) (BIO *, const char *));
//  int (*BIO_meth_get_gets(const BIO_METHOD *biom)) (BIO *, char *, int);
//  int BIO_meth_set_gets(BIO_METHOD *biom,
//                        int (*gets) (BIO *, char *, int));
//  long (*BIO_meth_get_ctrl(const BIO_METHOD *biom)) (BIO *, int, long, void *);
//  int BIO_meth_set_ctrl(BIO_METHOD *biom,
//                        long (*ctrl) (BIO *, int, long, void *));
//  int (*BIO_meth_get_create(const BIO_METHOD *bion)) (BIO *);
//  int BIO_meth_set_create(BIO_METHOD *biom, int (*create) (BIO *));
//  int (*BIO_meth_get_destroy(const BIO_METHOD *biom)) (BIO *);
//  int BIO_meth_set_destroy(BIO_METHOD *biom, int (*destroy) (BIO *));
//  long (*BIO_meth_get_callback_ctrl(const BIO_METHOD *biom))
//                                   (BIO *, int, BIO_info_cb *);
//  int BIO_meth_set_callback_ctrl(BIO_METHOD *biom,
//                                 long (*callback_ctrl) (BIO *, int,
//                                                        BIO_info_cb *));

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  BIO_get_new_index := LoadFunction('BIO_get_new_index', AFailed);
  BIO_set_flags := LoadFunction('BIO_set_flags', AFailed);
  BIO_test_flags := LoadFunction('BIO_test_flags', AFailed);
  BIO_clear_flags := LoadFunction('BIO_clear_flags', AFailed);
  BIO_get_callback := LoadFunction('BIO_get_callback', AFailed);
  BIO_set_callback := LoadFunction('BIO_set_callback', AFailed);
  BIO_get_callback_ex := LoadFunction('BIO_get_callback_ex', AFailed);
  BIO_set_callback_ex := LoadFunction('BIO_set_callback_ex', AFailed);
  BIO_get_callback_arg := LoadFunction('BIO_get_callback_arg', AFailed);
  BIO_set_callback_arg := LoadFunction('BIO_set_callback_arg', AFailed);
  BIO_method_name := LoadFunction('BIO_method_name', AFailed);
  BIO_method_type := LoadFunction('BIO_method_type', AFailed);
  BIO_ctrl_pending := LoadFunction('BIO_ctrl_pending', AFailed);
  BIO_ctrl_wpending := LoadFunction('BIO_ctrl_wpending', AFailed);
  BIO_ctrl_get_write_guarantee := LoadFunction('BIO_ctrl_get_write_guarantee', AFailed);
  BIO_ctrl_get_read_request := LoadFunction('BIO_ctrl_get_read_request', AFailed);
  BIO_ctrl_reset_read_request := LoadFunction('BIO_ctrl_reset_read_request', AFailed);
  BIO_set_ex_data := LoadFunction('BIO_set_ex_data', AFailed);
  BIO_get_ex_data := LoadFunction('BIO_get_ex_data', AFailed);
  BIO_number_read := LoadFunction('BIO_number_read', AFailed);
  BIO_number_written := LoadFunction('BIO_number_written', AFailed);
  BIO_s_file := LoadFunction('BIO_s_file', AFailed);
  BIO_new_file := LoadFunction('BIO_new_file', AFailed);
  BIO_new := LoadFunction('BIO_new', AFailed);
  BIO_free := LoadFunction('BIO_free', AFailed);
  BIO_set_data := LoadFunction('BIO_set_data', AFailed);
  BIO_get_data := LoadFunction('BIO_get_data', AFailed);
  BIO_set_init := LoadFunction('BIO_set_init', AFailed);
  BIO_get_init := LoadFunction('BIO_get_init', AFailed);
  BIO_set_shutdown := LoadFunction('BIO_set_shutdown', AFailed);
  BIO_get_shutdown := LoadFunction('BIO_get_shutdown', AFailed);
  BIO_vfree := LoadFunction('BIO_vfree', AFailed);
  BIO_up_ref := LoadFunction('BIO_up_ref', AFailed);
  BIO_read := LoadFunction('BIO_read', AFailed);
  BIO_read_ex := LoadFunction('BIO_read_ex', AFailed);
  BIO_gets := LoadFunction('BIO_gets', AFailed);
  BIO_write := LoadFunction('BIO_write', AFailed);
  BIO_write_ex := LoadFunction('BIO_write_ex', AFailed);
  BIO_puts := LoadFunction('BIO_puts', AFailed);
  BIO_indent := LoadFunction('BIO_indent', AFailed);
  BIO_ctrl := LoadFunction('BIO_ctrl', AFailed);
  BIO_callback_ctrl := LoadFunction('BIO_callback_ctrl', AFailed);
  BIO_ptr_ctrl := LoadFunction('BIO_ptr_ctrl', AFailed);
  BIO_int_ctrl := LoadFunction('BIO_int_ctrl', AFailed);
  BIO_push := LoadFunction('BIO_push', AFailed);
  BIO_pop := LoadFunction('BIO_pop', AFailed);
  BIO_free_all := LoadFunction('BIO_free_all', AFailed);
  BIO_find_type := LoadFunction('BIO_find_type', AFailed);
  BIO_next := LoadFunction('BIO_next', AFailed);
  BIO_set_next := LoadFunction('BIO_set_next', AFailed);
  BIO_get_retry_BIO := LoadFunction('BIO_get_retry_BIO', AFailed);
  BIO_get_retry_reason := LoadFunction('BIO_get_retry_reason', AFailed);
  BIO_set_retry_reason := LoadFunction('BIO_set_retry_reason', AFailed);
  BIO_dup_chain := LoadFunction('BIO_dup_chain', AFailed);
  BIO_nread0 := LoadFunction('BIO_nread0', AFailed);
  BIO_nread := LoadFunction('BIO_nread', AFailed);
  BIO_nwrite0 := LoadFunction('BIO_nwrite0', AFailed);
  BIO_nwrite := LoadFunction('BIO_nwrite', AFailed);
  BIO_debug_callback := LoadFunction('BIO_debug_callback', AFailed);
  BIO_s_mem := LoadFunction('BIO_s_mem', AFailed);
  BIO_s_secmem := LoadFunction('BIO_s_secmem', AFailed);
  BIO_new_mem_buf := LoadFunction('BIO_new_mem_buf', AFailed);
  BIO_s_socket := LoadFunction('BIO_s_socket', AFailed);
  BIO_s_connect := LoadFunction('BIO_s_connect', AFailed);
  BIO_s_accept := LoadFunction('BIO_s_accept', AFailed);
  BIO_s_fd := LoadFunction('BIO_s_fd', AFailed);
  BIO_s_log := LoadFunction('BIO_s_log', AFailed);
  BIO_s_bio := LoadFunction('BIO_s_bio', AFailed);
  BIO_s_null := LoadFunction('BIO_s_null', AFailed);
  BIO_f_null := LoadFunction('BIO_f_null', AFailed);
  BIO_f_buffer := LoadFunction('BIO_f_buffer', AFailed);
  BIO_f_linebuffer := LoadFunction('BIO_f_linebuffer', AFailed);
  BIO_f_nbio_test := LoadFunction('BIO_f_nbio_test', AFailed);
  BIO_s_datagram := LoadFunction('BIO_s_datagram', AFailed);
  BIO_dgram_non_fatal_error := LoadFunction('BIO_dgram_non_fatal_error', AFailed);
  BIO_new_dgram := LoadFunction('BIO_new_dgram', AFailed);
  BIO_s_datagram_sctp := LoadFunction('BIO_s_datagram_sctp', AFailed);
  BIO_new_dgram_sctp := LoadFunction('BIO_new_dgram_sctp', AFailed);
  BIO_dgram_is_sctp := LoadFunction('BIO_dgram_is_sctp', AFailed);
  BIO_dgram_sctp_wait_for_dry := LoadFunction('BIO_dgram_sctp_wait_for_dry', AFailed);
  BIO_dgram_sctp_msg_waiting := LoadFunction('BIO_dgram_sctp_msg_waiting', AFailed);
  BIO_sock_should_retry := LoadFunction('BIO_sock_should_retry', AFailed);
  BIO_sock_non_fatal_error := LoadFunction('BIO_sock_non_fatal_error', AFailed);
  BIO_fd_should_retry := LoadFunction('BIO_fd_should_retry', AFailed);
  BIO_fd_non_fatal_error := LoadFunction('BIO_fd_non_fatal_error', AFailed);
  BIO_dump := LoadFunction('BIO_dump', AFailed);
  BIO_dump_indent := LoadFunction('BIO_dump_indent', AFailed);
  BIO_hex_string := LoadFunction('BIO_hex_string', AFailed);
  BIO_ADDR_new := LoadFunction('BIO_ADDR_new', AFailed);
  BIO_ADDR_rawmake := LoadFunction('BIO_ADDR_rawmake', AFailed);
  BIO_ADDR_free := LoadFunction('BIO_ADDR_free', AFailed);
  BIO_ADDR_clear := LoadFunction('BIO_ADDR_clear', AFailed);
  BIO_ADDR_family := LoadFunction('BIO_ADDR_family', AFailed);
  BIO_ADDR_rawaddress := LoadFunction('BIO_ADDR_rawaddress', AFailed);
  BIO_ADDR_rawport := LoadFunction('BIO_ADDR_rawport', AFailed);
  BIO_ADDR_hostname_string := LoadFunction('BIO_ADDR_hostname_string', AFailed);
  BIO_ADDR_service_string := LoadFunction('BIO_ADDR_service_string', AFailed);
  BIO_ADDR_path_string := LoadFunction('BIO_ADDR_path_string', AFailed);
  BIO_ADDRINFO_next := LoadFunction('BIO_ADDRINFO_next', AFailed);
  BIO_ADDRINFO_family := LoadFunction('BIO_ADDRINFO_family', AFailed);
  BIO_ADDRINFO_socktype := LoadFunction('BIO_ADDRINFO_socktype', AFailed);
  BIO_ADDRINFO_protocol := LoadFunction('BIO_ADDRINFO_protocol', AFailed);
  BIO_ADDRINFO_address := LoadFunction('BIO_ADDRINFO_address', AFailed);
  BIO_ADDRINFO_free := LoadFunction('BIO_ADDRINFO_free', AFailed);
  BIO_parse_hostserv := LoadFunction('BIO_parse_hostserv', AFailed);
  BIO_lookup := LoadFunction('BIO_lookup', AFailed);
  BIO_lookup_ex := LoadFunction('BIO_lookup_ex', AFailed);
  BIO_sock_error := LoadFunction('BIO_sock_error', AFailed);
  BIO_socket_ioctl := LoadFunction('BIO_socket_ioctl', AFailed);
  BIO_socket_nbio := LoadFunction('BIO_socket_nbio', AFailed);
  BIO_sock_init := LoadFunction('BIO_sock_init', AFailed);
  BIO_set_tcp_ndelay := LoadFunction('BIO_set_tcp_ndelay', AFailed);
  BIO_sock_info := LoadFunction('BIO_sock_info', AFailed);
  BIO_socket := LoadFunction('BIO_socket', AFailed);
  BIO_connect := LoadFunction('BIO_connect', AFailed);
  BIO_bind := LoadFunction('BIO_bind', AFailed);
  BIO_listen := LoadFunction('BIO_listen', AFailed);
  BIO_accept_ex := LoadFunction('BIO_accept_ex', AFailed);
  BIO_closesocket := LoadFunction('BIO_closesocket', AFailed);
  BIO_new_socket := LoadFunction('BIO_new_socket', AFailed);
  BIO_new_connect := LoadFunction('BIO_new_connect', AFailed);
  BIO_new_accept := LoadFunction('BIO_new_accept', AFailed);
  BIO_new_fd := LoadFunction('BIO_new_fd', AFailed);
  BIO_new_bio_pair := LoadFunction('BIO_new_bio_pair', AFailed);
  BIO_copy_next_retry := LoadFunction('BIO_copy_next_retry', AFailed);
end;

procedure UnLoad;
begin
  BIO_get_new_index := nil;
  BIO_set_flags := nil;
  BIO_test_flags := nil;
  BIO_clear_flags := nil;
  BIO_get_callback := nil;
  BIO_set_callback := nil;
  BIO_get_callback_ex := nil;
  BIO_set_callback_ex := nil;
  BIO_get_callback_arg := nil;
  BIO_set_callback_arg := nil;
  BIO_method_name := nil;
  BIO_method_type := nil;
  BIO_ctrl_pending := nil;
  BIO_ctrl_wpending := nil;
  BIO_ctrl_get_write_guarantee := nil;
  BIO_ctrl_get_read_request := nil;
  BIO_ctrl_reset_read_request := nil;
  BIO_set_ex_data := nil;
  BIO_get_ex_data := nil;
  BIO_number_read := nil;
  BIO_number_written := nil;
  BIO_s_file := nil;
  BIO_new_file := nil;
  BIO_new := nil;
  BIO_free := nil;
  BIO_set_data := nil;
  BIO_get_data := nil;
  BIO_set_init := nil;
  BIO_get_init := nil;
  BIO_set_shutdown := nil;
  BIO_get_shutdown := nil;
  BIO_vfree := nil;
  BIO_up_ref := nil;
  BIO_read := nil;
  BIO_read_ex := nil;
  BIO_gets := nil;
  BIO_write := nil;
  BIO_write_ex := nil;
  BIO_puts := nil;
  BIO_indent := nil;
  BIO_ctrl := nil;
  BIO_callback_ctrl := nil;
  BIO_ptr_ctrl := nil;
  BIO_int_ctrl := nil;
  BIO_push := nil;
  BIO_pop := nil;
  BIO_free_all := nil;
  BIO_find_type := nil;
  BIO_next := nil;
  BIO_set_next := nil;
  BIO_get_retry_BIO := nil;
  BIO_get_retry_reason := nil;
  BIO_set_retry_reason := nil;
  BIO_dup_chain := nil;
  BIO_nread0 := nil;
  BIO_nread := nil;
  BIO_nwrite0 := nil;
  BIO_nwrite := nil;
  BIO_debug_callback := nil;
  BIO_s_mem := nil;
  BIO_s_secmem := nil;
  BIO_new_mem_buf := nil;
  BIO_s_socket := nil;
  BIO_s_connect := nil;
  BIO_s_accept := nil;
  BIO_s_fd := nil;
  BIO_s_log := nil;
  BIO_s_bio := nil;
  BIO_s_null := nil;
  BIO_f_null := nil;
  BIO_f_buffer := nil;
  BIO_f_linebuffer := nil;
  BIO_f_nbio_test := nil;
  BIO_s_datagram := nil;
  BIO_dgram_non_fatal_error := nil;
  BIO_new_dgram := nil;
  BIO_s_datagram_sctp := nil;
  BIO_new_dgram_sctp := nil;
  BIO_dgram_is_sctp := nil;
  BIO_dgram_sctp_wait_for_dry := nil;
  BIO_dgram_sctp_msg_waiting := nil;
  BIO_sock_should_retry := nil;
  BIO_sock_non_fatal_error := nil;
  BIO_fd_should_retry := nil;
  BIO_fd_non_fatal_error := nil;
  BIO_dump := nil;
  BIO_dump_indent := nil;
  BIO_hex_string := nil;
  BIO_ADDR_new := nil;
  BIO_ADDR_rawmake := nil;
  BIO_ADDR_free := nil;
  BIO_ADDR_clear := nil;
  BIO_ADDR_family := nil;
  BIO_ADDR_rawaddress := nil;
  BIO_ADDR_rawport := nil;
  BIO_ADDR_hostname_string := nil;
  BIO_ADDR_service_string := nil;
  BIO_ADDR_path_string := nil;
  BIO_ADDRINFO_next := nil;
  BIO_ADDRINFO_family := nil;
  BIO_ADDRINFO_socktype := nil;
  BIO_ADDRINFO_protocol := nil;
  BIO_ADDRINFO_address := nil;
  BIO_ADDRINFO_free := nil;
  BIO_parse_hostserv := nil;
  BIO_lookup := nil;
  BIO_lookup_ex := nil;
  BIO_sock_error := nil;
  BIO_socket_ioctl := nil;
  BIO_socket_nbio := nil;
  BIO_sock_init := nil;
  BIO_set_tcp_ndelay := nil;
  BIO_sock_info := nil;
  BIO_socket := nil;
  BIO_connect := nil;
  BIO_bind := nil;
  BIO_listen := nil;
  BIO_accept_ex := nil;
  BIO_closesocket := nil;
  BIO_new_socket := nil;
  BIO_new_connect := nil;
  BIO_new_accept := nil;
  BIO_new_fd := nil;
  BIO_new_bio_pair := nil;
  BIO_copy_next_retry := nil;
end;

// # define BIO_get_flags(b) BIO_test_flags(b, ~(0x0))
function BIO_get_flags(const b: PBIO): TIdC_INT;
begin
  Result := BIO_test_flags(b, not $0);
end;

//# define BIO_set_retry_special(b) \
//                BIO_set_flags(b, (BIO_FLAGS_IO_SPECIAL|BIO_FLAGS_SHOULD_RETRY))
procedure BIO_set_retry_special(b: PBIO);
begin
  BIO_set_flags(b, BIO_FLAGS_IO_SPECIAL or BIO_FLAGS_SHOULD_RETRY);
end;

//# define BIO_set_retry_read(b) \
//                BIO_set_flags(b, (BIO_FLAGS_READ|BIO_FLAGS_SHOULD_RETRY))
procedure BIO_set_retry_read(b: PBIO);
begin
  BIO_set_flags(b, BIO_FLAGS_READ or BIO_FLAGS_SHOULD_RETRY);
end;

//# define BIO_set_retry_write(b) \
//                BIO_set_flags(b, (BIO_FLAGS_WRITE|BIO_FLAGS_SHOULD_RETRY))
procedure BIO_set_retry_write(b: PBIO);
begin
  BIO_set_flags(b, BIO_FLAGS_WRITE or BIO_FLAGS_SHOULD_RETRY);
end;

//# define BIO_clear_retry_flags(b) \
//                BIO_clear_flags(b, (BIO_FLAGS_RWS|BIO_FLAGS_SHOULD_RETRY))
procedure BIO_clear_retry_flags(b: PBIO);
begin
  BIO_clear_flags(b, BIO_FLAGS_RWS or BIO_FLAGS_SHOULD_RETRY);
end;

//# define BIO_get_retry_flags(b) \
//                BIO_test_flags(b, (BIO_FLAGS_RWS|BIO_FLAGS_SHOULD_RETRY))
function BIO_get_retry_flags(b: PBIO): TIdC_INT;
begin
  Result := BIO_test_flags(b, BIO_FLAGS_RWS or BIO_FLAGS_SHOULD_RETRY);
end;

//# define BIO_should_read(a)              BIO_test_flags(a, BIO_FLAGS_READ)
function BIO_should_read(b: PBIO): TIdC_INT;
begin
  Result := BIO_test_flags(b, BIO_FLAGS_READ);
end;

//# define BIO_should_write(a)             BIO_test_flags(a, BIO_FLAGS_WRITE)
function BIO_should_write(b: PBIO): TIdC_INT;
begin
  Result := BIO_test_flags(b, BIO_FLAGS_WRITE);
end;

//# define BIO_should_io_special(a)        BIO_test_flags(a, BIO_FLAGS_IO_SPECIAL)
function BIO_should_io_special(b: PBIO): TIdC_INT;
begin
  Result := BIO_test_flags(b, BIO_FLAGS_IO_SPECIAL);
end;

//# define BIO_retry_type(a)               BIO_test_flags(a, BIO_FLAGS_RWS)
function BIO_retry_type(b: PBIO): TIdC_INT;
begin
  Result := BIO_test_flags(b, BIO_FLAGS_RWS);
end;

//# define BIO_should_retry(a)             BIO_test_flags(a, BIO_FLAGS_SHOULD_RETRY)
function BIO_should_retry(b: PBIO): TIdC_INT;
begin
  Result := BIO_test_flags(b, BIO_FLAGS_SHOULD_RETRY);
end;

//#  define BIO_do_connect(b)       BIO_do_handshake(b)
function BIO_do_connect(b: PBIO): TIdC_LONG;
begin
  Result := BIO_do_handshake(b);
end;

//#  define BIO_do_accept(b)        BIO_do_handshake(b)
function BIO_do_accept(b: PBIO): TIdC_LONG;
begin
  Result := BIO_do_handshake(b);
end;

//# define BIO_do_handshake(b)     BIO_ctrl(b,BIO_C_DO_STATE_MACHINE,0,NULL)
function BIO_do_handshake(b: PBIO): TIdC_LONG;
begin
  Result := BIO_ctrl(b, BIO_C_DO_STATE_MACHINE, 0, nil);
end;

end.

