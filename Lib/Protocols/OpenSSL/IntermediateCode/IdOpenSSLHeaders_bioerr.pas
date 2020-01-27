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

unit IdOpenSSLHeaders_bioerr;

interface

// Headers for OpenSSL 1.1.1
// bioerr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  (*
   * BIO function codes.
   *)
  BIO_F_ACPT_STATE = 100;
  BIO_F_ADDRINFO_WRAP = 148;
  BIO_F_ADDR_STRINGS = 134;
  BIO_F_BIO_ACCEPT = 101;
  BIO_F_BIO_ACCEPT_EX = 137;
  BIO_F_BIO_ACCEPT_NEW = 152;
  BIO_F_BIO_ADDR_NEW = 144;
  BIO_F_BIO_BIND = 147;
  BIO_F_BIO_CALLBACK_CTRL = 131;
  BIO_F_BIO_CONNECT = 138;
  BIO_F_BIO_CONNECT_NEW = 153;
  BIO_F_BIO_CTRL = 103;
  BIO_F_BIO_GETS = 104;
  BIO_F_BIO_GET_HOST_IP = 106;
  BIO_F_BIO_GET_NEW_INDEX = 102;
  BIO_F_BIO_GET_PORT = 107;
  BIO_F_BIO_LISTEN = 139;
  BIO_F_BIO_LOOKUP = 135;
  BIO_F_BIO_LOOKUP_EX = 143;
  BIO_F_BIO_MAKE_PAIR = 121;
  BIO_F_BIO_METH_NEW = 146;
  BIO_F_BIO_NEW = 108;
  BIO_F_BIO_NEW_DGRAM_SCTP = 145;
  BIO_F_BIO_NEW_FILE = 109;
  BIO_F_BIO_NEW_MEM_BUF = 126;
  BIO_F_BIO_NREAD = 123;
  BIO_F_BIO_NREAD0 = 124;
  BIO_F_BIO_NWRITE = 125;
  BIO_F_BIO_NWRITE0 = 122;
  BIO_F_BIO_PARSE_HOSTSERV = 136;
  BIO_F_BIO_PUTS = 110;
  BIO_F_BIO_READ = 111;
  BIO_F_BIO_READ_EX = 105;
  BIO_F_BIO_READ_INTERN = 120;
  BIO_F_BIO_SOCKET = 140;
  BIO_F_BIO_SOCKET_NBIO = 142;
  BIO_F_BIO_SOCK_INFO = 141;
  BIO_F_BIO_SOCK_INIT = 112;
  BIO_F_BIO_WRITE = 113;
  BIO_F_BIO_WRITE_EX = 119;
  BIO_F_BIO_WRITE_INTERN = 128;
  BIO_F_BUFFER_CTRL = 114;
  BIO_F_CONN_CTRL = 127;
  BIO_F_CONN_STATE = 115;
  BIO_F_DGRAM_SCTP_NEW = 149;
  BIO_F_DGRAM_SCTP_READ = 132;
  BIO_F_DGRAM_SCTP_WRITE = 133;
  BIO_F_DOAPR_OUTCH = 150;
  BIO_F_FILE_CTRL = 116;
  BIO_F_FILE_READ = 130;
  BIO_F_LINEBUFFER_CTRL = 129;
  BIO_F_LINEBUFFER_NEW = 151;
  BIO_F_MEM_WRITE = 117;
  BIO_F_NBIOF_NEW = 154;
  BIO_F_SLG_WRITE = 155;
  BIO_F_SSL_NEW = 118;

  (*
   * BIO reason codes.
   *)
  BIO_R_ACCEPT_ERROR =   100;
  BIO_R_ADDRINFO_ADDR_IS_NOT_AF_INET =  141;
  BIO_R_AMBIGUOUS_HOST_OR_SERVICE =  129;
  BIO_R_BAD_FOPEN_MODE =  101;
  BIO_R_BROKEN_PIPE =   124;
  BIO_R_CONNECT_ERROR =  103;
  BIO_R_GETHOSTBYNAME_ADDR_IS_NOT_AF_INET = 107;
  BIO_R_GETSOCKNAME_ERROR =  132;
  BIO_R_GETSOCKNAME_TRUNCATED_ADDRESS = 133;
  BIO_R_GETTING_SOCKTYPE =  134;
  BIO_R_INVALID_ARGUMENT =  125;
  BIO_R_INVALID_SOCKET =  135;
  BIO_R_IN_USE =   123;
  BIO_R_LENGTH_TOO_LONG =  102;
  BIO_R_LISTEN_V6_ONLY =  136;
  BIO_R_LOOKUP_RETURNED_NOTHING =  142;
  BIO_R_MALFORMED_HOST_OR_SERVICE =  130;
  BIO_R_NBIO_CONNECT_ERROR =  110;
  BIO_R_NO_ACCEPT_ADDR_OR_SERVICE_SPECIFIED = 143;
  BIO_R_NO_HOSTNAME_OR_SERVICE_SPECIFIED = 144;
  BIO_R_NO_PORT_DEFINED =  113;
  BIO_R_NO_SUCH_FILE =   128;
  BIO_R_NULL_PARAMETER =  115;
  BIO_R_UNABLE_TO_BIND_SOCKET =  117;
  BIO_R_UNABLE_TO_CREATE_SOCKET =  118;
  BIO_R_UNABLE_TO_KEEPALIVE =  137;
  BIO_R_UNABLE_TO_LISTEN_SOCKET =  119;
  BIO_R_UNABLE_TO_NODELAY =  138;
  BIO_R_UNABLE_TO_REUSEADDR =  139;
  BIO_R_UNAVAILABLE_IP_FAMILY =  145;
  BIO_R_UNINITIALIZED =  120;
  BIO_R_UNKNOWN_INFO_TYPE =  140;
  BIO_R_UNSUPPORTED_IP_FAMILY =  146;
  BIO_R_UNSUPPORTED_METHOD =  121;
  BIO_R_UNSUPPORTED_PROTOCOL_FAMILY =  131;
  BIO_R_WRITE_TO_READ_ONLY_BIO =  126;
  BIO_R_WSASTARTUP =   122;
  
var
  function ERR_load_BIO_strings: TIdC_INT;

implementation

end.
