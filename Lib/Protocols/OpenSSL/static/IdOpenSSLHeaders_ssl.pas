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

// Generation date: 29.10.2020 07:09:32

unit IdOpenSSLHeaders_ssl;

interface

// Headers for OpenSSL 1.1.1
// ssl.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_async,
  IdOpenSSLHeaders_bio,
  IdOpenSSLHeaders_crypto,
  IdOpenSSLHeaders_pem,
  IdOpenSSLHeaders_tls1,
  IdOpenSSLHeaders_ssl3,
  IdOpenSSLHeaders_x509;

{$MINENUMSIZE 4}

const
  (* OpenSSL version number for ASN.1 encoding of the session information *)
  (*-
   * Version 0 - initial version
   * Version 1 - added the optional peer certificate
   *)
  SSL_SESSION_ASN1_VERSION = $0001;
  
  SSL_MAX_SSL_SESSION_ID_LENGTH = 32;
  SSL_MAX_SID_CTX_LENGTH = 32;

  SSL_MIN_RSA_MODULUS_LENGTH_IN_BYTES = 512/8;
  SSL_MAX_KEY_ARG_LENGTH = 8;
  SSL_MAX_MASTER_KEY_LENGTH = 48;

  (* The maximum number of encrypt/decrypt pipelines we can support *)
  SSL_MAX_PIPELINES = 32;

  (* text strings for the ciphers *)

  (* These are used to specify which ciphers to use and not to use *)

  SSL_TXT_LOW = AnsiString('LOW');
  SSL_TXT_MEDIUM = AnsiString('MEDIUM');
  SSL_TXT_HIGH = AnsiString('HIGH');
  SSL_TXT_FIPS = AnsiString('FIPS');

  SSL_TXT_aNULL = AnsiString('aNULL');
  SSL_TXT_eNULL = AnsiString('eNULL');
  SSL_TXT_NULL = AnsiString('NULL');

  SSL_TXT_kRSA = AnsiString('kRSA');
  SSL_TXT_kDHr = AnsiString('kDHr');
  SSL_TXT_kDHd = AnsiString('kDHd');
  SSL_TXT_kDH = AnsiString('kDH');
  SSL_TXT_kEDH = AnsiString('kEDH');
  SSL_TXT_kDHE = AnsiString('kDHE');
  SSL_TXT_kECDHr = AnsiString('kECDHr');
//const SSL_TXT_kECDHe = AnsiString('kECDHe');
  SSL_TXT_kECDH = AnsiString('kECDH');
  SSL_TXT_kEECDH = AnsiString('kEECDH');
  SSL_TXT_kECDHE = AnsiString('kECDHE');
  SSL_TXT_kPSK = AnsiString('kPSK');
  SSL_TXT_kRSAPSK = AnsiString('kRSAPSK');
  SSL_TXT_kECDHEPSK = AnsiString('kECDHEPSK');
  SSL_TXT_kDHEPSK = AnsiString('kDHEPSK');
  SSL_TXT_kGOST = AnsiString('kGOST');
  SSL_TXT_kSRP = AnsiString('kSRP');

  SSL_TXT_aRSA = AnsiString('aRSA');
  SSL_TXT_aDSS = AnsiString('aDSS');
  SSL_TXT_aDH = AnsiString('aDH');
  SSL_TXT_aECDH = AnsiString('aECDH');
  SSL_TXT_aECDSA = AnsiString('aECDSA');
  SSL_TXT_aPSK = AnsiString('aPSK');
  SSL_TXT_aGOST94 = AnsiString('aGOST94');
  SSL_TXT_aGOST01 = AnsiString('aGOST01');
  SSL_TXT_aGOST12 = AnsiString('aGOST12');
  SSL_TXT_aGOST = AnsiString('aGOST');
  SSL_TXT_aSRP = AnsiString('aSRP');

  SSL_TXT_DSS = AnsiString('DSS');
  SSL_TXT_DH = AnsiString('DH');
  SSL_TXT_DHE = AnsiString('DHE');
  SSL_TXT_EDH = AnsiString('EDH');
  //SSL_TXT_ADH = AnsiString('ADH');
  SSL_TXT_RSA = AnsiString('RSA');
  SSL_TXT_ECDH = AnsiString('ECDH');
  SSL_TXT_EECDH = AnsiString('EECDH');
  SSL_TXT_ECDHE = AnsiString('ECDHE');
  //SSL_TXT_AECDH = AnsiString('AECDH');
  SSL_TXT_ECDSA = AnsiString('ECDSA');
  SSL_TXT_PSK = AnsiString('PSK');
  SSL_TXT_SRP = AnsiString('SRP');

  SSL_TXT_DES = AnsiString('DES');
  SSL_TXT_3DES = AnsiString('3DES');
  SSL_TXT_RC4 = AnsiString('RC4');
  SSL_TXT_RC2 = AnsiString('RC2');
  SSL_TXT_IDEA = AnsiString('IDEA');
  SSL_TXT_SEED = AnsiString('SEED');
  SSL_TXT_AES128 = AnsiString('AES128');
  SSL_TXT_AES256 = AnsiString('AES256');
  SSL_TXT_AES = AnsiString('AES');
  SSL_TXT_AES_GCM = AnsiString('AESGCM');
  SSL_TXT_AES_CCM = AnsiString('AESCCM');
  SSL_TXT_AES_CCM_8 = AnsiString('AESCCM8');
  SSL_TXT_CAMELLIA128 = AnsiString('CAMELLIA128');
  SSL_TXT_CAMELLIA256 = AnsiString('CAMELLIA256');
  SSL_TXT_CAMELLIA = AnsiString('CAMELLIA');
  SSL_TXT_CHACHA20 = AnsiString('CHACHA20');
  SSL_TXT_GOST = AnsiString('GOST89');
  SSL_TXT_ARIA = AnsiString('ARIA');
  SSL_TXT_ARIA_GCM = AnsiString('ARIAGCM');
  SSL_TXT_ARIA128 = AnsiString('ARIA128');
  SSL_TXT_ARIA256 = AnsiString('ARIA256');

  SSL_TXT_MD5 = AnsiString('MD5');
  SSL_TXT_SHA1 = AnsiString('SHA1');
  SSL_TXT_SHA = AnsiString('SHA');
  SSL_TXT_GOST94 = AnsiString('GOST94');
  SSL_TXT_GOST89MAC = AnsiString('GOST89MAC');
  SSL_TXT_GOST12 = AnsiString('GOST12');
  SSL_TXT_GOST89MAC12 = AnsiString('GOST89MAC12');
  SSL_TXT_SHA256 = AnsiString('SHA256');
  SSL_TXT_SHA384 = AnsiString('SHA384');

  SSL_TXT_SSLV3 = AnsiString('SSLv3');
  SSL_TXT_TLSV1 = AnsiString('TLSv1');
  SSL_TXT_TLSV1_1 = AnsiString('TLSv1.1');
  SSL_TXT_TLSV1_2 = AnsiString('TLSv1.2');

  SSL_TXT_ALL = AnsiString('ALL');

  (*-
   * COMPLEMENTOF* definitions. These identifiers are used to (de-select)
   * ciphers normally not being used.
   * Example: "RC4" will activate all ciphers using RC4 including ciphers
   * without authentication, which would normally disabled by DEFAULT (due
   * the "!ADH" being part of default). Therefore "RC4:!COMPLEMENTOFDEFAULT"
   * will make sure that it is also disabled in the specific selection.
   * COMPLEMENTOF* identifiers are portable between version, as adjustments
   * to the default cipher setup will also be included here.
   *
   * COMPLEMENTOFDEFAULT does not experience the same special treatment that
   * DEFAULT gets, as only selection is being done and no sorting as needed
   * for DEFAULT.
   *)
  SSL_TXT_CMPALL = AnsiString('COMPLEMENTOFALL');
  SSL_TXT_CMPDEF = AnsiString('COMPLEMENTOFDEFAULT');

  (*
   * The following cipher list is used by default. It also is substituted when
   * an application-defined cipher list string starts with 'DEFAULT'.
   * This applies to ciphersuites for TLSv1.2 and below.
   *)
  SSL_DEFAULT_CIPHER_LIST = AnsiString('ALL:!COMPLEMENTOFDEFAULT:!eNULL');
  (* This is the default set of TLSv1.3 ciphersuites *)
  TLS_DEFAULT_CIPHERSUITES = AnsiString('TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256');

  (*
   * As of OpenSSL 1.0.0, ssl_create_cipher_list() in ssl/ssl_ciph.c always
   * starts with a reasonable order, and all we have to do for DEFAULT is
   * throwing out anonymous and unencrypted ciphersuites! (The latter are not
   * actually enabled by ALL, but "ALL:RSA" would enable some of them.)
   *)

  (* Used in SSL_set_shutdown()/SSL_get_shutdown(); *)
  SSL_SENT_SHUTDOWN = 1;
  SSL_RECEIVED_SHUTDOWN = 2;

  SSL_FILETYPE_ASN1 = X509_FILETYPE_ASN1;
  SSL_FILETYPE_PEM = X509_FILETYPE_PEM;

  (* Extension context codes *)
  (* This extension is only allowed in TLS *)
  SSL_EXT_TLS_ONLY = $0001;
  (* This extension is only allowed in DTLS *)
  SSL_EXT_DTLS_ONLY = $0002;
  (* Some extensions may be allowed in DTLS but we don't implement them for it *)
  SSL_EXT_TLS_IMPLEMENTATION_ONLY = $0004;
  (* Most extensions are not defined for SSLv3 but EXT_TYPE_renegotiate is *)
  SSL_EXT_SSL3_ALLOWED = $0008;
  (* Extension is only defined for TLS1.2 and below *)
  SSL_EXT_TLS1_2_AND_BELOW_ONLY = $0010;
  (* Extension is only defined for TLS1.3 and above *)
  SSL_EXT_TLS1_3_ONLY = $0020;
  (* Ignore this extension during parsing if we are resuming *)
  SSL_EXT_IGNORE_ON_RESUMPTION = $0040;
  SSL_EXT_CLIENT_HELLO = $0080;
  (* Really means TLS1.2 or below *)
  SSL_EXT_TLS1_2_SERVER_HELLO = $0100;
  SSL_EXT_TLS1_3_SERVER_HELLO = $0200;
  SSL_EXT_TLS1_3_ENCRYPTED_EXTENSIONS = $0400;
  SSL_EXT_TLS1_3_HELLO_RETRY_REQUEST = $0800;
  SSL_EXT_TLS1_3_CERTIFICATE = $1000;
  SSL_EXT_TLS1_3_NEW_SESSION_TICKET = $2000;
  SSL_EXT_TLS1_3_CERTIFICATE_REQUEST = $4000;

  (*
   * Some values are reserved until OpenSSL 1.2.0 because they were previously
   * included in SSL_OP_ALL in a 1.1.x release.
   *
   * Reserved value (until OpenSSL 1.2.0)                  $00000001U
   * Reserved value (until OpenSSL 1.2.0)                  $00000002U
   *)
  (* Allow initial connection to servers that don't support RI *)
  SSL_OP_LEGACY_SERVER_CONNECT = TIdC_UINT($00000004);

  (* Reserved value (until OpenSSL 1.2.0)                  $00000008U *)
  SSL_OP_TLSEXT_PADDING =      TIdC_UINT($00000010);
  (* Reserved value (until OpenSSL 1.2.0)                  $00000020U *)
  SSL_OP_SAFARI_ECDHE_ECDSA_BUG = TIdC_UINT($00000040);
  (*
   * Reserved value (until OpenSSL 1.2.0)                  $00000080U
   * Reserved value (until OpenSSL 1.2.0)                  $00000100U
   * Reserved value (until OpenSSL 1.2.0)                  $00000200U
   *)

  (* In TLSv1.3 allow a non-(ec)dhe based kex_mode *)
  SSL_OP_ALLOW_NO_DHE_KEX                         = TIdC_UINT($00000400);

  (*
   * Disable SSL 3.0/TLS 1.0 CBC vulnerability workaround that was added in
   * OpenSSL 0.9.6d.  Usually (depending on the application protocol) the
   * workaround is not needed.  Unfortunately some broken SSL/TLS
   * implementations cannot handle it at all, which is why we include it in
   * SSL_OP_ALL. Added in 0.9.6e
   *)
  SSL_OP_DONT_INSERT_EMPTY_FRAGMENTS              = TIdC_UINT($00000800);

  (* DTLS options *)
  SSL_OP_NO_QUERY_MTU                             = TIdC_UINT($00001000);
  (* Turn on Cookie Exchange (on relevant for servers) *)
  SSL_OP_COOKIE_EXCHANGE                          = TIdC_UINT($00002000);
  (* Don't use RFC4507 ticket extension *)
  SSL_OP_NO_TICKET                                = TIdC_UINT($00004000);
  (* Use Cisco's "speshul" version of DTLS_BAD_VER
   * (only with deprecated DTLSv1_client_method())  *)
  SSL_OP_CISCO_ANYCONNECT                        = TIdC_UINT($00008000);

  (* As server, disallow session resumption on renegotiation *)
  SSL_OP_NO_SESSION_RESUMPTION_ON_RENEGOTIATION   = TIdC_UINT($00010000);
  (* Don't use compression even if supported *)
  SSL_OP_NO_COMPRESSION                           = TIdC_UINT($00020000);
  (* Permit unsafe legacy renegotiation *)
  SSL_OP_ALLOW_UNSAFE_LEGACY_RENEGOTIATION        = TIdC_UINT($00040000);
  (* Disable encrypt-then-mac *)
  SSL_OP_NO_ENCRYPT_THEN_MAC                      = TIdC_UINT($00080000);

  (*
   * Enable TLSv1.3 Compatibility mode. This is on by default. A future version
   * of OpenSSL may have this disabled by default.
   *)
  SSL_OP_ENABLE_MIDDLEBOX_COMPAT                  = TIdC_UINT($00100000);

  (* Prioritize Chacha20Poly1305 when client does.
   * Modifies SSL_OP_CIPHER_SERVER_PREFERENCE *)
  SSL_OP_PRIORITIZE_CHACHA                        = TIdC_UINT($00200000);

  (*
   * Set on servers to choose the cipher according to the server's preferences
   *)
  SSL_OP_CIPHER_SERVER_PREFERENCE                 = TIdC_UINT($00400000);
  (*
   * If set, a server will allow a client to issue a SSLv3.0 version number as
   * latest version supported in the premaster secret, even when TLSv1.0
   * (version 3.1) was announced in the client hello. Normally this is
   * forbidden to prevent version rollback attacks.
   *)
  SSL_OP_TLS_ROLLBACK_BUG                         = TIdC_UINT($00800000);

  (*
   * Switches off automatic TLSv1.3 anti-replay protection for early data. This
   * is a server-side option only (no effect on the client).
   *)
  SSL_OP_NO_ANTI_REPLAY                           = TIdC_UINT($01000000);

  SSL_OP_NO_SSLv3                                 = TIdC_UINT($02000000);
  SSL_OP_NO_TLSv1                                 = TIdC_UINT($04000000);
  SSL_OP_NO_TLSv1_2                               = TIdC_UINT($08000000);
  SSL_OP_NO_TLSv1_1                               = TIdC_UINT($10000000);
  SSL_OP_NO_TLSv1_3                               = TIdC_UINT($20000000);

  SSL_OP_NO_DTLSv1                                = TIdC_UINT($04000000);
  SSL_OP_NO_DTLSv1_2                              = TIdC_UINT($08000000);

  SSL_OP_NO_SSL_MASK = SSL_OP_NO_SSLv3 or SSL_OP_NO_TLSv1 or SSL_OP_NO_TLSv1_1
    or SSL_OP_NO_TLSv1_2 or SSL_OP_NO_TLSv1_3;
  SSL_OP_NO_DTLS_MASK = SSL_OP_NO_DTLSv1 or SSL_OP_NO_DTLSv1_2;

  (* Disallow all renegotiation *)
  SSL_OP_NO_RENEGOTIATION                         = TIdC_UINT($40000000);

  (*
   * Make server add server-hello extension from early version of cryptopro
   * draft, when GOST ciphersuite is negotiated. Required for interoperability
   * with CryptoPro CSP 3.x
   *)
  SSL_OP_CRYPTOPRO_TLSEXT_BUG                     = TIdC_UINT($80000000);

  (*
   * SSL_OP_ALL: various bug workarounds that should be rather harmless.
   * This used to be $000FFFFFL before 0.9.7.
   * This used to be $80000BFFU before 1.1.1.
   *)
  SSL_OP_ALL = SSL_OP_CRYPTOPRO_TLSEXT_BUG or SSL_OP_DONT_INSERT_EMPTY_FRAGMENTS
    or SSL_OP_LEGACY_SERVER_CONNECT or SSL_OP_TLSEXT_PADDING or SSL_OP_SAFARI_ECDHE_ECDSA_BUG;

  (* OBSOLETE OPTIONS: retained for compatibility *)

  (* Removed from OpenSSL 1.1.0. Was $00000001L *)
  (* Related to removed SSLv2. *)
  SSL_OP_MICROSOFT_SESS_ID_BUG                    = $0;
  (* Removed from OpenSSL 1.1.0. Was $00000002L *)
  (* Related to removed SSLv2. *)
  SSL_OP_NETSCAPE_CHALLENGE_BUG                   = $0;
  (* Removed from OpenSSL 0.9.8q and 1.0.0c. Was $00000008L *)
  (* Dead forever, see CVE-2010-4180 *)
  SSL_OP_NETSCAPE_REUSE_CIPHER_CHANGE_BUG         = $0;
  (* Removed from OpenSSL 1.0.1h and 1.0.2. Was $00000010L *)
  (* Refers to ancient SSLREF and SSLv2. *)
  SSL_OP_SSLREF2_REUSE_CERT_TYPE_BUG              = $0;
  (* Removed from OpenSSL 1.1.0. Was $00000020 *)
  SSL_OP_MICROSOFT_BIG_SSLV3_BUFFER               = $0;
  (* Removed from OpenSSL 0.9.7h and 0.9.8b. Was $00000040L *)
  SSL_OP_MSIE_SSLV2_RSA_PADDING                   = $0;
  (* Removed from OpenSSL 1.1.0. Was $00000080 *)
  (* Ancient SSLeay version. *)
  SSL_OP_SSLEAY_080_CLIENT_DH_BUG                 = $0;
  (* Removed from OpenSSL 1.1.0. Was $00000100L *)
  SSL_OP_TLS_D5_BUG                               = $0;
  (* Removed from OpenSSL 1.1.0. Was $00000200L *)
  SSL_OP_TLS_BLOCK_PADDING_BUG                    = $0;
  (* Removed from OpenSSL 1.1.0. Was $00080000L *)
  SSL_OP_SINGLE_ECDH_USE                          = $0;
  (* Removed from OpenSSL 1.1.0. Was $00100000L *)
  SSL_OP_SINGLE_DH_USE                            = $0;
  (* Removed from OpenSSL 1.0.1k and 1.0.2. Was $00200000L *)
  SSL_OP_EPHEMERAL_RSA                            = $0;
  (* Removed from OpenSSL 1.1.0. Was $01000000L *)
  SSL_OP_NO_SSLv2                                 = $0;
  (* Removed from OpenSSL 1.0.1. Was $08000000L *)
  SSL_OP_PKCS1_CHECK_1                            = $0;
  (* Removed from OpenSSL 1.0.1. Was $10000000L *)
  SSL_OP_PKCS1_CHECK_2                            = $0;
  (* Removed from OpenSSL 1.1.0. Was $20000000L *)
  SSL_OP_NETSCAPE_CA_DN_BUG                       = $0;
  (* Removed from OpenSSL 1.1.0. Was $40000000L *)
  SSL_OP_NETSCAPE_DEMO_CIPHER_CHANGE_BUG          = $0;

  (*
   * Allow SSL_write(..., n) to return r with 0 < r < n (i.e. report success
   * when just a single record has been written):
   *)
  SSL_MODE_ENABLE_PARTIAL_WRITE = TIdC_UINT($00000001);
  (*
   * Make it possible to retry SSL_write() with changed buffer location (buffer
   * contents must stay the same!); this is not the default to avoid the
   * misconception that non-blocking SSL_write() behaves like non-blocking
   * write():
   *)
  SSL_MODE_ACCEPT_MOVING_WRITE_BUFFER = TIdC_UINT($00000002);
  (*
   * Never bother the application with retries if the transport is blocking:
   *)
  SSL_MODE_AUTO_RETRY = TIdC_UINT($00000004);
  (* Don't attempt to automatically build certificate chain *)
  SSL_MODE_NO_AUTO_CHAIN = TIdC_UINT($00000008);
  (*
   * Save RAM by releasing read and write buffers when they're empty. (SSL3 and
   * TLS only.) Released buffers are freed.
   *)
  SSL_MODE_RELEASE_BUFFERS = TIdC_UINT($00000010);
  (*
   * Send the current time in the Random fields of the ClientHello and
   * ServerHello records for compatibility with hypothetical implementations
   * that require it.
   *)
  SSL_MODE_SEND_CLIENTHELLO_TIME = TIdC_UINT($00000020);
  SSL_MODE_SEND_SERVERHELLO_TIME = TIdC_UINT($00000040);
  (*
   * Send TLS_FALLBACK_SCSV in the ClientHello. To be set only by applications
   * that reconnect with a downgraded protocol version; see
   * draft-ietf-tls-downgrade-scsv-00 for details. DO NOT ENABLE THIS if your
   * application attempts a normal handshake. Only use this in explicit
   * fallback retries, following the guidance in
   * draft-ietf-tls-downgrade-scsv-00.
   *)
  SSL_MODE_SEND_FALLBACK_SCSV = TIdC_UINT($00000080);
  (*
   * Support Asynchronous operation
   *)
  SSL_MODE_ASYNC = TIdC_UINT($00000100);

  (*
   * When using DTLS/SCTP, include the terminating zero in the label
   * used for computing the endpoint-pair shared secret. Required for
   * interoperability with implementations having this bug like these
   * older version of OpenSSL:
   * - OpenSSL 1.0.0 series
   * - OpenSSL 1.0.1 series
   * - OpenSSL 1.0.2 series
   * - OpenSSL 1.1.0 series
   * - OpenSSL 1.1.1 and 1.1.1a
   *)
  SSL_MODE_DTLS_SCTP_LABEL_LENGTH_BUG = TIdC_UINT($00000400);

  (* Cert related flags *)
  (*
   * Many implementations ignore some aspects of the TLS standards such as
   * enforcing certificate chain algorithms. When this is set we enforce them.
   *)
  SSL_CERT_FLAG_TLS_STRICT = TIdC_UINT($00000001);
  (* Suite B modes, takes same values as certificate verify flags *)
  SSL_CERT_FLAG_SUITEB_128_LOS_ONLY = $10000;
  (* Suite B 192 bit only mode *)
  SSL_CERT_FLAG_SUITEB_192_LOS = $20000;
  (* Suite B 128 bit mode allowing 192 bit algorithms *)
  SSL_CERT_FLAG_SUITEB_128_LOS = $30000;

  (* Perform all sorts of protocol violations for testing purposes *)
  SSL_CERT_FLAG_BROKEN_PROTOCOL = $10000000;

  (* Flags for building certificate chains *)
  (* Treat any existing certificates as untrusted CAs *)
  SSL_BUILD_CHAIN_FLAG_UNTRUSTED = $1;
  (* Don't include root CA in chain *)
  SSL_BUILD_CHAIN_FLAG_NO_ROOT = $2;
  (* Just check certificates already there *)
  SSL_BUILD_CHAIN_FLAG_CHECK = $4;
  (* Ignore verification errors *)
  SSL_BUILD_CHAIN_FLAG_IGNORE_ERROR = $8;
  (* Clear verification errors from queue *)
  SSL_BUILD_CHAIN_FLAG_CLEAR_ERROR = $10;

  (* Flags returned by SSL_check_chain *)
  (* Certificate can be used with this session *)
  CERT_PKEY_VALID = $1;
  (* Certificate can also be used for signing *)
  CERT_PKEY_SIGN = $2;
  (* EE certificate signing algorithm OK *)
  CERT_PKEY_EE_SIGNATURE = $10;
  (* CA signature algorithms OK *)
  CERT_PKEY_CA_SIGNATURE = $20;
  (* EE certificate parameters OK *)
  CERT_PKEY_EE_PARAM = $40;
  (* CA certificate parameters OK *)
  CERT_PKEY_CA_PARAM = $80;
  (* Signing explicitly allowed as opposed to SHA1 fallback *)
  CERT_PKEY_EXPLICIT_SIGN = $100;
  (* Client CA issuer names match (always set for server cert) *)
  CERT_PKEY_ISSUER_NAME = $200;
  (* Cert type matches client types (always set for server cert) *)
  CERT_PKEY_CERT_TYPE = $400;
  (* Cert chain suitable to Suite B *)
  CERT_PKEY_SUITEB = $800;

  SSL_CONF_FLAG_CMDLINE = $1;
  SSL_CONF_FLAG_FILE = $2;
  SSL_CONF_FLAG_CLIENT = $4;
  SSL_CONF_FLAG_SERVER = $8;
  SSL_CONF_FLAG_SHOW_ERRORS = $10;
  SSL_CONF_FLAG_CERTIFICATE = $20;
  SSL_CONF_FLAG_REQUIRE_PRIVATE = $40;
  (* Configuration value types *)
  SSL_CONF_TYPE_UNKNOWN = $0;
  SSL_CONF_TYPE_STRING = $1;
  SSL_CONF_TYPE_FILE = $2;
  SSL_CONF_TYPE_DIR = $3;
  SSL_CONF_TYPE_NONE = $4;

  (* Maximum length of the application-controlled segment of a a TLSv1.3 cookie *)
  SSL_COOKIE_LENGTH = 4096;

  (* 100k max cert list *)
  SSL_MAX_CERT_LIST_DEFAULT = 1024 * 100;
  SSL_SESSION_CACHE_MAX_SIZE_DEFAULT = 1024 * 20;

  SSL_SESS_CACHE_OFF = $0000;
  SSL_SESS_CACHE_CLIENT = $0001;
  SSL_SESS_CACHE_SERVER = $0002;
  SSL_SESS_CACHE_BOTH = (SSL_SESS_CACHE_CLIENT or SSL_SESS_CACHE_SERVER);
  SSL_SESS_CACHE_NO_AUTO_CLEAR = $0080;
  (* enough comments already ... see SSL_CTX_set_session_cache_mode(3) *)
  SSL_SESS_CACHE_NO_INTERNAL_LOOKUP = $0100;
  SSL_SESS_CACHE_NO_INTERNAL_STORE = $0200;
  SSL_SESS_CACHE_NO_INTERNAL = (SSL_SESS_CACHE_NO_INTERNAL_LOOKUP or SSL_SESS_CACHE_NO_INTERNAL_STORE);

  OPENSSL_NPN_UNSUPPORTED = 0;
  OPENSSL_NPN_NEGOTIATED = 1;
  OPENSSL_NPN_NO_OVERLAP = 2;

  (*
   * the maximum length of the buffer given to callbacks containing the
   * resulting identity/psk
   *)
  PSK_MAX_IDENTITY_LEN = 128;
  PSK_MAX_PSK_LEN = 256;

  SSL_NOTHING = 1;
  SSL_WRITING = 2;
  SSL_READING = 3;
  SSL_X509_LOOKUP = 4;
  SSL_ASYNC_PAUSED = 5;
  SSL_ASYNC_NO_JOBS = 6;
  SSL_CLIENT_HELLO_CB = 7;

  SSL_MAC_FLAG_READ_MAC_STREAM = 1;
  SSL_MAC_FLAG_WRITE_MAC_STREAM = 2;

  (* TLSv1.3 KeyUpdate message types *)
  (* -1 used so that this is an invalid value for the on-the-wire protocol *)
  SSL_KEY_UPDATE_NONE = -1;
  (* Values as defined for the on-the-wire protocol *)
  SSL_KEY_UPDATE_NOT_REQUESTED = 0;
  SSL_KEY_UPDATE_REQUESTED = 1;

  (*
   * Most of the following state values are no longer used and are defined to be
   * the closest equivalent value in_ the current state machine code. Not all
   * defines have an equivalent and are set to a dummy value (-1). SSL_ST_CONNECT
   * and SSL_ST_ACCEPT are still in_ use in_ the definition of SSL_CB_ACCEPT_LOOP,
   * SSL_CB_ACCEPT_EXIT, SSL_CB_CONNECT_LOOP and SSL_CB_CONNECT_EXIT.
   *)
  SSL_ST_CONNECT = $1000;
  SSL_ST_ACCEPT = $2000;
  
  SSL_ST_MASK = $0FFF;
  
  SSL_CB_LOOP = $01;
  SSL_CB_EXIT = $02;
  SSL_CB_READ = $04;
  SSL_CB_WRITE = $08;
  SSL_CB_ALERT = $4000;
  SSL_CB_READ_ALERT = SSL_CB_ALERT or SSL_CB_READ;
  SSL_CB_WRITE_ALERT = SSL_CB_ALERT or SSL_CB_WRITE;
  SSL_CB_ACCEPT_LOOP = SSL_ST_ACCEPT or SSL_CB_LOOP;
  SSL_CB_ACCEPT_EXIT = SSL_ST_ACCEPT or SSL_CB_EXIT;
  SSL_CB_CONNECT_LOOP = SSL_ST_CONNECT or SSL_CB_LOOP;
  SSL_CB_CONNECT_EXIT = SSL_ST_CONNECT or SSL_CB_EXIT;
  SSL_CB_HANDSHAKE_START = $10;
  SSL_CB_HANDSHAKE_DONE = $20;

  (*
   * The following 3 states are kept in ssl->rlayer.rstate when reads fail, you
   * should not need these
   *)
  SSL_ST_READ_HEADER = $F0;
  SSL_ST_READ_BODY = $F1;
  SSL_ST_READ_DONE = $F2;

  (*
   * use either SSL_VERIFY_NONE or SSL_VERIFY_PEER, the last 3 options are
   * 'ored' with SSL_VERIFY_PEER if they are desired
   *)
  SSL_VERIFY_NONE = $00;
  SSL_VERIFY_PEER = $01;
  SSL_VERIFY_FAIL_IF_NO_PEER_CERT = $02;
  SSL_VERIFY_CLIENT_ONCE = $04;
  SSL_VERIFY_POST_HANDSHAKE = $08;

  SSL_AD_REASON_OFFSET = 1000; (* offset to get SSL_R_... value
                                * from SSL_AD_... *)
  (* These alert types are for SSLv3 and TLSv1 *)
  SSL_AD_CLOSE_NOTIFY = SSL3_AD_CLOSE_NOTIFY;
  (* fatal *)
  SSL_AD_UNEXPECTED_MESSAGE = SSL3_AD_UNEXPECTED_MESSAGE;
  (* fatal *)
  SSL_AD_BAD_RECORD_MAC = SSL3_AD_BAD_RECORD_MAC;
  SSL_AD_DECRYPTION_FAILED = TLS1_AD_DECRYPTION_FAILED;
  SSL_AD_RECORD_OVERFLOW = TLS1_AD_RECORD_OVERFLOW;
  (* fatal *)
  SSL_AD_DECOMPRESSION_FAILURE = SSL3_AD_DECOMPRESSION_FAILURE;
  (* fatal *)
  SSL_AD_HANDSHAKE_FAILURE = SSL3_AD_HANDSHAKE_FAILURE;
  (* Not for TLS *)
  SSL_AD_NO_CERTIFICATE = SSL3_AD_NO_CERTIFICATE;
  SSL_AD_BAD_CERTIFICATE = SSL3_AD_BAD_CERTIFICATE;
  SSL_AD_UNSUPPORTED_CERTIFICATE = SSL3_AD_UNSUPPORTED_CERTIFICATE;
  SSL_AD_CERTIFICATE_REVOKED = SSL3_AD_CERTIFICATE_REVOKED;
  SSL_AD_CERTIFICATE_EXPIRED = SSL3_AD_CERTIFICATE_EXPIRED;
  SSL_AD_CERTIFICATE_UNKNOWN = SSL3_AD_CERTIFICATE_UNKNOWN;
  (* fatal *)
  SSL_AD_ILLEGAL_PARAMETER = SSL3_AD_ILLEGAL_PARAMETER;
  (* fatal *)
  SSL_AD_UNKNOWN_CA = TLS1_AD_UNKNOWN_CA;
  (* fatal *)
  SSL_AD_ACCESS_DENIED = TLS1_AD_ACCESS_DENIED;
  (* fatal *)
  SSL_AD_DECODE_ERROR = TLS1_AD_DECODE_ERROR;
  SSL_AD_DECRYPT_ERROR = TLS1_AD_DECRYPT_ERROR;
  (* fatal *)
  SSL_AD_EXPORT_RESTRICTION = TLS1_AD_EXPORT_RESTRICTION;
  (* fatal *)
  SSL_AD_PROTOCOL_VERSION = TLS1_AD_PROTOCOL_VERSION;
  (* fatal *)
  SSL_AD_INSUFFICIENT_SECURITY = TLS1_AD_INSUFFICIENT_SECURITY;
  (* fatal *)
  SSL_AD_INTERNAL_ERROR = TLS1_AD_INTERNAL_ERROR;
  SSL_AD_USER_CANCELLED = TLS1_AD_USER_CANCELLED;
  SSL_AD_NO_RENEGOTIATION = TLS1_AD_NO_RENEGOTIATION;
  SSL_AD_MISSING_EXTENSION = TLS13_AD_MISSING_EXTENSION;
  SSL_AD_CERTIFICATE_REQUIRED = TLS13_AD_CERTIFICATE_REQUIRED;
  SSL_AD_UNSUPPORTED_EXTENSION = TLS1_AD_UNSUPPORTED_EXTENSION;
  SSL_AD_CERTIFICATE_UNOBTAINABLE = TLS1_AD_CERTIFICATE_UNOBTAINABLE;
  SSL_AD_UNRECOGNIZED_NAME = TLS1_AD_UNRECOGNIZED_NAME;
  SSL_AD_BAD_CERTIFICATE_STATUS_RESPONSE = TLS1_AD_BAD_CERTIFICATE_STATUS_RESPONSE;
  SSL_AD_BAD_CERTIFICATE_HASH_VALUE = TLS1_AD_BAD_CERTIFICATE_HASH_VALUE;
  (* fatal *)
  SSL_AD_UNKNOWN_PSK_IDENTITY = TLS1_AD_UNKNOWN_PSK_IDENTITY;
  (* fatal *)
  SSL_AD_INAPPROPRIATE_FALLBACK = TLS1_AD_INAPPROPRIATE_FALLBACK;
  SSL_AD_NO_APPLICATION_PROTOCOL = TLS1_AD_NO_APPLICATION_PROTOCOL;
  SSL_ERROR_NONE = 0;
  SSL_ERROR_SSL = 1;
  SSL_ERROR_WANT_READ = 2;
  SSL_ERROR_WANT_WRITE = 3;
  SSL_ERROR_WANT_X509_LOOKUP = 4;
  SSL_ERROR_SYSCALL = 5; (* look at error stack/return
                          * value/errno *)
  SSL_ERROR_ZERO_RETURN = 6;
  SSL_ERROR_WANT_CONNECT = 7;
  SSL_ERROR_WANT_ACCEPT = 8;
  SSL_ERROR_WANT_ASYNC = 9;
  SSL_ERROR_WANT_ASYNC_JOB = 10;
  SSL_ERROR_WANT_CLIENT_HELLO_CB = 11;
  SSL_CTRL_SET_TMP_DH = 3;
  SSL_CTRL_SET_TMP_ECDH = 4;
  SSL_CTRL_SET_TMP_DH_CB = 6;
  SSL_CTRL_GET_CLIENT_CERT_REQUEST = 9;
  SSL_CTRL_GET_NUM_RENEGOTIATIONS = 10;
  SSL_CTRL_CLEAR_NUM_RENEGOTIATIONS = 11;
  SSL_CTRL_GET_TOTAL_RENEGOTIATIONS = 12;
  SSL_CTRL_GET_FLAGS = 13;
  SSL_CTRL_EXTRA_CHAIN_CERT = 14;
  SSL_CTRL_SET_MSG_CALLBACK = 15;
  SSL_CTRL_SET_MSG_CALLBACK_ARG = 16;
  (* only applies to datagram connections *)
  SSL_CTRL_SET_MTU = 17;
  (* Stats *)
  SSL_CTRL_SESS_NUMBER = 20;
  SSL_CTRL_SESS_CONNECT = 21;
  SSL_CTRL_SESS_CONNECT_GOOD = 22;
  SSL_CTRL_SESS_CONNECT_RENEGOTIATE = 23;
  SSL_CTRL_SESS_ACCEPT = 24;
  SSL_CTRL_SESS_ACCEPT_GOOD = 25;
  SSL_CTRL_SESS_ACCEPT_RENEGOTIATE = 26;
  SSL_CTRL_SESS_HIT = 27;
  SSL_CTRL_SESS_CB_HIT = 28;
  SSL_CTRL_SESS_MISSES = 29;
  SSL_CTRL_SESS_TIMEOUTS = 30;
  SSL_CTRL_SESS_CACHE_FULL = 31;
  SSL_CTRL_MODE = 33;
  SSL_CTRL_GET_READ_AHEAD = 40;
  SSL_CTRL_SET_READ_AHEAD = 41;
  SSL_CTRL_SET_SESS_CACHE_SIZE = 42;
  SSL_CTRL_GET_SESS_CACHE_SIZE = 43;
  SSL_CTRL_SET_SESS_CACHE_MODE = 44;
  SSL_CTRL_GET_SESS_CACHE_MODE = 45;
  SSL_CTRL_GET_MAX_CERT_LIST = 50;
  SSL_CTRL_SET_MAX_CERT_LIST = 51;
  SSL_CTRL_SET_MAX_SEND_FRAGMENT = 52;
  (* see tls1.h for macros based on these *)
  SSL_CTRL_SET_TLSEXT_SERVERNAME_CB = 53;
  SSL_CTRL_SET_TLSEXT_SERVERNAME_ARG = 54;
  SSL_CTRL_SET_TLSEXT_HOSTNAME = 55;
  SSL_CTRL_SET_TLSEXT_DEBUG_CB = 56;
  SSL_CTRL_SET_TLSEXT_DEBUG_ARG = 57;
  SSL_CTRL_GET_TLSEXT_TICKET_KEYS = 58;
  SSL_CTRL_SET_TLSEXT_TICKET_KEYS = 59;
  SSL_CTRL_SET_TLSEXT_STATUS_REQ_CB = 63;
  SSL_CTRL_SET_TLSEXT_STATUS_REQ_CB_ARG = 64;
  SSL_CTRL_SET_TLSEXT_STATUS_REQ_TYPE = 65;
  SSL_CTRL_GET_TLSEXT_STATUS_REQ_EXTS = 66;
  SSL_CTRL_SET_TLSEXT_STATUS_REQ_EXTS = 67;
  SSL_CTRL_GET_TLSEXT_STATUS_REQ_IDS = 68;
  SSL_CTRL_SET_TLSEXT_STATUS_REQ_IDS = 69;
  SSL_CTRL_GET_TLSEXT_STATUS_REQ_OCSP_RESP = 70;
  SSL_CTRL_SET_TLSEXT_STATUS_REQ_OCSP_RESP = 71;
  SSL_CTRL_SET_TLSEXT_TICKET_KEY_CB = 72;
  SSL_CTRL_SET_TLS_EXT_SRP_USERNAME_CB = 75;
  SSL_CTRL_SET_SRP_VERIFY_PARAM_CB = 76;
  SSL_CTRL_SET_SRP_GIVE_CLIENT_PWD_CB = 77;
  SSL_CTRL_SET_SRP_ARG = 78;
  SSL_CTRL_SET_TLS_EXT_SRP_USERNAME = 79;
  SSL_CTRL_SET_TLS_EXT_SRP_STRENGTH = 80;
  SSL_CTRL_SET_TLS_EXT_SRP_PASSWORD = 81;
  SSL_CTRL_DTLS_EXT_SEND_HEARTBEAT = 85;
  SSL_CTRL_GET_DTLS_EXT_HEARTBEAT_PENDING = 86;
  SSL_CTRL_SET_DTLS_EXT_HEARTBEAT_NO_REQUESTS = 87;
  DTLS_CTRL_GET_TIMEOUT = 73;
  DTLS_CTRL_HANDLE_TIMEOUT = 74;
  SSL_CTRL_GET_RI_SUPPORT = 76;
  SSL_CTRL_CLEAR_MODE = 78;
  SSL_CTRL_SET_NOT_RESUMABLE_SESS_CB = 79;
  SSL_CTRL_GET_EXTRA_CHAIN_CERTS = 82;
  SSL_CTRL_CLEAR_EXTRA_CHAIN_CERTS = 83;
  SSL_CTRL_CHAIN = 88;
  SSL_CTRL_CHAIN_CERT = 89;
  SSL_CTRL_GET_GROUPS = 90;
  SSL_CTRL_SET_GROUPS = 91;
  SSL_CTRL_SET_GROUPS_LIST = 92;
  SSL_CTRL_GET_SHARED_GROUP = 93;
  SSL_CTRL_SET_SIGALGS = 97;
  SSL_CTRL_SET_SIGALGS_LIST = 98;
  SSL_CTRL_CERT_FLAGS = 99;
  SSL_CTRL_CLEAR_CERT_FLAGS = 100;
  SSL_CTRL_SET_CLIENT_SIGALGS = 101;
  SSL_CTRL_SET_CLIENT_SIGALGS_LIST = 102;
  SSL_CTRL_GET_CLIENT_CERT_TYPES = 103;
  SSL_CTRL_SET_CLIENT_CERT_TYPES = 104;
  SSL_CTRL_BUILD_CERT_CHAIN = 105;
  SSL_CTRL_SET_VERIFY_CERT_STORE = 106;
  SSL_CTRL_SET_CHAIN_CERT_STORE = 107;
  SSL_CTRL_GET_PEER_SIGNATURE_NID = 108;
  SSL_CTRL_GET_PEER_TMP_KEY = 109;
  SSL_CTRL_GET_RAW_CIPHERLIST = 110;
  SSL_CTRL_GET_EC_POINT_FORMATS = 111;
  SSL_CTRL_GET_CHAIN_CERTS = 115;
  SSL_CTRL_SELECT_CURRENT_CERT = 116;
  SSL_CTRL_SET_CURRENT_CERT = 117;
  SSL_CTRL_SET_DH_AUTO = 118;
  DTLS_CTRL_SET_LINK_MTU = 120;
  DTLS_CTRL_GET_LINK_MIN_MTU = 121;
  SSL_CTRL_GET_EXTMS_SUPPORT = 122;
  SSL_CTRL_SET_MIN_PROTO_VERSION = 123;
  SSL_CTRL_SET_MAX_PROTO_VERSION = 124;
  SSL_CTRL_SET_SPLIT_SEND_FRAGMENT = 125;
  SSL_CTRL_SET_MAX_PIPELINES = 126;
  SSL_CTRL_GET_TLSEXT_STATUS_REQ_TYPE = 127;
  SSL_CTRL_GET_TLSEXT_STATUS_REQ_CB = 128;
  SSL_CTRL_GET_TLSEXT_STATUS_REQ_CB_ARG = 129;
  SSL_CTRL_GET_MIN_PROTO_VERSION = 130;
  SSL_CTRL_GET_MAX_PROTO_VERSION = 131;
  SSL_CTRL_GET_SIGNATURE_NID = 132;
  SSL_CTRL_GET_TMP_KEY = 133;
  SSL_CERT_SET_FIRST = 1;
  SSL_CERT_SET_NEXT = 2;
  SSL_CERT_SET_SERVER = 3;

  (*
   * The following symbol names are old and obsolete. They are kept
   * for compatibility reasons only and should not be used anymore.
   *)
  SSL_CTRL_GET_CURVES = SSL_CTRL_GET_GROUPS;
  SSL_CTRL_SET_CURVES = SSL_CTRL_SET_GROUPS;
  SSL_CTRL_SET_CURVES_LIST = SSL_CTRL_SET_GROUPS_LIST;
  SSL_CTRL_GET_SHARED_CURVE = SSL_CTRL_GET_SHARED_GROUP;
  
//  SSL_get1_curves = SSL_get1_groups;
//  SSL_CTX_set1_curves = SSL_CTX_set1_groups;
//  SSL_CTX_set1_curves_list = SSL_CTX_set1_groups_list;
//  SSL_set1_curves = SSL_set1_groups;
//  SSL_set1_curves_list = SSL_set1_groups_list;
//  SSL_get_shared_curve = SSL_get_shared_group;

  (* serverinfo file format versions *)
  SSL_SERVERINFOV1 = 1;
  SSL_SERVERINFOV2 = 2;

  SSL_CLIENT_HELLO_SUCCESS = 1;
  SSL_CLIENT_HELLO_ERROR = 0;
  SSL_CLIENT_HELLO_RETRY = -1;

  SSL_READ_EARLY_DATA_ERROR = 0;
  SSL_READ_EARLY_DATA_SUCCESS = 1;
  SSL_READ_EARLY_DATA_FINISH = 2;

  SSL_EARLY_DATA_NOT_SENT = 0;
  SSL_EARLY_DATA_REJECTED = 1;
  SSL_EARLY_DATA_ACCEPTED = 2;

  //SSLv23_method = TLS_method;
  //SSLv23_server_method = TLS_server_method;
  //SSLv23_client_method = TLS_client_method;

  (* What the 'other' parameter contains in_ security callback *)
  (* Mask for type *)
  SSL_SECOP_OTHER_TYPE = $ffff0000;
  SSL_SECOP_OTHER_NONE = 0;
  SSL_SECOP_OTHER_CIPHER = (1 shl 16);
  SSL_SECOP_OTHER_CURVE = (2 shl 16);
  SSL_SECOP_OTHER_DH = (3 shl 16);
  SSL_SECOP_OTHER_PKEY = (4 shl 16);
  SSL_SECOP_OTHER_SIGALG = (5 shl 16);
  SSL_SECOP_OTHER_CERT = (6 shl 16);

  (* Indicated operation refers to peer key or certificate *)
  SSL_SECOP_PEER = $1000;

  (* Values for "op" parameter in security callback *)

  (* Called to filter ciphers *)
  (* Ciphers client supports *)
  SSL_SECOP_CIPHER_SUPPORTED = 1 or SSL_SECOP_OTHER_CIPHER;
  (* Cipher shared by client/server *)
  SSL_SECOP_CIPHER_SHARED = 2 or SSL_SECOP_OTHER_CIPHER;
  (* Sanity check of cipher server selects *)
  SSL_SECOP_CIPHER_CHECK = 3 or SSL_SECOP_OTHER_CIPHER;
  (* Curves supported by client *)
  SSL_SECOP_CURVE_SUPPORTED = 4 or SSL_SECOP_OTHER_CURVE;
  (* Curves shared by client/server *)
  SSL_SECOP_CURVE_SHARED = 5 or SSL_SECOP_OTHER_CURVE;
  (* Sanity check of curve server selects *)
  SSL_SECOP_CURVE_CHECK = 6 or SSL_SECOP_OTHER_CURVE;
  (* Temporary DH key *)
  SSL_SECOP_TMP_DH = 7 or SSL_SECOP_OTHER_PKEY;
  (* SSL/TLS version *)
  SSL_SECOP_VERSION = 9 or SSL_SECOP_OTHER_NONE;
  (* Session tickets *)
  SSL_SECOP_TICKET = 10 or SSL_SECOP_OTHER_NONE;
  (* Supported signature algorithms sent to peer *)
  SSL_SECOP_SIGALG_SUPPORTED = 11 or SSL_SECOP_OTHER_SIGALG;
  (* Shared signature algorithm *)
  SSL_SECOP_SIGALG_SHARED = 12 or SSL_SECOP_OTHER_SIGALG;
  (* Sanity check signature algorithm allowed *)
  SSL_SECOP_SIGALG_CHECK = 13 or SSL_SECOP_OTHER_SIGALG;
  (* Used to get mask of supported public key signature algorithms *)
  SSL_SECOP_SIGALG_MASK = 14 or SSL_SECOP_OTHER_SIGALG;
  (* Use to see if compression is allowed *)
  SSL_SECOP_COMPRESSION = 15 or SSL_SECOP_OTHER_NONE;
  (* EE key in certificate *)
  SSL_SECOP_EE_KEY = 16 or SSL_SECOP_OTHER_CERT;
  (* CA key in certificate *)
  SSL_SECOP_CA_KEY = 17 or SSL_SECOP_OTHER_CERT;
  (* CA digest algorithm in certificate *)
  SSL_SECOP_CA_MD = 18 or SSL_SECOP_OTHER_CERT;
  (* Peer EE key in certificate *)
  SSL_SECOP_PEER_EE_KEY = SSL_SECOP_EE_KEY or SSL_SECOP_PEER;
  (* Peer CA key in certificate *)
  SSL_SECOP_PEER_CA_KEY = SSL_SECOP_CA_KEY or SSL_SECOP_PEER;
  (* Peer CA digest algorithm in certificate *)
  SSL_SECOP_PEER_CA_MD = SSL_SECOP_CA_MD or SSL_SECOP_PEER;

  (* OPENSSL_INIT flag 0x010000 reserved for internal use *)
  OPENSSL_INIT_NO_LOAD_SSL_STRINGS = TIdC_LONG($00100000);
  OPENSSL_INIT_LOAD_SSL_STRINGS = TIdC_LONG($00200000);
  OPENSSL_INIT_SSL_DEFAULT = OPENSSL_INIT_LOAD_SSL_STRINGS or OPENSSL_INIT_LOAD_CRYPTO_STRINGS;

  (* Support for ticket appdata *)
  (* fatal error, malloc failure *)
  SSL_TICKET_FATAL_ERR_MALLOC = 0;
  (* fatal error, either from parsing or decrypting the ticket *)
  SSL_TICKET_FATAL_ERR_OTHER = 1;
  (* No ticket present *)
  SSL_TICKET_NONE = 2;
  (* Empty ticket present *)
  SSL_TICKET_EMPTY = 3;
  (* the ticket couldn't be decrypted *)
  SSL_TICKET_NO_DECRYPT = 4;
  (* a ticket was successfully decrypted *)
  SSL_TICKET_SUCCESS = 5;
  (* same as above but the ticket needs to be renewed *)
  SSL_TICKET_SUCCESS_RENEW = 6;

  (* An error occurred *)
  SSL_TICKET_RETURN_ABORT = 0;
  (* Do not use the ticket, do not send a renewed ticket to the client *)
  SSL_TICKET_RETURN_IGNORE = 1;
  (* Do not use the ticket, send a renewed ticket to the client *)
  SSL_TICKET_RETURN_IGNORE_RENEW = 2;
  (* Use the ticket, do not send a renewed ticket to the client *)
  SSL_TICKET_RETURN_USE = 3;
  (* Use the ticket, send a renewed ticket to the client *)
  SSL_TICKET_RETURN_USE_RENEW = 4;

type
  (*
   * This is needed to stop compilers complaining about the 'struct ssl_st *'
   * function parameters used to prototype callbacks in SSL_CTX.
   *)
  ssl_crock_st = ^ssl_st;
  TLS_SESSION_TICKET_EXT = tls_session_ticket_ext_st;
  ssl_method_st = type Pointer;
  SSL_METHOD = ssl_method_st;
  PSSL_METHOD = ^SSL_METHOD;
  ssl_session_st = type Pointer;
  SSL_CIPHER = ssl_session_st;
  PSSL_CIPHER = ^SSL_CIPHER;
  SSL_SESSION = ssl_session_st;
  PSSL_SESSION = ^SSL_SESSION;
  PPSSL_SESSION = ^PSSL_SESSION;
  tls_sigalgs_st = type Pointer;
  TLS_SIGALGS = tls_sigalgs_st;
  ssl_conf_ctx_st = type Pointer;
  SSL_CONF_CTX = ssl_conf_ctx_st;
  PSSL_CONF_CTX = ^SSL_CONF_CTX;
  ssl_comp_st = type Pointer;
  SSL_COMP = ssl_comp_st;

  //STACK_OF(SSL_CIPHER);
  //STACK_OF(SSL_COMP);

  (* SRTP protection profiles for use with the use_srtp extension (RFC 5764)*)
  srtp_protection_profile_st = record
    name: PIdAnsiChar;
    id: TIdC_ULONG;
  end;
  SRTP_PROTECTION_PROFILE = srtp_protection_profile_st;
  PSRTP_PROTECTION_PROFILE = ^SRTP_PROTECTION_PROFILE;

  //DEFINE_STACK_OF(SRTP_PROTECTION_PROFILE)

  (* Typedefs for handling custom extensions *)
  custom_ext_add_cb = function (s: PSSL; ext_type: TIdC_UINT; const out_: PByte; outlen: PIdC_SIZET; al: PIdC_INT; add_arg: Pointer): TIdC_INT; cdecl;
  custom_ext_free_cb = procedure (s: PSSL; ext_type: TIdC_UINT; const out_: PByte; add_arg: Pointer); cdecl;
  custom_ext_parse_cb = function (s: PSSL; ext_type: TIdC_UINT; const in_: PByte; inlen: TIdC_SIZET; al: PIdC_INT; parse_arg: Pointer): TIdC_INT; cdecl;

  SSL_custom_ext_add_cb_ex = function (s: PSSL; ext_type: TIdC_UINT; context: TIdC_UINT; const out_: PByte; outlen: PIdC_SIZET; x: Px509; chainidx: TIdC_SIZET; al: PIdC_INT; add_arg: Pointer): TIdC_INT; cdecl;
  SSL_custom_ext_free_cb_ex = procedure (s: PSSL; ext_type: TIdC_UINT; context: TIdC_UINT; const out_: PByte; add_arg: Pointer); cdecl;
  SSL_custom_ext_parse_cb_ex = function (s: PSSL; ext_type: TIdC_UINT; context: TIdC_UINT; const in_: PByte; inlen: TIdC_SIZET; x: Px509; chainidx: TIdC_SIZET; al: PIdC_INT; parse_arg: Pointer): TIdC_INT; cdecl;

  (* Typedef for verification callback *)
  SSL_verify_cb = function (preverify_ok: TIdC_INT; x509_ctx: PX509_STORE_CTX): TIdC_INT; cdecl;

  tls_session_ticket_ext_cb_fn = function (s: PSSL; const data: PByte; len: TIdC_INT; arg: Pointer): TIdC_INT; cdecl;

  (*
   * This callback type is used inside SSL_CTX, SSL, and in_ the functions that
   * set them. It is used to override the generation of SSL/TLS session IDs in_
   * a server. Return value should be zero on an error, non-zero to proceed.
   * Also, callbacks should themselves check if the id they generate is unique
   * otherwise the SSL handshake will fail with an error - callbacks can do
   * this using the 'ssl' value they're passed by;
   * SSL_has_matching_session_id(ssl, id, *id_len) The length value passed in_
   * is set at the maximum size the session ID can be. in_ SSLv3/TLSv1 it is 32
   * bytes. The callback can alter this length to be less if desired. It is
   * also an error for the callback to set the size to zero.
   *)
  GEN_SESSION_CB = function (ssl: PSSL; id: PByte; id_len: PIdC_UINT): TIdC_INT; cdecl;

  SSL_CTX_info_callback = procedure (const ssl: PSSL; type_: TIdC_INT; val: TIdC_INT); cdecl;
  SSL_CTX_client_cert_cb = function (ssl: PSSL; x509: PPx509; pkey: PPEVP_PKEY): TIdC_INT; cdecl;

  SSL_CTX_cookie_verify_cb = function (ssl: PSSL; cookie: PByte; cookie_len: PIdC_UINT): TIdC_INT; cdecl;
  SSL_CTX_set_cookie_verify_cb_app_verify_cookie_cb = function (ssl: PSSL; const cookie: PByte; cookie_len: TIdC_UINT): TIdC_INT; cdecl;
  SSL_CTX_set_stateless_cookie_generate_cb_gen_stateless_cookie_cb = function (ssl: PSSL; cookie: PByte; cookie_len: PIdC_SIZET): TIdC_INT; cdecl;
  SSL_CTX_set_stateless_cookie_verify_cb_verify_stateless_cookie_cb = function (ssl: PSSL; const cookie: PByte; cookie_len: TIdC_SIZET): TIdC_INT; cdecl;

  SSL_CTX_alpn_select_cb_func = function (ssl: PSSL; const out_: PPByte; outlen: PByte; const in_: PByte; inlen: TIdC_UINT; arg: Pointer): TIdC_INT; cdecl;
  SSL_psk_client_cb_func = function (ssl: PSSL; const hint: PIdAnsiChar; identity: PIdAnsiChar; max_identity_len: TIdC_UINT; psk: PByte; max_psk_len: TIdC_UINT): TIdC_UINT; cdecl;
  SSL_psk_server_cb_func = function (ssl: PSSL; const identity: PIdAnsiChar; psk: PByte; max_psk_len: TIdC_UINT): TIdC_UINT; cdecl;
  SSL_psk_find_session_cb_func = function (ssl: PSSL; const identity: PByte; identity_len: TIdC_SIZET; sess: PPSSL_SESSION): TIdC_INT; cdecl;
  SSL_psk_use_session_cb_func = function (ssl: PSSL; const md: PEVP_MD; const id: PPByte; idlen: PIdC_SIZET; sess: PPSSL_SESSION): TIdC_INT; cdecl;

  (*
   * A callback for logging out TLS key material. This callback should log out
   * |line| followed by a newline.
   *)
  SSL_CTX_keylog_cb_func = procedure(const ssl: PSSL; const line: PIdAnsiChar); cdecl;

  (*
   * The valid handshake states (one for each type message sent and one for each
   * type of message received). There are also two "special" states:
   * TLS = TLS or DTLS state
   * DTLS = DTLS specific state
   * CR/SR = Client Read/Server Read
   * CW/SW = Client Write/Server Write
   *
   * The "special" states are:
   * TLS_ST_BEFORE = No handshake has been initiated yet
   * TLS_ST_OK = A handshake has been successfully completed
   *)
  TLS_ST_OK = (
    DTLS_ST_CR_HELLO_VERIFY_REQUEST,
    TLS_ST_CR_SRVR_HELLO,
    TLS_ST_CR_CERT,
    TLS_ST_CR_CERT_STATUS,
    TLS_ST_CR_KEY_EXCH,
    TLS_ST_CR_CERT_REQ,
    TLS_ST_CR_SRVR_DONE,
    TLS_ST_CR_SESSION_TICKET,
    TLS_ST_CR_CHANGE,
    TLS_ST_CR_FINISHED,
    TLS_ST_CW_CLNT_HELLO,
    TLS_ST_CW_CERT,
    TLS_ST_CW_KEY_EXCH,
    TLS_ST_CW_CERT_VRFY,
    TLS_ST_CW_CHANGE,
    TLS_ST_CW_NEXT_PROTO,
    TLS_ST_CW_FINISHED,
    TLS_ST_SW_HELLO_REQ,
    TLS_ST_SR_CLNT_HELLO,
    DTLS_ST_SW_HELLO_VERIFY_REQUEST,
    TLS_ST_SW_SRVR_HELLO,
    TLS_ST_SW_CERT,
    TLS_ST_SW_KEY_EXCH,
    TLS_ST_SW_CERT_REQ,
    TLS_ST_SW_SRVR_DONE,
    TLS_ST_SR_CERT,
    TLS_ST_SR_KEY_EXCH,
    TLS_ST_SR_CERT_VRFY,
    TLS_ST_SR_NEXT_PROTO,
    TLS_ST_SR_CHANGE,
    TLS_ST_SR_FINISHED,
    TLS_ST_SW_SESSION_TICKET,
    TLS_ST_SW_CERT_STATUS,
    TLS_ST_SW_CHANGE,
    TLS_ST_SW_FINISHED,
    TLS_ST_SW_ENCRYPTED_EXTENSIONS,
    TLS_ST_CR_ENCRYPTED_EXTENSIONS,
    TLS_ST_CR_CERT_VRFY,
    TLS_ST_SW_CERT_VRFY,
    TLS_ST_CR_HELLO_REQ,
    TLS_ST_SW_KEY_UPDATE,
    TLS_ST_CW_KEY_UPDATE,
    TLS_ST_SR_KEY_UPDATE,
    TLS_ST_CR_KEY_UPDATE,
    TLS_ST_EARLY_DATA,
    TLS_ST_PENDING_EARLY_DATA_END,
    TLS_ST_CW_END_OF_EARLY_DATA
  );
  OSSL_HANDSHAKE_STATE = TLS_ST_OK;

  SSL_CTX_set_cert_verify_callback_cb = function (v1: PX509_STORE_CTX; v2: Pointer): TIdC_INT; cdecl;
  SSL_CTX_set_cert_cb_cb = function (ssl: PSSL; arg: Pointer): TIdC_INT; cdecl;

  SSL_CTX_set_srp_client_pwd_callback_cb = function (v1: PSSL; v2: Pointer): PIdAnsiChar; cdecl;
  SSL_CTX_set_srp_verify_param_callback_cb = function (v1: PSSL; v2: Pointer): TIdC_INT; cdecl;
  SSL_CTX_set_srp_username_callback_cb = function (v1: PSSL; v2: PIdC_INT; v3: Pointer): TIdC_INT; cdecl;
  SSL_client_hello_cb_fn = function (s: PSSL; al: PIdC_INT; arg: Pointer): TIdC_INT; cdecl;
  SSL_callback_ctrl_v3 = procedure; cdecl;
  SSL_CTX_callback_ctrl_v3 = procedure; cdecl;
  SSL_info_callback = procedure (const ssl: PSSL; type_: TIdC_INT; val: TIdC_INT); cdecl;

  (* NB: the |keylength| is only applicable when is_export is true *)
  SSL_CTX_set_tmp_dh_callback_dh = function (ssl: PSSL; is_export: TIdC_INT; keylength: TIdC_INT): PDH; cdecl;
  SSL_set_tmp_dh_callback_dh = function (ssl: PSSL; is_export: TIdC_INT; keylength: TIdC_INT): PDH; cdecl;
  SSL_CTX_set_not_resumable_session_callback_cb = function (ssl: PSSL; is_forward_secure: TIdC_INT): TIdC_INT; cdecl;
  SSL_set_not_resumable_session_callback_cb = function (ssl: PSSL; is_forward_secure: TIdC_INT): TIdC_INT; cdecl;
  SSL_CTX_set_record_padding_callback_cb = function (ssl: PSSL; type_: TIdC_INT; len: TIdC_SIZET; arg: Pointer): TIdC_SIZET; cdecl;
  SSL_set_record_padding_callback_cb = function (ssl: PSSL; type_: TIdC_INT; len: TIdC_SIZET; arg: Pointer): TIdC_SIZET; cdecl;
  
  (*
   * The validation type enumerates the available behaviours of the built-in SSL
   * CT validation callback selected via SSL_enable_ct() and SSL_CTX_enable_ct().
   * The underlying callback is a static function in libssl.
   *)
  SSL_CT_VALIDATION = (         
    SSL_CT_VALIDATION_PERMISSIVE = 0,
    SSL_CT_VALIDATION_STRICT
  );
  SSL_security_callback = function (const s: PSSL; const ctx: PSSL_CTX; op: TIdC_INT; bits: TIdC_INT; nid: TIdC_INT; other: Pointer; ex: Pointer): TIdC_INT; cdecl;

  (* Status codes passed to the decrypt session ticket callback. Some of these
   * are for internal use only and are never passed to the callback. *)
  SSL_TICKET_STATUS = TIdC_INT;
  SSL_TICKET_RETURN = TIdC_INT;

  SSL_CTX_generate_session_ticket_fn = function(s: PSSL; arg: Pointer): TIdC_INT; cdecl;

  SSL_CTX_decrypt_session_ticket_fn = function (s: PSSL; ss: PSSL_SESSION; const keyname: PByte; keyname_length: TIdC_SIZET; status: SSL_TICKET_STATUS; arg: Pointer): SSL_TICKET_RETURN; cdecl;

  DTLS_timer_cb = function(s: PSSL; timer_us: TIdC_UINT): TIdC_UINT; cdecl;
  SSL_allow_early_data_cb_fn = function(s: PSSL; arg: Pointer): TIdC_INT; cdecl;

  SSL_CTX_sess_new_cb = function (ssl: PSSL; sess: PSSL_SESSION): TIdC_INT; cdecl;

  SSL_CTX_sess_remove_cb = procedure(ctx: PSSL_CTX; sess: PSSL_SESSION); cdecl;

function SSL_CTX_set_mode(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG;
function SSL_CTX_clear_mode(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG;

function SSL_CTX_sess_set_cache_size(ctx: PSSL_CTX; t: TIdC_LONG): TIdC_LONG;
function SSL_CTX_sess_get_cache_size(ctx: PSSL_CTX): TIdC_LONG;
function SSL_CTX_set_session_cache_mode(ctx: PSSL_CTX; m: TIdC_LONG): TIdC_LONG;
function SSL_CTX_get_session_cache_mode(ctx: PSSL_CTX): TIdC_LONG;

function SSL_num_renegotiations(ssl: PSSL): TIdC_LONG;
function SSL_clear_num_renegotiations(ssl: PSSL): TIdC_LONG;
function SSL_total_renegotiations(ssl: PSSL): TIdC_LONG;
function SSL_CTX_set_tmp_dh(ctx: PSSL_CTX; dh: PByte): TIdC_LONG;
function SSL_CTX_set_tmp_ecdh(ctx: PSSL_CTX; ecdh: PByte): TIdC_LONG;
function SSL_CTX_set_dh_auto(ctx: PSSL_CTX; onoff: TIdC_LONG): TIdC_LONG;
function SSL_set_dh_auto(s: PSSL; onoff: TIdC_LONG): TIdC_LONG;
function SSL_set_tmp_dh(ssl: PSSL; dh: PByte): TIdC_LONG;
function SSL_set_tmp_ecdh(ssl: PSSL; ecdh: PByte): TIdC_LONG;
function SSL_CTX_add_extra_chain_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG;
function SSL_CTX_get_extra_chain_certs(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG;
function SSL_CTX_get_extra_chain_certs_only(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG;
function SSL_CTX_clear_extra_chain_certs(ctx: PSSL_CTX): TIdC_LONG;
function SSL_CTX_set0_chain(ctx: PSSL_CTX; sk: PByte): TIdC_LONG;
function SSL_CTX_set1_chain(ctx: PSSL_CTX; sk: PByte): TIdC_LONG;
function SSL_CTX_add0_chain_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG;
function SSL_CTX_add1_chain_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG;
function SSL_CTX_get0_chain_certs(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG;
function SSL_CTX_clear_chain_certs(ctx: PSSL_CTX): TIdC_LONG;
function SSL_CTX_build_cert_chain(ctx: PSSL_CTX; flags: TIdC_LONG): TIdC_LONG;
function SSL_CTX_select_current_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG;
function SSL_CTX_set_current_cert(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG;
function SSL_CTX_set0_verify_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG;
function SSL_CTX_set1_verify_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG;
function SSL_CTX_set0_chain_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG;
function SSL_CTX_set1_chain_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG;
function SSL_set0_chain(s: PSSL; sk: PByte): TIdC_LONG;
function SSL_set1_chain(s: PSSL; sk: PByte): TIdC_LONG;
function SSL_add0_chain_cert(s: PSSL; x509: PByte): TIdC_LONG;
function SSL_add1_chain_cert(s: PSSL; x509: PByte): TIdC_LONG;
function SSL_get0_chain_certs(s: PSSL; px509: Pointer): TIdC_LONG;
function SSL_clear_chain_certs(s: PSSL): TIdC_LONG;
function SSL_build_cert_chain(s: PSSL; flags: TIdC_LONG): TIdC_LONG;
function SSL_select_current_cert(s: PSSL; x509: PByte): TIdC_LONG;
function SSL_set_current_cert(s: PSSL; op: TIdC_LONG): TIdC_LONG;
function SSL_set0_verify_cert_store(s: PSSL; st: PByte): TIdC_LONG;
function SSL_set1_verify_cert_store(s: PSSL; st: PByte): TIdC_LONG;
function SSL_set0_chain_cert_store(s: PSSL; st: PByte): TIdC_LONG;
function SSL_set1_chain_cert_store(s: PSSL; st: PByte): TIdC_LONG;
function SSL_get1_groups(s: PSSL; glist: PIdC_INT): TIdC_LONG;
function SSL_CTX_set1_groups(ctx: PSSL_CTX; glist: PByte; glistlen: TIdC_LONG): TIdC_LONG;
function SSL_CTX_set1_groups_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG;
function SSL_set1_groups(s: PSSL; glist: PByte; glistlen: TIdC_LONG): TIdC_LONG;
function SSL_set1_groups_list(s: PSSL; str: PByte): TIdC_LONG;
function SSL_get_shared_group(s: PSSL; n: TIdC_LONG): TIdC_LONG;
function SSL_CTX_set1_sigalgs(ctx: PSSL_CTX; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG;
function SSL_CTX_set1_sigalgs_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG;
function SSL_set1_sigalgs(s: PSSL; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG;
function SSL_set1_sigalgs_list(s: PSSL; str: PByte): TIdC_LONG;
function SSL_CTX_set1_client_sigalgs(ctx: PSSL_CTX; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG;
function SSL_CTX_set1_client_sigalgs_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG;
function SSL_set1_client_sigalgs(s: PSSL; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG;
function SSL_set1_client_sigalgs_list(s: PSSL; str: PByte): TIdC_LONG;
function SSL_get0_certificate_types(s: PSSL; clist: PByte): TIdC_LONG;
function SSL_CTX_set1_client_certificate_types(ctx: PSSL_CTX; clist: PByte; clistlen: TIdC_LONG): TIdC_LONG;
function SSL_set1_client_certificate_types(s: PSSL; clist: PByte; clistlen: TIdC_LONG): TIdC_LONG;
function SSL_get_signature_nid(s: PSSL; pn: Pointer): TIdC_LONG;
function SSL_get_peer_signature_nid(s: PSSL; pn: Pointer): TIdC_LONG;
function SSL_get_peer_tmp_key(s: PSSL; pk: Pointer): TIdC_LONG;
function SSL_get_tmp_key(s: PSSL; pk: Pointer): TIdC_LONG;
function SSL_get0_raw_cipherlist(s: PSSL; plst: Pointer): TIdC_LONG;
function SSL_get0_ec_point_formats(s: PSSL; plst: Pointer): TIdC_LONG;
function SSL_CTX_set_min_proto_version(ctx: PSSL_CTX; version: TIdC_LONG): TIdC_LONG;
function SSL_CTX_set_max_proto_version(ctx: PSSL_CTX; version: TIdC_LONG): TIdC_LONG;
function SSL_CTX_get_min_proto_version(ctx: PSSL_CTX): TIdC_LONG;
function SSL_CTX_get_max_proto_version(ctx: PSSL_CTX): TIdC_LONG;
function SSL_set_min_proto_version(s: PSSL; version: TIdC_LONG): TIdC_LONG;
function SSL_set_max_proto_version(s: PSSL; version: TIdC_LONG): TIdC_LONG;
function SSL_get_min_proto_version(s: PSSL): TIdC_LONG;
function SSL_get_max_proto_version(s: PSSL): TIdC_LONG;

  //typedef TIdC_INT (*tls_session_secret_cb_fn)(s: PSSL, void *secret, TIdC_INT *secret_len,
  //                                        STACK_OF(SSL_CIPHER) *peer_ciphers,
  //                                        const SSL_CIPHER **cipher, void *arg);

  function SSL_CTX_get_options(const ctx: PSSL_CTX): TIdC_ULONG cdecl; external CLibSSL;
  function SSL_get_options(const s: PSSL): TIdC_ULONG cdecl; external CLibSSL;
  function SSL_CTX_clear_options(ctx: PSSL_CTX; op: TIdC_ULONG): TIdC_ULONG cdecl; external CLibSSL;
  function SSL_clear_options(s: PSSL; op: TIdC_ULONG): TIdC_ULONG cdecl; external CLibSSL;
  function SSL_CTX_set_options(ctx: PSSL_CTX; op: TIdC_ULONG): TIdC_ULONG cdecl; external CLibSSL;
  function SSL_set_options(s: PSSL; op: TIdC_ULONG): TIdC_ULONG cdecl; external CLibSSL;

  //# define SSL_CTX_set_mode(ctx,op) \
  //        SSL_CTX_ctrl((ctx),SSL_CTRL_MODE,(op),NULL)
  //# define SSL_CTX_clear_mode(ctx,op) \
  //        SSL_CTX_ctrl((ctx),SSL_CTRL_CLEAR_MODE,(op),NULL)
  //# define SSL_CTX_get_mode(ctx) \
  //        SSL_CTX_ctrl((ctx),SSL_CTRL_MODE,0,NULL)
  //# define SSL_clear_mode(ssl,op) \
  //        SSL_ctrl((ssl),SSL_CTRL_CLEAR_MODE,(op),NULL)
  //# define SSL_set_mode(ssl,op) \
  //        SSL_ctrl((ssl),SSL_CTRL_MODE,(op),NULL)
  //# define SSL_get_mode(ssl) \
  //        SSL_ctrl((ssl),SSL_CTRL_MODE,0,NULL)
  //# define SSL_set_mtu(ssl, mtu) \
  //        SSL_ctrl((ssl),SSL_CTRL_SET_MTU,(mtu),NULL)
  //# define DTLS_set_link_mtu(ssl, mtu) \
  //        SSL_ctrl((ssl),DTLS_CTRL_SET_LINK_MTU,(mtu),NULL)
  //# define DTLS_get_link_min_mtu(ssl) \
  //        SSL_ctrl((ssl),DTLS_CTRL_GET_LINK_MIN_MTU,0,NULL)
  //
  //# define SSL_get_secure_renegotiation_support(ssl) \
  //        SSL_ctrl((ssl), SSL_CTRL_GET_RI_SUPPORT, 0, NULL)
  //
  //# ifndef OPENSSL_NO_HEARTBEATS
  //#  define SSL_heartbeat(ssl) \
  //        SSL_ctrl((ssl),SSL_CTRL_DTLS_EXT_SEND_HEARTBEAT,0,NULL)
  //# endif
  //
  //# define SSL_CTX_set_cert_flags(ctx,op) \
  //        SSL_CTX_ctrl((ctx),SSL_CTRL_CERT_FLAGS,(op),NULL)
  //# define SSL_set_cert_flags(s,op) \
  //        SSL_ctrl((s),SSL_CTRL_CERT_FLAGS,(op),NULL)
  //# define SSL_CTX_clear_cert_flags(ctx,op) \
  //        SSL_CTX_ctrl((ctx),SSL_CTRL_CLEAR_CERT_FLAGS,(op),NULL)
  //# define SSL_clear_cert_flags(s,op) \
  //        SSL_ctrl((s),SSL_CTRL_CLEAR_CERT_FLAGS,(op),NULL)
  //
  //void SSL_CTX_set_msg_callback(ctx: PSSL_CTX,
  //                              void (*cb) (TIdC_INT write_p, TIdC_INT version,
  //                                          TIdC_INT content_type, const void *buf,
  //                                          TIdC_SIZET len, ssl: PSSL, void *arg));
  //void SSL_set_msg_callback(ssl: PSSL,
  //                          void (*cb) (TIdC_INT write_p, TIdC_INT version,
  //                                      TIdC_INT content_type, const void *buf,
  //                                      TIdC_SIZET len, ssl: PSSL, void *arg));
  //# define SSL_CTX_set_msg_callback_arg(ctx, arg) SSL_CTX_ctrl((ctx), SSL_CTRL_SET_MSG_CALLBACK_ARG, 0, (arg))
  //# define SSL_set_msg_callback_arg(ssl, arg) SSL_ctrl((ssl), SSL_CTRL_SET_MSG_CALLBACK_ARG, 0, (arg))
  //
  //# define SSL_get_extms_support(s) \
  //        SSL_ctrl((s),SSL_CTRL_GET_EXTMS_SUPPORT,0,NULL)
  //
  //# ifndef OPENSSL_NO_SRP

  ///* see tls_srp.c */
  //__owur TIdC_INT SSL_SRP_CTX_init(s: PSSL);
  //__owur TIdC_INT SSL_CTX_SRP_CTX_init(ctx: PSSL_CTX);
  //TIdC_INT SSL_SRP_CTX_free(SSL *ctx);
  //TIdC_INT SSL_CTX_SRP_CTX_free(ctx: PSSL_CTX);
  //__owur TIdC_INT SSL_srp_server_param_with_username(s: PSSL, TIdC_INT *ad);
  //__owur TIdC_INT SRP_Calc_A_param(s: PSSL);

  // # endif

  // LHASH_OF(SSL_SESSION) *SSL_CTX_sessions(ctx: PSSL_CTX);
  //# define SSL_CTX_sess_number(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SESS_NUMBER,0,NULL)
  //# define SSL_CTX_sess_connect(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SESS_CONNECT,0,NULL)
  //# define SSL_CTX_sess_connect_good(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SESS_CONNECT_GOOD,0,NULL)
  //# define SSL_CTX_sess_connect_renegotiate(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SESS_CONNECT_RENEGOTIATE,0,NULL)
  //# define SSL_CTX_sess_accept(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SESS_ACCEPT,0,NULL)
  //# define SSL_CTX_sess_accept_renegotiate(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SESS_ACCEPT_RENEGOTIATE,0,NULL)
  //# define SSL_CTX_sess_accept_good(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SESS_ACCEPT_GOOD,0,NULL)
  //# define SSL_CTX_sess_hits(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SESS_HIT,0,NULL)
  //# define SSL_CTX_sess_cb_hits(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SESS_CB_HIT,0,NULL)
  //# define SSL_CTX_sess_misses(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SESS_MISSES,0,NULL)
  //# define SSL_CTX_sess_timeouts(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SESS_TIMEOUTS,0,NULL)
  //# define SSL_CTX_sess_cache_full(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SESS_CACHE_FULL,0,NULL)

  procedure SSL_CTX_sess_set_new_cb(ctx: PSSL_CTX; new_session_cb: SSL_CTX_sess_new_cb) cdecl; external CLibSSL;
  function SSL_CTX_sess_get_new_cb(ctx: PSSL_CTX): SSL_CTX_sess_new_cb cdecl; external CLibSSL;
  procedure SSL_CTX_sess_set_remove_cb(ctx: PSSL_CTX; remove_session_cb: SSL_CTX_sess_remove_cb) cdecl; external CLibSSL;
  function SSL_CTX_sess_get_remove_cb(ctx: PSSL_CTX): SSL_CTX_sess_remove_cb cdecl; external CLibSSL;

  //void SSL_CTX_sess_set_get_cb(ctx: PSSL_CTX,
  //                             SSL_SESSION *(*get_session_cb) (struct ssl_st
  //                                                             *ssl,
  //                                                             const Byte
  //                                                             *data, TIdC_INT len,
  //                                                             TIdC_INT *copy));
  //SSL_SESSION *(*SSL_CTX_sess_get_get_cb(ctx: PSSL_CTX)) (struct ssl_st *ssl,
  //                                                       const d: PByteata,
  //                                                       TIdC_INT len, TIdC_INT *copy);
  procedure SSL_CTX_set_info_callback(ctx: PSSL_CTX; cb: SSL_CTX_info_callback) cdecl; external CLibSSL;
  function SSL_CTX_get_info_callback(ctx: PSSL_CTX): SSL_CTX_info_callback cdecl; external CLibSSL;
  procedure SSL_CTX_set_client_cert_cb(ctx: PSSL_CTX; client_cert_cb: SSL_CTX_client_cert_cb) cdecl; external CLibSSL;
  function SSL_CTX_get_client_cert_cb(ctx: PSSL_CTX): SSL_CTX_client_cert_cb cdecl; external CLibSSL;
  function SSL_CTX_set_client_cert_engine(ctx: PSSL_CTX; e: PENGINE): TIdC_INT cdecl; external CLibSSL;

  procedure SSL_CTX_set_cookie_generate_cb(ctx: PSSL_CTX; app_gen_cookie_cb: SSL_CTX_cookie_verify_cb) cdecl; external CLibSSL;
  procedure SSL_CTX_set_cookie_verify_cb(ctx: PSSL_CTX; app_verify_cookie_cb: SSL_CTX_set_cookie_verify_cb_app_verify_cookie_cb) cdecl; external CLibSSL;
  procedure SSL_CTX_set_stateless_cookie_generate_cb(ctx: PSSL_CTX; gen_stateless_cookie_cb: SSL_CTX_set_stateless_cookie_generate_cb_gen_stateless_cookie_cb) cdecl; external CLibSSL;
  procedure SSL_CTX_set_stateless_cookie_verify_cb(ctx: PSSL_CTX; verify_stateless_cookie_cb: SSL_CTX_set_stateless_cookie_verify_cb_verify_stateless_cookie_cb) cdecl; external CLibSSL;

  //__owur TIdC_INT SSL_CTX_set_alpn_protos(ctx: PSSL_CTX, const Byte *protos,
  //                                   TIdC_UINT protos_len);
  //__owur TIdC_INT SSL_set_alpn_protos(ssl: PSSL, const Byte *protos,
  //                               TIdC_UINT protos_len);

  procedure SSL_CTX_set_alpn_select_cb(ctx: PSSL_CTX; cb: SSL_CTX_alpn_select_cb_func; arg: Pointer) cdecl; external CLibSSL;
  procedure SSL_get0_alpn_selected(const ssl: PSSL; const data: PPByte; len: PIdC_UINT) cdecl; external CLibSSL;
  procedure SSL_CTX_set_psk_client_callback(ctx: PSSL_CTX; cb: SSL_psk_client_cb_func) cdecl; external CLibSSL;
  procedure SSL_set_psk_client_callback(ssl: PSSL; cb: SSL_psk_client_cb_func) cdecl; external CLibSSL;
  procedure SSL_CTX_set_psk_server_callback(ctx: PSSL_CTX; cb: SSL_psk_server_cb_func) cdecl; external CLibSSL;
  procedure SSL_set_psk_server_callback(ssl: PSSL; cb: SSL_psk_server_cb_func) cdecl; external CLibSSL;

  //__owur TIdC_INT SSL_CTX_use_psk_identity_hint(ctx: PSSL_CTX, const PIdAnsiChar *identity_hint);
  //__owur TIdC_INT SSL_use_psk_identity_hint(s: PSSL, const PIdAnsiChar *identity_hint);
  //const PIdAnsiChar *SSL_get_psk_identity_hint(const s: PSSL);
  //const PIdAnsiChar *SSL_get_psk_identity(const s: PSSL);

  procedure SSL_set_psk_find_session_callback(s: PSSL; cb: SSL_psk_find_session_cb_func) cdecl; external CLibSSL;
  procedure SSL_CTX_set_psk_find_session_callback(ctx: PSSL_CTX; cb: SSL_psk_find_session_cb_func) cdecl; external CLibSSL;
  procedure SSL_set_psk_use_session_callback(s: PSSL; cb: SSL_psk_use_session_cb_func) cdecl; external CLibSSL;
  procedure SSL_CTX_set_psk_use_session_callback(ctx: PSSL_CTX; cb: SSL_psk_use_session_cb_func) cdecl; external CLibSSL;

  ///* Register callbacks to handle custom TLS Extensions for client or server. */

  //__owur TIdC_INT SSL_CTX_has_client_custom_ext(const ctx: PSSL_CTX,
  //                                         TIdC_UINT ext_type);
  //
  //__owur TIdC_INT SSL_CTX_add_client_custom_ext(ctx: PSSL_CTX,
  //                                         TIdC_UINT ext_type,
  //                                         custom_ext_add_cb add_cb,
  //                                         custom_ext_free_cb free_cb,
  //                                         void *add_arg,
  //                                         custom_ext_parse_cb parse_cb,
  //                                         void *parse_arg);
  //
  //__owur TIdC_INT SSL_CTX_add_server_custom_ext(ctx: PSSL_CTX,
  //                                         TIdC_UINT ext_type,
  //                                         custom_ext_add_cb add_cb,
  //                                         custom_ext_free_cb free_cb,
  //                                         void *add_arg,
  //                                         custom_ext_parse_cb parse_cb,
  //                                         void *parse_arg);
  //
  //__owur TIdC_INT SSL_CTX_add_custom_ext(ctx: PSSL_CTX, TIdC_UINT ext_type,
  //                                  TIdC_UINT context,
  //                                  SSL_custom_ext_add_cb_ex add_cb,
  //                                  SSL_custom_ext_free_cb_ex free_cb,
  //                                  void *add_arg,
  //                                  SSL_custom_ext_parse_cb_ex parse_cb,
  //                                  void *parse_arg);

  //__owur TIdC_INT SSL_extension_supported(TIdC_UINT ext_type);


  ///* These will only be used when doing non-blocking IO */
  //# define SSL_want_nothing(s)         (SSL_want(s) == SSL_NOTHING)
  //# define SSL_want_read(s)            (SSL_want(s) == SSL_READING)
  //# define SSL_want_write(s)           (SSL_want(s) == SSL_WRITING)
  //# define SSL_want_x509_lookup(s)     (SSL_want(s) == SSL_X509_LOOKUP)
  //# define SSL_want_async(s)           (SSL_want(s) == SSL_ASYNC_PAUSED)
  //# define SSL_want_async_job(s)       (SSL_want(s) == SSL_ASYNC_NO_JOBS)
  //# define SSL_want_client_hello_cb(s) (SSL_want(s) == SSL_CLIENT_HELLO_CB)

  (*
   * SSL_CTX_set_keylog_callback configures a callback to log key material. This
   * is intended for debugging use with tools like Wireshark. The cb function
   * should log line followed by a newline.
   *)
  procedure SSL_CTX_set_keylog_callback(ctx: PSSL_CTX; cb: SSL_CTX_keylog_cb_func) cdecl; external CLibSSL;
  (*
   * SSL_CTX_get_keylog_callback returns the callback configured by
   * SSL_CTX_set_keylog_callback.
   *)
  function SSL_CTX_get_keylog_callback(const ctx: PSSL_CTX): SSL_CTX_keylog_cb_func cdecl; external CLibSSL;
  function SSL_CTX_set_max_early_data(ctx: PSSL_CTX; max_early_data: TIdC_UINT32): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_get_max_early_data(const ctx: PSSL_CTX): TIdC_UINT32 cdecl; external CLibSSL;
  function SSL_set_max_early_data(s: PSSL; max_early_data: TIdC_UINT32): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_max_early_data(const s: PSSL): TIdC_UINT32 cdecl; external CLibSSL;
  function SSL_CTX_set_recv_max_early_data(ctx: PSSL_CTX; recv_max_early_data: TIdC_UINT32): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_get_recv_max_early_data(const ctx: PSSL_CTX): TIdC_UINT32 cdecl; external CLibSSL;
  function SSL_set_recv_max_early_data(s: PSSL; recv_max_early_data: TIdC_UINT32): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_recv_max_early_data(const s: PSSL): TIdC_UINT32 cdecl; external CLibSSL;

  ///*
  // * These need to be after the above set of includes due to a compiler bug
  // * in_ VisualStudio 2015
  // */
  //DEFINE_STACK_OF_CONST(SSL_CIPHER)
  //DEFINE_STACK_OF(SSL_COMP)

  ///* compatibility */
  //# define SSL_set_app_data(s,arg)         (SSL_set_ex_data(s,0,(PIdAnsiChar *)(arg)))
  //# define SSL_get_app_data(s)             (SSL_get_ex_data(s,0))
  //# define SSL_SESSION_set_app_data(s,a)   (SSL_SESSION_set_ex_data(s,0, \
  //                                                                  (PIdAnsiChar *)(a)))
  //# define SSL_SESSION_get_app_data(s)     (SSL_SESSION_get_ex_data(s,0))
  //# define SSL_CTX_get_app_data(ctx)       (SSL_CTX_get_ex_data(ctx,0))
  //# define SSL_CTX_set_app_data(ctx,arg)   (SSL_CTX_set_ex_data(ctx,0, \
  //                                                              (PIdAnsiChar *)(arg)))

  ///* Is the SSL_connection established? */
  //# define SSL_in_connect_init(a)          (SSL_in_init(a) && !SSL_is_server(a))
  //# define SSL_in_accept_init(a)           (SSL_in_init(a) && SSL_is_server(a))
  function SSL_in_init(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_in_before(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_is_init_finished(const s: PSSL): TIdC_INT cdecl; external CLibSSL;

  (*-
   * Obtain latest Finished message
   *   -- that we sent (SSL_get_finished)
   *   -- that we expected from peer (SSL_get_peer_finished).
   * Returns length (0 == no Finished so far), copies up to 'count' bytes.
   *)
  function SSL_get_finished(const s: PSSL; buf: Pointer; count: TIdC_SIZET): TIdC_SIZET cdecl; external CLibSSL;
  function SSL_get_peer_finished(const s: PSSL; buf: Pointer; count: TIdC_SIZET): TIdC_SIZET cdecl; external CLibSSL;

  //# if OPENSSL_API_COMPAT < 0x10100000L
  //#  define OpenSSL_add_ssl_algorithms()   SSL_library_init()
  //#  define SSLeay_add_ssl_algorithms()    SSL_library_init()
  //# endif

  ///* More backward compatibility */
  //# define SSL_get_cipher(s) \
  //                SSL_CIPHER_get_name(SSL_get_current_cipher(s))
  //# define SSL_get_cipher_bits(s,np) \
  //                SSL_CIPHER_get_bits(SSL_get_current_cipher(s),np)
  //# define SSL_get_cipher_version(s) \
  //                SSL_CIPHER_get_version(SSL_get_current_cipher(s))
  //# define SSL_get_cipher_name(s) \
  //                SSL_CIPHER_get_name(SSL_get_current_cipher(s))
  //# define SSL_get_time(a)         SSL_SESSION_get_time(a)
  //# define SSL_set_time(a,b)       SSL_SESSION_set_time((a),(b))
  //# define SSL_get_timeout(a)      SSL_SESSION_get_timeout(a)
  //# define SSL_set_timeout(a,b)    SSL_SESSION_set_timeout((a),(b))
  //
  //# define d2i_SSL_SESSION_bio(bp,s_id) ASN1_d2i_bio_of(SSL_SESSION,SSL_SESSION_new,d2i_SSL_SESSION,bp,s_id)
  //# define i2d_SSL_SESSION_bio(bp,s_id) ASN1_i2d_bio_of(SSL_SESSION,i2d_SSL_SESSION,bp,s_id)

  //DECLARE_PEM_rw(SSL_SESSION, SSL_SESSION)

  //# define DTLSv1_get_timeout(ssl, arg) \
  //        SSL_ctrl(ssl,DTLS_CTRL_GET_TIMEOUT,0, (void *)(arg))
  //# define DTLSv1_handle_timeout(ssl) \
  //        SSL_ctrl(ssl,DTLS_CTRL_HANDLE_TIMEOUT,0, NULL)
  //
  ///* Backwards compatibility, original 1.1.0 names */
  //# define SSL_CTRL_GET_SERVER_TMP_KEY \
  //         SSL_CTRL_GET_PEER_TMP_KEY
  //# define SSL_get_server_tmp_key(s, pk) \
  //         SSL_get_peer_tmp_key(s, pk)

  //# if OPENSSL_API_COMPAT < 0x10100000L
  //const SSL_CTX_need_tmp_RSA = (ctx)    0;
  //const SSL_CTX_set_tmp_rsa = (ctx;rsa)   1;
  //const SSL_need_tmp_RSA = (ssl)     0;
  //const SSL_set_tmp_rsa = (ssl;rsa)    1;

  //#  define SSL_CTX_set_ecdh_auto(dummy, onoff)      ((onoff) != 0)
  //#  define SSL_set_ecdh_auto(dummy, onoff)          ((onoff) != 0)
  ///*
  // * We 'pretend' to call the callback to avoid warnings about unused static
  // * functions.
  // */
  //#  define SSL_CTX_set_tmp_rsa_callback(ctx, cb)    while(0) (cb)(NULL, 0, 0)
  //#  define SSL_set_tmp_rsa_callback(ssl, cb)        while(0) (cb)(NULL, 0, 0)
  //# endif
  //
  function BIO_f_ssl: PBIO_METHOD cdecl; external CLibSSL;
  function BIO_new_ssl(ctx: PSSL_CTX; client: TIdC_INT): PBIO cdecl; external CLibSSL;
  function BIO_new_ssl_connect(ctx: PSSL_CTX): PBIO cdecl; external CLibSSL;
  function BIO_new_buffer_ssl_connect(ctx: PSSL_CTX): PBIO cdecl; external CLibSSL;
  function BIO_ssl_copy_session_id(&to: PBIO; from: PBIO): TIdC_INT cdecl; external CLibSSL;

  function SSL_CTX_set_cipher_list(v1: PSSL_CTX; const str: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_new(const meth: PSSL_METHOD): PSSL_CTX cdecl; external CLibSSL;
  function SSL_CTX_set_timeout(ctx: PSSL_CTX; t: TIdC_LONG): TIdC_LONG cdecl; external CLibSSL;
  function SSL_CTX_get_timeout(const ctx: PSSL_CTX): TIdC_LONG cdecl; external CLibSSL;
  function SSL_CTX_get_cert_store(const v1: PSSL_CTX): PX509_STORE cdecl; external CLibSSL;
  function SSL_want(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_clear(s: PSSL): TIdC_INT cdecl; external CLibSSL;

  procedure BIO_ssl_shutdown(ssl_bio: PBIO) cdecl; external CLibSSL;
  function SSL_CTX_up_ref(ctx: PSSL_CTX): TIdC_INT cdecl; external CLibSSL;
  procedure SSL_CTX_free(v1: PSSL_CTX) cdecl; external CLibSSL;
  procedure SSL_CTX_set_cert_store(v1: PSSL_CTX; v2: PX509_STORE) cdecl; external CLibSSL;
  procedure SSL_CTX_set1_cert_store(v1: PSSL_CTX; v2: PX509_STORE) cdecl; external CLibSSL;

  procedure SSL_CTX_flush_sessions(ctx: PSSL_CTX; tm: TIdC_LONG) cdecl; external CLibSSL;

  function SSL_get_current_cipher(const s: PSSL): PSSL_CIPHER cdecl; external CLibSSL;
  function SSL_get_pending_cipher(const s: PSSL): PSSL_CIPHER cdecl; external CLibSSL;
  function SSL_CIPHER_get_bits(const c: PSSL_CIPHER; alg_bits: PIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_CIPHER_get_version(const c: PSSL_CIPHER): PIdAnsiChar cdecl; external CLibSSL;
  function SSL_CIPHER_get_name(const c: PSSL_CIPHER): PIdAnsiChar cdecl; external CLibSSL;
  function SSL_CIPHER_standard_name(const c: PSSL_CIPHER): PIdAnsiChar cdecl; external CLibSSL;
  function OPENSSL_cipher_name(const rfc_name: PIdAnsiChar): PIdAnsiChar cdecl; external CLibSSL;
  function SSL_CIPHER_get_id(const c: PSSL_CIPHER): TIdC_UINT32 cdecl; external CLibSSL;
  function SSL_CIPHER_get_protocol_id(const c: PSSL_CIPHER): TIdC_UINT16 cdecl; external CLibSSL;
  function SSL_CIPHER_get_kx_nid(const c: PSSL_CIPHER): TIdC_INT cdecl; external CLibSSL;
  function SSL_CIPHER_get_auth_nid(const c: PSSL_CIPHER): TIdC_INT cdecl; external CLibSSL;
  function SSL_CIPHER_get_handshake_digest(const c: PSSL_CIPHER): PEVP_MD cdecl; external CLibSSL;
  function SSL_CIPHER_is_aead(const c: PSSL_CIPHER): TIdC_INT cdecl; external CLibSSL;

  function SSL_get_fd(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_rfd(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_wfd(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_cipher_list(const s: PSSL; n: TIdC_INT): PIdAnsiChar cdecl; external CLibSSL;
  function SSL_get_shared_ciphers(const s: PSSL; buf: PIdAnsiChar; size: TIdC_INT): PIdAnsiChar cdecl; external CLibSSL;
  function SSL_get_read_ahead(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_pending(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_has_pending(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_set_fd(s: PSSL; fd: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_set_rfd(s: PSSL; fd: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_set_wfd(s: PSSL; fd: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  procedure SSL_set0_rbio(s: PSSL; rbio: PBIO) cdecl; external CLibSSL;
  procedure SSL_set0_wbio(s: PSSL; wbio: PBIO) cdecl; external CLibSSL;
  procedure SSL_set_bio(s: PSSL; rbio: PBIO; wbio: PBIO) cdecl; external CLibSSL;
  function SSL_get_rbio(const s: PSSL): PBIO cdecl; external CLibSSL;
  function SSL_get_wbio(const s: PSSL): PBIO cdecl; external CLibSSL;
  function SSL_set_cipher_list(s: PSSL; const str: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_set_ciphersuites(ctx: PSSL_CTX; const str: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_set_ciphersuites(s: PSSL; const str: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_verify_mode(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_verify_depth(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_verify_callback(const s: PSSL): SSL_verify_cb cdecl; external CLibSSL;
  procedure SSL_set_read_ahead(s: PSSL; yes: TIdC_INT) cdecl; external CLibSSL;
  procedure SSL_set_verify(s: PSSL; mode: TIdC_INT; callback: SSL_verify_cb) cdecl; external CLibSSL;
  procedure SSL_set_verify_depth(s: PSSL; depth: TIdC_INT) cdecl; external CLibSSL;
  //void SSL_set_cert_cb(s: PSSL, TIdC_INT (*cb) (ssl: PSSL, void *arg), void *arg);

  function SSL_use_RSAPrivateKey(ssl: PSSL; rsa: PRSA): TIdC_INT cdecl; external CLibSSL;
  function SSL_use_RSAPrivateKey_ASN1(ssl: PSSL; const d: PByte; len: TIdC_LONG): TIdC_INT cdecl; external CLibSSL;
  function SSL_use_PrivateKey(ssl: PSSL; pkey: PEVP_PKEY): TIdC_INT cdecl; external CLibSSL;
  function SSL_use_PrivateKey_ASN1(pk: TIdC_INT; ssl: PSSL; const d: PByte; len: TIdC_LONG): TIdC_INT cdecl; external CLibSSL;
  function SSL_use_certificate(ssl: PSSL; x: PX509): TIdC_INT cdecl; external CLibSSL;
  function SSL_use_certificate_ASN1(ssl: PSSL; const d: PByte; len: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  //__owur TIdC_INT SSL_use_cert_and_key(ssl: PSSL, x509: PX509, EVP_PKEY *privatekey,
  //                                STACK_OF(X509) *chain, TIdC_INT override);

  (* Set serverinfo data for the current active cert. *)
  function SSL_CTX_use_serverinfo(ctx: PSSL_CTX; const serverinfo: PByte; serverinfo_length: TIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_use_serverinfo_ex(ctx: PSSL_CTX; version: TIdC_UINT; const serverinfo: PByte; serverinfo_length: TIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_use_serverinfo_file(ctx: PSSL_CTX; const file_: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;

  function SSL_use_RSAPrivateKey_file(ssl: PSSL; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external CLibSSL;

  function SSL_use_PrivateKey_file(ssl: PSSL; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_use_certificate_file(ssl: PSSL; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external CLibSSL;

  function SSL_CTX_use_RSAPrivateKey_file(ctx: PSSL_CTX; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external CLibSSL;

  function SSL_CTX_use_PrivateKey_file(ctx: PSSL_CTX; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_use_certificate_file(ctx: PSSL_CTX; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  (* PEM type *)
  function SSL_CTX_use_certificate_chain_file(ctx: PSSL_CTX; const file_: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_use_certificate_chain_file(ssl: PSSL; const file_: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  //__owur STACK_OF(X509_NAME) *SSL_load_client_CA_file(const PIdAnsiChar *file);
  //__owur TIdC_INT SSL_add_file_cert_subjects_to_stack(STACK_OF(X509_NAME) *stackCAs,
  //                                               const PIdAnsiChar *file);
  //TIdC_INT SSL_add_dir_cert_subjects_to_stack(STACK_OF(X509_NAME) *stackCAs,
  //                                       const PIdAnsiChar *dir);

  //# if OPENSSL_API_COMPAT < 0x10100000L
  //#  define SSL_load_error_strings() \
  //    OPENSSL_init_ssl(OPENSSL_INIT_LOAD_SSL_STRINGS \
  //                     | OPENSSL_INIT_LOAD_CRYPTO_STRINGS, NULL)
  //# endif

  function SSL_state_string(const s: PSSL): PIdAnsiChar cdecl; external CLibSSL;
  function SSL_rstate_string(const s: PSSL): PIdAnsiChar cdecl; external CLibSSL;
  function SSL_state_string_long(const s: PSSL): PIdAnsiChar cdecl; external CLibSSL;
  function SSL_rstate_string_long(const s: PSSL): PIdAnsiChar cdecl; external CLibSSL;
  function SSL_SESSION_get_time(const s: PSSL_SESSION): TIdC_LONG cdecl; external CLibSSL;
  function SSL_SESSION_set_time(s: PSSL_SESSION; t: TIdC_LONG): TIdC_LONG cdecl; external CLibSSL;
  function SSL_SESSION_get_timeout(const s: PSSL_SESSION): TIdC_LONG cdecl; external CLibSSL;
  function SSL_SESSION_set_timeout(s: PSSL_SESSION; t: TIdC_LONG): TIdC_LONG cdecl; external CLibSSL;
  function SSL_SESSION_get_protocol_version(const s: PSSL_SESSION): TIdC_INT cdecl; external CLibSSL;
  function SSL_SESSION_set_protocol_version(s: PSSL_SESSION; version: TIdC_INT): TIdC_INT cdecl; external CLibSSL;

  function SSL_SESSION_get0_hostname(const s: PSSL_SESSION): PIdAnsiChar cdecl; external CLibSSL;
  function SSL_SESSION_set1_hostname(s: PSSL_SESSION; const hostname: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  procedure SSL_SESSION_get0_alpn_selected(const s: PSSL_SESSION; const alpn: PPByte; len: PIdC_SIZET) cdecl; external CLibSSL;
  function SSL_SESSION_set1_alpn_selected(s: PSSL_SESSION; const alpn: PByte; len: TIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_SESSION_get0_cipher(const s: PSSL_SESSION): PSSL_CIPHER cdecl; external CLibSSL;
  function SSL_SESSION_set_cipher(s: PSSL_SESSION; const cipher: PSSL_CIPHER): TIdC_INT cdecl; external CLibSSL;
  function SSL_SESSION_has_ticket(const s: PSSL_SESSION): TIdC_INT cdecl; external CLibSSL;
  function SSL_SESSION_get_ticket_lifetime_hint(const s: PSSL_SESSION): TIdC_ULONG cdecl; external CLibSSL;
  procedure SSL_SESSION_get0_ticket(const s: PSSL_SESSION; const tick: PPByte; len: PIdC_SIZET) cdecl; external CLibSSL;
  function SSL_SESSION_get_max_early_data(const s: PSSL_SESSION): TIdC_UINT32 cdecl; external CLibSSL;
  function SSL_SESSION_set_max_early_data(s: PSSL_SESSION; max_early_data: TIdC_UINT32): TIdC_INT cdecl; external CLibSSL;
  function SSL_copy_session_id(&to: PSSL; const from: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_SESSION_get0_peer(s: PSSL_SESSION): PX509 cdecl; external CLibSSL;
  function SSL_SESSION_set1_id_context(s: PSSL_SESSION; const sid_ctx: PByte; sid_ctx_len: TIdC_UINT): TIdC_INT cdecl; external CLibSSL;
  function SSL_SESSION_set1_id(s: PSSL_SESSION; const sid: PByte; sid_len: TIdC_UINT): TIdC_INT cdecl; external CLibSSL;
  function SSL_SESSION_is_resumable(const s: PSSL_SESSION): TIdC_INT cdecl; external CLibSSL;

  function SSL_SESSION_new: PSSL_SESSION cdecl; external CLibSSL;
  function SSL_SESSION_dup(src: PSSL_SESSION): PSSL_SESSION cdecl; external CLibSSL;
  function SSL_SESSION_get_id(const s: PSSL_SESSION; len: PIdC_UINT): PByte cdecl; external CLibSSL;
  function SSL_SESSION_get0_id_context(const s: PSSL_SESSION; len: PIdC_UINT): PByte cdecl; external CLibSSL;
  function SSL_SESSION_get_compress_id(const s: PSSL_SESSION): TIdC_UINT cdecl; external CLibSSL;
  function SSL_SESSION_print(fp: PBIO; const ses: PSSL_SESSION): TIdC_INT cdecl; external CLibSSL;
  function SSL_SESSION_print_keylog(bp: PBIO; const x: PSSL_SESSION): TIdC_INT cdecl; external CLibSSL;
  function SSL_SESSION_up_ref(ses: PSSL_SESSION): TIdC_INT cdecl; external CLibSSL;
  procedure SSL_SESSION_free(ses: PSSL_SESSION) cdecl; external CLibSSL;
  //__owur TIdC_INT i2d_SSL_SESSION(SSL_SESSION *&in, Byte **pp);
  function SSL_set_session(&to: PSSL; session: PSSL_SESSION): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_add_session(ctx: PSSL_CTX; session: PSSL_SESSION): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_remove_session(ctx: PSSL_CTX; session: PSSL_SESSION): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_set_generate_session_id(ctx: PSSL_CTX; cb: GEN_SESSION_CB): TIdC_INT cdecl; external CLibSSL;
  function SSL_set_generate_session_id(s: PSSL; cb: GEN_SESSION_CB): TIdC_INT cdecl; external CLibSSL;
  function SSL_has_matching_session_id(const s: PSSL; const id: PByte; id_len: TIdC_UINT): TIdC_INT cdecl; external CLibSSL;
  function d2i_SSL_SESSION(a: PPSSL_SESSION; const pp: PPByte; length: TIdC_LONG): PSSL_SESSION cdecl; external CLibSSL;

  function SSL_get_peer_certificate(const s: PSSL): PX509 cdecl; external CLibSSL;

  //__owur STACK_OF(X509) *SSL_get_peer_cert_chain(const s: PSSL);
  //
  function SSL_CTX_get_verify_mode(const ctx: PSSL_CTX): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_get_verify_depth(const ctx: PSSL_CTX): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_get_verify_callback(const ctx: PSSL_CTX): SSL_verify_cb cdecl; external CLibSSL;
  procedure SSL_CTX_set_verify(ctx: PSSL_CTX; mode: TIdC_INT; callback: SSL_verify_cb) cdecl; external CLibSSL;
  procedure SSL_CTX_set_verify_depth(ctx: PSSL_CTX; depth: TIdC_INT) cdecl; external CLibSSL;
  procedure SSL_CTX_set_cert_verify_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_cert_verify_callback_cb; arg: Pointer) cdecl; external CLibSSL;
  procedure SSL_CTX_set_cert_cb(c: PSSL_CTX; cb: SSL_CTX_set_cert_cb_cb; arg: Pointer) cdecl; external CLibSSL;
  function SSL_CTX_use_RSAPrivateKey(ctx: PSSL_CTX; rsa: PRSA): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_use_RSAPrivateKey_ASN1(ctx: PSSL_CTX; const d: PByte; len: TIdC_LONG): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_use_PrivateKey(ctx: PSSL_CTX; pkey: PEVP_PKEY): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_use_PrivateKey_ASN1(pk: TIdC_INT; ctx: PSSL_CTX; const d: PByte; len: TIdC_LONG): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_use_certificate(ctx: PSSL_CTX; x: X509): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_use_certificate_ASN1(ctx: PSSL_CTX; len: TIdC_INT; const d: PByte): TIdC_INT cdecl; external CLibSSL;
  //function TIdC_INT SSL_CTX_use_cert_and_key(ctx: PSSL_CTX; x509: PX509; EVP_PKEY *privatekey; STACK_OF(X509) *chain; TIdC_INT override);

  procedure SSL_CTX_set_default_passwd_cb(ctx: PSSL_CTX; cb: pem_password_cb) cdecl; external CLibSSL;
  procedure SSL_CTX_set_default_passwd_cb_userdata(ctx: PSSL_CTX; u: Pointer) cdecl; external CLibSSL;
  function SSL_CTX_get_default_passwd_cb(ctx: PSSL_CTX): pem_password_cb cdecl; external CLibSSL;
  function SSL_CTX_get_default_passwd_cb_userdata(ctx: PSSL_CTX): Pointer cdecl; external CLibSSL;
  procedure SSL_set_default_passwd_cb(s: PSSL; cb: pem_password_cb) cdecl; external CLibSSL;
  procedure SSL_set_default_passwd_cb_userdata(s: PSSL; u: Pointer) cdecl; external CLibSSL;
  function SSL_get_default_passwd_cb(s: PSSL): pem_password_cb cdecl; external CLibSSL;
  function SSL_get_default_passwd_cb_userdata(s: PSSL): Pointer cdecl; external CLibSSL;

  function SSL_CTX_check_private_key(const ctx: PSSL_CTX): TIdC_INT cdecl; external CLibSSL;
  function SSL_check_private_key(const ctx: PSSL): TIdC_INT cdecl; external CLibSSL;

  function SSL_CTX_set_session_id_context(ctx: PSSL_CTX; const sid_ctx: PByte; sid_ctx_len: TIdC_UINT): TIdC_INT cdecl; external CLibSSL;

  function SSL_new(ctx: PSSL_CTX): PSSL cdecl; external CLibSSL;
  function SSL_up_ref(s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_is_dtls(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_set_session_id_context(ssl: PSSL; const sid_ctx: PByte; sid_ctx_len: TIdC_UINT): TIdC_INT cdecl; external CLibSSL;

  function SSL_CTX_set_purpose(ctx: PSSL_CTX; purpose: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_set_purpose(ssl: PSSL; purpose: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_set_trust(ctx: PSSL_CTX; trust: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_set_trust(ssl: PSSL; trust: TIdC_INT): TIdC_INT cdecl; external CLibSSL;

  function SSL_set1_host(s: PSSL; const hostname: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_add1_host(s: PSSL; const hostname: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_get0_peername(s: PSSL): PIdAnsiChar cdecl; external CLibSSL;
  procedure SSL_set_hostflags(s: PSSL; flags: TIdC_UINT) cdecl; external CLibSSL;

  function SSL_CTX_dane_enable(ctx: PSSL_CTX): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_dane_mtype_set(ctx: PSSL_CTX; const md: PEVP_MD; mtype: TIdC_UINT8; ord: TIdC_UINT8): TIdC_INT cdecl; external CLibSSL;
  function SSL_dane_enable(s: PSSL; const basedomain: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_dane_tlsa_add(s: PSSL; usage: TIdC_UINT8; selector: TIdC_UINT8; mtype: TIdC_UINT8; const data: PByte; dlen: TIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_get0_dane_authority(s: PSSL; mcert: PPX509; mspki: PPEVP_PKEY): TIdC_INT cdecl; external CLibSSL;
  function SSL_get0_dane_tlsa(s: PSSL; usage: PIdC_UINT8; selector: PIdC_UINT8; mtype: PIdC_UINT8; const data: PPByte; dlen: PIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  (*
   * Bridge opacity barrier between libcrypt and libssl, also needed to support
   * offline testing in test/danetest.c
   *)
  function SSL_get0_dane(ssl: PSSL): PSSL_DANE cdecl; external CLibSSL;

  (*
   * DANE flags
   *)
  function SSL_CTX_dane_set_flags(ctx: PSSL_CTX; flags: TIdC_ULONG): TIdC_ULONG cdecl; external CLibSSL;
  function SSL_CTX_dane_clear_flags(ctx: PSSL_CTX; flags: TIdC_ULONG): TIdC_ULONG cdecl; external CLibSSL;
  function SSL_dane_set_flags(ssl: PSSL; flags: TIdC_ULONG): TIdC_ULONG cdecl; external CLibSSL;
  function SSL_dane_clear_flags(ssl: PSSL; flags: TIdC_ULONG): TIdC_ULONG cdecl; external CLibSSL;

  function SSL_CTX_set1_param(ctx: PSSL_CTX; vpm: PX509_VERIFY_PARAM): TIdC_INT cdecl; external CLibSSL;
  function SSL_set1_param(ssl: PSSL; vpm: PX509_VERIFY_PARAM): TIdC_INT cdecl; external CLibSSL;

  function SSL_CTX_get0_param(ctx: PSSL_CTX): PX509_VERIFY_PARAM cdecl; external CLibSSL;
  function SSL_get0_param(ssl: PSSL): PX509_VERIFY_PARAM cdecl; external CLibSSL;

  function SSL_CTX_set_srp_username(ctx: PSSL_CTX; name: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_set_srp_password(ctx: PSSL_CTX; password: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_set_srp_strength(ctx: PSSL_CTX; strength: TIdC_INT): TIdC_INT cdecl; external CLibSSL;

  function SSL_CTX_set_srp_client_pwd_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_srp_client_pwd_callback_cb): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_set_srp_verify_param_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_srp_verify_param_callback_cb): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_set_srp_username_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_srp_username_callback_cb): TIdC_INT cdecl; external CLibSSL;

  function SSL_CTX_set_srp_cb_arg(ctx: PSSL_CTX; arg: Pointer): TIdC_INT cdecl; external CLibSSL;
  function SSL_set_srp_server_param(s: PSSL; const N: PBIGNUm; const g: PBIGNUm; sa: PBIGNUm; v: PBIGNUm; info: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_set_srp_server_param_pw(s: PSSL; const user: PIdAnsiChar; const pass: PIdAnsiChar; const grp: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;

  //__owur BIGNUM *SSL_get_srp_g(s: PSSL);
  //__owur BIGNUM *SSL_get_srp_N(s: PSSL);
  //
  //__owur PIdAnsiChar *SSL_get_srp_username(s: PSSL);
  //__owur PIdAnsiChar *SSL_get_srp_userinfo(s: PSSL);
  //
  ///*
  // * ClientHello callback and helpers.
  // */
  procedure SSL_CTX_set_client_hello_cb(c: PSSL_CTX; cb: SSL_client_hello_cb_fn; arg: Pointer) cdecl; external CLibSSL;
  function SSL_client_hello_isv2(s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_client_hello_get0_legacy_version(s: PSSL): TIdC_UINT cdecl; external CLibSSL;
  function SSL_client_hello_get0_random(s: PSSL; const out_: PPByte): TIdC_SIZET cdecl; external CLibSSL;
  function SSL_client_hello_get0_session_id(s: PSSL; const out_: PPByte): TIdC_SIZET cdecl; external CLibSSL;
  function SSL_client_hello_get0_ciphers(s: PSSL; const out_: PPByte): TIdC_SIZET cdecl; external CLibSSL;
  function SSL_client_hello_get0_compression_methods(s: PSSL; const out_: PPByte): TIdC_SIZET cdecl; external CLibSSL;
  function SSL_client_hello_get1_extensions_present(s: PSSL; out_: PPIdC_INT; outlen: PIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_client_hello_get0_ext(s: PSSL; type_: TIdC_UINT; const out_: PPByte; outlen: PIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  procedure SSL_certs_clear(s: PSSL) cdecl; external CLibSSL;
  procedure SSL_free(ssl: PSSL) cdecl; external CLibSSL;

  (*
   * Windows application developer has to include windows.h to use these.
   *)
  function SSL_waiting_for_async(s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_all_async_fds(s: PSSL; fds: POSSL_ASYNC_FD; numfds: PIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_changed_async_fds(s: PSSL; addfd: POSSL_ASYNC_FD; numaddfds: PIdC_SIZET; delfd: POSSL_ASYNC_FD; numdelfds: PIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_accept(ssl: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_stateless(s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_connect(ssl: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_read(ssl: PSSL; buf: Pointer; num: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_read_ex(ssl: PSSL; buf: Pointer; num: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT cdecl; external CLibSSL;

  function SSL_read_early_data(s: PSSL; buf: Pointer; num: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_peek(ssl: PSSL; buf: Pointer; num: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_peek_ex(ssl: PSSL; buf: Pointer; num: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_write(ssl: PSSL; const buf: Pointer; num: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_write_ex(s: PSSL; const buf: Pointer; num: TIdC_SIZET; written: PIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_write_early_data(s: PSSL; const buf: Pointer; num: TIdC_SIZET; written: PIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_callback_ctrl(v1: PSSL; v2: TIdC_INT; v3: SSL_callback_ctrl_v3): TIdC_LONG cdecl; external CLibSSL;

  function SSL_ctrl(ssl: PSSL; cmd: TIdC_INT; larg: TIdC_LONG; parg: Pointer): TIdC_LONG cdecl; external CLibSSL;
  function SSL_CTX_ctrl(ctx: PSSL_CTX; cmd: TIdC_INT; larg: TIdC_LONG; parg: Pointer): TIdC_LONG cdecl; external CLibSSL;
  function SSL_CTX_callback_ctrl(v1: PSSL_CTX; v2: TIdC_INT; v3: SSL_CTX_callback_ctrl_v3): TIdC_LONG cdecl; external CLibSSL;

  function SSL_get_early_data_status(const s: PSSL): TIdC_INT cdecl; external CLibSSL;

  function SSL_get_error(const s: PSSL; ret_code: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_version(const s: PSSL): PIdAnsiChar cdecl; external CLibSSL;

  (* This sets the 'default' SSL version that SSL_new() will create *)
  function SSL_CTX_set_ssl_version(ctx: PSSL_CTX; const meth: PSSL_METHOD): TIdC_INT cdecl; external CLibSSL;

  ///* Negotiate highest available SSL/TLS version */
  function TLS_method: PSSL_METHOD cdecl; external CLibSSL;
  function TLS_server_method: PSSL_METHOD cdecl; external CLibSSL;
  function TLS_client_method: PSSL_METHOD cdecl; external CLibSSL;

  //__owur const SSL_METHOD *DTLS_method(void); /* DTLS 1.0 and 1.2 */
  //__owur const SSL_METHOD *DTLS_server_method(void); /* DTLS 1.0 and 1.2 */
  //__owur const SSL_METHOD *DTLS_client_method(void); /* DTLS 1.0 and 1.2 */
  //
  //__owur TIdC_SIZET DTLS_get_data_mtu(const s: PSSL);
  //
  //__owur STACK_OF(SSL_CIPHER) *SSL_get_ciphers(const s: PSSL);
  //__owur STACK_OF(SSL_CIPHER) *SSL_CTX_get_ciphers(const ctx: PSSL_CTX);
  //__owur STACK_OF(SSL_CIPHER) *SSL_get_client_ciphers(const s: PSSL);
  //__owur STACK_OF(SSL_CIPHER) *SSL_get1_supported_ciphers(s: PSSL);
  //
  //__owur TIdC_INT SSL_do_handshake(s: PSSL);
  function SSL_key_update(s: PSSL; updatetype: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_key_update_type(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_renegotiate(s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_renegotiate_abbreviated(s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_shutdown(s: PSSL): TIdC_INT cdecl; external CLibSSL;
  procedure SSL_CTX_set_post_handshake_auth(ctx: PSSL_CTX; val: TIdC_INT) cdecl; external CLibSSL;
  procedure SSL_set_post_handshake_auth(s: PSSL; val: TIdC_INT) cdecl; external CLibSSL;

  function SSL_renegotiate_pending(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_verify_client_post_handshake(s: PSSL): TIdC_INT cdecl; external CLibSSL;

  function SSL_CTX_get_ssl_method(const ctx: PSSL_CTX): PSSL_METHOD cdecl; external CLibSSL;
  function SSL_get_ssl_method(const s: PSSL): PSSL_METHOD cdecl; external CLibSSL;
  function SSL_set_ssl_method(s: PSSL; const method: PSSL_METHOD): TIdC_INT cdecl; external CLibSSL;
  function SSL_alert_type_string_long(value: TIdC_INT): PIdAnsiChar cdecl; external CLibSSL;
  function SSL_alert_type_string(value: TIdC_INT): PIdAnsiChar cdecl; external CLibSSL;
  function SSL_alert_desc_string_long(value: TIdC_INT): PIdAnsiChar cdecl; external CLibSSL;
  function SSL_alert_desc_string(value: TIdC_INT): PIdAnsiChar cdecl; external CLibSSL;

  //void SSL_set0_CA_list(s: PSSL, STACK_OF(X509_NAME) *name_list);
  //void SSL_CTX_set0_CA_list(ctx: PSSL_CTX, STACK_OF(X509_NAME) *name_list);
  //__owur const STACK_OF(X509_NAME) *SSL_get0_CA_list(const s: PSSL);
  //__owur const STACK_OF(X509_NAME) *SSL_CTX_get0_CA_list(const ctx: PSSL_CTX);
  //__owur TIdC_INT SSL_add1_to_CA_list(ssl: PSSL, const X509 *x);
  //__owur TIdC_INT SSL_CTX_add1_to_CA_list(ctx: PSSL_CTX, const X509 *x);
  //__owur const STACK_OF(X509_NAME) *SSL_get0_peer_CA_list(const s: PSSL);

  //void SSL_set_client_CA_list(s: PSSL, STACK_OF(X509_NAME) *name_list);
  //void SSL_CTX_set_client_CA_list(ctx: PSSL_CTX, STACK_OF(X509_NAME) *name_list);
  //__owur STACK_OF(X509_NAME) *SSL_get_client_CA_list(const s: PSSL);
  //__owur STACK_OF(X509_NAME) *SSL_CTX_get_client_CA_list(const SSL_CTX *s);
  function SSL_add_client_CA(ssl: PSSL; x: PX509): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_add_client_CA(ctx: PSSL_CTX; x: PX509): TIdC_INT cdecl; external CLibSSL;

  procedure SSL_set_connect_state(s: PSSL) cdecl; external CLibSSL;
  procedure SSL_set_accept_state(s: PSSL) cdecl; external CLibSSL;

  //__owur TIdC_LONG SSL_get_default_timeout(const s: PSSL);
  //
  //# if OPENSSL_API_COMPAT < 0x10100000L
  //#  define SSL_library_init() OPENSSL_init_ssl(0, NULL)
  //# endif

  //__owur PIdAnsiChar *SSL_CIPHER_description(const SSL_CIPHER *, PIdAnsiChar *buf, TIdC_INT size);
  //__owur STACK_OF(X509_NAME) *SSL_dup_CA_list(const STACK_OF(X509_NAME) *sk);

  function SSL_dup(ssl: PSSL): PSSL cdecl; external CLibSSL;

  function SSL_get_certificate(const ssl: PSSL): PX509 cdecl; external CLibSSL;
  (*
   * EVP_PKEY
   *)
  function SSL_get_privatekey(const ssl: PSSL): PEVP_PKEY cdecl; external CLibSSL;

  function SSL_CTX_get0_certificate(const ctx: PSSL_CTX): PX509 cdecl; external CLibSSL;
  function SSL_CTX_get0_privatekey(const ctx: PSSL_CTX): PEVP_PKEY cdecl; external CLibSSL;

  procedure SSL_CTX_set_quiet_shutdown(ctx: PSSL_CTX; mode: TIdC_INT) cdecl; external CLibSSL;
  function SSL_CTX_get_quiet_shutdown(const ctx: PSSL_CTX): TIdC_INT cdecl; external CLibSSL;
  procedure SSL_set_quiet_shutdown(ssl: PSSL; mode: TIdC_INT) cdecl; external CLibSSL;
  function SSL_get_quiet_shutdown(const ssl: PSSL): TIdC_INT cdecl; external CLibSSL;
  procedure SSL_set_shutdown(ssl: PSSL; mode: TIdC_INT) cdecl; external CLibSSL;
  function SSL_get_shutdown(const ssl: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_version(const ssl: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_client_version(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_set_default_verify_paths(ctx: PSSL_CTX): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_set_default_verify_dir(ctx: PSSL_CTX): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_set_default_verify_file(ctx: PSSL_CTX): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_load_verify_locations(ctx: PSSL_CTX; const CAfile: PIdAnsiChar; const CApath: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  //# define SSL_get0_session SSL_get_session/* just peek at pointer */
  function SSL_get_session(const ssl: PSSL): PSSL_SESSION cdecl; external CLibSSL;
  (* obtain a reference count *)
  function SSL_get1_session(ssl: PSSL): PSSL_SESSION cdecl; external CLibSSL;
  function SSL_get_SSL_CTX(const ssl: PSSL): PSSL_CTX cdecl; external CLibSSL;
  function SSL_set_SSL_CTX(ssl: PSSL; ctx: PSSL_CTX): PSSL_CTX cdecl; external CLibSSL;
  procedure SSL_set_info_callback(ssl: PSSL; cb: SSL_info_callback) cdecl; external CLibSSL;
  function SSL_get_info_callback(const ssl: PSSL): SSL_info_callback cdecl; external CLibSSL;
  function SSL_get_state(const ssl: PSSL): OSSL_HANDSHAKE_STATE cdecl; external CLibSSL;

  procedure SSL_set_verify_result(ssl: PSSL; v: TIdC_LONG) cdecl; external CLibSSL;
  function SSL_get_verify_result(const ssl: PSSL): TIdC_LONG cdecl; external CLibSSL;
  //__owur STACK_OF(X509) *SSL_get0_verified_chain(const s: PSSL);

  function SSL_get_client_random(const ssl: PSSL; out_: PByte; outlen: TIdC_SIZET): TIdC_SIZET cdecl; external CLibSSL;
  function SSL_get_server_random(const ssl: PSSL; out_: PByte; outlen: TIdC_SIZET): TIdC_SIZET cdecl; external CLibSSL;
  function SSL_SESSION_get_master_key(const sess: PSSL_SESSION; out_: PByte; outlen: TIdC_SIZET): TIdC_SIZET cdecl; external CLibSSL;
  function SSL_SESSION_set1_master_key(sess: PSSL_SESSION; const in_: PByte; len: TIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_SESSION_get_max_fragment_length(const sess: PSSL_SESSION): TIdC_UINT8 cdecl; external CLibSSL;

  //#define SSL_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_SSL, l, p, newf, dupf, freef)
  function SSL_set_ex_data(ssl: PSSL; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_ex_data(const ssl: PSSL; idx: TIdC_INT): Pointer cdecl; external CLibSSL;
  //#define SSL_SESSION_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_SSL_SESSION, l, p, newf, dupf, freef)
  function SSL_SESSION_set_ex_data(ss: PSSL_SESSION; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl; external CLibSSL;
  function SSL_SESSION_get_ex_data(const ss: PSSL_SESSION; idx: TIdC_INT): Pointer cdecl; external CLibSSL;
  //#define SSL_CTX_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_SSL_CTX, l, p, newf, dupf, freef)
  function SSL_CTX_set_ex_data(ssl: PSSL_CTX; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_get_ex_data(const ssl: PSSL_CTX; idx: TIdC_INT): Pointer cdecl; external CLibSSL;

  function SSL_get_ex_data_X509_STORE_CTX_idx: TIdC_INT cdecl; external CLibSSL;

  //# define SSL_CTX_get_default_read_ahead(ctx) SSL_CTX_get_read_ahead(ctx)
  //# define SSL_CTX_set_default_read_ahead(ctx,m) SSL_CTX_set_read_ahead(ctx,m)
  //# define SSL_CTX_get_read_ahead(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_GET_READ_AHEAD,0,NULL)
  //# define SSL_CTX_set_read_ahead(ctx,m) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SET_READ_AHEAD,m,NULL)
  //# define SSL_CTX_get_max_cert_list(ctx) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_GET_MAX_CERT_LIST,0,NULL)
  //# define SSL_CTX_set_max_cert_list(ctx,m) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SET_MAX_CERT_LIST,m,NULL)
  //# define SSL_get_max_cert_list(ssl) \
  //        SSL_ctrl(ssl,SSL_CTRL_GET_MAX_CERT_LIST,0,NULL)
  //# define SSL_set_max_cert_list(ssl,m) \
  //        SSL_ctrl(ssl,SSL_CTRL_SET_MAX_CERT_LIST,m,NULL)
  //
  //# define SSL_CTX_set_max_send_fragment(ctx,m) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SET_MAX_SEND_FRAGMENT,m,NULL)
  //# define SSL_set_max_send_fragment(ssl,m) \
  //        SSL_ctrl(ssl,SSL_CTRL_SET_MAX_SEND_FRAGMENT,m,NULL)
  //# define SSL_CTX_set_split_send_fragment(ctx,m) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SET_SPLIT_SEND_FRAGMENT,m,NULL)
  //# define SSL_set_split_send_fragment(ssl,m) \
  //        SSL_ctrl(ssl,SSL_CTRL_SET_SPLIT_SEND_FRAGMENT,m,NULL)
  //# define SSL_CTX_set_max_pipelines(ctx,m) \
  //        SSL_CTX_ctrl(ctx,SSL_CTRL_SET_MAX_PIPELINES,m,NULL)
  //# define SSL_set_max_pipelines(ssl,m) \
  //        SSL_ctrl(ssl,SSL_CTRL_SET_MAX_PIPELINES,m,NULL)

  procedure SSL_CTX_set_default_read_buffer_len(ctx: PSSL_CTX; len: TIdC_SIZET) cdecl; external CLibSSL;
  procedure SSL_set_default_read_buffer_len(s: PSSL; len: TIdC_SIZET) cdecl; external CLibSSL;

  procedure SSL_CTX_set_tmp_dh_callback(ctx: PSSL_CTX; dh: SSL_CTX_set_tmp_dh_callback_dh) cdecl; external CLibSSL;
  procedure SSL_set_tmp_dh_callback(ssl: PSSL; dh: SSL_set_tmp_dh_callback_dh) cdecl; external CLibSSL;

  //__owur const COMP_METHOD *SSL_get_current_compression(const s: PSSL);
  //__owur const COMP_METHOD *SSL_get_current_expansion(const s: PSSL);
  //__owur const PIdAnsiChar *SSL_COMP_get_name(const COMP_METHOD *comp);
  //__owur const PIdAnsiChar *SSL_COMP_get0_name(const SSL_COMP *comp);
  //__owur TIdC_INT SSL_COMP_get_id(const SSL_COMP *comp);
  //STACK_OF(SSL_COMP) *SSL_COMP_get_compression_methods(void);
  //__owur STACK_OF(SSL_COMP) *SSL_COMP_set0_compression_methods(STACK_OF(SSL_COMP)
  //                                                             *meths);
  //# if OPENSSL_API_COMPAT < 0x10100000L
  //#  define SSL_COMP_free_compression_methods() while(0) continue
  //# endif
  //__owur TIdC_INT SSL_COMP_add_compression_method(TIdC_INT id, COMP_METHOD *cm);

  function SSL_CIPHER_find(ssl: PSSL; const ptr: PByte): PSSL_CIPHER cdecl; external CLibSSL;
  function SSL_CIPHER_get_cipher_nid(const c: PSSL_CIPHEr): TIdC_INT cdecl; external CLibSSL;
  function SSL_CIPHER_get_digest_nid(const c: PSSL_CIPHEr): TIdC_INT cdecl; external CLibSSL;
  //TIdC_INT SSL_bytes_to_cipher_list(s: PSSL, const Byte *bytes, TIdC_SIZET len,
  //                             TIdC_INT isv2format, STACK_OF(SSL_CIPHER) **sk,
  //                             STACK_OF(SSL_CIPHER) **scsvs);

  (* TLS extensions functions *)
  function SSL_set_session_ticket_ext(s: PSSL; ext_data: Pointer; ext_len: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  //
  function SSL_set_session_ticket_ext_cb(s: PSSL; cb: tls_session_ticket_ext_cb_fn; arg: Pointer): TIdC_INT cdecl; external CLibSSL;

  ///* Pre-shared secret session resumption functions */
  //__owur TIdC_INT SSL_set_session_secret_cb(s: PSSL,
  //                                     tls_session_secret_cb_fn session_secret_cb,
  //                                     void *arg);

  procedure SSL_CTX_set_not_resumable_session_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_not_resumable_session_callback_cb) cdecl; external CLibSSL;
  procedure SSL_set_not_resumable_session_callback(ssl: PSSL; cb: SSL_set_not_resumable_session_callback_cb) cdecl; external CLibSSL;
  procedure SSL_CTX_set_record_padding_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_record_padding_callback_cb) cdecl; external CLibSSL;

  procedure SSL_CTX_set_record_padding_callback_arg(ctx: PSSL_CTX; arg: Pointer) cdecl; external CLibSSL;
  function SSL_CTX_get_record_padding_callback_arg(const ctx: PSSL_CTX): Pointer cdecl; external CLibSSL;
  function SSL_CTX_set_block_padding(ctx: PSSL_CTX; block_size: TIdC_SIZET): TIdC_INT cdecl; external CLibSSL;

  procedure SSL_set_record_padding_callback(ssl: PSSL; cb: SSL_set_record_padding_callback_cb) cdecl; external CLibSSL;

  procedure SSL_set_record_padding_callback_arg(ssl: PSSL; arg: Pointer) cdecl; external CLibSSL;
  function SSL_get_record_padding_callback_arg(const ssl: PSSL): Pointer cdecl; external CLibSSL;
  function SSL_set_block_padding(ssl: PSSL; block_size: TIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_set_num_tickets(s: PSSL; num_tickets: TIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_get_num_tickets(const s: PSSL): TIdC_SIZET cdecl; external CLibSSL;
  function SSL_CTX_set_num_tickets(ctx: PSSL_CTX; num_tickets: TIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_get_num_tickets(const ctx: PSSL_CTX): TIdC_SIZET cdecl; external CLibSSL;

  //# if OPENSSL_API_COMPAT < 0x10100000L
  //#  define SSL_cache_hit(s) SSL_session_reused(s)
  //# endif

  function SSL_session_reused(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_is_server(const s: PSSL): TIdC_INT cdecl; external CLibSSL;

  function SSL_CONF_CTX_new: PSSL_CONF_CTX cdecl; external CLibSSL;
  function SSL_CONF_CTX_finish(cctx: PSSL_CONF_CTX): TIdC_INT cdecl; external CLibSSL;
  procedure SSL_CONF_CTX_free(cctx: PSSL_CONF_CTX) cdecl; external CLibSSL;
  function SSL_CONF_CTX_set_flags(cctx: PSSL_CONF_CTX; flags: TIdC_UINT): TIdC_UINT cdecl; external CLibSSL;
  function SSL_CONF_CTX_clear_flags(cctx: PSSL_CONF_CTX; flags: TIdC_UINT): TIdC_UINT cdecl; external CLibSSL;
  function SSL_CONF_CTX_set1_prefix(cctx: PSSL_CONF_CTX; const pre: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_CONF_cmd(cctx: PSSL_CONF_CTX; const cmd: PIdAnsiChar; const value: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_CONF_cmd_argv(cctx: PSSL_CONF_CTX; pargc: PIdC_INT; pargv: PPPIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_CONF_cmd_value_type(cctx: PSSL_CONF_CTX; const cmd: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;

  procedure SSL_CONF_CTX_set_ssl(cctx: PSSL_CONF_CTX; ssl: PSSL) cdecl; external CLibSSL;
  procedure SSL_CONF_CTX_set_ssl_ctx(cctx: PSSL_CONF_CTX; ctx: PSSL_CTX) cdecl; external CLibSSL;
  procedure SSL_add_ssl_module cdecl; external CLibSSL;
  function SSL_config(s: PSSL; const name: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_config(ctx: PSSL_CTX; const name: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;

  procedure SSL_trace(write_p: TIdC_INT; version: TIdC_INT; content_type: TIdC_INT; const buf: Pointer; len: TIdC_SIZET; ssl: PSSL; arg: Pointer) cdecl; external CLibSSL;

  function DTLSv1_listen(s: PSSL; client: PBIO_ADDr): TIdC_INT cdecl; external CLibSSL;

  //# ifndef OPENSSL_NO_CT
  //
  ///*
  // * A callback for verifying that the received SCTs are sufficient.
  // * Expected to return 1 if they are sufficient, otherwise 0.
  // * May return a negative integer if an error occurs.
  // * A connection should be aborted if the SCTs are deemed insufficient.
  // */
  //typedef TIdC_INT (*ssl_ct_validation_cb)(const CT_POLICY_EVAL_CTX *ctx,
  //                                    const STACK_OF(SCT) *scts, void *arg);

  ///*
  // * Sets a |callback| that is invoked upon receipt of ServerHelloDone to validate
  // * the received SCTs.
  // * If the callback returns a non-positive result, the connection is terminated.
  // * Call this function before beginning a handshake.
  // * If a NULL |callback| is provided, SCT validation is disabled.
  // * |arg| is arbitrary userdata that will be passed to the callback whenever it
  // * is invoked. Ownership of |arg| remains with the caller.
  // *
  // * NOTE: A side-effect of setting a CT callback is that an OCSP stapled response
  // *       will be requested.
  // */
  //function SSL_set_ct_validation_callback(s: PSSL; callback: ssl_ct_validation_cb; arg: Pointer): TIdC_INT;
  //function SSL_CTX_set_ct_validation_callback(ctx: PSSL_CTX; callback: ssl_ct_validation_cb; arg: Pointer): TIdC_INT;

  //#define SSL_disable_ct(s) \
  //        ((void) SSL_set_validation_callback((s), NULL, NULL))
  //#define SSL_CTX_disable_ct(ctx) \
  //        ((void) SSL_CTX_set_validation_callback((ctx), NULL, NULL))

  ///*
  // * The validation type enumerates the available behaviours of the built-&in SSL
  // * CT validation callback selected via SSL_enable_ct() and SSL_CTX_enable_ct().
  // * The underlying callback is a static function in_ libssl.
  // */

  ///*
  // * Enable CT by setting up a callback that implements one of the built-&in
  // * validation variants.  The SSL_CT_VALIDATION_PERMISSIVE variant always
  // * continues the handshake, the application can make appropriate decisions at
  // * handshake completion.  The SSL_CT_VALIDATION_STRICT variant requires at
  // * least one valid SCT, or else handshake termination will be requested.  The
  // * handshake may continue anyway if SSL_VERIFY_NONE is in_ effect.
  // */
  function SSL_enable_ct(s: PSSL; validation_mode: TIdC_INT): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_enable_ct(ctx: PSSL_CTX; validation_mode: TIdC_INT): TIdC_INT cdecl; external CLibSSL;

  ///*
  // * Report whether a non-NULL callback is enabled.
  // */
  function SSL_ct_is_enabled(const s: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_ct_is_enabled(const ctx: PSSL_CTX): TIdC_INT cdecl; external CLibSSL;

  ///* Gets the SCTs received from a connection */
  //const STACK_OF(SCT) *SSL_get0_peer_scts(s: PSSL);

  function SSL_CTX_set_default_ctlog_list_file(ctx: PSSL_CTX): TIdC_INT cdecl; external CLibSSL;
  function SSL_CTX_set_ctlog_list_file(ctx: PSSL_CTX; const path: PIdAnsiChar): TIdC_INT cdecl; external CLibSSL;
  procedure SSL_CTX_set0_ctlog_store(ctx: PSSL_CTX; logs: PCTLOG_STORE) cdecl; external CLibSSL;

  // const CTLOG_STORE *SSL_CTX_get0_ctlog_store(const ctx: PSSL_CTX);

  // # endif /* OPENSSL_NO_CT */

  procedure SSL_set_security_level(s: PSSL; level: TIdC_INT) cdecl; external CLibSSL;

  ////__owur TIdC_INT SSL_get_security_level(const s: PSSL);
  procedure SSL_set_security_callback(s: PSSL; cb: SSL_security_callback) cdecl; external CLibSSL;
  function SSL_get_security_callback(const s: PSSL): SSL_security_callback cdecl; external CLibSSL;
  procedure SSL_set0_security_ex_data(s: PSSL; ex: Pointer) cdecl; external CLibSSL;
  function SSL_get0_security_ex_data(const s: PSSL): Pointer cdecl; external CLibSSL;
  procedure SSL_CTX_set_security_level(ctx: PSSL_CTX; level: TIdC_INT) cdecl; external CLibSSL;
  function SSL_CTX_get_security_level(const ctx: PSSL_CTX): TIdC_INT cdecl; external CLibSSL;
  //void SSL_CTX_set_security_callback(ctx: PSSL_CTX,
  //                                   TIdC_INT (*cb) (const s: PSSL, const ctx: PSSL_CTX,
  //                                              TIdC_INT op, TIdC_INT bits, TIdC_INT nid,
  //                                              void *other, void *ex));
  //TIdC_INT (*SSL_CTX_get_security_callback(const ctx: PSSL_CTX)) (const s: PSSL,
  //                                                          const ctx: PSSL_CTX,
  //                                                          TIdC_INT op, TIdC_INT bits,
  //                                                          TIdC_INT nid,
  //                                                          void *other,
  //                                                          void *ex);

  function SSL_CTX_get0_security_ex_data(const ctx: PSSL_CTX): Pointer cdecl; external CLibSSL;

  procedure SSL_CTX_set0_security_ex_data(ctx: PSSL_CTX; ex: Pointer) cdecl; external CLibSSL;

  function OPENSSL_init_ssl(opts: TIdC_UINT64; const settings: POPENSSL_INIT_SETTINGS): TIdC_INT cdecl; external CLibSSL;

  //# ifndef OPENSSL_NO_UNIT_TEST
  //__owur const struct openssl_ssl_test_functions *SSL_test_functions(void);
  //# endif

  function SSL_free_buffers(ssl: PSSL): TIdC_INT cdecl; external CLibSSL;
  function SSL_alloc_buffers(ssl: PSSL): TIdC_INT cdecl; external CLibSSL;

  function SSL_CTX_set_session_ticket_cb(ctx: PSSL_CTX; gen_cb: SSL_CTX_generate_session_ticket_fn; dec_cb: SSL_CTX_decrypt_session_ticket_fn; arg: Pointer): TIdC_INT cdecl; external CLibSSL;

  function SSL_SESSION_set1_ticket_appdata(ss: PSSL_SESSION; const data: Pointer; len: TIdC_SIZET): TIdC_INT cdecl; external CLibSSL;
  function SSL_SESSION_get0_ticket_appdata(ss: PSSL_SESSION; data: PPointer; len: PIdC_SIZET): TIdC_INT cdecl; external CLibSSL;

  //extern const PIdAnsiChar SSL_version_str[];

  procedure DTLS_set_timer_cb(s: PSSL; cb: DTLS_timer_cb) cdecl; external CLibSSL;
  procedure SSL_CTX_set_allow_early_data_cb(ctx: PSSL_CTX; cb: SSL_allow_early_data_cb_fN; arg: Pointer) cdecl; external CLibSSL;
  procedure SSL_set_allow_early_data_cb(s: PSSL; cb: SSL_allow_early_data_cb_fN; arg: Pointer) cdecl; external CLibSSL;

implementation

//# define SSL_CTX_set_mode(ctx,op)      SSL_CTX_ctrl((ctx),SSL_CTRL_MODE,(op),NULL)
function SSL_CTX_set_mode(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_MODE, op, nil);
end;

//# define SSL_CTX_clear_mode(ctx,op)   SSL_CTX_ctrl((ctx),SSL_CTRL_CLEAR_MODE,(op),NULL)
function SSL_CTX_clear_mode(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_CLEAR_MODE, op, nil);
end;

//# define SSL_CTX_sess_set_cache_size(ctx,t)         SSL_CTX_ctrl(ctx,SSL_CTRL_SET_SESS_CACHE_SIZE,t,NULL)
function SSL_CTX_sess_set_cache_size(ctx: PSSL_CTX; t: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_SESS_CACHE_SIZE, t, nil);
end;

//# define SSL_CTX_sess_get_cache_size(ctx)           SSL_CTX_ctrl(ctx,SSL_CTRL_GET_SESS_CACHE_SIZE,0,NULL)
function SSL_CTX_sess_get_cache_size(ctx: PSSL_CTX): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_GET_SESS_CACHE_SIZE, 0, nil);
end;

//# define SSL_CTX_set_session_cache_mode(ctx,m)      SSL_CTX_ctrl(ctx,SSL_CTRL_SET_SESS_CACHE_MODE,m,NULL)
function SSL_CTX_set_session_cache_mode(ctx: PSSL_CTX; m: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_SESS_CACHE_MODE, m, nil);
end;

//# define SSL_CTX_get_session_cache_mode(ctx)        SSL_CTX_ctrl(ctx,SSL_CTRL_GET_SESS_CACHE_MODE,0,NULL)
function SSL_CTX_get_session_cache_mode(ctx: PSSL_CTX): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_GET_SESS_CACHE_MODE, 0, nil);
end;

//# define SSL_num_renegotiations(ssl)                       SSL_ctrl((ssl),SSL_CTRL_GET_NUM_RENEGOTIATIONS,0,NULL)
function SSL_num_renegotiations(ssl: PSSL): TIdC_LONG;
begin
  Result := SSL_ctrl(ssl, SSL_CTRL_GET_NUM_RENEGOTIATIONS, 0, nil);
end;

//# define SSL_clear_num_renegotiations(ssl)                 SSL_ctrl((ssl),SSL_CTRL_CLEAR_NUM_RENEGOTIATIONS,0,NULL)
function SSL_clear_num_renegotiations(ssl: PSSL): TIdC_LONG;
begin
  Result := SSL_ctrl(ssl, SSL_CTRL_CLEAR_NUM_RENEGOTIATIONS, 0, nil);
end;

//# define SSL_total_renegotiations(ssl)                     SSL_ctrl((ssl),SSL_CTRL_GET_TOTAL_RENEGOTIATIONS,0,NULL)
function SSL_total_renegotiations(ssl: PSSL): TIdC_LONG;
begin
  Result := SSL_ctrl(ssl, SSL_CTRL_GET_TOTAL_RENEGOTIATIONS, 0, nil);
end;

//# define SSL_CTX_set_tmp_dh(ctx,dh)                        SSL_CTX_ctrl(ctx,SSL_CTRL_SET_TMP_DH,0,(char *)(dh))
function SSL_CTX_set_tmp_dh(ctx: PSSL_CTX; dh: PByte): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_TMP_DH, 0, dh);
end;

//# define SSL_CTX_set_tmp_ecdh(ctx,ecdh)                    SSL_CTX_ctrl(ctx,SSL_CTRL_SET_TMP_ECDH,0,(char *)(ecdh))
function SSL_CTX_set_tmp_ecdh(ctx: PSSL_CTX; ecdh: PByte): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_TMP_ECDH, 0, ecdh);
end;

//# define SSL_CTX_set_dh_auto(ctx, onoff)                   SSL_CTX_ctrl(ctx,SSL_CTRL_SET_DH_AUTO,onoff,NULL)
function SSL_CTX_set_dh_auto(ctx: PSSL_CTX; onoff: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_DH_AUTO, onoff, nil);
end;

//# define SSL_set_dh_auto(s, onoff)                         SSL_ctrl(s,SSL_CTRL_SET_DH_AUTO,onoff,NULL)
function SSL_set_dh_auto(s: PSSL; onoff: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_DH_AUTO, onoff, nil);
end;

//# define SSL_set_tmp_dh(ssl,dh)                            SSL_ctrl(ssl,SSL_CTRL_SET_TMP_DH,0,(char *)(dh))
function SSL_set_tmp_dh(ssl: PSSL; dh: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(ssl, SSL_CTRL_SET_TMP_DH, 0, dh);
end;

//# define SSL_set_tmp_ecdh(ssl,ecdh)                        SSL_ctrl(ssl,SSL_CTRL_SET_TMP_ECDH,0,(char *)(ecdh))
function SSL_set_tmp_ecdh(ssl: PSSL; ecdh: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(ssl, SSL_CTRL_SET_TMP_ECDH, 0, ecdh);
end;

//# define SSL_CTX_add_extra_chain_cert(ctx,x509)            SSL_CTX_ctrl(ctx,SSL_CTRL_EXTRA_CHAIN_CERT,0,(char *)(x509))
function SSL_CTX_add_extra_chain_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_EXTRA_CHAIN_CERT, 0, x509);
end;

//# define SSL_CTX_get_extra_chain_certs(ctx,px509)          SSL_CTX_ctrl(ctx,SSL_CTRL_GET_EXTRA_CHAIN_CERTS,0,px509)
function SSL_CTX_get_extra_chain_certs(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_GET_EXTRA_CHAIN_CERTS, 0, px509);
end;

//# define SSL_CTX_get_extra_chain_certs_only(ctx,px509)     SSL_CTX_ctrl(ctx,SSL_CTRL_GET_EXTRA_CHAIN_CERTS,1,px509)
function SSL_CTX_get_extra_chain_certs_only(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_GET_EXTRA_CHAIN_CERTS, 1, px509);
end;

//# define SSL_CTX_clear_extra_chain_certs(ctx)              SSL_CTX_ctrl(ctx,SSL_CTRL_CLEAR_EXTRA_CHAIN_CERTS,0,NULL)
function SSL_CTX_clear_extra_chain_certs(ctx: PSSL_CTX): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_CLEAR_EXTRA_CHAIN_CERTS, 0, nil);
end;

//# define SSL_CTX_set0_chain(ctx,sk)                        SSL_CTX_ctrl(ctx,SSL_CTRL_CHAIN,0,(char *)(sk))
function SSL_CTX_set0_chain(ctx: PSSL_CTX; sk: PByte): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_CHAIN, 0, sk);
end;

//# define SSL_CTX_set1_chain(ctx,sk)                        SSL_CTX_ctrl(ctx,SSL_CTRL_CHAIN,1,(char *)(sk))
function SSL_CTX_set1_chain(ctx: PSSL_CTX; sk: PByte): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_CHAIN, 1, sk);
end;

//# define SSL_CTX_add0_chain_cert(ctx,x509)                 SSL_CTX_ctrl(ctx,SSL_CTRL_CHAIN_CERT,0,(char *)(x509))
function SSL_CTX_add0_chain_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_CHAIN_CERT, 0, x509);
end;

//# define SSL_CTX_add1_chain_cert(ctx,x509)                 SSL_CTX_ctrl(ctx,SSL_CTRL_CHAIN_CERT,1,(char *)(x509))
function SSL_CTX_add1_chain_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_CHAIN_CERT, 1, x509);
end;

//# define SSL_CTX_get0_chain_certs(ctx,px509)               SSL_CTX_ctrl(ctx,SSL_CTRL_GET_CHAIN_CERTS,0,px509)
function SSL_CTX_get0_chain_certs(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_GET_CHAIN_CERTS, 0, px509);
end;

//# define SSL_CTX_clear_chain_certs(ctx)                    SSL_CTX_set0_chain(ctx,NULL)
function SSL_CTX_clear_chain_certs(ctx: PSSL_CTX): TIdC_LONG;
begin
  Result := SSL_CTX_set0_chain(ctx, nil);
end;

//# define SSL_CTX_build_cert_chain(ctx, flags)              SSL_CTX_ctrl(ctx,SSL_CTRL_BUILD_CERT_CHAIN, flags, NULL)
function SSL_CTX_build_cert_chain(ctx: PSSL_CTX; flags: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_BUILD_CERT_CHAIN, flags, nil);
end;

//# define SSL_CTX_select_current_cert(ctx,x509)             SSL_CTX_ctrl(ctx,SSL_CTRL_SELECT_CURRENT_CERT,0,(char *)(x509))
function SSL_CTX_select_current_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SELECT_CURRENT_CERT, 0, x509);
end;

//# define SSL_CTX_set_current_cert(ctx, op)                 SSL_CTX_ctrl(ctx,SSL_CTRL_SET_CURRENT_CERT, op, NULL)
function SSL_CTX_set_current_cert(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_CURRENT_CERT, op, nil);
end;

//# define SSL_CTX_set0_verify_cert_store(ctx,st)            SSL_CTX_ctrl(ctx,SSL_CTRL_SET_VERIFY_CERT_STORE,0,(char *)(st))
function SSL_CTX_set0_verify_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_VERIFY_CERT_STORE, 0, st);
end;

//# define SSL_CTX_set1_verify_cert_store(ctx,st)            SSL_CTX_ctrl(ctx,SSL_CTRL_SET_VERIFY_CERT_STORE,1,(char *)(st))
function SSL_CTX_set1_verify_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_VERIFY_CERT_STORE, 1, st);
end;

//# define SSL_CTX_set0_chain_cert_store(ctx,st)             SSL_CTX_ctrl(ctx,SSL_CTRL_SET_CHAIN_CERT_STORE,0,(char *)(st))
function SSL_CTX_set0_chain_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_CHAIN_CERT_STORE, 0, st);
end;

//# define SSL_CTX_set1_chain_cert_store(ctx,st)             SSL_CTX_ctrl(ctx,SSL_CTRL_SET_CHAIN_CERT_STORE,1,(char *)(st))
function SSL_CTX_set1_chain_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_CHAIN_CERT_STORE, 1, st);
end;

//# define SSL_set0_chain(s,sk)                              SSL_ctrl(s,SSL_CTRL_CHAIN,0,(char *)(sk))
function SSL_set0_chain(s: PSSL; sk: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_CHAIN, 0, sk);
end;

//# define SSL_set1_chain(s,sk)                              SSL_ctrl(s,SSL_CTRL_CHAIN,1,(char *)(sk))
function SSL_set1_chain(s: PSSL; sk: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_CHAIN, 1, sk);
end;

//# define SSL_add0_chain_cert(s,x509)                       SSL_ctrl(s,SSL_CTRL_CHAIN_CERT,0,(char *)(x509))
function SSL_add0_chain_cert(s: PSSL; x509: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_CHAIN_CERT, 0, x509);
end;

//# define SSL_add1_chain_cert(s,x509)                       SSL_ctrl(s,SSL_CTRL_CHAIN_CERT,1,(char *)(x509))
function SSL_add1_chain_cert(s: PSSL; x509: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_CHAIN_CERT, 1, x509);
end;

//# define SSL_get0_chain_certs(s,px509)                     SSL_ctrl(s,SSL_CTRL_GET_CHAIN_CERTS,0,px509)
function SSL_get0_chain_certs(s: PSSL; px509: Pointer): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_CHAIN_CERTS, 0, px509);
end;

//# define SSL_clear_chain_certs(s)                          SSL_set0_chain(s,NULL)
function SSL_clear_chain_certs(s: PSSL): TIdC_LONG;
begin
  Result := SSL_set0_chain(s, nil);
end;

//# define SSL_build_cert_chain(s, flags)                    SSL_ctrl(s,SSL_CTRL_BUILD_CERT_CHAIN, flags, NULL)
function SSL_build_cert_chain(s: PSSL; flags: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_BUILD_CERT_CHAIN, flags, nil);
end;

//# define SSL_select_current_cert(s,x509)                   SSL_ctrl(s,SSL_CTRL_SELECT_CURRENT_CERT,0,(char *)(x509))
function SSL_select_current_cert(s: PSSL; x509: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SELECT_CURRENT_CERT, 0, x509);
end;

//# define SSL_set_current_cert(s,op)                        SSL_ctrl(s,SSL_CTRL_SET_CURRENT_CERT, op, NULL)
function SSL_set_current_cert(s: PSSL; op: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_CURRENT_CERT, op, nil);
end;

//# define SSL_set0_verify_cert_store(s,st)                  SSL_ctrl(s,SSL_CTRL_SET_VERIFY_CERT_STORE,0,(char *)(st))
function SSL_set0_verify_cert_store(s: PSSL; st: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_VERIFY_CERT_STORE, 0, st);
end;

//# define SSL_set1_verify_cert_store(s,st)                  SSL_ctrl(s,SSL_CTRL_SET_VERIFY_CERT_STORE,1,(char *)(st))
function SSL_set1_verify_cert_store(s: PSSL; st: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_VERIFY_CERT_STORE, 1, st);
end;

//# define SSL_set0_chain_cert_store(s,st)                   SSL_ctrl(s,SSL_CTRL_SET_CHAIN_CERT_STORE,0,(char *)(st))
function SSL_set0_chain_cert_store(s: PSSL; st: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_CHAIN_CERT_STORE, 0, st);
end;

//# define SSL_set1_chain_cert_store(s,st)                   SSL_ctrl(s,SSL_CTRL_SET_CHAIN_CERT_STORE,1,(char *)(st))
function SSL_set1_chain_cert_store(s: PSSL; st: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_CHAIN_CERT_STORE, 1, st);
end;

//# define SSL_get1_groups(s, glist)                         SSL_ctrl(s,SSL_CTRL_GET_GROUPS,0,(TIdC_INT*)(glist))
function SSL_get1_groups(s: PSSL; glist: PIdC_INT): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_GROUPS, 0, glist);
end;

//# define SSL_CTX_set1_groups(ctx, glist, glistlen)         SSL_CTX_ctrl(ctx,SSL_CTRL_SET_GROUPS,glistlen,(char *)(glist))
function SSL_CTX_set1_groups(ctx: PSSL_CTX; glist: PByte; glistlen: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_GROUPS, glistlen, glist);
end;

//# define SSL_CTX_set1_groups_list(ctx, s)                  SSL_CTX_ctrl(ctx,SSL_CTRL_SET_GROUPS_LIST,0,(char *)(s))
function SSL_CTX_set1_groups_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_GROUPS_LIST, 0, s);
end;

//# define SSL_set1_groups(s, glist, glistlen)               SSL_ctrl(s,SSL_CTRL_SET_GROUPS,glistlen,(char *)(glist))
function SSL_set1_groups(s: PSSL; glist: PByte; glistlen: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_GROUPS, glistlen, glist);
end;

//# define SSL_set1_groups_list(s, str)                      SSL_ctrl(s,SSL_CTRL_SET_GROUPS_LIST,0,(char *)(str))
function SSL_set1_groups_list(s: PSSL; str: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_GROUPS_LIST, 0, str);
end;

//# define SSL_get_shared_group(s, n)                        SSL_ctrl(s,SSL_CTRL_GET_SHARED_GROUP,n,NULL)
function SSL_get_shared_group(s: PSSL; n: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_SHARED_GROUP, n, nil);
end;

//# define SSL_CTX_set1_sigalgs(ctx, slist, slistlen)        SSL_CTX_ctrl(ctx,SSL_CTRL_SET_SIGALGS,slistlen,(TIdC_INT *)(slist))
function SSL_CTX_set1_sigalgs(ctx: PSSL_CTX; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_SIGALGS, slistlen, slist);
end;

//# define SSL_CTX_set1_sigalgs_list(ctx, s)                 SSL_CTX_ctrl(ctx,SSL_CTRL_SET_SIGALGS_LIST,0,(char *)(s))
function SSL_CTX_set1_sigalgs_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_SIGALGS_LIST, 0, s);
end;

//# define SSL_set1_sigalgs(s, slist, slistlen)              SSL_ctrl(s,SSL_CTRL_SET_SIGALGS,slistlen,(TIdC_INT *)(slist))
function SSL_set1_sigalgs(s: PSSL; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_SIGALGS, slistlen, slist);
end;

//# define SSL_set1_sigalgs_list(s, str)                     SSL_ctrl(s,SSL_CTRL_SET_SIGALGS_LIST,0,(char *)(str))
function SSL_set1_sigalgs_list(s: PSSL; str: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_SIGALGS_LIST, 0, str);
end;

//# define SSL_CTX_set1_client_sigalgs(ctx, slist, slistlen) SSL_CTX_ctrl(ctx,SSL_CTRL_SET_CLIENT_SIGALGS,slistlen,(TIdC_INT *)(slist))
function SSL_CTX_set1_client_sigalgs(ctx: PSSL_CTX; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_CLIENT_SIGALGS, slistlen, slist);
end;

//# define SSL_CTX_set1_client_sigalgs_list(ctx, s)          SSL_CTX_ctrl(ctx,SSL_CTRL_SET_CLIENT_SIGALGS_LIST,0,(char *)(s))
function SSL_CTX_set1_client_sigalgs_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_CLIENT_SIGALGS_LIST, 0, s);
end;

//# define SSL_set1_client_sigalgs(s, slist, slistlen)       SSL_ctrl(s,SSL_CTRL_SET_CLIENT_SIGALGS,slistlen,(TIdC_INT *)(slist))
function SSL_set1_client_sigalgs(s: PSSL; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_CLIENT_SIGALGS, slistlen, slist);
end;

//# define SSL_set1_client_sigalgs_list(s, str)              SSL_ctrl(s,SSL_CTRL_SET_CLIENT_SIGALGS_LIST,0,(char *)(str))
function SSL_set1_client_sigalgs_list(s: PSSL; str: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_CLIENT_SIGALGS_LIST, 0, str);
end;

//# define SSL_get0_certificate_types(s, clist)              SSL_ctrl(s, SSL_CTRL_GET_CLIENT_CERT_TYPES, 0, (char *)(clist))
function SSL_get0_certificate_types(s: PSSL; clist: PByte): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_CLIENT_CERT_TYPES, 0, clist);
end;

//# define SSL_CTX_set1_client_certificate_types(ctx, clist, clistlen)   SSL_CTX_ctrl(ctx,SSL_CTRL_SET_CLIENT_CERT_TYPES,clistlen, (char *)(clist))
function SSL_CTX_set1_client_certificate_types(ctx: PSSL_CTX; clist: PByte; clistlen: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_CLIENT_CERT_TYPES, clistlen, clist);
end;

//# define SSL_set1_client_certificate_types(s, clist, clistlen)         SSL_ctrl(s,SSL_CTRL_SET_CLIENT_CERT_TYPES,clistlen,(char *)(clist))
function SSL_set1_client_certificate_types(s: PSSL; clist: PByte; clistlen: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_CLIENT_CERT_TYPES, clistlen, clist);
end;

//# define SSL_get_signature_nid(s, pn)                      SSL_ctrl(s,SSL_CTRL_GET_SIGNATURE_NID,0,pn)
function SSL_get_signature_nid(s: PSSL; pn: Pointer): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_SIGNATURE_NID, 0, pn);
end;

//# define SSL_get_peer_signature_nid(s, pn)                 SSL_ctrl(s,SSL_CTRL_GET_PEER_SIGNATURE_NID,0,pn)
function SSL_get_peer_signature_nid(s: PSSL; pn: Pointer): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_PEER_SIGNATURE_NID, 0, pn);
end;

//# define SSL_get_peer_tmp_key(s, pk)                       SSL_ctrl(s,SSL_CTRL_GET_PEER_TMP_KEY,0,pk)
function SSL_get_peer_tmp_key(s: PSSL; pk: Pointer): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_PEER_TMP_KEY, 0, pk);
end;

//# define SSL_get_tmp_key(s, pk)                            SSL_ctrl(s,SSL_CTRL_GET_TMP_KEY,0,pk)
function SSL_get_tmp_key(s: PSSL; pk: Pointer): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_TMP_KEY, 0, pk);
end;

//# define SSL_get0_raw_cipherlist(s, plst)                  SSL_ctrl(s,SSL_CTRL_GET_RAW_CIPHERLIST,0,plst)
function SSL_get0_raw_cipherlist(s: PSSL; plst: Pointer): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_RAW_CIPHERLIST, 0, plst);
end;

//# define SSL_get0_ec_point_formats(s, plst)                SSL_ctrl(s,SSL_CTRL_GET_EC_POINT_FORMATS,0,plst)
function SSL_get0_ec_point_formats(s: PSSL; plst: Pointer): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_EC_POINT_FORMATS, 0, plst);
end;

//# define SSL_CTX_set_min_proto_version(ctx, version)       SSL_CTX_ctrl(ctx, SSL_CTRL_SET_MIN_PROTO_VERSION, version, NULL)
function SSL_CTX_set_min_proto_version(ctx: PSSL_CTX; version: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_MIN_PROTO_VERSION, version, nil);
end;

//# define SSL_CTX_set_max_proto_version(ctx, version)       SSL_CTX_ctrl(ctx, SSL_CTRL_SET_MAX_PROTO_VERSION, version, NULL)
function SSL_CTX_set_max_proto_version(ctx: PSSL_CTX; version: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_MAX_PROTO_VERSION, version, nil);
end;

//# define SSL_CTX_get_min_proto_version(ctx)                SSL_CTX_ctrl(ctx, SSL_CTRL_GET_MIN_PROTO_VERSION, 0, NULL)
function SSL_CTX_get_min_proto_version(ctx: PSSL_CTX): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_GET_MIN_PROTO_VERSION, 0, nil);
end;

//# define SSL_CTX_get_max_proto_version(ctx)                SSL_CTX_ctrl(ctx, SSL_CTRL_GET_MAX_PROTO_VERSION, 0, NULL)
function SSL_CTX_get_max_proto_version(ctx: PSSL_CTX): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_GET_MAX_PROTO_VERSION, 0, nil);
end;

//# define SSL_set_min_proto_version(s, version)             SSL_ctrl(s, SSL_CTRL_SET_MIN_PROTO_VERSION, version, NULL)
function SSL_set_min_proto_version(s: PSSL; version: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_MIN_PROTO_VERSION, version, nil);
end;

//# define SSL_set_max_proto_version(s, version)             SSL_ctrl(s, SSL_CTRL_SET_MAX_PROTO_VERSION, version, NULL)
function SSL_set_max_proto_version(s: PSSL; version: TIdC_LONG): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_MAX_PROTO_VERSION, version, nil);
end;

//# define SSL_get_min_proto_version(s)                      SSL_ctrl(s, SSL_CTRL_GET_MIN_PROTO_VERSION, 0, NULL)
function SSL_get_min_proto_version(s: PSSL): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_MIN_PROTO_VERSION, 0, nil);
end;

//# define SSL_get_max_proto_version(s)                      SSL_ctrl(s, SSL_CTRL_GET_MAX_PROTO_VERSION, 0, NULL)
function SSL_get_max_proto_version(s: PSSL): TIdC_LONG;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_MAX_PROTO_VERSION, 0, nil);
end;

end.
