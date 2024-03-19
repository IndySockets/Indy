  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_bio.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_bio.h2pas
     and this file regenerated. IdOpenSSLHeaders_bio.h2pas is distributed with the full Indy
     Distribution.
   *)
   
{$i IdCompilerDefines.inc} 
{$i IdSSLOpenSSLDefines.inc} 

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
{                                                                              }
{******************************************************************************}

unit IdOpenSSLHeaders_bio;

interface

// Headers for OpenSSL 1.1.1
// bio.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
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

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM BIO_get_new_index} {introduced 1.1.0}
  {$EXTERNALSYM BIO_set_flags}
  {$EXTERNALSYM BIO_test_flags}
  {$EXTERNALSYM BIO_clear_flags}
  {$EXTERNALSYM BIO_get_callback}
  {$EXTERNALSYM BIO_set_callback}
  {$EXTERNALSYM BIO_get_callback_ex} {introduced 1.1.0}
  {$EXTERNALSYM BIO_set_callback_ex} {introduced 1.1.0}
  {$EXTERNALSYM BIO_get_callback_arg}
  {$EXTERNALSYM BIO_set_callback_arg}
  {$EXTERNALSYM BIO_method_name}
  {$EXTERNALSYM BIO_method_type}
//  {$EXTERNALSYM PBIO}
  {$EXTERNALSYM BIO_ctrl_pending}
  {$EXTERNALSYM BIO_ctrl_wpending}
  {$EXTERNALSYM BIO_ctrl_get_write_guarantee}
  {$EXTERNALSYM BIO_ctrl_get_read_request}
  {$EXTERNALSYM BIO_ctrl_reset_read_request}
  {$EXTERNALSYM BIO_set_ex_data}
  {$EXTERNALSYM BIO_get_ex_data}
  {$EXTERNALSYM BIO_number_read}
  {$EXTERNALSYM BIO_number_written}
  {$EXTERNALSYM BIO_s_file}
  {$EXTERNALSYM BIO_new_file}
  {$EXTERNALSYM BIO_new}
  {$EXTERNALSYM BIO_free}
  {$EXTERNALSYM BIO_set_data} {introduced 1.1.0}
  {$EXTERNALSYM BIO_get_data} {introduced 1.1.0}
  {$EXTERNALSYM BIO_set_init} {introduced 1.1.0}
  {$EXTERNALSYM BIO_get_init} {introduced 1.1.0}
  {$EXTERNALSYM BIO_set_shutdown} {introduced 1.1.0}
  {$EXTERNALSYM BIO_get_shutdown} {introduced 1.1.0}
  {$EXTERNALSYM BIO_vfree}
  {$EXTERNALSYM BIO_up_ref} {introduced 1.1.0}
  {$EXTERNALSYM BIO_read}
  {$EXTERNALSYM BIO_read_ex} {introduced 1.1.0}
  {$EXTERNALSYM BIO_gets}
  {$EXTERNALSYM BIO_write}
  {$EXTERNALSYM BIO_write_ex} {introduced 1.1.0}
  {$EXTERNALSYM BIO_puts}
  {$EXTERNALSYM BIO_indent}
  {$EXTERNALSYM BIO_ctrl}
  {$EXTERNALSYM BIO_callback_ctrl}
  {$EXTERNALSYM BIO_ptr_ctrl}
  {$EXTERNALSYM BIO_int_ctrl}
  {$EXTERNALSYM BIO_push}
  {$EXTERNALSYM BIO_pop}
  {$EXTERNALSYM BIO_free_all}
  {$EXTERNALSYM BIO_find_type}
  {$EXTERNALSYM BIO_next}
  {$EXTERNALSYM BIO_set_next} {introduced 1.1.0}
  {$EXTERNALSYM BIO_get_retry_BIO}
  {$EXTERNALSYM BIO_get_retry_reason}
  {$EXTERNALSYM BIO_set_retry_reason} {introduced 1.1.0}
  {$EXTERNALSYM BIO_dup_chain}
  {$EXTERNALSYM BIO_nread0}
  {$EXTERNALSYM BIO_nread}
  {$EXTERNALSYM BIO_nwrite0}
  {$EXTERNALSYM BIO_nwrite}
  {$EXTERNALSYM BIO_debug_callback}
  {$EXTERNALSYM BIO_s_mem}
  {$EXTERNALSYM BIO_s_secmem} {introduced 1.1.0}
  {$EXTERNALSYM BIO_new_mem_buf}
  {$EXTERNALSYM BIO_s_socket}
  {$EXTERNALSYM BIO_s_connect}
  {$EXTERNALSYM BIO_s_accept}
  {$EXTERNALSYM BIO_s_fd}
  {$EXTERNALSYM BIO_s_log}
  {$EXTERNALSYM BIO_s_bio}
  {$EXTERNALSYM BIO_s_null}
  {$EXTERNALSYM BIO_f_null}
  {$EXTERNALSYM BIO_f_buffer}
  {$EXTERNALSYM BIO_f_linebuffer} {introduced 1.1.0}
  {$EXTERNALSYM BIO_f_nbio_test}
  {$EXTERNALSYM BIO_s_datagram}
  {$EXTERNALSYM BIO_dgram_non_fatal_error}
  {$EXTERNALSYM BIO_new_dgram}
  {$EXTERNALSYM BIO_sock_should_retry}
  {$EXTERNALSYM BIO_sock_non_fatal_error}
  {$EXTERNALSYM BIO_fd_should_retry}
  {$EXTERNALSYM BIO_fd_non_fatal_error}
  {$EXTERNALSYM BIO_dump}
  {$EXTERNALSYM BIO_dump_indent}
  {$EXTERNALSYM BIO_hex_string}
  {$EXTERNALSYM BIO_ADDR_new} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDR_rawmake} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDR_free} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDR_clear} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDR_family} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDR_rawaddress} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDR_rawport} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDR_hostname_string} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDR_service_string} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDR_path_string} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDRINFO_next} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDRINFO_family} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDRINFO_socktype} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDRINFO_protocol} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDRINFO_address} {introduced 1.1.0}
  {$EXTERNALSYM BIO_ADDRINFO_free} {introduced 1.1.0}
  {$EXTERNALSYM BIO_parse_hostserv} {introduced 1.1.0}
  {$EXTERNALSYM BIO_lookup} {introduced 1.1.0}
  {$EXTERNALSYM BIO_lookup_ex} {introduced 1.1.0}
  {$EXTERNALSYM BIO_sock_error}
  {$EXTERNALSYM BIO_socket_ioctl}
  {$EXTERNALSYM BIO_socket_nbio}
  {$EXTERNALSYM BIO_sock_init}
  {$EXTERNALSYM BIO_set_tcp_ndelay}
  {$EXTERNALSYM BIO_sock_info} {introduced 1.1.0}
  {$EXTERNALSYM BIO_socket} {introduced 1.1.0}
  {$EXTERNALSYM BIO_connect} {introduced 1.1.0}
  {$EXTERNALSYM BIO_bind} {introduced 1.1.0}
  {$EXTERNALSYM BIO_listen} {introduced 1.1.0}
  {$EXTERNALSYM BIO_accept_ex} {introduced 1.1.0}
  {$EXTERNALSYM BIO_closesocket} {introduced 1.1.0}
  {$EXTERNALSYM BIO_new_socket}
  {$EXTERNALSYM BIO_new_connect}
  {$EXTERNALSYM BIO_new_accept}
  {$EXTERNALSYM BIO_new_fd}
  {$EXTERNALSYM BIO_new_bio_pair}
  {$EXTERNALSYM BIO_copy_next_retry}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  {$EXTERNALSYM BIO_get_flags} {removed 1.0.0}
  {$EXTERNALSYM BIO_set_retry_special} {removed 1.0.0}
  {$EXTERNALSYM BIO_set_retry_read} {removed 1.0.0}
  {$EXTERNALSYM BIO_set_retry_write} {removed 1.0.0}
  {$EXTERNALSYM BIO_clear_retry_flags} {removed 1.0.0}
  {$EXTERNALSYM BIO_get_retry_flags} {removed 1.0.0}
  {$EXTERNALSYM BIO_should_read} {removed 1.0.0}
  {$EXTERNALSYM BIO_should_write} {removed 1.0.0}
  {$EXTERNALSYM BIO_should_io_special} {removed 1.0.0}
  {$EXTERNALSYM BIO_retry_type} {removed 1.0.0}
  {$EXTERNALSYM BIO_should_retry} {removed 1.0.0}
  {$EXTERNALSYM BIO_do_connect} {removed 1.0.0}
  {$EXTERNALSYM BIO_do_accept} {removed 1.0.0}
  {$EXTERNALSYM BIO_do_handshake} {removed 1.0.0}
  {$EXTERNALSYM BIO_get_mem_data} {removed 1.0.0}
  {$EXTERNALSYM BIO_set_mem_buf} {removed 1.0.0}
  {$EXTERNALSYM BIO_get_mem_ptr} {removed 1.0.0}
  {$EXTERNALSYM BIO_set_mem_eof_return} {removed 1.0.0}
  BIO_get_flags: function(const b: PBIO): TIdC_INT; cdecl = nil; {removed 1.0.0}
  BIO_set_retry_special: procedure(b: PBIO); cdecl = nil; {removed 1.0.0}
  BIO_set_retry_read: procedure(b: PBIO); cdecl = nil; {removed 1.0.0}
  BIO_set_retry_write: procedure(b: PBIO); cdecl = nil; {removed 1.0.0}

(* These are normally used internally in BIOs *)
  BIO_clear_retry_flags: procedure(b: PBIO); cdecl = nil; {removed 1.0.0}
  BIO_get_retry_flags: function(b: PBIO): TIdC_INT; cdecl = nil; {removed 1.0.0}

(* These should be used by the application to tell why we should retry *)
  BIO_should_read: function(b: PBIO): TIdC_INT; cdecl = nil; {removed 1.0.0}
  BIO_should_write: function(b: PBIO): TIdC_INT; cdecl = nil; {removed 1.0.0}
  BIO_should_io_special: function(b: PBIO): TIdC_INT; cdecl = nil; {removed 1.0.0}
  BIO_retry_type: function(b: PBIO): TIdC_INT; cdecl = nil; {removed 1.0.0}
  BIO_should_retry: function(b: PBIO): TIdC_INT; cdecl = nil; {removed 1.0.0}

(* BIO_s_accept() and BIO_s_connect() *)
  BIO_do_connect: function(b: PBIO): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  BIO_do_accept: function(b: PBIO): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  BIO_do_handshake: function(b: PBIO): TIdC_LONG; cdecl = nil; {removed 1.0.0}

  BIO_get_mem_data: function(b: PBIO; pp: PIdAnsiChar) : TIdC_INT; cdecl = nil; {removed 1.0.0}
  BIO_set_mem_buf: function(b: PBIO; bm: PIdAnsiChar; c: TIdC_INT): TIdC_INT; cdecl = nil; {removed 1.0.0}
  BIO_get_mem_ptr: function(b: PBIO; pp: PIdAnsiChar): TIdC_INT; cdecl = nil; {removed 1.0.0}
  BIO_set_mem_eof_return: function(b: PBIO; v: TIdC_INT): TIdC_INT; cdecl = nil; {removed 1.0.0}

  BIO_get_new_index: function: TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_set_flags: procedure(b: PBIO; flags: TIdC_INT); cdecl = nil;
  BIO_test_flags: function(const b: PBIO; flags: TIdC_INT): TIdC_INT; cdecl = nil;
  BIO_clear_flags: procedure(b: PBIO; flags: TIdC_INT); cdecl = nil;

  BIO_get_callback: function(b: PBIO): BIO_callback_fn; cdecl = nil;
  BIO_set_callback: procedure(b: PBIO; callback: BIO_callback_fn); cdecl = nil;

  BIO_get_callback_ex: function(b: PBIO): BIO_callback_fn_ex; cdecl = nil; {introduced 1.1.0}
  BIO_set_callback_ex: procedure(b: PBIO; callback: BIO_callback_fn_ex); cdecl = nil; {introduced 1.1.0}

  BIO_get_callback_arg: function(const b: PBIO): PIdAnsiChar; cdecl = nil;
  BIO_set_callback_arg: procedure(var b: PBIO; arg: PIdAnsiChar); cdecl = nil;

  BIO_method_name: function(const b: PBIO): PIdAnsiChar; cdecl = nil;
  BIO_method_type: function(const b: PBIO): TIdC_INT; cdecl = nil;

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
  BIO_ctrl_pending: function(b: PBIO): TIdC_SIZET; cdecl = nil;
  BIO_ctrl_wpending: function(b: PBIO): TIdC_SIZET; cdecl = nil;
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
  BIO_ctrl_get_write_guarantee: function(b: PBIO): TIdC_SIZET; cdecl = nil;
  BIO_ctrl_get_read_request: function(b: PBIO): TIdC_SIZET; cdecl = nil;
  BIO_ctrl_reset_read_request: function(b: PBIO): TIdC_INT; cdecl = nil;

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

  BIO_set_ex_data: function(bio: PBIO; idx: TIdC_INT; data: Pointer): TIdC_INT; cdecl = nil;
  BIO_get_ex_data: function(bio: PBIO; idx: TIdC_INT): Pointer; cdecl = nil;
  BIO_number_read: function(bio: PBIO): TIdC_UINT64; cdecl = nil;
  BIO_number_written: function(bio: PBIO): TIdC_UINT64; cdecl = nil;

  (* For BIO_f_asn1() *)
//  function BIO_asn1_set_prefix(b: PBIO; prefix: ^asn1_ps_func; prefix_free: ^asn1_ps_func): TIdC_INT;
//  function BIO_asn1_get_prefix(b: PBIO; pprefix: ^^asn1_ps_func; pprefix_free: ^^asn1_ps_func): TIdC_INT;
//  function BIO_asn1_set_suffix(b: PBIO; suffix: ^asn1_ps_func; suffix_free: ^asn1_ps_func): TIdC_INT;
//  function BIO_asn1_get_suffix(b: PBIO; psuffix: ^asn1_ps_func; psuffix_free: ^^asn1_ps_func): TIdC_INT;

  BIO_s_file: function: PBIO_METHOD; cdecl = nil;
  BIO_new_file: function(const filename: PIdAnsiChar; const mode: PIdAnsiChar): PBIO; cdecl = nil;
//  function BIO_new_fp(stream: cFile; close_flag: TIdC_INT): PBIO;
  BIO_new: function(const cType: PBIO_METHOD): PBIO; cdecl = nil;
  BIO_free: function(a: PBIO): TIdC_INT; cdecl = nil;
  BIO_set_data: procedure(a: PBIO; ptr: Pointer); cdecl = nil; {introduced 1.1.0}
  BIO_get_data: function(a: PBIO): Pointer; cdecl = nil; {introduced 1.1.0}
  BIO_set_init: procedure(a: PBIO; init: TIdC_INT); cdecl = nil; {introduced 1.1.0}
  BIO_get_init: function(a: PBIO): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_set_shutdown: procedure(a: PBIO; shut: TIdC_INT); cdecl = nil; {introduced 1.1.0}
  BIO_get_shutdown: function(a: PBIO): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_vfree: procedure(a: PBIO); cdecl = nil;
  BIO_up_ref: function(a: PBIO): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_read: function(b: PBIO; data: Pointer; dlen: TIdC_INT): TIdC_INT; cdecl = nil;
  BIO_read_ex: function(b: PBIO; data: Pointer; dlen: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_gets: function( bp: PBIO; buf: PIdAnsiChar; size: TIdC_INT): TIdC_INT; cdecl = nil;
  BIO_write: function(b: PBIO; const data: Pointer; dlen: TIdC_INT): TIdC_INT; cdecl = nil;
  BIO_write_ex: function(b: PBIO; const data: Pointer; dlen: TIdC_SIZET; written: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_puts: function(bp: PBIO; const buf: PIdAnsiChar): TIdC_INT; cdecl = nil;
  BIO_indent: function(b: PBIO; indent: TIdC_INT; max: TIdC_INT): TIdC_INT; cdecl = nil;
  BIO_ctrl: function(bp: PBIO; cmd: TIdC_INT; larg: TIdC_LONG; parg: Pointer): TIdC_LONG; cdecl = nil;
  BIO_callback_ctrl: function(b: PBIO; cmd: TIdC_INT; fp: PBIO_info_cb): TIdC_LONG; cdecl = nil;
  BIO_ptr_ctrl: function(bp: PBIO; cmd: TIdC_INT; larg: TIdC_LONG): Pointer; cdecl = nil;
  BIO_int_ctrl: function(bp: PBIO; cmd: TIdC_INT; larg: TIdC_LONG; iarg: TIdC_INT): TIdC_LONG; cdecl = nil;
  BIO_push: function(b: PBIO; append: PBIO): PBIO; cdecl = nil;
  BIO_pop: function(b: PBIO): PBIO; cdecl = nil;
  BIO_free_all: procedure(a: PBIO); cdecl = nil;
  BIO_find_type: function(b: PBIO; bio_type: TIdC_INT): PBIO; cdecl = nil;
  BIO_next: function(b: PBIO): PBIO; cdecl = nil;
  BIO_set_next: procedure(b: PBIO; next: PBIO); cdecl = nil; {introduced 1.1.0}
  BIO_get_retry_BIO: function(bio: PBIO; reason: TIdC_INT): PBIO; cdecl = nil;
  BIO_get_retry_reason: function(bio: PBIO): TIdC_INT; cdecl = nil;
  BIO_set_retry_reason: procedure(bio: PBIO; reason: TIdC_INT); cdecl = nil; {introduced 1.1.0}
  BIO_dup_chain: function(in_: PBIO): PBIO; cdecl = nil;

  BIO_nread0: function(bio: PBIO; buf: PPIdAnsiChar): TIdC_INT; cdecl = nil;
  BIO_nread: function(bio: PBIO; buf: PPIdAnsiChar; num: TIdC_INT): TIdC_INT; cdecl = nil;
  BIO_nwrite0: function(bio: PBIO; buf: PPIdAnsiChar): TIdC_INT; cdecl = nil;
  BIO_nwrite: function(bio: PBIO; buf: PPIdAnsiChar; num: TIdC_INT): TIdC_INT; cdecl = nil;

  BIO_debug_callback: function(bio: PBIO; cmd: TIdC_INT; const argp: PIdAnsiChar; argi: TIdC_INT; argl: TIdC_LONG; ret: TIdC_LONG): TIdC_LONG; cdecl = nil;

  BIO_s_mem: function: PBIO_METHOD; cdecl = nil;
  BIO_s_secmem: function: PBIO_METHOD; cdecl = nil; {introduced 1.1.0}
  BIO_new_mem_buf: function(const buf: Pointer; len: TIdC_INT): PBIO; cdecl = nil;

  BIO_s_socket: function: PBIO_METHOD; cdecl = nil;
  BIO_s_connect: function: PBIO_METHOD; cdecl = nil;
  BIO_s_accept: function: PBIO_METHOD; cdecl = nil;

  BIO_s_fd: function: PBIO_METHOD; cdecl = nil;
  BIO_s_log: function: PBIO_METHOD; cdecl = nil;
  BIO_s_bio: function: PBIO_METHOD; cdecl = nil;
  BIO_s_null: function: PBIO_METHOD; cdecl = nil;
  BIO_f_null: function: PBIO_METHOD; cdecl = nil;
  BIO_f_buffer: function: PBIO_METHOD; cdecl = nil;
  BIO_f_linebuffer: function: PBIO_METHOD; cdecl = nil; {introduced 1.1.0}
  BIO_f_nbio_test: function: PBIO_METHOD; cdecl = nil;
  BIO_s_datagram: function: PBIO_METHOD; cdecl = nil;
  BIO_dgram_non_fatal_error: function(error: TIdC_INT): TIdC_INT; cdecl = nil;
  BIO_new_dgram: function(fd: TIdC_INT; close_flag: TIdC_INT): PBIO; cdecl = nil;

//  function BIO_s_datagram_sctp: PBIO_METHOD;
//  function BIO_new_dgram_sctp(fd: TIdC_INT; close_flag: TIdC_INT): PBIO;
//  function BIO_dgram_is_sctp(bio: PBIO): TIdC_INT;
//  function BIO_dgram_sctp_notification_cb(bio: PBIO; handle_notifications(PBIO;
//    context: Pointer;
//    buf: Pointer): TIdC_INT, Pointer context);
//  function BIO_dgram_sctp_wait_for_dry(b: PBIO): TIdC_INT;
//  function BIO_dgram_sctp_msg_waiting(b: PBIO): TIdC_INT;

  BIO_sock_should_retry: function(i: TIdC_INT): TIdC_INT; cdecl = nil;
  BIO_sock_non_fatal_error: function(error: TIdC_INT): TIdC_INT; cdecl = nil;

  BIO_fd_should_retry: function(i: TIdC_INT): TIdC_INT; cdecl = nil;
  BIO_fd_non_fatal_error: function(error: TIdC_INT): TIdC_INT; cdecl = nil;
//  function BIO_dump_cb(
//    Pointer data: cb(;
//    len: TIdC_SIZET;
//    function: Pointer): u: TIdC_INT, Pointer function ,  PIdAnsiChar s, TIdC_INT len): u;
//  function BIO_dump_indent_cb(TIdC_INT (cb( Pointer data, TIdC_SIZET len, Pointer function ): u: TIdC_INT, Pointer function ,  PIdAnsiChar s, TIdC_INT len, TIdC_INT indent): u;
  BIO_dump: function(b: PBIO; const bytes: PIdAnsiChar; len: TIdC_INT): TIdC_INT; cdecl = nil;
  BIO_dump_indent: function(b: PBIO; const bytes: PIdAnsiChar; len: TIdC_INT; indent: TIdC_INT): TIdC_INT; cdecl = nil;

//  function BIO_dump_fp(fp: cFile; const s: PByte; len: TIdC_INT): TIdC_INT;
//  function BIO_dump_indent_fp(fp: cFile; const s: PByte; len: TIdC_INT; indent: TIdC_INT): TIdC_INT;

  BIO_hex_string: function(out_: PBIO; indent: TIdC_INT; width: TIdC_INT; data: PByte; datalen: TIdC_INT): TIdC_INT; cdecl = nil;

  BIO_ADDR_new: function: PBIO_ADDR; cdecl = nil; {introduced 1.1.0}
  BIO_ADDR_rawmake: function(ap: PBIO_ADDR; familiy: TIdC_INT; const where: Pointer; wherelen: TIdC_SIZET; port: TIdC_SHORT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_ADDR_free: procedure(a: PBIO_ADDR); cdecl = nil; {introduced 1.1.0}
  BIO_ADDR_clear: procedure(ap: PBIO_ADDR); cdecl = nil; {introduced 1.1.0}
  BIO_ADDR_family: function(const ap: PBIO_ADDR): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_ADDR_rawaddress: function(const ap: PBIO_ADDR; p: Pointer; l: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_ADDR_rawport: function(const ap: PBIO_ADDR): TIdC_SHORT; cdecl = nil; {introduced 1.1.0}
  BIO_ADDR_hostname_string: function(const ap: PBIO_ADDR; numeric: TIdC_INT): PIdAnsiChar; cdecl = nil; {introduced 1.1.0}
  BIO_ADDR_service_string: function(const ap: PBIO_ADDR; numeric: TIdC_INT): PIdAnsiChar; cdecl = nil; {introduced 1.1.0}
  BIO_ADDR_path_string: function(const ap: PBIO_ADDR): PIdAnsiChar; cdecl = nil; {introduced 1.1.0}

  BIO_ADDRINFO_next: function(const bai: PBIO_ADDRINFO): PBIO_ADDRINFO; cdecl = nil; {introduced 1.1.0}
  BIO_ADDRINFO_family: function(const bai: PBIO_ADDRINFO): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_ADDRINFO_socktype: function(const bai: PBIO_ADDRINFO): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_ADDRINFO_protocol: function(const bai: PBIO_ADDRINFO): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_ADDRINFO_address: function(const bai: PBIO_ADDRINFO): PBIO_ADDR; cdecl = nil; {introduced 1.1.0}
  BIO_ADDRINFO_free: procedure(bai: PBIO_ADDRINFO); cdecl = nil; {introduced 1.1.0}

  BIO_parse_hostserv: function(const hostserv: PIdAnsiChar; host: PPIdAnsiChar; service: PPIdAnsiChar; hostserv_prio: BIO_hostserv_priorities): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  BIO_lookup: function(const host: PIdAnsiChar; const service: PIdAnsiChar; lookup_type: BIO_lookup_type; family: TIdC_INT; socktype: TIdC_INT; res: PPBIO_ADDRINFO): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_lookup_ex: function(const host: PIdAnsiChar; const service: PIdAnsiChar; lookup_type: TIdC_INT; family: TIdC_INT; socktype: TIdC_INT; protocol: TIdC_INT; res: PPBIO_ADDRINFO): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_sock_error: function(sock: TIdC_INT): TIdC_INT; cdecl = nil;
  BIO_socket_ioctl: function(fd: TIdC_INT; cType: TIdC_LONG; arg: Pointer): TIdC_INT; cdecl = nil;
  BIO_socket_nbio: function(fd: TIdC_INT; mode: TIdC_INT): TIdC_INT; cdecl = nil;
  BIO_sock_init: function: TIdC_INT; cdecl = nil;

  BIO_set_tcp_ndelay: function(sock: TIdC_INT; turn_on: TIdC_INT): TIdC_INT; cdecl = nil;

  BIO_sock_info: function(sock: TIdC_INT; type_: BIO_sock_info_type; info: PBIO_sock_info_u): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  BIO_socket: function(domain: TIdC_INT; socktype: TIdC_INT; protocol: TIdC_INT; options: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_connect: function(sock: TIdC_INT; const addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_bind: function(sock: TIdC_INT; const addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_listen: function(sock: TIdC_INT; const addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_accept_ex: function(accept_sock: TIdC_INT; addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  BIO_closesocket: function(sock: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  BIO_new_socket: function(sock: TIdC_INT; close_flag: TIdC_INT): PBIO; cdecl = nil;
  BIO_new_connect: function(const host_port: PIdAnsiChar): PBIO; cdecl = nil;
  BIO_new_accept: function(const host_port: PIdAnsiChar): PBIO; cdecl = nil;

  BIO_new_fd: function(fd: TIdC_INT; close_flag: TIdC_INT): PBIO; cdecl = nil;

  BIO_new_bio_pair: function(bio1: PPBIO; writebuf1: TIdC_SIZET; bio2: PPBIO; writebuf2: TIdC_SIZET): TIdC_INT; cdecl = nil;
  (*
   * If successful, returns 1 and in *bio1, *bio2 two BIO pair endpoints.
   * Otherwise returns 0 and sets *bio1 and *bio2 to NULL. Size 0 uses default
   * value.
   *)

  BIO_copy_next_retry: procedure(b: PBIO); cdecl = nil;

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

{$ELSE}

(* These are normally used internally in BIOs *)

(* These should be used by the application to tell why we should retry *)

(* BIO_s_accept() and BIO_s_connect() *)


  function BIO_get_new_index: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure BIO_set_flags(b: PBIO; flags: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_test_flags(const b: PBIO; flags: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure BIO_clear_flags(b: PBIO; flags: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_get_callback(b: PBIO): BIO_callback_fn cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure BIO_set_callback(b: PBIO; callback: BIO_callback_fn) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_get_callback_ex(b: PBIO): BIO_callback_fn_ex cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure BIO_set_callback_ex(b: PBIO; callback: BIO_callback_fn_ex) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function BIO_get_callback_arg(const b: PBIO): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure BIO_set_callback_arg(var b: PBIO; arg: PIdAnsiChar) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_method_name(const b: PBIO): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_method_type(const b: PBIO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

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
  function BIO_ctrl_pending(b: PBIO): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_ctrl_wpending(b: PBIO): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
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
  function BIO_ctrl_get_write_guarantee(b: PBIO): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_ctrl_get_read_request(b: PBIO): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_ctrl_reset_read_request(b: PBIO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

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

  function BIO_set_ex_data(bio: PBIO; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_get_ex_data(bio: PBIO; idx: TIdC_INT): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_number_read(bio: PBIO): TIdC_UINT64 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_number_written(bio: PBIO): TIdC_UINT64 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  (* For BIO_f_asn1() *)
//  function BIO_asn1_set_prefix(b: PBIO; prefix: ^asn1_ps_func; prefix_free: ^asn1_ps_func): TIdC_INT;
//  function BIO_asn1_get_prefix(b: PBIO; pprefix: ^^asn1_ps_func; pprefix_free: ^^asn1_ps_func): TIdC_INT;
//  function BIO_asn1_set_suffix(b: PBIO; suffix: ^asn1_ps_func; suffix_free: ^asn1_ps_func): TIdC_INT;
//  function BIO_asn1_get_suffix(b: PBIO; psuffix: ^asn1_ps_func; psuffix_free: ^^asn1_ps_func): TIdC_INT;

  function BIO_s_file: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_new_file(const filename: PIdAnsiChar; const mode: PIdAnsiChar): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
//  function BIO_new_fp(stream: cFile; close_flag: TIdC_INT): PBIO;
  function BIO_new(const cType: PBIO_METHOD): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_free(a: PBIO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure BIO_set_data(a: PBIO; ptr: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_get_data(a: PBIO): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure BIO_set_init(a: PBIO; init: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_get_init(a: PBIO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure BIO_set_shutdown(a: PBIO; shut: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_get_shutdown(a: PBIO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure BIO_vfree(a: PBIO) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_up_ref(a: PBIO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_read(b: PBIO; data: Pointer; dlen: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_read_ex(b: PBIO; data: Pointer; dlen: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_gets( bp: PBIO; buf: PIdAnsiChar; size: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_write(b: PBIO; const data: Pointer; dlen: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_write_ex(b: PBIO; const data: Pointer; dlen: TIdC_SIZET; written: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_puts(bp: PBIO; const buf: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_indent(b: PBIO; indent: TIdC_INT; max: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_ctrl(bp: PBIO; cmd: TIdC_INT; larg: TIdC_LONG; parg: Pointer): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_callback_ctrl(b: PBIO; cmd: TIdC_INT; fp: PBIO_info_cb): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_ptr_ctrl(bp: PBIO; cmd: TIdC_INT; larg: TIdC_LONG): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_int_ctrl(bp: PBIO; cmd: TIdC_INT; larg: TIdC_LONG; iarg: TIdC_INT): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_push(b: PBIO; append: PBIO): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_pop(b: PBIO): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure BIO_free_all(a: PBIO) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_find_type(b: PBIO; bio_type: TIdC_INT): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_next(b: PBIO): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure BIO_set_next(b: PBIO; next: PBIO) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_get_retry_BIO(bio: PBIO; reason: TIdC_INT): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_get_retry_reason(bio: PBIO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  procedure BIO_set_retry_reason(bio: PBIO; reason: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_dup_chain(in_: PBIO): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_nread0(bio: PBIO; buf: PPIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_nread(bio: PBIO; buf: PPIdAnsiChar; num: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_nwrite0(bio: PBIO; buf: PPIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_nwrite(bio: PBIO; buf: PPIdAnsiChar; num: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_debug_callback(bio: PBIO; cmd: TIdC_INT; const argp: PIdAnsiChar; argi: TIdC_INT; argl: TIdC_LONG; ret: TIdC_LONG): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_s_mem: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_s_secmem: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_new_mem_buf(const buf: Pointer; len: TIdC_INT): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_s_socket: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_s_connect: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_s_accept: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_s_fd: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_s_log: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_s_bio: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_s_null: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_f_null: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_f_buffer: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_f_linebuffer: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_f_nbio_test: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_s_datagram: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_dgram_non_fatal_error(error: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_new_dgram(fd: TIdC_INT; close_flag: TIdC_INT): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

//  function BIO_s_datagram_sctp: PBIO_METHOD;
//  function BIO_new_dgram_sctp(fd: TIdC_INT; close_flag: TIdC_INT): PBIO;
//  function BIO_dgram_is_sctp(bio: PBIO): TIdC_INT;
//  function BIO_dgram_sctp_notification_cb(bio: PBIO; handle_notifications(PBIO;
//    context: Pointer;
//    buf: Pointer): TIdC_INT, Pointer context);
//  function BIO_dgram_sctp_wait_for_dry(b: PBIO): TIdC_INT;
//  function BIO_dgram_sctp_msg_waiting(b: PBIO): TIdC_INT;

  function BIO_sock_should_retry(i: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_sock_non_fatal_error(error: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_fd_should_retry(i: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_fd_non_fatal_error(error: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
//  function BIO_dump_cb(
//    Pointer data: cb(;
//    len: TIdC_SIZET;
//    function: Pointer): u: TIdC_INT, Pointer function ,  PIdAnsiChar s, TIdC_INT len): u;
//  function BIO_dump_indent_cb(TIdC_INT (cb( Pointer data, TIdC_SIZET len, Pointer function ): u: TIdC_INT, Pointer function ,  PIdAnsiChar s, TIdC_INT len, TIdC_INT indent): u;
  function BIO_dump(b: PBIO; const bytes: PIdAnsiChar; len: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_dump_indent(b: PBIO; const bytes: PIdAnsiChar; len: TIdC_INT; indent: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

//  function BIO_dump_fp(fp: cFile; const s: PByte; len: TIdC_INT): TIdC_INT;
//  function BIO_dump_indent_fp(fp: cFile; const s: PByte; len: TIdC_INT; indent: TIdC_INT): TIdC_INT;

  function BIO_hex_string(out_: PBIO; indent: TIdC_INT; width: TIdC_INT; data: PByte; datalen: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_ADDR_new: PBIO_ADDR cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_ADDR_rawmake(ap: PBIO_ADDR; familiy: TIdC_INT; const where: Pointer; wherelen: TIdC_SIZET; port: TIdC_SHORT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure BIO_ADDR_free(a: PBIO_ADDR) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure BIO_ADDR_clear(ap: PBIO_ADDR) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_ADDR_family(const ap: PBIO_ADDR): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_ADDR_rawaddress(const ap: PBIO_ADDR; p: Pointer; l: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_ADDR_rawport(const ap: PBIO_ADDR): TIdC_SHORT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_ADDR_hostname_string(const ap: PBIO_ADDR; numeric: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_ADDR_service_string(const ap: PBIO_ADDR; numeric: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_ADDR_path_string(const ap: PBIO_ADDR): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function BIO_ADDRINFO_next(const bai: PBIO_ADDRINFO): PBIO_ADDRINFO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_ADDRINFO_family(const bai: PBIO_ADDRINFO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_ADDRINFO_socktype(const bai: PBIO_ADDRINFO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_ADDRINFO_protocol(const bai: PBIO_ADDRINFO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_ADDRINFO_address(const bai: PBIO_ADDRINFO): PBIO_ADDR cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  procedure BIO_ADDRINFO_free(bai: PBIO_ADDRINFO) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function BIO_parse_hostserv(const hostserv: PIdAnsiChar; host: PPIdAnsiChar; service: PPIdAnsiChar; hostserv_prio: BIO_hostserv_priorities): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function BIO_lookup(const host: PIdAnsiChar; const service: PIdAnsiChar; lookup_type: BIO_lookup_type; family: TIdC_INT; socktype: TIdC_INT; res: PPBIO_ADDRINFO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_lookup_ex(const host: PIdAnsiChar; const service: PIdAnsiChar; lookup_type: TIdC_INT; family: TIdC_INT; socktype: TIdC_INT; protocol: TIdC_INT; res: PPBIO_ADDRINFO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_sock_error(sock: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_socket_ioctl(fd: TIdC_INT; cType: TIdC_LONG; arg: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_socket_nbio(fd: TIdC_INT; mode: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_sock_init: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_set_tcp_ndelay(sock: TIdC_INT; turn_on: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_sock_info(sock: TIdC_INT; type_: BIO_sock_info_type; info: PBIO_sock_info_u): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function BIO_socket(domain: TIdC_INT; socktype: TIdC_INT; protocol: TIdC_INT; options: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_connect(sock: TIdC_INT; const addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_bind(sock: TIdC_INT; const addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_listen(sock: TIdC_INT; const addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_accept_ex(accept_sock: TIdC_INT; addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}
  function BIO_closesocket(sock: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF}; {introduced 1.1.0}

  function BIO_new_socket(sock: TIdC_INT; close_flag: TIdC_INT): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_new_connect(const host_port: PIdAnsiChar): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  function BIO_new_accept(const host_port: PIdAnsiChar): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_new_fd(fd: TIdC_INT; close_flag: TIdC_INT): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

  function BIO_new_bio_pair(bio1: PPBIO; writebuf1: TIdC_SIZET; bio2: PPBIO; writebuf2: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};
  (*
   * If successful, returns 1 and in *bio1, *bio2 two BIO pair endpoints.
   * Otherwise returns 0 and sets *bio1 and *bio2 to NULL. Size 0 uses default
   * value.
   *)

  procedure BIO_copy_next_retry(b: PBIO) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibCrypto{$ENDIF};

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

function BIO_get_flags(const b: PBIO): TIdC_INT; {removed 1.0.0}
procedure BIO_set_retry_special(b: PBIO); {removed 1.0.0}
procedure BIO_set_retry_read(b: PBIO); {removed 1.0.0}
procedure BIO_set_retry_write(b: PBIO); {removed 1.0.0}
procedure BIO_clear_retry_flags(b: PBIO); {removed 1.0.0}
function BIO_get_retry_flags(b: PBIO): TIdC_INT; {removed 1.0.0}
function BIO_should_read(b: PBIO): TIdC_INT; {removed 1.0.0}
function BIO_should_write(b: PBIO): TIdC_INT; {removed 1.0.0}
function BIO_should_io_special(b: PBIO): TIdC_INT; {removed 1.0.0}
function BIO_retry_type(b: PBIO): TIdC_INT; {removed 1.0.0}
function BIO_should_retry(b: PBIO): TIdC_INT; {removed 1.0.0}
function BIO_do_connect(b: PBIO): TIdC_LONG; {removed 1.0.0}
function BIO_do_accept(b: PBIO): TIdC_LONG; {removed 1.0.0}
function BIO_do_handshake(b: PBIO): TIdC_LONG; {removed 1.0.0}
function BIO_get_mem_data(b: PBIO; pp: PIdAnsiChar) : TIdC_INT; {removed 1.0.0}
function BIO_set_mem_buf(b: PBIO; bm: PIdAnsiChar; c: TIdC_INT): TIdC_INT; {removed 1.0.0}
function BIO_get_mem_ptr(b: PBIO; pp: PIdAnsiChar): TIdC_INT; {removed 1.0.0}
function BIO_set_mem_eof_return(b: PBIO; v: TIdC_INT): TIdC_INT; {removed 1.0.0}
{$ENDIF}

implementation

  {$IFNDEF USE_EXTERNAL_LIBRARY}
  uses
  classes, 
  IdSSLOpenSSLExceptionHandlers, 
  IdSSLOpenSSLLoader;
  {$ENDIF}
  
const
  BIO_get_new_index_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_get_callback_ex_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_set_callback_ex_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_set_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_get_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_set_init_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_get_init_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_set_shutdown_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_get_shutdown_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_up_ref_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_read_ex_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_write_ex_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_set_next_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_set_retry_reason_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_s_secmem_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_f_linebuffer_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDR_new_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDR_rawmake_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDR_free_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDR_clear_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDR_family_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDR_rawaddress_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDR_rawport_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDR_hostname_string_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDR_service_string_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDR_path_string_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDRINFO_next_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDRINFO_family_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDRINFO_socktype_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDRINFO_protocol_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDRINFO_address_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_ADDRINFO_free_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_parse_hostserv_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_lookup_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_lookup_ex_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_sock_info_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_socket_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_connect_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_bind_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_listen_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_accept_ex_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_closesocket_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  BIO_get_flags_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_set_retry_special_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_set_retry_read_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_set_retry_write_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_clear_retry_flags_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_get_retry_flags_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_should_read_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_should_write_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_should_io_special_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_retry_type_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_should_retry_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_do_connect_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_do_accept_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_do_handshake_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_get_mem_data_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_set_mem_buf_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_get_mem_ptr_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  BIO_set_mem_eof_return_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);

// # define BIO_get_flags(b) BIO_test_flags(b, ~(0x0))
{$IFNDEF USE_EXTERNAL_LIBRARY}

// # define BIO_get_flags(b) BIO_test_flags(b, ~(0x0))
function _BIO_get_flags(const b: PBIO): TIdC_INT; cdecl;
begin
  Result := BIO_test_flags(b, not $0);
end;

//# define BIO_set_retry_special(b) \
//                BIO_set_flags(b, (BIO_FLAGS_IO_SPECIAL|BIO_FLAGS_SHOULD_RETRY))
procedure _BIO_set_retry_special(b: PBIO); cdecl;
begin
  BIO_set_flags(b, BIO_FLAGS_IO_SPECIAL or BIO_FLAGS_SHOULD_RETRY);
end;

//# define BIO_set_retry_read(b) \
//                BIO_set_flags(b, (BIO_FLAGS_READ|BIO_FLAGS_SHOULD_RETRY))
procedure _BIO_set_retry_read(b: PBIO); cdecl;
begin
  BIO_set_flags(b, BIO_FLAGS_READ or BIO_FLAGS_SHOULD_RETRY);
end;

//# define BIO_set_retry_write(b) \
//                BIO_set_flags(b, (BIO_FLAGS_WRITE|BIO_FLAGS_SHOULD_RETRY))
procedure _BIO_set_retry_write(b: PBIO); cdecl;
begin
  BIO_set_flags(b, BIO_FLAGS_WRITE or BIO_FLAGS_SHOULD_RETRY);
end;

//# define BIO_clear_retry_flags(b) \
//                BIO_clear_flags(b, (BIO_FLAGS_RWS|BIO_FLAGS_SHOULD_RETRY))
procedure _BIO_clear_retry_flags(b: PBIO); cdecl;
begin
  BIO_clear_flags(b, BIO_FLAGS_RWS or BIO_FLAGS_SHOULD_RETRY);
end;

//# define BIO_get_retry_flags(b) \
//                BIO_test_flags(b, (BIO_FLAGS_RWS|BIO_FLAGS_SHOULD_RETRY))
function _BIO_get_retry_flags(b: PBIO): TIdC_INT; cdecl;
begin
  Result := BIO_test_flags(b, BIO_FLAGS_RWS or BIO_FLAGS_SHOULD_RETRY);
end;

//# define BIO_should_read(a)              BIO_test_flags(a, BIO_FLAGS_READ)
function _BIO_should_read(b: PBIO): TIdC_INT; cdecl;
begin
  Result := BIO_test_flags(b, BIO_FLAGS_READ);
end;

//# define BIO_should_write(a)             BIO_test_flags(a, BIO_FLAGS_WRITE)
function _BIO_should_write(b: PBIO): TIdC_INT; cdecl;
begin
  Result := BIO_test_flags(b, BIO_FLAGS_WRITE);
end;

//# define BIO_should_io_special(a)        BIO_test_flags(a, BIO_FLAGS_IO_SPECIAL)
function _BIO_should_io_special(b: PBIO): TIdC_INT; cdecl;
begin
  Result := BIO_test_flags(b, BIO_FLAGS_IO_SPECIAL);
end;

//# define BIO_retry_type(a)               BIO_test_flags(a, BIO_FLAGS_RWS)
function _BIO_retry_type(b: PBIO): TIdC_INT; cdecl;
begin
  Result := BIO_test_flags(b, BIO_FLAGS_RWS);
end;

//# define BIO_should_retry(a)             BIO_test_flags(a, BIO_FLAGS_SHOULD_RETRY)
function _BIO_should_retry(b: PBIO): TIdC_INT; cdecl;
begin
  Result := BIO_test_flags(b, BIO_FLAGS_SHOULD_RETRY);
end;

//#  define BIO_do_connect(b)       BIO_do_handshake(b)
function _BIO_do_connect(b: PBIO): TIdC_LONG; cdecl;
begin
  Result := BIO_do_handshake(b);
end;

//#  define BIO_do_accept(b)        BIO_do_handshake(b)
function _BIO_do_accept(b: PBIO): TIdC_LONG; cdecl;
begin
  Result := BIO_do_handshake(b);
end;

//# define BIO_do_handshake(b)     BIO_ctrl(b,BIO_C_DO_STATE_MACHINE,0,NULL)
function _BIO_do_handshake(b: PBIO): TIdC_LONG; cdecl;
begin
  Result := BIO_ctrl(b, BIO_C_DO_STATE_MACHINE, 0, nil);
end;

//# define BIO_get_mem_data(b,pp)  BIO_ctrl(b,BIO_CTRL_INFO,0,(char (pp))
function _BIO_get_mem_data(b: PBIO; pp: PIdAnsiChar) : TIdC_INT; cdecl;
begin
  Result := BIO_ctrl(b, BIO_CTRL_INFO, 0, pp);
end;

//# define BIO_set_mem_buf(b,bm,c) BIO_ctrl(b,BIO_C_SET_BUF_MEM,c,(char (bm))
function _BIO_set_mem_buf(b: PBIO; bm: PIdAnsiChar; c: TIdC_INT): TIdC_INT; cdecl;
begin
  Result := BIO_ctrl(b, BIO_C_SET_BUF_MEM, c, bm);
end;

//# define BIO_get_mem_ptr(b,pp)   BIO_ctrl(b,BIO_C_GET_BUF_MEM_PTR,0,(char (pp))
function _BIO_get_mem_ptr(b: PBIO; pp: PIdAnsiChar): TIdC_INT; cdecl;
begin
  Result := BIO_ctrl(b, BIO_C_GET_BUF_MEM_PTR, 0, pp);
end;

//# define BIO_set_mem_eof_return(b,v) BIO_ctrl(b,BIO_C_SET_BUF_MEM_EOF_RETURN,v,0)
function _BIO_set_mem_eof_return(b: PBIO; v: TIdC_INT): TIdC_INT; cdecl;
begin
  Result := BIO_ctrl(b, BIO_C_SET_BUF_MEM_EOF_RETURN, v, nil);
end;

{$WARN  NO_RETVAL OFF}
function ERR_BIO_get_flags(const b: PBIO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_get_flags');
end;


procedure ERR_BIO_set_retry_special(b: PBIO); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_set_retry_special');
end;


procedure ERR_BIO_set_retry_read(b: PBIO); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_set_retry_read');
end;


procedure ERR_BIO_set_retry_write(b: PBIO); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_set_retry_write');
end;


procedure ERR_BIO_clear_retry_flags(b: PBIO); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_clear_retry_flags');
end;


function ERR_BIO_get_retry_flags(b: PBIO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_get_retry_flags');
end;


function ERR_BIO_should_read(b: PBIO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_should_read');
end;


function ERR_BIO_should_write(b: PBIO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_should_write');
end;


function ERR_BIO_should_io_special(b: PBIO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_should_io_special');
end;


function ERR_BIO_retry_type(b: PBIO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_retry_type');
end;


function ERR_BIO_should_retry(b: PBIO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_should_retry');
end;


function ERR_BIO_do_connect(b: PBIO): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_do_connect');
end;


function ERR_BIO_do_accept(b: PBIO): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_do_accept');
end;


function ERR_BIO_do_handshake(b: PBIO): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_do_handshake');
end;


function ERR_BIO_get_mem_data(b: PBIO; pp: PIdAnsiChar) : TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_get_mem_data');
end;


function ERR_BIO_set_mem_buf(b: PBIO; bm: PIdAnsiChar; c: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_set_mem_buf');
end;


function ERR_BIO_get_mem_ptr(b: PBIO; pp: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_get_mem_ptr');
end;


function ERR_BIO_set_mem_eof_return(b: PBIO; v: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_set_mem_eof_return');
end;


function ERR_BIO_get_new_index: TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_get_new_index');
end;


function ERR_BIO_get_callback_ex(b: PBIO): BIO_callback_fn_ex; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_get_callback_ex');
end;


procedure ERR_BIO_set_callback_ex(b: PBIO; callback: BIO_callback_fn_ex); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_set_callback_ex');
end;


procedure ERR_BIO_set_data(a: PBIO; ptr: Pointer); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_set_data');
end;


function ERR_BIO_get_data(a: PBIO): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_get_data');
end;


procedure ERR_BIO_set_init(a: PBIO; init: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_set_init');
end;


function ERR_BIO_get_init(a: PBIO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_get_init');
end;


procedure ERR_BIO_set_shutdown(a: PBIO; shut: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_set_shutdown');
end;


function ERR_BIO_get_shutdown(a: PBIO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_get_shutdown');
end;


function ERR_BIO_up_ref(a: PBIO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_up_ref');
end;


function ERR_BIO_read_ex(b: PBIO; data: Pointer; dlen: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_read_ex');
end;


function ERR_BIO_write_ex(b: PBIO; const data: Pointer; dlen: TIdC_SIZET; written: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_write_ex');
end;


procedure ERR_BIO_set_next(b: PBIO; next: PBIO); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_set_next');
end;


procedure ERR_BIO_set_retry_reason(bio: PBIO; reason: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_set_retry_reason');
end;


function ERR_BIO_s_secmem: PBIO_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_s_secmem');
end;


function ERR_BIO_f_linebuffer: PBIO_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_f_linebuffer');
end;


function ERR_BIO_ADDR_new: PBIO_ADDR; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDR_new');
end;


function ERR_BIO_ADDR_rawmake(ap: PBIO_ADDR; familiy: TIdC_INT; const where: Pointer; wherelen: TIdC_SIZET; port: TIdC_SHORT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDR_rawmake');
end;


procedure ERR_BIO_ADDR_free(a: PBIO_ADDR); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDR_free');
end;


procedure ERR_BIO_ADDR_clear(ap: PBIO_ADDR); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDR_clear');
end;


function ERR_BIO_ADDR_family(const ap: PBIO_ADDR): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDR_family');
end;


function ERR_BIO_ADDR_rawaddress(const ap: PBIO_ADDR; p: Pointer; l: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDR_rawaddress');
end;


function ERR_BIO_ADDR_rawport(const ap: PBIO_ADDR): TIdC_SHORT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDR_rawport');
end;


function ERR_BIO_ADDR_hostname_string(const ap: PBIO_ADDR; numeric: TIdC_INT): PIdAnsiChar; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDR_hostname_string');
end;


function ERR_BIO_ADDR_service_string(const ap: PBIO_ADDR; numeric: TIdC_INT): PIdAnsiChar; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDR_service_string');
end;


function ERR_BIO_ADDR_path_string(const ap: PBIO_ADDR): PIdAnsiChar; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDR_path_string');
end;


function ERR_BIO_ADDRINFO_next(const bai: PBIO_ADDRINFO): PBIO_ADDRINFO; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDRINFO_next');
end;


function ERR_BIO_ADDRINFO_family(const bai: PBIO_ADDRINFO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDRINFO_family');
end;


function ERR_BIO_ADDRINFO_socktype(const bai: PBIO_ADDRINFO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDRINFO_socktype');
end;


function ERR_BIO_ADDRINFO_protocol(const bai: PBIO_ADDRINFO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDRINFO_protocol');
end;


function ERR_BIO_ADDRINFO_address(const bai: PBIO_ADDRINFO): PBIO_ADDR; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDRINFO_address');
end;


procedure ERR_BIO_ADDRINFO_free(bai: PBIO_ADDRINFO); 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_ADDRINFO_free');
end;


function ERR_BIO_parse_hostserv(const hostserv: PIdAnsiChar; host: PPIdAnsiChar; service: PPIdAnsiChar; hostserv_prio: BIO_hostserv_priorities): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_parse_hostserv');
end;


function ERR_BIO_lookup(const host: PIdAnsiChar; const service: PIdAnsiChar; lookup_type: BIO_lookup_type; family: TIdC_INT; socktype: TIdC_INT; res: PPBIO_ADDRINFO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_lookup');
end;


function ERR_BIO_lookup_ex(const host: PIdAnsiChar; const service: PIdAnsiChar; lookup_type: TIdC_INT; family: TIdC_INT; socktype: TIdC_INT; protocol: TIdC_INT; res: PPBIO_ADDRINFO): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_lookup_ex');
end;


function ERR_BIO_sock_info(sock: TIdC_INT; type_: BIO_sock_info_type; info: PBIO_sock_info_u): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_sock_info');
end;


function ERR_BIO_socket(domain: TIdC_INT; socktype: TIdC_INT; protocol: TIdC_INT; options: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_socket');
end;


function ERR_BIO_connect(sock: TIdC_INT; const addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_connect');
end;


function ERR_BIO_bind(sock: TIdC_INT; const addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_bind');
end;


function ERR_BIO_listen(sock: TIdC_INT; const addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_listen');
end;


function ERR_BIO_accept_ex(accept_sock: TIdC_INT; addr: PBIO_ADDR; options: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_accept_ex');
end;


function ERR_BIO_closesocket(sock: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('BIO_closesocket');
end;


{$WARN  NO_RETVAL ON}

procedure Load(const ADllHandle: TIdLibHandle; LibVersion: TIdC_UINT; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) and Assigned(AFailed) then
      AFailed.Add(AMethodName);
  end;

begin
  BIO_set_flags := LoadFunction('BIO_set_flags',AFailed);
  BIO_test_flags := LoadFunction('BIO_test_flags',AFailed);
  BIO_clear_flags := LoadFunction('BIO_clear_flags',AFailed);
  BIO_get_callback := LoadFunction('BIO_get_callback',AFailed);
  BIO_set_callback := LoadFunction('BIO_set_callback',AFailed);
  BIO_get_callback_arg := LoadFunction('BIO_get_callback_arg',AFailed);
  BIO_set_callback_arg := LoadFunction('BIO_set_callback_arg',AFailed);
  BIO_method_name := LoadFunction('BIO_method_name',AFailed);
  BIO_method_type := LoadFunction('BIO_method_type',AFailed);
  BIO_ctrl_pending := LoadFunction('BIO_ctrl_pending',AFailed);
  BIO_ctrl_wpending := LoadFunction('BIO_ctrl_wpending',AFailed);
  BIO_ctrl_get_write_guarantee := LoadFunction('BIO_ctrl_get_write_guarantee',AFailed);
  BIO_ctrl_get_read_request := LoadFunction('BIO_ctrl_get_read_request',AFailed);
  BIO_ctrl_reset_read_request := LoadFunction('BIO_ctrl_reset_read_request',AFailed);
  BIO_set_ex_data := LoadFunction('BIO_set_ex_data',AFailed);
  BIO_get_ex_data := LoadFunction('BIO_get_ex_data',AFailed);
  BIO_number_read := LoadFunction('BIO_number_read',AFailed);
  BIO_number_written := LoadFunction('BIO_number_written',AFailed);
  BIO_s_file := LoadFunction('BIO_s_file',AFailed);
  BIO_new_file := LoadFunction('BIO_new_file',AFailed);
  BIO_new := LoadFunction('BIO_new',AFailed);
  BIO_free := LoadFunction('BIO_free',AFailed);
  BIO_vfree := LoadFunction('BIO_vfree',AFailed);
  BIO_read := LoadFunction('BIO_read',AFailed);
  BIO_gets := LoadFunction('BIO_gets',AFailed);
  BIO_write := LoadFunction('BIO_write',AFailed);
  BIO_puts := LoadFunction('BIO_puts',AFailed);
  BIO_indent := LoadFunction('BIO_indent',AFailed);
  BIO_ctrl := LoadFunction('BIO_ctrl',AFailed);
  BIO_callback_ctrl := LoadFunction('BIO_callback_ctrl',AFailed);
  BIO_ptr_ctrl := LoadFunction('BIO_ptr_ctrl',AFailed);
  BIO_int_ctrl := LoadFunction('BIO_int_ctrl',AFailed);
  BIO_push := LoadFunction('BIO_push',AFailed);
  BIO_pop := LoadFunction('BIO_pop',AFailed);
  BIO_free_all := LoadFunction('BIO_free_all',AFailed);
  BIO_find_type := LoadFunction('BIO_find_type',AFailed);
  BIO_next := LoadFunction('BIO_next',AFailed);
  BIO_get_retry_BIO := LoadFunction('BIO_get_retry_BIO',AFailed);
  BIO_get_retry_reason := LoadFunction('BIO_get_retry_reason',AFailed);
  BIO_dup_chain := LoadFunction('BIO_dup_chain',AFailed);
  BIO_nread0 := LoadFunction('BIO_nread0',AFailed);
  BIO_nread := LoadFunction('BIO_nread',AFailed);
  BIO_nwrite0 := LoadFunction('BIO_nwrite0',AFailed);
  BIO_nwrite := LoadFunction('BIO_nwrite',AFailed);
  BIO_debug_callback := LoadFunction('BIO_debug_callback',AFailed);
  BIO_s_mem := LoadFunction('BIO_s_mem',AFailed);
  BIO_new_mem_buf := LoadFunction('BIO_new_mem_buf',AFailed);
  BIO_s_socket := LoadFunction('BIO_s_socket',AFailed);
  BIO_s_connect := LoadFunction('BIO_s_connect',AFailed);
  BIO_s_accept := LoadFunction('BIO_s_accept',AFailed);
  BIO_s_fd := LoadFunction('BIO_s_fd',AFailed);
  BIO_s_log := LoadFunction('BIO_s_log',AFailed);
  BIO_s_bio := LoadFunction('BIO_s_bio',AFailed);
  BIO_s_null := LoadFunction('BIO_s_null',AFailed);
  BIO_f_null := LoadFunction('BIO_f_null',AFailed);
  BIO_f_buffer := LoadFunction('BIO_f_buffer',AFailed);
  BIO_f_nbio_test := LoadFunction('BIO_f_nbio_test',AFailed);
  BIO_s_datagram := LoadFunction('BIO_s_datagram',AFailed);
  BIO_dgram_non_fatal_error := LoadFunction('BIO_dgram_non_fatal_error',AFailed);
  BIO_new_dgram := LoadFunction('BIO_new_dgram',AFailed);
  BIO_sock_should_retry := LoadFunction('BIO_sock_should_retry',AFailed);
  BIO_sock_non_fatal_error := LoadFunction('BIO_sock_non_fatal_error',AFailed);
  BIO_fd_should_retry := LoadFunction('BIO_fd_should_retry',AFailed);
  BIO_fd_non_fatal_error := LoadFunction('BIO_fd_non_fatal_error',AFailed);
  BIO_dump := LoadFunction('BIO_dump',AFailed);
  BIO_dump_indent := LoadFunction('BIO_dump_indent',AFailed);
  BIO_hex_string := LoadFunction('BIO_hex_string',AFailed);
  BIO_sock_error := LoadFunction('BIO_sock_error',AFailed);
  BIO_socket_ioctl := LoadFunction('BIO_socket_ioctl',AFailed);
  BIO_socket_nbio := LoadFunction('BIO_socket_nbio',AFailed);
  BIO_sock_init := LoadFunction('BIO_sock_init',AFailed);
  BIO_set_tcp_ndelay := LoadFunction('BIO_set_tcp_ndelay',AFailed);
  BIO_new_socket := LoadFunction('BIO_new_socket',AFailed);
  BIO_new_connect := LoadFunction('BIO_new_connect',AFailed);
  BIO_new_accept := LoadFunction('BIO_new_accept',AFailed);
  BIO_new_fd := LoadFunction('BIO_new_fd',AFailed);
  BIO_new_bio_pair := LoadFunction('BIO_new_bio_pair',AFailed);
  BIO_copy_next_retry := LoadFunction('BIO_copy_next_retry',AFailed);
  BIO_get_flags := LoadFunction('BIO_get_flags',nil); {removed 1.0.0}
  BIO_set_retry_special := LoadFunction('BIO_set_retry_special',nil); {removed 1.0.0}
  BIO_set_retry_read := LoadFunction('BIO_set_retry_read',nil); {removed 1.0.0}
  BIO_set_retry_write := LoadFunction('BIO_set_retry_write',nil); {removed 1.0.0}
  BIO_clear_retry_flags := LoadFunction('BIO_clear_retry_flags',nil); {removed 1.0.0}
  BIO_get_retry_flags := LoadFunction('BIO_get_retry_flags',nil); {removed 1.0.0}
  BIO_should_read := LoadFunction('BIO_should_read',nil); {removed 1.0.0}
  BIO_should_write := LoadFunction('BIO_should_write',nil); {removed 1.0.0}
  BIO_should_io_special := LoadFunction('BIO_should_io_special',nil); {removed 1.0.0}
  BIO_retry_type := LoadFunction('BIO_retry_type',nil); {removed 1.0.0}
  BIO_should_retry := LoadFunction('BIO_should_retry',nil); {removed 1.0.0}
  BIO_do_connect := LoadFunction('BIO_do_connect',nil); {removed 1.0.0}
  BIO_do_accept := LoadFunction('BIO_do_accept',nil); {removed 1.0.0}
  BIO_do_handshake := LoadFunction('BIO_do_handshake',nil); {removed 1.0.0}
  BIO_get_mem_data := LoadFunction('BIO_get_mem_data',nil); {removed 1.0.0}
  BIO_set_mem_buf := LoadFunction('BIO_set_mem_buf',nil); {removed 1.0.0}
  BIO_get_mem_ptr := LoadFunction('BIO_get_mem_ptr',nil); {removed 1.0.0}
  BIO_set_mem_eof_return := LoadFunction('BIO_set_mem_eof_return',nil); {removed 1.0.0}
  BIO_get_new_index := LoadFunction('BIO_get_new_index',nil); {introduced 1.1.0}
  BIO_get_callback_ex := LoadFunction('BIO_get_callback_ex',nil); {introduced 1.1.0}
  BIO_set_callback_ex := LoadFunction('BIO_set_callback_ex',nil); {introduced 1.1.0}
  BIO_set_data := LoadFunction('BIO_set_data',nil); {introduced 1.1.0}
  BIO_get_data := LoadFunction('BIO_get_data',nil); {introduced 1.1.0}
  BIO_set_init := LoadFunction('BIO_set_init',nil); {introduced 1.1.0}
  BIO_get_init := LoadFunction('BIO_get_init',nil); {introduced 1.1.0}
  BIO_set_shutdown := LoadFunction('BIO_set_shutdown',nil); {introduced 1.1.0}
  BIO_get_shutdown := LoadFunction('BIO_get_shutdown',nil); {introduced 1.1.0}
  BIO_up_ref := LoadFunction('BIO_up_ref',nil); {introduced 1.1.0}
  BIO_read_ex := LoadFunction('BIO_read_ex',nil); {introduced 1.1.0}
  BIO_write_ex := LoadFunction('BIO_write_ex',nil); {introduced 1.1.0}
  BIO_set_next := LoadFunction('BIO_set_next',nil); {introduced 1.1.0}
  BIO_set_retry_reason := LoadFunction('BIO_set_retry_reason',nil); {introduced 1.1.0}
  BIO_s_secmem := LoadFunction('BIO_s_secmem',nil); {introduced 1.1.0}
  BIO_f_linebuffer := LoadFunction('BIO_f_linebuffer',nil); {introduced 1.1.0}
  BIO_ADDR_new := LoadFunction('BIO_ADDR_new',nil); {introduced 1.1.0}
  BIO_ADDR_rawmake := LoadFunction('BIO_ADDR_rawmake',nil); {introduced 1.1.0}
  BIO_ADDR_free := LoadFunction('BIO_ADDR_free',nil); {introduced 1.1.0}
  BIO_ADDR_clear := LoadFunction('BIO_ADDR_clear',nil); {introduced 1.1.0}
  BIO_ADDR_family := LoadFunction('BIO_ADDR_family',nil); {introduced 1.1.0}
  BIO_ADDR_rawaddress := LoadFunction('BIO_ADDR_rawaddress',nil); {introduced 1.1.0}
  BIO_ADDR_rawport := LoadFunction('BIO_ADDR_rawport',nil); {introduced 1.1.0}
  BIO_ADDR_hostname_string := LoadFunction('BIO_ADDR_hostname_string',nil); {introduced 1.1.0}
  BIO_ADDR_service_string := LoadFunction('BIO_ADDR_service_string',nil); {introduced 1.1.0}
  BIO_ADDR_path_string := LoadFunction('BIO_ADDR_path_string',nil); {introduced 1.1.0}
  BIO_ADDRINFO_next := LoadFunction('BIO_ADDRINFO_next',nil); {introduced 1.1.0}
  BIO_ADDRINFO_family := LoadFunction('BIO_ADDRINFO_family',nil); {introduced 1.1.0}
  BIO_ADDRINFO_socktype := LoadFunction('BIO_ADDRINFO_socktype',nil); {introduced 1.1.0}
  BIO_ADDRINFO_protocol := LoadFunction('BIO_ADDRINFO_protocol',nil); {introduced 1.1.0}
  BIO_ADDRINFO_address := LoadFunction('BIO_ADDRINFO_address',nil); {introduced 1.1.0}
  BIO_ADDRINFO_free := LoadFunction('BIO_ADDRINFO_free',nil); {introduced 1.1.0}
  BIO_parse_hostserv := LoadFunction('BIO_parse_hostserv',nil); {introduced 1.1.0}
  BIO_lookup := LoadFunction('BIO_lookup',nil); {introduced 1.1.0}
  BIO_lookup_ex := LoadFunction('BIO_lookup_ex',nil); {introduced 1.1.0}
  BIO_sock_info := LoadFunction('BIO_sock_info',nil); {introduced 1.1.0}
  BIO_socket := LoadFunction('BIO_socket',nil); {introduced 1.1.0}
  BIO_connect := LoadFunction('BIO_connect',nil); {introduced 1.1.0}
  BIO_bind := LoadFunction('BIO_bind',nil); {introduced 1.1.0}
  BIO_listen := LoadFunction('BIO_listen',nil); {introduced 1.1.0}
  BIO_accept_ex := LoadFunction('BIO_accept_ex',nil); {introduced 1.1.0}
  BIO_closesocket := LoadFunction('BIO_closesocket',nil); {introduced 1.1.0}
  if not assigned(BIO_get_flags) then 
  begin
    {$if declared(BIO_get_flags_introduced)}
    if LibVersion < BIO_get_flags_introduced then
      {$if declared(FC_BIO_get_flags)}
      BIO_get_flags := @FC_BIO_get_flags
      {$else}
      BIO_get_flags := @ERR_BIO_get_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_get_flags_removed)}
   if BIO_get_flags_removed <= LibVersion then
     {$if declared(_BIO_get_flags)}
     BIO_get_flags := @_BIO_get_flags
     {$else}
       {$IF declared(ERR_BIO_get_flags)}
       BIO_get_flags := @ERR_BIO_get_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_get_flags) and Assigned(AFailed) then 
     AFailed.Add('BIO_get_flags');
  end;


  if not assigned(BIO_set_retry_special) then 
  begin
    {$if declared(BIO_set_retry_special_introduced)}
    if LibVersion < BIO_set_retry_special_introduced then
      {$if declared(FC_BIO_set_retry_special)}
      BIO_set_retry_special := @FC_BIO_set_retry_special
      {$else}
      BIO_set_retry_special := @ERR_BIO_set_retry_special
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_set_retry_special_removed)}
   if BIO_set_retry_special_removed <= LibVersion then
     {$if declared(_BIO_set_retry_special)}
     BIO_set_retry_special := @_BIO_set_retry_special
     {$else}
       {$IF declared(ERR_BIO_set_retry_special)}
       BIO_set_retry_special := @ERR_BIO_set_retry_special
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_set_retry_special) and Assigned(AFailed) then 
     AFailed.Add('BIO_set_retry_special');
  end;


  if not assigned(BIO_set_retry_read) then 
  begin
    {$if declared(BIO_set_retry_read_introduced)}
    if LibVersion < BIO_set_retry_read_introduced then
      {$if declared(FC_BIO_set_retry_read)}
      BIO_set_retry_read := @FC_BIO_set_retry_read
      {$else}
      BIO_set_retry_read := @ERR_BIO_set_retry_read
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_set_retry_read_removed)}
   if BIO_set_retry_read_removed <= LibVersion then
     {$if declared(_BIO_set_retry_read)}
     BIO_set_retry_read := @_BIO_set_retry_read
     {$else}
       {$IF declared(ERR_BIO_set_retry_read)}
       BIO_set_retry_read := @ERR_BIO_set_retry_read
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_set_retry_read) and Assigned(AFailed) then 
     AFailed.Add('BIO_set_retry_read');
  end;


  if not assigned(BIO_set_retry_write) then 
  begin
    {$if declared(BIO_set_retry_write_introduced)}
    if LibVersion < BIO_set_retry_write_introduced then
      {$if declared(FC_BIO_set_retry_write)}
      BIO_set_retry_write := @FC_BIO_set_retry_write
      {$else}
      BIO_set_retry_write := @ERR_BIO_set_retry_write
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_set_retry_write_removed)}
   if BIO_set_retry_write_removed <= LibVersion then
     {$if declared(_BIO_set_retry_write)}
     BIO_set_retry_write := @_BIO_set_retry_write
     {$else}
       {$IF declared(ERR_BIO_set_retry_write)}
       BIO_set_retry_write := @ERR_BIO_set_retry_write
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_set_retry_write) and Assigned(AFailed) then 
     AFailed.Add('BIO_set_retry_write');
  end;


  if not assigned(BIO_clear_retry_flags) then 
  begin
    {$if declared(BIO_clear_retry_flags_introduced)}
    if LibVersion < BIO_clear_retry_flags_introduced then
      {$if declared(FC_BIO_clear_retry_flags)}
      BIO_clear_retry_flags := @FC_BIO_clear_retry_flags
      {$else}
      BIO_clear_retry_flags := @ERR_BIO_clear_retry_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_clear_retry_flags_removed)}
   if BIO_clear_retry_flags_removed <= LibVersion then
     {$if declared(_BIO_clear_retry_flags)}
     BIO_clear_retry_flags := @_BIO_clear_retry_flags
     {$else}
       {$IF declared(ERR_BIO_clear_retry_flags)}
       BIO_clear_retry_flags := @ERR_BIO_clear_retry_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_clear_retry_flags) and Assigned(AFailed) then 
     AFailed.Add('BIO_clear_retry_flags');
  end;


  if not assigned(BIO_get_retry_flags) then 
  begin
    {$if declared(BIO_get_retry_flags_introduced)}
    if LibVersion < BIO_get_retry_flags_introduced then
      {$if declared(FC_BIO_get_retry_flags)}
      BIO_get_retry_flags := @FC_BIO_get_retry_flags
      {$else}
      BIO_get_retry_flags := @ERR_BIO_get_retry_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_get_retry_flags_removed)}
   if BIO_get_retry_flags_removed <= LibVersion then
     {$if declared(_BIO_get_retry_flags)}
     BIO_get_retry_flags := @_BIO_get_retry_flags
     {$else}
       {$IF declared(ERR_BIO_get_retry_flags)}
       BIO_get_retry_flags := @ERR_BIO_get_retry_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_get_retry_flags) and Assigned(AFailed) then 
     AFailed.Add('BIO_get_retry_flags');
  end;


  if not assigned(BIO_should_read) then 
  begin
    {$if declared(BIO_should_read_introduced)}
    if LibVersion < BIO_should_read_introduced then
      {$if declared(FC_BIO_should_read)}
      BIO_should_read := @FC_BIO_should_read
      {$else}
      BIO_should_read := @ERR_BIO_should_read
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_should_read_removed)}
   if BIO_should_read_removed <= LibVersion then
     {$if declared(_BIO_should_read)}
     BIO_should_read := @_BIO_should_read
     {$else}
       {$IF declared(ERR_BIO_should_read)}
       BIO_should_read := @ERR_BIO_should_read
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_should_read) and Assigned(AFailed) then 
     AFailed.Add('BIO_should_read');
  end;


  if not assigned(BIO_should_write) then 
  begin
    {$if declared(BIO_should_write_introduced)}
    if LibVersion < BIO_should_write_introduced then
      {$if declared(FC_BIO_should_write)}
      BIO_should_write := @FC_BIO_should_write
      {$else}
      BIO_should_write := @ERR_BIO_should_write
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_should_write_removed)}
   if BIO_should_write_removed <= LibVersion then
     {$if declared(_BIO_should_write)}
     BIO_should_write := @_BIO_should_write
     {$else}
       {$IF declared(ERR_BIO_should_write)}
       BIO_should_write := @ERR_BIO_should_write
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_should_write) and Assigned(AFailed) then 
     AFailed.Add('BIO_should_write');
  end;


  if not assigned(BIO_should_io_special) then 
  begin
    {$if declared(BIO_should_io_special_introduced)}
    if LibVersion < BIO_should_io_special_introduced then
      {$if declared(FC_BIO_should_io_special)}
      BIO_should_io_special := @FC_BIO_should_io_special
      {$else}
      BIO_should_io_special := @ERR_BIO_should_io_special
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_should_io_special_removed)}
   if BIO_should_io_special_removed <= LibVersion then
     {$if declared(_BIO_should_io_special)}
     BIO_should_io_special := @_BIO_should_io_special
     {$else}
       {$IF declared(ERR_BIO_should_io_special)}
       BIO_should_io_special := @ERR_BIO_should_io_special
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_should_io_special) and Assigned(AFailed) then 
     AFailed.Add('BIO_should_io_special');
  end;


  if not assigned(BIO_retry_type) then 
  begin
    {$if declared(BIO_retry_type_introduced)}
    if LibVersion < BIO_retry_type_introduced then
      {$if declared(FC_BIO_retry_type)}
      BIO_retry_type := @FC_BIO_retry_type
      {$else}
      BIO_retry_type := @ERR_BIO_retry_type
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_retry_type_removed)}
   if BIO_retry_type_removed <= LibVersion then
     {$if declared(_BIO_retry_type)}
     BIO_retry_type := @_BIO_retry_type
     {$else}
       {$IF declared(ERR_BIO_retry_type)}
       BIO_retry_type := @ERR_BIO_retry_type
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_retry_type) and Assigned(AFailed) then 
     AFailed.Add('BIO_retry_type');
  end;


  if not assigned(BIO_should_retry) then 
  begin
    {$if declared(BIO_should_retry_introduced)}
    if LibVersion < BIO_should_retry_introduced then
      {$if declared(FC_BIO_should_retry)}
      BIO_should_retry := @FC_BIO_should_retry
      {$else}
      BIO_should_retry := @ERR_BIO_should_retry
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_should_retry_removed)}
   if BIO_should_retry_removed <= LibVersion then
     {$if declared(_BIO_should_retry)}
     BIO_should_retry := @_BIO_should_retry
     {$else}
       {$IF declared(ERR_BIO_should_retry)}
       BIO_should_retry := @ERR_BIO_should_retry
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_should_retry) and Assigned(AFailed) then 
     AFailed.Add('BIO_should_retry');
  end;


  if not assigned(BIO_do_connect) then 
  begin
    {$if declared(BIO_do_connect_introduced)}
    if LibVersion < BIO_do_connect_introduced then
      {$if declared(FC_BIO_do_connect)}
      BIO_do_connect := @FC_BIO_do_connect
      {$else}
      BIO_do_connect := @ERR_BIO_do_connect
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_do_connect_removed)}
   if BIO_do_connect_removed <= LibVersion then
     {$if declared(_BIO_do_connect)}
     BIO_do_connect := @_BIO_do_connect
     {$else}
       {$IF declared(ERR_BIO_do_connect)}
       BIO_do_connect := @ERR_BIO_do_connect
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_do_connect) and Assigned(AFailed) then 
     AFailed.Add('BIO_do_connect');
  end;


  if not assigned(BIO_do_accept) then 
  begin
    {$if declared(BIO_do_accept_introduced)}
    if LibVersion < BIO_do_accept_introduced then
      {$if declared(FC_BIO_do_accept)}
      BIO_do_accept := @FC_BIO_do_accept
      {$else}
      BIO_do_accept := @ERR_BIO_do_accept
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_do_accept_removed)}
   if BIO_do_accept_removed <= LibVersion then
     {$if declared(_BIO_do_accept)}
     BIO_do_accept := @_BIO_do_accept
     {$else}
       {$IF declared(ERR_BIO_do_accept)}
       BIO_do_accept := @ERR_BIO_do_accept
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_do_accept) and Assigned(AFailed) then 
     AFailed.Add('BIO_do_accept');
  end;


  if not assigned(BIO_do_handshake) then 
  begin
    {$if declared(BIO_do_handshake_introduced)}
    if LibVersion < BIO_do_handshake_introduced then
      {$if declared(FC_BIO_do_handshake)}
      BIO_do_handshake := @FC_BIO_do_handshake
      {$else}
      BIO_do_handshake := @ERR_BIO_do_handshake
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_do_handshake_removed)}
   if BIO_do_handshake_removed <= LibVersion then
     {$if declared(_BIO_do_handshake)}
     BIO_do_handshake := @_BIO_do_handshake
     {$else}
       {$IF declared(ERR_BIO_do_handshake)}
       BIO_do_handshake := @ERR_BIO_do_handshake
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_do_handshake) and Assigned(AFailed) then 
     AFailed.Add('BIO_do_handshake');
  end;


  if not assigned(BIO_get_mem_data) then 
  begin
    {$if declared(BIO_get_mem_data_introduced)}
    if LibVersion < BIO_get_mem_data_introduced then
      {$if declared(FC_BIO_get_mem_data)}
      BIO_get_mem_data := @FC_BIO_get_mem_data
      {$else}
      BIO_get_mem_data := @ERR_BIO_get_mem_data
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_get_mem_data_removed)}
   if BIO_get_mem_data_removed <= LibVersion then
     {$if declared(_BIO_get_mem_data)}
     BIO_get_mem_data := @_BIO_get_mem_data
     {$else}
       {$IF declared(ERR_BIO_get_mem_data)}
       BIO_get_mem_data := @ERR_BIO_get_mem_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_get_mem_data) and Assigned(AFailed) then 
     AFailed.Add('BIO_get_mem_data');
  end;


  if not assigned(BIO_set_mem_buf) then 
  begin
    {$if declared(BIO_set_mem_buf_introduced)}
    if LibVersion < BIO_set_mem_buf_introduced then
      {$if declared(FC_BIO_set_mem_buf)}
      BIO_set_mem_buf := @FC_BIO_set_mem_buf
      {$else}
      BIO_set_mem_buf := @ERR_BIO_set_mem_buf
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_set_mem_buf_removed)}
   if BIO_set_mem_buf_removed <= LibVersion then
     {$if declared(_BIO_set_mem_buf)}
     BIO_set_mem_buf := @_BIO_set_mem_buf
     {$else}
       {$IF declared(ERR_BIO_set_mem_buf)}
       BIO_set_mem_buf := @ERR_BIO_set_mem_buf
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_set_mem_buf) and Assigned(AFailed) then 
     AFailed.Add('BIO_set_mem_buf');
  end;


  if not assigned(BIO_get_mem_ptr) then 
  begin
    {$if declared(BIO_get_mem_ptr_introduced)}
    if LibVersion < BIO_get_mem_ptr_introduced then
      {$if declared(FC_BIO_get_mem_ptr)}
      BIO_get_mem_ptr := @FC_BIO_get_mem_ptr
      {$else}
      BIO_get_mem_ptr := @ERR_BIO_get_mem_ptr
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_get_mem_ptr_removed)}
   if BIO_get_mem_ptr_removed <= LibVersion then
     {$if declared(_BIO_get_mem_ptr)}
     BIO_get_mem_ptr := @_BIO_get_mem_ptr
     {$else}
       {$IF declared(ERR_BIO_get_mem_ptr)}
       BIO_get_mem_ptr := @ERR_BIO_get_mem_ptr
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_get_mem_ptr) and Assigned(AFailed) then 
     AFailed.Add('BIO_get_mem_ptr');
  end;


  if not assigned(BIO_set_mem_eof_return) then 
  begin
    {$if declared(BIO_set_mem_eof_return_introduced)}
    if LibVersion < BIO_set_mem_eof_return_introduced then
      {$if declared(FC_BIO_set_mem_eof_return)}
      BIO_set_mem_eof_return := @FC_BIO_set_mem_eof_return
      {$else}
      BIO_set_mem_eof_return := @ERR_BIO_set_mem_eof_return
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_set_mem_eof_return_removed)}
   if BIO_set_mem_eof_return_removed <= LibVersion then
     {$if declared(_BIO_set_mem_eof_return)}
     BIO_set_mem_eof_return := @_BIO_set_mem_eof_return
     {$else}
       {$IF declared(ERR_BIO_set_mem_eof_return)}
       BIO_set_mem_eof_return := @ERR_BIO_set_mem_eof_return
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_set_mem_eof_return) and Assigned(AFailed) then 
     AFailed.Add('BIO_set_mem_eof_return');
  end;


  if not assigned(BIO_get_new_index) then 
  begin
    {$if declared(BIO_get_new_index_introduced)}
    if LibVersion < BIO_get_new_index_introduced then
      {$if declared(FC_BIO_get_new_index)}
      BIO_get_new_index := @FC_BIO_get_new_index
      {$else}
      BIO_get_new_index := @ERR_BIO_get_new_index
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_get_new_index_removed)}
   if BIO_get_new_index_removed <= LibVersion then
     {$if declared(_BIO_get_new_index)}
     BIO_get_new_index := @_BIO_get_new_index
     {$else}
       {$IF declared(ERR_BIO_get_new_index)}
       BIO_get_new_index := @ERR_BIO_get_new_index
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_get_new_index) and Assigned(AFailed) then 
     AFailed.Add('BIO_get_new_index');
  end;


  if not assigned(BIO_get_callback_ex) then 
  begin
    {$if declared(BIO_get_callback_ex_introduced)}
    if LibVersion < BIO_get_callback_ex_introduced then
      {$if declared(FC_BIO_get_callback_ex)}
      BIO_get_callback_ex := @FC_BIO_get_callback_ex
      {$else}
      BIO_get_callback_ex := @ERR_BIO_get_callback_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_get_callback_ex_removed)}
   if BIO_get_callback_ex_removed <= LibVersion then
     {$if declared(_BIO_get_callback_ex)}
     BIO_get_callback_ex := @_BIO_get_callback_ex
     {$else}
       {$IF declared(ERR_BIO_get_callback_ex)}
       BIO_get_callback_ex := @ERR_BIO_get_callback_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_get_callback_ex) and Assigned(AFailed) then 
     AFailed.Add('BIO_get_callback_ex');
  end;


  if not assigned(BIO_set_callback_ex) then 
  begin
    {$if declared(BIO_set_callback_ex_introduced)}
    if LibVersion < BIO_set_callback_ex_introduced then
      {$if declared(FC_BIO_set_callback_ex)}
      BIO_set_callback_ex := @FC_BIO_set_callback_ex
      {$else}
      BIO_set_callback_ex := @ERR_BIO_set_callback_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_set_callback_ex_removed)}
   if BIO_set_callback_ex_removed <= LibVersion then
     {$if declared(_BIO_set_callback_ex)}
     BIO_set_callback_ex := @_BIO_set_callback_ex
     {$else}
       {$IF declared(ERR_BIO_set_callback_ex)}
       BIO_set_callback_ex := @ERR_BIO_set_callback_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_set_callback_ex) and Assigned(AFailed) then 
     AFailed.Add('BIO_set_callback_ex');
  end;


  if not assigned(BIO_set_data) then 
  begin
    {$if declared(BIO_set_data_introduced)}
    if LibVersion < BIO_set_data_introduced then
      {$if declared(FC_BIO_set_data)}
      BIO_set_data := @FC_BIO_set_data
      {$else}
      BIO_set_data := @ERR_BIO_set_data
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_set_data_removed)}
   if BIO_set_data_removed <= LibVersion then
     {$if declared(_BIO_set_data)}
     BIO_set_data := @_BIO_set_data
     {$else}
       {$IF declared(ERR_BIO_set_data)}
       BIO_set_data := @ERR_BIO_set_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_set_data) and Assigned(AFailed) then 
     AFailed.Add('BIO_set_data');
  end;


  if not assigned(BIO_get_data) then 
  begin
    {$if declared(BIO_get_data_introduced)}
    if LibVersion < BIO_get_data_introduced then
      {$if declared(FC_BIO_get_data)}
      BIO_get_data := @FC_BIO_get_data
      {$else}
      BIO_get_data := @ERR_BIO_get_data
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_get_data_removed)}
   if BIO_get_data_removed <= LibVersion then
     {$if declared(_BIO_get_data)}
     BIO_get_data := @_BIO_get_data
     {$else}
       {$IF declared(ERR_BIO_get_data)}
       BIO_get_data := @ERR_BIO_get_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_get_data) and Assigned(AFailed) then 
     AFailed.Add('BIO_get_data');
  end;


  if not assigned(BIO_set_init) then 
  begin
    {$if declared(BIO_set_init_introduced)}
    if LibVersion < BIO_set_init_introduced then
      {$if declared(FC_BIO_set_init)}
      BIO_set_init := @FC_BIO_set_init
      {$else}
      BIO_set_init := @ERR_BIO_set_init
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_set_init_removed)}
   if BIO_set_init_removed <= LibVersion then
     {$if declared(_BIO_set_init)}
     BIO_set_init := @_BIO_set_init
     {$else}
       {$IF declared(ERR_BIO_set_init)}
       BIO_set_init := @ERR_BIO_set_init
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_set_init) and Assigned(AFailed) then 
     AFailed.Add('BIO_set_init');
  end;


  if not assigned(BIO_get_init) then 
  begin
    {$if declared(BIO_get_init_introduced)}
    if LibVersion < BIO_get_init_introduced then
      {$if declared(FC_BIO_get_init)}
      BIO_get_init := @FC_BIO_get_init
      {$else}
      BIO_get_init := @ERR_BIO_get_init
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_get_init_removed)}
   if BIO_get_init_removed <= LibVersion then
     {$if declared(_BIO_get_init)}
     BIO_get_init := @_BIO_get_init
     {$else}
       {$IF declared(ERR_BIO_get_init)}
       BIO_get_init := @ERR_BIO_get_init
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_get_init) and Assigned(AFailed) then 
     AFailed.Add('BIO_get_init');
  end;


  if not assigned(BIO_set_shutdown) then 
  begin
    {$if declared(BIO_set_shutdown_introduced)}
    if LibVersion < BIO_set_shutdown_introduced then
      {$if declared(FC_BIO_set_shutdown)}
      BIO_set_shutdown := @FC_BIO_set_shutdown
      {$else}
      BIO_set_shutdown := @ERR_BIO_set_shutdown
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_set_shutdown_removed)}
   if BIO_set_shutdown_removed <= LibVersion then
     {$if declared(_BIO_set_shutdown)}
     BIO_set_shutdown := @_BIO_set_shutdown
     {$else}
       {$IF declared(ERR_BIO_set_shutdown)}
       BIO_set_shutdown := @ERR_BIO_set_shutdown
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_set_shutdown) and Assigned(AFailed) then 
     AFailed.Add('BIO_set_shutdown');
  end;


  if not assigned(BIO_get_shutdown) then 
  begin
    {$if declared(BIO_get_shutdown_introduced)}
    if LibVersion < BIO_get_shutdown_introduced then
      {$if declared(FC_BIO_get_shutdown)}
      BIO_get_shutdown := @FC_BIO_get_shutdown
      {$else}
      BIO_get_shutdown := @ERR_BIO_get_shutdown
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_get_shutdown_removed)}
   if BIO_get_shutdown_removed <= LibVersion then
     {$if declared(_BIO_get_shutdown)}
     BIO_get_shutdown := @_BIO_get_shutdown
     {$else}
       {$IF declared(ERR_BIO_get_shutdown)}
       BIO_get_shutdown := @ERR_BIO_get_shutdown
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_get_shutdown) and Assigned(AFailed) then 
     AFailed.Add('BIO_get_shutdown');
  end;


  if not assigned(BIO_up_ref) then 
  begin
    {$if declared(BIO_up_ref_introduced)}
    if LibVersion < BIO_up_ref_introduced then
      {$if declared(FC_BIO_up_ref)}
      BIO_up_ref := @FC_BIO_up_ref
      {$else}
      BIO_up_ref := @ERR_BIO_up_ref
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_up_ref_removed)}
   if BIO_up_ref_removed <= LibVersion then
     {$if declared(_BIO_up_ref)}
     BIO_up_ref := @_BIO_up_ref
     {$else}
       {$IF declared(ERR_BIO_up_ref)}
       BIO_up_ref := @ERR_BIO_up_ref
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_up_ref) and Assigned(AFailed) then 
     AFailed.Add('BIO_up_ref');
  end;


  if not assigned(BIO_read_ex) then 
  begin
    {$if declared(BIO_read_ex_introduced)}
    if LibVersion < BIO_read_ex_introduced then
      {$if declared(FC_BIO_read_ex)}
      BIO_read_ex := @FC_BIO_read_ex
      {$else}
      BIO_read_ex := @ERR_BIO_read_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_read_ex_removed)}
   if BIO_read_ex_removed <= LibVersion then
     {$if declared(_BIO_read_ex)}
     BIO_read_ex := @_BIO_read_ex
     {$else}
       {$IF declared(ERR_BIO_read_ex)}
       BIO_read_ex := @ERR_BIO_read_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_read_ex) and Assigned(AFailed) then 
     AFailed.Add('BIO_read_ex');
  end;


  if not assigned(BIO_write_ex) then 
  begin
    {$if declared(BIO_write_ex_introduced)}
    if LibVersion < BIO_write_ex_introduced then
      {$if declared(FC_BIO_write_ex)}
      BIO_write_ex := @FC_BIO_write_ex
      {$else}
      BIO_write_ex := @ERR_BIO_write_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_write_ex_removed)}
   if BIO_write_ex_removed <= LibVersion then
     {$if declared(_BIO_write_ex)}
     BIO_write_ex := @_BIO_write_ex
     {$else}
       {$IF declared(ERR_BIO_write_ex)}
       BIO_write_ex := @ERR_BIO_write_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_write_ex) and Assigned(AFailed) then 
     AFailed.Add('BIO_write_ex');
  end;


  if not assigned(BIO_set_next) then 
  begin
    {$if declared(BIO_set_next_introduced)}
    if LibVersion < BIO_set_next_introduced then
      {$if declared(FC_BIO_set_next)}
      BIO_set_next := @FC_BIO_set_next
      {$else}
      BIO_set_next := @ERR_BIO_set_next
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_set_next_removed)}
   if BIO_set_next_removed <= LibVersion then
     {$if declared(_BIO_set_next)}
     BIO_set_next := @_BIO_set_next
     {$else}
       {$IF declared(ERR_BIO_set_next)}
       BIO_set_next := @ERR_BIO_set_next
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_set_next) and Assigned(AFailed) then 
     AFailed.Add('BIO_set_next');
  end;


  if not assigned(BIO_set_retry_reason) then 
  begin
    {$if declared(BIO_set_retry_reason_introduced)}
    if LibVersion < BIO_set_retry_reason_introduced then
      {$if declared(FC_BIO_set_retry_reason)}
      BIO_set_retry_reason := @FC_BIO_set_retry_reason
      {$else}
      BIO_set_retry_reason := @ERR_BIO_set_retry_reason
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_set_retry_reason_removed)}
   if BIO_set_retry_reason_removed <= LibVersion then
     {$if declared(_BIO_set_retry_reason)}
     BIO_set_retry_reason := @_BIO_set_retry_reason
     {$else}
       {$IF declared(ERR_BIO_set_retry_reason)}
       BIO_set_retry_reason := @ERR_BIO_set_retry_reason
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_set_retry_reason) and Assigned(AFailed) then 
     AFailed.Add('BIO_set_retry_reason');
  end;


  if not assigned(BIO_s_secmem) then 
  begin
    {$if declared(BIO_s_secmem_introduced)}
    if LibVersion < BIO_s_secmem_introduced then
      {$if declared(FC_BIO_s_secmem)}
      BIO_s_secmem := @FC_BIO_s_secmem
      {$else}
      BIO_s_secmem := @ERR_BIO_s_secmem
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_s_secmem_removed)}
   if BIO_s_secmem_removed <= LibVersion then
     {$if declared(_BIO_s_secmem)}
     BIO_s_secmem := @_BIO_s_secmem
     {$else}
       {$IF declared(ERR_BIO_s_secmem)}
       BIO_s_secmem := @ERR_BIO_s_secmem
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_s_secmem) and Assigned(AFailed) then 
     AFailed.Add('BIO_s_secmem');
  end;


  if not assigned(BIO_f_linebuffer) then 
  begin
    {$if declared(BIO_f_linebuffer_introduced)}
    if LibVersion < BIO_f_linebuffer_introduced then
      {$if declared(FC_BIO_f_linebuffer)}
      BIO_f_linebuffer := @FC_BIO_f_linebuffer
      {$else}
      BIO_f_linebuffer := @ERR_BIO_f_linebuffer
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_f_linebuffer_removed)}
   if BIO_f_linebuffer_removed <= LibVersion then
     {$if declared(_BIO_f_linebuffer)}
     BIO_f_linebuffer := @_BIO_f_linebuffer
     {$else}
       {$IF declared(ERR_BIO_f_linebuffer)}
       BIO_f_linebuffer := @ERR_BIO_f_linebuffer
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_f_linebuffer) and Assigned(AFailed) then 
     AFailed.Add('BIO_f_linebuffer');
  end;


  if not assigned(BIO_ADDR_new) then 
  begin
    {$if declared(BIO_ADDR_new_introduced)}
    if LibVersion < BIO_ADDR_new_introduced then
      {$if declared(FC_BIO_ADDR_new)}
      BIO_ADDR_new := @FC_BIO_ADDR_new
      {$else}
      BIO_ADDR_new := @ERR_BIO_ADDR_new
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDR_new_removed)}
   if BIO_ADDR_new_removed <= LibVersion then
     {$if declared(_BIO_ADDR_new)}
     BIO_ADDR_new := @_BIO_ADDR_new
     {$else}
       {$IF declared(ERR_BIO_ADDR_new)}
       BIO_ADDR_new := @ERR_BIO_ADDR_new
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDR_new) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDR_new');
  end;


  if not assigned(BIO_ADDR_rawmake) then 
  begin
    {$if declared(BIO_ADDR_rawmake_introduced)}
    if LibVersion < BIO_ADDR_rawmake_introduced then
      {$if declared(FC_BIO_ADDR_rawmake)}
      BIO_ADDR_rawmake := @FC_BIO_ADDR_rawmake
      {$else}
      BIO_ADDR_rawmake := @ERR_BIO_ADDR_rawmake
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDR_rawmake_removed)}
   if BIO_ADDR_rawmake_removed <= LibVersion then
     {$if declared(_BIO_ADDR_rawmake)}
     BIO_ADDR_rawmake := @_BIO_ADDR_rawmake
     {$else}
       {$IF declared(ERR_BIO_ADDR_rawmake)}
       BIO_ADDR_rawmake := @ERR_BIO_ADDR_rawmake
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDR_rawmake) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDR_rawmake');
  end;


  if not assigned(BIO_ADDR_free) then 
  begin
    {$if declared(BIO_ADDR_free_introduced)}
    if LibVersion < BIO_ADDR_free_introduced then
      {$if declared(FC_BIO_ADDR_free)}
      BIO_ADDR_free := @FC_BIO_ADDR_free
      {$else}
      BIO_ADDR_free := @ERR_BIO_ADDR_free
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDR_free_removed)}
   if BIO_ADDR_free_removed <= LibVersion then
     {$if declared(_BIO_ADDR_free)}
     BIO_ADDR_free := @_BIO_ADDR_free
     {$else}
       {$IF declared(ERR_BIO_ADDR_free)}
       BIO_ADDR_free := @ERR_BIO_ADDR_free
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDR_free) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDR_free');
  end;


  if not assigned(BIO_ADDR_clear) then 
  begin
    {$if declared(BIO_ADDR_clear_introduced)}
    if LibVersion < BIO_ADDR_clear_introduced then
      {$if declared(FC_BIO_ADDR_clear)}
      BIO_ADDR_clear := @FC_BIO_ADDR_clear
      {$else}
      BIO_ADDR_clear := @ERR_BIO_ADDR_clear
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDR_clear_removed)}
   if BIO_ADDR_clear_removed <= LibVersion then
     {$if declared(_BIO_ADDR_clear)}
     BIO_ADDR_clear := @_BIO_ADDR_clear
     {$else}
       {$IF declared(ERR_BIO_ADDR_clear)}
       BIO_ADDR_clear := @ERR_BIO_ADDR_clear
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDR_clear) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDR_clear');
  end;


  if not assigned(BIO_ADDR_family) then 
  begin
    {$if declared(BIO_ADDR_family_introduced)}
    if LibVersion < BIO_ADDR_family_introduced then
      {$if declared(FC_BIO_ADDR_family)}
      BIO_ADDR_family := @FC_BIO_ADDR_family
      {$else}
      BIO_ADDR_family := @ERR_BIO_ADDR_family
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDR_family_removed)}
   if BIO_ADDR_family_removed <= LibVersion then
     {$if declared(_BIO_ADDR_family)}
     BIO_ADDR_family := @_BIO_ADDR_family
     {$else}
       {$IF declared(ERR_BIO_ADDR_family)}
       BIO_ADDR_family := @ERR_BIO_ADDR_family
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDR_family) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDR_family');
  end;


  if not assigned(BIO_ADDR_rawaddress) then 
  begin
    {$if declared(BIO_ADDR_rawaddress_introduced)}
    if LibVersion < BIO_ADDR_rawaddress_introduced then
      {$if declared(FC_BIO_ADDR_rawaddress)}
      BIO_ADDR_rawaddress := @FC_BIO_ADDR_rawaddress
      {$else}
      BIO_ADDR_rawaddress := @ERR_BIO_ADDR_rawaddress
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDR_rawaddress_removed)}
   if BIO_ADDR_rawaddress_removed <= LibVersion then
     {$if declared(_BIO_ADDR_rawaddress)}
     BIO_ADDR_rawaddress := @_BIO_ADDR_rawaddress
     {$else}
       {$IF declared(ERR_BIO_ADDR_rawaddress)}
       BIO_ADDR_rawaddress := @ERR_BIO_ADDR_rawaddress
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDR_rawaddress) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDR_rawaddress');
  end;


  if not assigned(BIO_ADDR_rawport) then 
  begin
    {$if declared(BIO_ADDR_rawport_introduced)}
    if LibVersion < BIO_ADDR_rawport_introduced then
      {$if declared(FC_BIO_ADDR_rawport)}
      BIO_ADDR_rawport := @FC_BIO_ADDR_rawport
      {$else}
      BIO_ADDR_rawport := @ERR_BIO_ADDR_rawport
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDR_rawport_removed)}
   if BIO_ADDR_rawport_removed <= LibVersion then
     {$if declared(_BIO_ADDR_rawport)}
     BIO_ADDR_rawport := @_BIO_ADDR_rawport
     {$else}
       {$IF declared(ERR_BIO_ADDR_rawport)}
       BIO_ADDR_rawport := @ERR_BIO_ADDR_rawport
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDR_rawport) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDR_rawport');
  end;


  if not assigned(BIO_ADDR_hostname_string) then 
  begin
    {$if declared(BIO_ADDR_hostname_string_introduced)}
    if LibVersion < BIO_ADDR_hostname_string_introduced then
      {$if declared(FC_BIO_ADDR_hostname_string)}
      BIO_ADDR_hostname_string := @FC_BIO_ADDR_hostname_string
      {$else}
      BIO_ADDR_hostname_string := @ERR_BIO_ADDR_hostname_string
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDR_hostname_string_removed)}
   if BIO_ADDR_hostname_string_removed <= LibVersion then
     {$if declared(_BIO_ADDR_hostname_string)}
     BIO_ADDR_hostname_string := @_BIO_ADDR_hostname_string
     {$else}
       {$IF declared(ERR_BIO_ADDR_hostname_string)}
       BIO_ADDR_hostname_string := @ERR_BIO_ADDR_hostname_string
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDR_hostname_string) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDR_hostname_string');
  end;


  if not assigned(BIO_ADDR_service_string) then 
  begin
    {$if declared(BIO_ADDR_service_string_introduced)}
    if LibVersion < BIO_ADDR_service_string_introduced then
      {$if declared(FC_BIO_ADDR_service_string)}
      BIO_ADDR_service_string := @FC_BIO_ADDR_service_string
      {$else}
      BIO_ADDR_service_string := @ERR_BIO_ADDR_service_string
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDR_service_string_removed)}
   if BIO_ADDR_service_string_removed <= LibVersion then
     {$if declared(_BIO_ADDR_service_string)}
     BIO_ADDR_service_string := @_BIO_ADDR_service_string
     {$else}
       {$IF declared(ERR_BIO_ADDR_service_string)}
       BIO_ADDR_service_string := @ERR_BIO_ADDR_service_string
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDR_service_string) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDR_service_string');
  end;


  if not assigned(BIO_ADDR_path_string) then 
  begin
    {$if declared(BIO_ADDR_path_string_introduced)}
    if LibVersion < BIO_ADDR_path_string_introduced then
      {$if declared(FC_BIO_ADDR_path_string)}
      BIO_ADDR_path_string := @FC_BIO_ADDR_path_string
      {$else}
      BIO_ADDR_path_string := @ERR_BIO_ADDR_path_string
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDR_path_string_removed)}
   if BIO_ADDR_path_string_removed <= LibVersion then
     {$if declared(_BIO_ADDR_path_string)}
     BIO_ADDR_path_string := @_BIO_ADDR_path_string
     {$else}
       {$IF declared(ERR_BIO_ADDR_path_string)}
       BIO_ADDR_path_string := @ERR_BIO_ADDR_path_string
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDR_path_string) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDR_path_string');
  end;


  if not assigned(BIO_ADDRINFO_next) then 
  begin
    {$if declared(BIO_ADDRINFO_next_introduced)}
    if LibVersion < BIO_ADDRINFO_next_introduced then
      {$if declared(FC_BIO_ADDRINFO_next)}
      BIO_ADDRINFO_next := @FC_BIO_ADDRINFO_next
      {$else}
      BIO_ADDRINFO_next := @ERR_BIO_ADDRINFO_next
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDRINFO_next_removed)}
   if BIO_ADDRINFO_next_removed <= LibVersion then
     {$if declared(_BIO_ADDRINFO_next)}
     BIO_ADDRINFO_next := @_BIO_ADDRINFO_next
     {$else}
       {$IF declared(ERR_BIO_ADDRINFO_next)}
       BIO_ADDRINFO_next := @ERR_BIO_ADDRINFO_next
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDRINFO_next) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDRINFO_next');
  end;


  if not assigned(BIO_ADDRINFO_family) then 
  begin
    {$if declared(BIO_ADDRINFO_family_introduced)}
    if LibVersion < BIO_ADDRINFO_family_introduced then
      {$if declared(FC_BIO_ADDRINFO_family)}
      BIO_ADDRINFO_family := @FC_BIO_ADDRINFO_family
      {$else}
      BIO_ADDRINFO_family := @ERR_BIO_ADDRINFO_family
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDRINFO_family_removed)}
   if BIO_ADDRINFO_family_removed <= LibVersion then
     {$if declared(_BIO_ADDRINFO_family)}
     BIO_ADDRINFO_family := @_BIO_ADDRINFO_family
     {$else}
       {$IF declared(ERR_BIO_ADDRINFO_family)}
       BIO_ADDRINFO_family := @ERR_BIO_ADDRINFO_family
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDRINFO_family) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDRINFO_family');
  end;


  if not assigned(BIO_ADDRINFO_socktype) then 
  begin
    {$if declared(BIO_ADDRINFO_socktype_introduced)}
    if LibVersion < BIO_ADDRINFO_socktype_introduced then
      {$if declared(FC_BIO_ADDRINFO_socktype)}
      BIO_ADDRINFO_socktype := @FC_BIO_ADDRINFO_socktype
      {$else}
      BIO_ADDRINFO_socktype := @ERR_BIO_ADDRINFO_socktype
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDRINFO_socktype_removed)}
   if BIO_ADDRINFO_socktype_removed <= LibVersion then
     {$if declared(_BIO_ADDRINFO_socktype)}
     BIO_ADDRINFO_socktype := @_BIO_ADDRINFO_socktype
     {$else}
       {$IF declared(ERR_BIO_ADDRINFO_socktype)}
       BIO_ADDRINFO_socktype := @ERR_BIO_ADDRINFO_socktype
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDRINFO_socktype) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDRINFO_socktype');
  end;


  if not assigned(BIO_ADDRINFO_protocol) then 
  begin
    {$if declared(BIO_ADDRINFO_protocol_introduced)}
    if LibVersion < BIO_ADDRINFO_protocol_introduced then
      {$if declared(FC_BIO_ADDRINFO_protocol)}
      BIO_ADDRINFO_protocol := @FC_BIO_ADDRINFO_protocol
      {$else}
      BIO_ADDRINFO_protocol := @ERR_BIO_ADDRINFO_protocol
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDRINFO_protocol_removed)}
   if BIO_ADDRINFO_protocol_removed <= LibVersion then
     {$if declared(_BIO_ADDRINFO_protocol)}
     BIO_ADDRINFO_protocol := @_BIO_ADDRINFO_protocol
     {$else}
       {$IF declared(ERR_BIO_ADDRINFO_protocol)}
       BIO_ADDRINFO_protocol := @ERR_BIO_ADDRINFO_protocol
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDRINFO_protocol) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDRINFO_protocol');
  end;


  if not assigned(BIO_ADDRINFO_address) then 
  begin
    {$if declared(BIO_ADDRINFO_address_introduced)}
    if LibVersion < BIO_ADDRINFO_address_introduced then
      {$if declared(FC_BIO_ADDRINFO_address)}
      BIO_ADDRINFO_address := @FC_BIO_ADDRINFO_address
      {$else}
      BIO_ADDRINFO_address := @ERR_BIO_ADDRINFO_address
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDRINFO_address_removed)}
   if BIO_ADDRINFO_address_removed <= LibVersion then
     {$if declared(_BIO_ADDRINFO_address)}
     BIO_ADDRINFO_address := @_BIO_ADDRINFO_address
     {$else}
       {$IF declared(ERR_BIO_ADDRINFO_address)}
       BIO_ADDRINFO_address := @ERR_BIO_ADDRINFO_address
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDRINFO_address) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDRINFO_address');
  end;


  if not assigned(BIO_ADDRINFO_free) then 
  begin
    {$if declared(BIO_ADDRINFO_free_introduced)}
    if LibVersion < BIO_ADDRINFO_free_introduced then
      {$if declared(FC_BIO_ADDRINFO_free)}
      BIO_ADDRINFO_free := @FC_BIO_ADDRINFO_free
      {$else}
      BIO_ADDRINFO_free := @ERR_BIO_ADDRINFO_free
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_ADDRINFO_free_removed)}
   if BIO_ADDRINFO_free_removed <= LibVersion then
     {$if declared(_BIO_ADDRINFO_free)}
     BIO_ADDRINFO_free := @_BIO_ADDRINFO_free
     {$else}
       {$IF declared(ERR_BIO_ADDRINFO_free)}
       BIO_ADDRINFO_free := @ERR_BIO_ADDRINFO_free
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_ADDRINFO_free) and Assigned(AFailed) then 
     AFailed.Add('BIO_ADDRINFO_free');
  end;


  if not assigned(BIO_parse_hostserv) then 
  begin
    {$if declared(BIO_parse_hostserv_introduced)}
    if LibVersion < BIO_parse_hostserv_introduced then
      {$if declared(FC_BIO_parse_hostserv)}
      BIO_parse_hostserv := @FC_BIO_parse_hostserv
      {$else}
      BIO_parse_hostserv := @ERR_BIO_parse_hostserv
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_parse_hostserv_removed)}
   if BIO_parse_hostserv_removed <= LibVersion then
     {$if declared(_BIO_parse_hostserv)}
     BIO_parse_hostserv := @_BIO_parse_hostserv
     {$else}
       {$IF declared(ERR_BIO_parse_hostserv)}
       BIO_parse_hostserv := @ERR_BIO_parse_hostserv
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_parse_hostserv) and Assigned(AFailed) then 
     AFailed.Add('BIO_parse_hostserv');
  end;


  if not assigned(BIO_lookup) then 
  begin
    {$if declared(BIO_lookup_introduced)}
    if LibVersion < BIO_lookup_introduced then
      {$if declared(FC_BIO_lookup)}
      BIO_lookup := @FC_BIO_lookup
      {$else}
      BIO_lookup := @ERR_BIO_lookup
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_lookup_removed)}
   if BIO_lookup_removed <= LibVersion then
     {$if declared(_BIO_lookup)}
     BIO_lookup := @_BIO_lookup
     {$else}
       {$IF declared(ERR_BIO_lookup)}
       BIO_lookup := @ERR_BIO_lookup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_lookup) and Assigned(AFailed) then 
     AFailed.Add('BIO_lookup');
  end;


  if not assigned(BIO_lookup_ex) then 
  begin
    {$if declared(BIO_lookup_ex_introduced)}
    if LibVersion < BIO_lookup_ex_introduced then
      {$if declared(FC_BIO_lookup_ex)}
      BIO_lookup_ex := @FC_BIO_lookup_ex
      {$else}
      BIO_lookup_ex := @ERR_BIO_lookup_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_lookup_ex_removed)}
   if BIO_lookup_ex_removed <= LibVersion then
     {$if declared(_BIO_lookup_ex)}
     BIO_lookup_ex := @_BIO_lookup_ex
     {$else}
       {$IF declared(ERR_BIO_lookup_ex)}
       BIO_lookup_ex := @ERR_BIO_lookup_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_lookup_ex) and Assigned(AFailed) then 
     AFailed.Add('BIO_lookup_ex');
  end;


  if not assigned(BIO_sock_info) then 
  begin
    {$if declared(BIO_sock_info_introduced)}
    if LibVersion < BIO_sock_info_introduced then
      {$if declared(FC_BIO_sock_info)}
      BIO_sock_info := @FC_BIO_sock_info
      {$else}
      BIO_sock_info := @ERR_BIO_sock_info
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_sock_info_removed)}
   if BIO_sock_info_removed <= LibVersion then
     {$if declared(_BIO_sock_info)}
     BIO_sock_info := @_BIO_sock_info
     {$else}
       {$IF declared(ERR_BIO_sock_info)}
       BIO_sock_info := @ERR_BIO_sock_info
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_sock_info) and Assigned(AFailed) then 
     AFailed.Add('BIO_sock_info');
  end;


  if not assigned(BIO_socket) then 
  begin
    {$if declared(BIO_socket_introduced)}
    if LibVersion < BIO_socket_introduced then
      {$if declared(FC_BIO_socket)}
      BIO_socket := @FC_BIO_socket
      {$else}
      BIO_socket := @ERR_BIO_socket
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_socket_removed)}
   if BIO_socket_removed <= LibVersion then
     {$if declared(_BIO_socket)}
     BIO_socket := @_BIO_socket
     {$else}
       {$IF declared(ERR_BIO_socket)}
       BIO_socket := @ERR_BIO_socket
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_socket) and Assigned(AFailed) then 
     AFailed.Add('BIO_socket');
  end;


  if not assigned(BIO_connect) then 
  begin
    {$if declared(BIO_connect_introduced)}
    if LibVersion < BIO_connect_introduced then
      {$if declared(FC_BIO_connect)}
      BIO_connect := @FC_BIO_connect
      {$else}
      BIO_connect := @ERR_BIO_connect
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_connect_removed)}
   if BIO_connect_removed <= LibVersion then
     {$if declared(_BIO_connect)}
     BIO_connect := @_BIO_connect
     {$else}
       {$IF declared(ERR_BIO_connect)}
       BIO_connect := @ERR_BIO_connect
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_connect) and Assigned(AFailed) then 
     AFailed.Add('BIO_connect');
  end;


  if not assigned(BIO_bind) then 
  begin
    {$if declared(BIO_bind_introduced)}
    if LibVersion < BIO_bind_introduced then
      {$if declared(FC_BIO_bind)}
      BIO_bind := @FC_BIO_bind
      {$else}
      BIO_bind := @ERR_BIO_bind
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_bind_removed)}
   if BIO_bind_removed <= LibVersion then
     {$if declared(_BIO_bind)}
     BIO_bind := @_BIO_bind
     {$else}
       {$IF declared(ERR_BIO_bind)}
       BIO_bind := @ERR_BIO_bind
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_bind) and Assigned(AFailed) then 
     AFailed.Add('BIO_bind');
  end;


  if not assigned(BIO_listen) then 
  begin
    {$if declared(BIO_listen_introduced)}
    if LibVersion < BIO_listen_introduced then
      {$if declared(FC_BIO_listen)}
      BIO_listen := @FC_BIO_listen
      {$else}
      BIO_listen := @ERR_BIO_listen
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_listen_removed)}
   if BIO_listen_removed <= LibVersion then
     {$if declared(_BIO_listen)}
     BIO_listen := @_BIO_listen
     {$else}
       {$IF declared(ERR_BIO_listen)}
       BIO_listen := @ERR_BIO_listen
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_listen) and Assigned(AFailed) then 
     AFailed.Add('BIO_listen');
  end;


  if not assigned(BIO_accept_ex) then 
  begin
    {$if declared(BIO_accept_ex_introduced)}
    if LibVersion < BIO_accept_ex_introduced then
      {$if declared(FC_BIO_accept_ex)}
      BIO_accept_ex := @FC_BIO_accept_ex
      {$else}
      BIO_accept_ex := @ERR_BIO_accept_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_accept_ex_removed)}
   if BIO_accept_ex_removed <= LibVersion then
     {$if declared(_BIO_accept_ex)}
     BIO_accept_ex := @_BIO_accept_ex
     {$else}
       {$IF declared(ERR_BIO_accept_ex)}
       BIO_accept_ex := @ERR_BIO_accept_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_accept_ex) and Assigned(AFailed) then 
     AFailed.Add('BIO_accept_ex');
  end;


  if not assigned(BIO_closesocket) then 
  begin
    {$if declared(BIO_closesocket_introduced)}
    if LibVersion < BIO_closesocket_introduced then
      {$if declared(FC_BIO_closesocket)}
      BIO_closesocket := @FC_BIO_closesocket
      {$else}
      BIO_closesocket := @ERR_BIO_closesocket
      {$ifend}
    else
    {$ifend}
   {$if declared(BIO_closesocket_removed)}
   if BIO_closesocket_removed <= LibVersion then
     {$if declared(_BIO_closesocket)}
     BIO_closesocket := @_BIO_closesocket
     {$else}
       {$IF declared(ERR_BIO_closesocket)}
       BIO_closesocket := @ERR_BIO_closesocket
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(BIO_closesocket) and Assigned(AFailed) then 
     AFailed.Add('BIO_closesocket');
  end;


end;

procedure Unload;
begin
  BIO_get_flags := nil; {removed 1.0.0}
  BIO_set_retry_special := nil; {removed 1.0.0}
  BIO_set_retry_read := nil; {removed 1.0.0}
  BIO_set_retry_write := nil; {removed 1.0.0}
  BIO_clear_retry_flags := nil; {removed 1.0.0}
  BIO_get_retry_flags := nil; {removed 1.0.0}
  BIO_should_read := nil; {removed 1.0.0}
  BIO_should_write := nil; {removed 1.0.0}
  BIO_should_io_special := nil; {removed 1.0.0}
  BIO_retry_type := nil; {removed 1.0.0}
  BIO_should_retry := nil; {removed 1.0.0}
  BIO_do_connect := nil; {removed 1.0.0}
  BIO_do_accept := nil; {removed 1.0.0}
  BIO_do_handshake := nil; {removed 1.0.0}
  BIO_get_mem_data := nil; {removed 1.0.0}
  BIO_set_mem_buf := nil; {removed 1.0.0}
  BIO_get_mem_ptr := nil; {removed 1.0.0}
  BIO_set_mem_eof_return := nil; {removed 1.0.0}
  BIO_get_new_index := nil; {introduced 1.1.0}
  BIO_set_flags := nil;
  BIO_test_flags := nil;
  BIO_clear_flags := nil;
  BIO_get_callback := nil;
  BIO_set_callback := nil;
  BIO_get_callback_ex := nil; {introduced 1.1.0}
  BIO_set_callback_ex := nil; {introduced 1.1.0}
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
  BIO_set_data := nil; {introduced 1.1.0}
  BIO_get_data := nil; {introduced 1.1.0}
  BIO_set_init := nil; {introduced 1.1.0}
  BIO_get_init := nil; {introduced 1.1.0}
  BIO_set_shutdown := nil; {introduced 1.1.0}
  BIO_get_shutdown := nil; {introduced 1.1.0}
  BIO_vfree := nil;
  BIO_up_ref := nil; {introduced 1.1.0}
  BIO_read := nil;
  BIO_read_ex := nil; {introduced 1.1.0}
  BIO_gets := nil;
  BIO_write := nil;
  BIO_write_ex := nil; {introduced 1.1.0}
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
  BIO_set_next := nil; {introduced 1.1.0}
  BIO_get_retry_BIO := nil;
  BIO_get_retry_reason := nil;
  BIO_set_retry_reason := nil; {introduced 1.1.0}
  BIO_dup_chain := nil;
  BIO_nread0 := nil;
  BIO_nread := nil;
  BIO_nwrite0 := nil;
  BIO_nwrite := nil;
  BIO_debug_callback := nil;
  BIO_s_mem := nil;
  BIO_s_secmem := nil; {introduced 1.1.0}
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
  BIO_f_linebuffer := nil; {introduced 1.1.0}
  BIO_f_nbio_test := nil;
  BIO_s_datagram := nil;
  BIO_dgram_non_fatal_error := nil;
  BIO_new_dgram := nil;
  BIO_sock_should_retry := nil;
  BIO_sock_non_fatal_error := nil;
  BIO_fd_should_retry := nil;
  BIO_fd_non_fatal_error := nil;
  BIO_dump := nil;
  BIO_dump_indent := nil;
  BIO_hex_string := nil;
  BIO_ADDR_new := nil; {introduced 1.1.0}
  BIO_ADDR_rawmake := nil; {introduced 1.1.0}
  BIO_ADDR_free := nil; {introduced 1.1.0}
  BIO_ADDR_clear := nil; {introduced 1.1.0}
  BIO_ADDR_family := nil; {introduced 1.1.0}
  BIO_ADDR_rawaddress := nil; {introduced 1.1.0}
  BIO_ADDR_rawport := nil; {introduced 1.1.0}
  BIO_ADDR_hostname_string := nil; {introduced 1.1.0}
  BIO_ADDR_service_string := nil; {introduced 1.1.0}
  BIO_ADDR_path_string := nil; {introduced 1.1.0}
  BIO_ADDRINFO_next := nil; {introduced 1.1.0}
  BIO_ADDRINFO_family := nil; {introduced 1.1.0}
  BIO_ADDRINFO_socktype := nil; {introduced 1.1.0}
  BIO_ADDRINFO_protocol := nil; {introduced 1.1.0}
  BIO_ADDRINFO_address := nil; {introduced 1.1.0}
  BIO_ADDRINFO_free := nil; {introduced 1.1.0}
  BIO_parse_hostserv := nil; {introduced 1.1.0}
  BIO_lookup := nil; {introduced 1.1.0}
  BIO_lookup_ex := nil; {introduced 1.1.0}
  BIO_sock_error := nil;
  BIO_socket_ioctl := nil;
  BIO_socket_nbio := nil;
  BIO_sock_init := nil;
  BIO_set_tcp_ndelay := nil;
  BIO_sock_info := nil; {introduced 1.1.0}
  BIO_socket := nil; {introduced 1.1.0}
  BIO_connect := nil; {introduced 1.1.0}
  BIO_bind := nil; {introduced 1.1.0}
  BIO_listen := nil; {introduced 1.1.0}
  BIO_accept_ex := nil; {introduced 1.1.0}
  BIO_closesocket := nil; {introduced 1.1.0}
  BIO_new_socket := nil;
  BIO_new_connect := nil;
  BIO_new_accept := nil;
  BIO_new_fd := nil;
  BIO_new_bio_pair := nil;
  BIO_copy_next_retry := nil;
end;
{$ELSE}
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

//# define BIO_get_mem_data(b,pp)  BIO_ctrl(b,BIO_CTRL_INFO,0,(char (pp))
function BIO_get_mem_data(b: PBIO; pp: PIdAnsiChar) : TIdC_INT;
begin
  Result := BIO_ctrl(b, BIO_CTRL_INFO, 0, pp);
end;

//# define BIO_set_mem_buf(b,bm,c) BIO_ctrl(b,BIO_C_SET_BUF_MEM,c,(char (bm))
function BIO_set_mem_buf(b: PBIO; bm: PIdAnsiChar; c: TIdC_INT): TIdC_INT;
begin
  Result := BIO_ctrl(b, BIO_C_SET_BUF_MEM, c, bm);
end;

//# define BIO_get_mem_ptr(b,pp)   BIO_ctrl(b,BIO_C_GET_BUF_MEM_PTR,0,(char (pp))
function BIO_get_mem_ptr(b: PBIO; pp: PIdAnsiChar): TIdC_INT;
begin
  Result := BIO_ctrl(b, BIO_C_GET_BUF_MEM_PTR, 0, pp);
end;

//# define BIO_set_mem_eof_return(b,v) BIO_ctrl(b,BIO_C_SET_BUF_MEM_EOF_RETURN,v,0)
function BIO_set_mem_eof_return(b: PBIO; v: TIdC_INT): TIdC_INT;
begin
  Result := BIO_ctrl(b, BIO_C_SET_BUF_MEM_EOF_RETURN, v, nil);
end;

{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibCrypto');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
