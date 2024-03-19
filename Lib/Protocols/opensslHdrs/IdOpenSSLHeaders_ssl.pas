  (* This unit was generated using the script genOpenSSLHdrs.sh from the source file IdOpenSSLHeaders_ssl.h2pas
     It should not be modified directly. All changes should be made to IdOpenSSLHeaders_ssl.h2pas
     and this file regenerated. IdOpenSSLHeaders_ssl.h2pas is distributed with the full Indy
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

unit IdOpenSSLHeaders_ssl;

interface

// Headers for OpenSSL 1.1.1
// ssl.h


uses
  IdCTypes,
  IdGlobal,
  IdSSLOpenSSLConsts,
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

  {Error codes for the SSL functions.}
  SSL_F_SSL_CTX_USE_CERTIFICATE_CHAIN_FILE = 220;

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

  TSSL_CTX_set_verify_callback = function (ok : TIdC_INT; ctx : PX509_STORE_CTX) : TIdC_INT; cdecl;

    { The EXTERNALSYM directive is ignored by FPC, however, it is used by Delphi as follows:
		
  	  The EXTERNALSYM directive prevents the specified Delphi symbol from appearing in header 
	  files generated for C++. }
	  
  {$EXTERNALSYM SSL_CTX_get_options} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_options} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_clear_options} {introduced 1.1.0}
  {$EXTERNALSYM SSL_clear_options} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_options} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_options} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_sess_set_new_cb}
  {$EXTERNALSYM SSL_CTX_sess_get_new_cb}
  {$EXTERNALSYM SSL_CTX_sess_set_remove_cb}
  {$EXTERNALSYM SSL_CTX_sess_get_remove_cb}
  {$EXTERNALSYM SSL_CTX_set_info_callback}
  {$EXTERNALSYM SSL_CTX_get_info_callback}
  {$EXTERNALSYM SSL_CTX_set_client_cert_cb}
  {$EXTERNALSYM SSL_CTX_get_client_cert_cb}
  {$EXTERNALSYM SSL_CTX_set_client_cert_engine}
  {$EXTERNALSYM SSL_CTX_set_cookie_generate_cb}
  {$EXTERNALSYM SSL_CTX_set_cookie_verify_cb}
  {$EXTERNALSYM SSL_CTX_set_stateless_cookie_generate_cb} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_stateless_cookie_verify_cb} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_alpn_select_cb}
  {$EXTERNALSYM SSL_get0_alpn_selected}
  {$EXTERNALSYM SSL_CTX_set_psk_client_callback}
  {$EXTERNALSYM SSL_set_psk_client_callback}
  {$EXTERNALSYM SSL_CTX_set_psk_server_callback}
  {$EXTERNALSYM SSL_set_psk_server_callback}
  {$EXTERNALSYM SSL_set_psk_find_session_callback} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_psk_find_session_callback} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_psk_use_session_callback} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_psk_use_session_callback} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_keylog_callback} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_get_keylog_callback} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_max_early_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_get_max_early_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_max_early_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_max_early_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_recv_max_early_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_get_recv_max_early_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_recv_max_early_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_recv_max_early_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_in_init} {introduced 1.1.0}
  {$EXTERNALSYM SSL_in_before} {introduced 1.1.0}
  {$EXTERNALSYM SSL_is_init_finished} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_finished}
  {$EXTERNALSYM SSL_get_peer_finished}
  {$EXTERNALSYM BIO_f_ssl}
  {$EXTERNALSYM BIO_new_ssl}
  {$EXTERNALSYM BIO_new_ssl_connect}
  {$EXTERNALSYM BIO_new_buffer_ssl_connect}
  {$EXTERNALSYM BIO_ssl_copy_session_id}
  {$EXTERNALSYM SSL_CTX_set_cipher_list}
  {$EXTERNALSYM SSL_CTX_new}
  {$EXTERNALSYM SSL_CTX_set_timeout}
  {$EXTERNALSYM SSL_CTX_get_timeout}
  {$EXTERNALSYM SSL_CTX_get_cert_store}
  {$EXTERNALSYM SSL_want}
  {$EXTERNALSYM SSL_clear}
  {$EXTERNALSYM BIO_ssl_shutdown}
  {$EXTERNALSYM SSL_CTX_up_ref} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_free}
  {$EXTERNALSYM SSL_CTX_set_cert_store}
  {$EXTERNALSYM SSL_CTX_set1_cert_store} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_flush_sessions}
  {$EXTERNALSYM SSL_get_current_cipher}
  {$EXTERNALSYM SSL_get_pending_cipher} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CIPHER_get_bits}
  {$EXTERNALSYM SSL_CIPHER_get_version}
  {$EXTERNALSYM SSL_CIPHER_get_name}
  {$EXTERNALSYM SSL_CIPHER_standard_name} {introduced 1.1.0}
  {$EXTERNALSYM OPENSSL_cipher_name} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CIPHER_get_id}
  {$EXTERNALSYM SSL_CIPHER_get_protocol_id} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CIPHER_get_kx_nid} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CIPHER_get_auth_nid} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CIPHER_get_handshake_digest} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CIPHER_is_aead} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_fd}
  {$EXTERNALSYM SSL_get_rfd}
  {$EXTERNALSYM SSL_get_wfd}
  {$EXTERNALSYM SSL_get_cipher_list}
  {$EXTERNALSYM SSL_get_shared_ciphers}
  {$EXTERNALSYM SSL_get_read_ahead}
  {$EXTERNALSYM SSL_pending}
  {$EXTERNALSYM SSL_has_pending} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_fd}
  {$EXTERNALSYM SSL_set_rfd}
  {$EXTERNALSYM SSL_set_wfd}
  {$EXTERNALSYM SSL_set0_rbio} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set0_wbio} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_bio}
  {$EXTERNALSYM SSL_get_rbio}
  {$EXTERNALSYM SSL_get_wbio}
  {$EXTERNALSYM SSL_set_cipher_list}
  {$EXTERNALSYM SSL_CTX_set_ciphersuites} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_ciphersuites} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_verify_mode}
  {$EXTERNALSYM SSL_get_verify_depth}
  {$EXTERNALSYM SSL_get_verify_callback}
  {$EXTERNALSYM SSL_set_read_ahead}
  {$EXTERNALSYM SSL_set_verify}
  {$EXTERNALSYM SSL_set_verify_depth}
  {$EXTERNALSYM SSL_use_RSAPrivateKey}
  {$EXTERNALSYM SSL_use_RSAPrivateKey_ASN1}
  {$EXTERNALSYM SSL_use_PrivateKey}
  {$EXTERNALSYM SSL_use_PrivateKey_ASN1}
  {$EXTERNALSYM SSL_use_certificate}
  {$EXTERNALSYM SSL_use_certificate_ASN1}
  {$EXTERNALSYM SSL_CTX_use_serverinfo}
  {$EXTERNALSYM SSL_CTX_use_serverinfo_ex} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_use_serverinfo_file}
  {$EXTERNALSYM SSL_use_RSAPrivateKey_file}
  {$EXTERNALSYM SSL_use_PrivateKey_file}
  {$EXTERNALSYM SSL_use_certificate_file}
  {$EXTERNALSYM SSL_CTX_use_RSAPrivateKey_file}
  {$EXTERNALSYM SSL_CTX_use_PrivateKey_file}
  {$EXTERNALSYM SSL_CTX_use_certificate_file}
  {$EXTERNALSYM SSL_CTX_use_certificate_chain_file}
  {$EXTERNALSYM SSL_use_certificate_chain_file} {introduced 1.1.0}
  {$EXTERNALSYM SSL_load_client_CA_file}
  {$EXTERNALSYM SSL_add_file_cert_subjects_to_stack}
  {$EXTERNALSYM SSL_add_dir_cert_subjects_to_stack}
  {$EXTERNALSYM SSL_state_string}
  {$EXTERNALSYM SSL_rstate_string}
  {$EXTERNALSYM SSL_state_string_long}
  {$EXTERNALSYM SSL_rstate_string_long}
  {$EXTERNALSYM SSL_SESSION_get_time}
  {$EXTERNALSYM SSL_SESSION_set_time}
  {$EXTERNALSYM SSL_SESSION_get_timeout}
  {$EXTERNALSYM SSL_SESSION_set_timeout}
  {$EXTERNALSYM SSL_SESSION_get_protocol_version} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_set_protocol_version} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_get0_hostname} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_set1_hostname} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_get0_alpn_selected} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_set1_alpn_selected} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_get0_cipher} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_set_cipher} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_has_ticket} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_get_ticket_lifetime_hint} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_get0_ticket} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_get_max_early_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_set_max_early_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_copy_session_id}
  {$EXTERNALSYM SSL_SESSION_get0_peer}
  {$EXTERNALSYM SSL_SESSION_set1_id_context}
  {$EXTERNALSYM SSL_SESSION_set1_id} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_is_resumable} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_new}
  {$EXTERNALSYM SSL_SESSION_dup} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_get_id}
  {$EXTERNALSYM SSL_SESSION_get0_id_context} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_get_compress_id}
  {$EXTERNALSYM SSL_SESSION_print}
  {$EXTERNALSYM SSL_SESSION_print_keylog} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_up_ref} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_free}
  {$EXTERNALSYM SSL_set_session}
  {$EXTERNALSYM SSL_CTX_add_session}
  {$EXTERNALSYM SSL_CTX_remove_session}
  {$EXTERNALSYM SSL_CTX_set_generate_session_id}
  {$EXTERNALSYM SSL_set_generate_session_id}
  {$EXTERNALSYM SSL_has_matching_session_id}
  {$EXTERNALSYM d2i_SSL_SESSION}
  {$EXTERNALSYM SSL_CTX_get_verify_mode}
  {$EXTERNALSYM SSL_CTX_get_verify_depth}
  {$EXTERNALSYM SSL_CTX_get_verify_callback}
  {$EXTERNALSYM SSL_CTX_set_verify}
  {$EXTERNALSYM SSL_CTX_set_verify_depth}
  {$EXTERNALSYM SSL_CTX_set_cert_verify_callback}
  {$EXTERNALSYM SSL_CTX_set_cert_cb}
  {$EXTERNALSYM SSL_CTX_use_RSAPrivateKey}
  {$EXTERNALSYM SSL_CTX_use_RSAPrivateKey_ASN1}
  {$EXTERNALSYM SSL_CTX_use_PrivateKey}
  {$EXTERNALSYM SSL_CTX_use_PrivateKey_ASN1}
  {$EXTERNALSYM SSL_CTX_use_certificate}
  {$EXTERNALSYM SSL_CTX_use_certificate_ASN1}
  {$EXTERNALSYM SSL_CTX_set_default_passwd_cb} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_default_passwd_cb_userdata} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_get_default_passwd_cb}  {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_get_default_passwd_cb_userdata} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_default_passwd_cb} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_default_passwd_cb_userdata} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_default_passwd_cb} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_default_passwd_cb_userdata} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_check_private_key}
  {$EXTERNALSYM SSL_check_private_key}
  {$EXTERNALSYM SSL_CTX_set_session_id_context}
  {$EXTERNALSYM SSL_new}
  {$EXTERNALSYM SSL_up_ref} {introduced 1.1.0}
  {$EXTERNALSYM SSL_is_dtls} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_session_id_context}
  {$EXTERNALSYM SSL_CTX_set_purpose}
  {$EXTERNALSYM SSL_set_purpose}
  {$EXTERNALSYM SSL_CTX_set_trust}
  {$EXTERNALSYM SSL_set_trust}
  {$EXTERNALSYM SSL_set1_host} {introduced 1.1.0}
  {$EXTERNALSYM SSL_add1_host} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get0_peername} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_hostflags} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_dane_enable} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_dane_mtype_set} {introduced 1.1.0}
  {$EXTERNALSYM SSL_dane_enable} {introduced 1.1.0}
  {$EXTERNALSYM SSL_dane_tlsa_add} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get0_dane_authority} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get0_dane_tlsa} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get0_dane} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_dane_set_flags} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_dane_clear_flags} {introduced 1.1.0}
  {$EXTERNALSYM SSL_dane_set_flags} {introduced 1.1.0}
  {$EXTERNALSYM SSL_dane_clear_flags} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set1_param}
  {$EXTERNALSYM SSL_set1_param}
  {$EXTERNALSYM SSL_CTX_get0_param}
  {$EXTERNALSYM SSL_get0_param}
  {$EXTERNALSYM SSL_CTX_set_srp_username}
  {$EXTERNALSYM SSL_CTX_set_srp_password}
  {$EXTERNALSYM SSL_CTX_set_srp_strength}
  {$EXTERNALSYM SSL_CTX_set_srp_client_pwd_callback}
  {$EXTERNALSYM SSL_CTX_set_srp_verify_param_callback}
  {$EXTERNALSYM SSL_CTX_set_srp_username_callback}
  {$EXTERNALSYM SSL_CTX_set_srp_cb_arg}
  {$EXTERNALSYM SSL_set_srp_server_param}
  {$EXTERNALSYM SSL_set_srp_server_param_pw}
  {$EXTERNALSYM SSL_CTX_set_client_hello_cb} {introduced 1.1.0}
  {$EXTERNALSYM SSL_client_hello_isv2} {introduced 1.1.0}
  {$EXTERNALSYM SSL_client_hello_get0_legacy_version} {introduced 1.1.0}
  {$EXTERNALSYM SSL_client_hello_get0_random} {introduced 1.1.0}
  {$EXTERNALSYM SSL_client_hello_get0_session_id} {introduced 1.1.0}
  {$EXTERNALSYM SSL_client_hello_get0_ciphers} {introduced 1.1.0}
  {$EXTERNALSYM SSL_client_hello_get0_compression_methods} {introduced 1.1.0}
  {$EXTERNALSYM SSL_client_hello_get1_extensions_present} {introduced 1.1.0}
  {$EXTERNALSYM SSL_client_hello_get0_ext} {introduced 1.1.0}
  {$EXTERNALSYM SSL_certs_clear}
  {$EXTERNALSYM SSL_free}
  {$EXTERNALSYM SSL_waiting_for_async} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_all_async_fds} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_changed_async_fds} {introduced 1.1.0}
  {$EXTERNALSYM SSL_accept}
  {$EXTERNALSYM SSL_stateless} {introduced 1.1.0}
  {$EXTERNALSYM SSL_connect}
  {$EXTERNALSYM SSL_read}
  {$EXTERNALSYM SSL_read_ex} {introduced 1.1.0}
  {$EXTERNALSYM SSL_read_early_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_peek}
  {$EXTERNALSYM SSL_peek_ex} {introduced 1.1.0}
  {$EXTERNALSYM SSL_write}
  {$EXTERNALSYM SSL_write_ex} {introduced 1.1.0}
  {$EXTERNALSYM SSL_write_early_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_callback_ctrl}
  {$EXTERNALSYM SSL_ctrl}
  {$EXTERNALSYM SSL_CTX_ctrl}
  {$EXTERNALSYM SSL_CTX_callback_ctrl}
  {$EXTERNALSYM SSL_get_early_data_status} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_error}
  {$EXTERNALSYM SSL_get_version}
  {$EXTERNALSYM SSL_CTX_set_ssl_version}
  {$EXTERNALSYM TLS_method} {introduced 1.1.0}
  {$EXTERNALSYM TLS_server_method} {introduced 1.1.0}
  {$EXTERNALSYM TLS_client_method} {introduced 1.1.0}
  {$EXTERNALSYM SSL_key_update} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_key_update_type} {introduced 1.1.0}
  {$EXTERNALSYM SSL_renegotiate}
  {$EXTERNALSYM SSL_renegotiate_abbreviated}
  {$EXTERNALSYM SSL_shutdown}
  {$EXTERNALSYM SSL_CTX_set_post_handshake_auth} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_post_handshake_auth} {introduced 1.1.0}
  {$EXTERNALSYM SSL_renegotiate_pending}
  {$EXTERNALSYM SSL_verify_client_post_handshake} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_get_ssl_method}
  {$EXTERNALSYM SSL_get_ssl_method}
  {$EXTERNALSYM SSL_set_ssl_method}
  {$EXTERNALSYM SSL_alert_type_string_long}
  {$EXTERNALSYM SSL_alert_type_string}
  {$EXTERNALSYM SSL_alert_desc_string_long}
  {$EXTERNALSYM SSL_alert_desc_string}
  {$EXTERNALSYM SSL_CTX_set_client_CA_list}
  {$EXTERNALSYM SSL_add_client_CA}
  {$EXTERNALSYM SSL_CTX_add_client_CA}
  {$EXTERNALSYM SSL_set_connect_state}
  {$EXTERNALSYM SSL_set_accept_state}
  {$EXTERNALSYM SSL_CIPHER_description}
  {$EXTERNALSYM SSL_dup}
  {$EXTERNALSYM SSL_get_certificate}
  {$EXTERNALSYM SSL_get_privatekey}
  {$EXTERNALSYM SSL_CTX_get0_certificate}
  {$EXTERNALSYM SSL_CTX_get0_privatekey}
  {$EXTERNALSYM SSL_CTX_set_quiet_shutdown}
  {$EXTERNALSYM SSL_CTX_get_quiet_shutdown}
  {$EXTERNALSYM SSL_set_quiet_shutdown}
  {$EXTERNALSYM SSL_get_quiet_shutdown}
  {$EXTERNALSYM SSL_set_shutdown}
  {$EXTERNALSYM SSL_get_shutdown}
  {$EXTERNALSYM SSL_version}
  {$EXTERNALSYM SSL_client_version} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_default_verify_paths}
  {$EXTERNALSYM SSL_CTX_set_default_verify_dir} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_default_verify_file} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_load_verify_locations}
  {$EXTERNALSYM SSL_get_session}
  {$EXTERNALSYM SSL_get1_session}
  {$EXTERNALSYM SSL_get_SSL_CTX}
  {$EXTERNALSYM SSL_set_SSL_CTX}
  {$EXTERNALSYM SSL_set_info_callback}
  {$EXTERNALSYM SSL_get_info_callback}
  {$EXTERNALSYM SSL_get_state} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_verify_result}
  {$EXTERNALSYM SSL_get_verify_result}
  {$EXTERNALSYM SSL_get_client_random} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_server_random} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_get_master_key} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_set1_master_key} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_get_max_fragment_length} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_ex_data}
  {$EXTERNALSYM SSL_get_ex_data}
  {$EXTERNALSYM SSL_SESSION_set_ex_data}
  {$EXTERNALSYM SSL_SESSION_get_ex_data}
  {$EXTERNALSYM SSL_CTX_set_ex_data}
  {$EXTERNALSYM SSL_CTX_get_ex_data}
  {$EXTERNALSYM SSL_get_ex_data_X509_STORE_CTX_idx}
  {$EXTERNALSYM SSL_CTX_set_default_read_buffer_len} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_default_read_buffer_len} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_tmp_dh_callback}
  {$EXTERNALSYM SSL_set_tmp_dh_callback}
  {$EXTERNALSYM SSL_CIPHER_find}
  {$EXTERNALSYM SSL_CIPHER_get_cipher_nid} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CIPHER_get_digest_nid} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_session_ticket_ext}
  {$EXTERNALSYM SSL_set_session_ticket_ext_cb}
  {$EXTERNALSYM SSL_CTX_set_not_resumable_session_callback} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_not_resumable_session_callback} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_record_padding_callback} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_record_padding_callback_arg} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_get_record_padding_callback_arg} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_block_padding} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_record_padding_callback} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_record_padding_callback_arg} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_record_padding_callback_arg} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_block_padding} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_num_tickets} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_num_tickets} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_num_tickets} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_get_num_tickets} {introduced 1.1.0}
  {$EXTERNALSYM SSL_session_reused} {introduced 1.1.0}
  {$EXTERNALSYM SSL_is_server}
  {$EXTERNALSYM SSL_CONF_CTX_new}
  {$EXTERNALSYM SSL_CONF_CTX_finish}
  {$EXTERNALSYM SSL_CONF_CTX_free}
  {$EXTERNALSYM SSL_CONF_CTX_set_flags}
  {$EXTERNALSYM SSL_CONF_CTX_clear_flags}
  {$EXTERNALSYM SSL_CONF_CTX_set1_prefix}
  {$EXTERNALSYM SSL_CONF_cmd}
  {$EXTERNALSYM SSL_CONF_cmd_argv}
  {$EXTERNALSYM SSL_CONF_cmd_value_type}
  {$EXTERNALSYM SSL_CONF_CTX_set_ssl}
  {$EXTERNALSYM SSL_CONF_CTX_set_ssl_ctx}
  {$EXTERNALSYM SSL_add_ssl_module} {introduced 1.1.0}
  {$EXTERNALSYM SSL_config} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_config} {introduced 1.1.0}
  {$EXTERNALSYM DTLSv1_listen} {introduced 1.1.0}
  {$EXTERNALSYM SSL_enable_ct} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_enable_ct} {introduced 1.1.0}
  {$EXTERNALSYM SSL_ct_is_enabled} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_ct_is_enabled} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_default_ctlog_list_file} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_ctlog_list_file} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set0_ctlog_store} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_security_level} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_security_callback} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get_security_callback} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set0_security_ex_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get0_security_ex_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_security_level} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_get_security_level} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_get0_security_ex_data} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set0_security_ex_data} {introduced 1.1.0}
  {$EXTERNALSYM OPENSSL_init_ssl} {introduced 1.1.0}
  {$EXTERNALSYM SSL_free_buffers} {introduced 1.1.0}
  {$EXTERNALSYM SSL_alloc_buffers} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_session_ticket_cb} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_set1_ticket_appdata} {introduced 1.1.0}
  {$EXTERNALSYM SSL_SESSION_get0_ticket_appdata} {introduced 1.1.0}
  {$EXTERNALSYM DTLS_set_timer_cb} {introduced 1.1.0}
  {$EXTERNALSYM SSL_CTX_set_allow_early_data_cb} {introduced 1.1.0}
  {$EXTERNALSYM SSL_set_allow_early_data_cb} {introduced 1.1.0}
  {$EXTERNALSYM SSL_get0_peer_certificate} {introduced 3.3.0}
  {$EXTERNALSYM SSL_get1_peer_certificate} {introduced 3.3.0}
{helper_functions}
  function IsOpenSSL_SSLv2_Available : Boolean;
  function IsOpenSSL_SSLv3_Available : Boolean;
  function IsOpenSSL_SSLv23_Available : Boolean;
  function IsOpenSSL_TLSv1_0_Available : Boolean;
  function IsOpenSSL_TLSv1_1_Available : Boolean;
  function IsOpenSSL_TLSv1_2_Available : Boolean;
  function HasTLS_method: boolean;
  function SSL_CTX_set_min_proto_version(ctx: PSSL_CTX; version: TIdC_LONG): TIdC_LONG;
  function SSL_CTX_set_max_proto_version(ctx: PSSL_CTX; version: TIdC_LONG): TIdC_LONG;
  function SSL_CTX_get_min_proto_version(ctx: PSSL_CTX): TIdC_LONG;
  function SSL_CTX_get_max_proto_version(ctx: PSSL_CTX): TIdC_LONG;
  function SSL_set_min_proto_version(s: PSSL; version: TIdC_LONG): TIdC_LONG;
  function SSL_set_max_proto_version(s: PSSL; version: TIdC_LONG): TIdC_LONG;
  function SSL_get_min_proto_version(s: PSSL): TIdC_LONG;
  function SSL_get_max_proto_version(s: PSSL): TIdC_LONG;
{/helper_functions}

{$IFNDEF USE_EXTERNAL_LIBRARY}
var
  {$EXTERNALSYM SSL_CTX_set_mode} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_clear_mode} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_sess_set_cache_size} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_sess_get_cache_size} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set_session_cache_mode} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_get_session_cache_mode} {removed 1.0.0}
  {$EXTERNALSYM SSL_clear_num_renegotiations} {removed 1.0.0}
  {$EXTERNALSYM SSL_total_renegotiations} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set_tmp_dh} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set_tmp_ecdh} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set_dh_auto} {removed 1.0.0}
  {$EXTERNALSYM SSL_set_dh_auto} {removed 1.0.0}
  {$EXTERNALSYM SSL_set_tmp_dh} {removed 1.0.0}
  {$EXTERNALSYM SSL_set_tmp_ecdh} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_add_extra_chain_cert} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_get_extra_chain_certs} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_get_extra_chain_certs_only} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_clear_extra_chain_certs} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set0_chain} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set1_chain} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_add0_chain_cert} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_add1_chain_cert} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_get0_chain_certs} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_clear_chain_certs} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_build_cert_chain} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_select_current_cert} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set_current_cert} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set0_verify_cert_store} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set1_verify_cert_store} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set0_chain_cert_store} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set1_chain_cert_store} {removed 1.0.0}
  {$EXTERNALSYM SSL_set0_chain} {removed 1.0.0}
  {$EXTERNALSYM SSL_set1_chain} {removed 1.0.0}
  {$EXTERNALSYM SSL_add0_chain_cert} {removed 1.0.0}
  {$EXTERNALSYM SSL_add1_chain_cert} {removed 1.0.0}
  {$EXTERNALSYM SSL_get0_chain_certs} {removed 1.0.0}
  {$EXTERNALSYM SSL_clear_chain_certs} {removed 1.0.0}
  {$EXTERNALSYM SSL_build_cert_chain} {removed 1.0.0}
  {$EXTERNALSYM SSL_select_current_cert} {removed 1.0.0}
  {$EXTERNALSYM SSL_set_current_cert} {removed 1.0.0}
  {$EXTERNALSYM SSL_set0_verify_cert_store} {removed 1.0.0}
  {$EXTERNALSYM SSL_set1_verify_cert_store} {removed 1.0.0}
  {$EXTERNALSYM SSL_set0_chain_cert_store} {removed 1.0.0}
  {$EXTERNALSYM SSL_set1_chain_cert_store} {removed 1.0.0}
  {$EXTERNALSYM SSL_get1_groups} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set1_groups} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set1_groups_list} {removed 1.0.0}
  {$EXTERNALSYM SSL_set1_groups} {removed 1.0.0}
  {$EXTERNALSYM SSL_set1_groups_list} {removed 1.0.0}
  {$EXTERNALSYM SSL_get_shared_group} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set1_sigalgs} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set1_sigalgs_list} {removed 1.0.0}
  {$EXTERNALSYM SSL_set1_sigalgs} {removed 1.0.0}
  {$EXTERNALSYM SSL_set1_sigalgs_list} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set1_client_sigalgs} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set1_client_sigalgs_list} {removed 1.0.0}
  {$EXTERNALSYM SSL_set1_client_sigalgs} {removed 1.0.0}
  {$EXTERNALSYM SSL_set1_client_sigalgs_list} {removed 1.0.0}
  {$EXTERNALSYM SSL_get0_certificate_types} {removed 1.0.0}
  {$EXTERNALSYM SSL_CTX_set1_client_certificate_types} {removed 1.0.0}
  {$EXTERNALSYM SSL_set1_client_certificate_types} {removed 1.0.0}
  {$EXTERNALSYM SSL_get_signature_nid} {removed 1.0.0}
  {$EXTERNALSYM SSL_get_peer_signature_nid} {removed 1.0.0}
  {$EXTERNALSYM SSL_get_peer_tmp_key} {removed 1.0.0}
  {$EXTERNALSYM SSL_get_tmp_key} {removed 1.0.0}
  {$EXTERNALSYM SSL_get0_raw_cipherlist} {removed 1.0.0}
  {$EXTERNALSYM SSL_get0_ec_point_formats} {removed 1.0.0}
  {$EXTERNALSYM SSL_get_app_data} {removed 1.0.0} 
  {$EXTERNALSYM SSL_set_app_data} {removed 1.0.0}
  {$EXTERNALSYM SSLeay_add_ssl_algorithms} {removed 1.0.0}
  {$EXTERNALSYM SSL_load_error_strings} {removed 1.1.0}
  {$EXTERNALSYM SSL_get_peer_certificate} {removed 3.0.0}
  {$EXTERNALSYM SSL_library_init} {removed 1.1.0}
  {$EXTERNALSYM SSLv2_method} {removed 1.1.0 allow_nil} // SSLv2
  {$EXTERNALSYM SSLv2_server_method} {removed 1.1.0 allow_nil} // SSLv2
  {$EXTERNALSYM SSLv2_client_method} {removed 1.1.0 allow_nil} // SSLv2
  {$EXTERNALSYM SSLv3_method} {removed 1.1.0 allow_nil} // SSLv3
  {$EXTERNALSYM SSLv3_server_method} {removed 1.1.0 allow_nil} // SSLv3
  {$EXTERNALSYM SSLv3_client_method} {removed 1.1.0 allow_nil} // SSLv3
  {$EXTERNALSYM SSLv23_method} {removed 1.1.0 allow_nil} // SSLv3 but can rollback to v2
  {$EXTERNALSYM SSLv23_server_method} {removed 1.1.0 allow_nil} // SSLv3 but can rollback to v2
  {$EXTERNALSYM SSLv23_client_method} {removed 1.1.0 allow_nil} // SSLv3 but can rollback to v2
  {$EXTERNALSYM TLSv1_method} {removed 1.1.0 allow_nil} // TLSv1.0
  {$EXTERNALSYM TLSv1_server_method} {removed 1.1.0 allow_nil} // TLSv1.0
  {$EXTERNALSYM TLSv1_client_method} {removed 1.1.0 allow_nil} // TLSv1.0
  {$EXTERNALSYM TLSv1_1_method} {removed 1.1.0 allow_nil} //TLS1.1
  {$EXTERNALSYM TLSv1_1_server_method} {removed 1.1.0 allow_nil} //TLS1.1
  {$EXTERNALSYM TLSv1_1_client_method} {removed 1.1.0 allow_nil} //TLS1.1
  {$EXTERNALSYM TLSv1_2_method} {removed 1.1.0 allow_nil}		// TLSv1.2
  {$EXTERNALSYM TLSv1_2_server_method} {removed 1.1.0 allow_nil}	// TLSv1.2 
  {$EXTERNALSYM TLSv1_2_client_method} {removed 1.1.0 allow_nil}	// TLSv1.2
  SSL_CTX_set_mode: function(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_clear_mode: function(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}

  SSL_CTX_sess_set_cache_size: function(ctx: PSSL_CTX; t: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_sess_get_cache_size: function(ctx: PSSL_CTX): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set_session_cache_mode: function(ctx: PSSL_CTX; m: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_get_session_cache_mode: function(ctx: PSSL_CTX): TIdC_LONG; cdecl = nil; {removed 1.0.0}

  SSL_clear_num_renegotiations: function(ssl: PSSL): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_total_renegotiations: function(ssl: PSSL): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set_tmp_dh: function(ctx: PSSL_CTX; dh: PDH): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set_tmp_ecdh: function(ctx: PSSL_CTX; ecdh: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set_dh_auto: function(ctx: PSSL_CTX; onoff: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set_dh_auto: function(s: PSSL; onoff: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set_tmp_dh: function(ssl: PSSL; dh: PDH): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set_tmp_ecdh: function(ssl: PSSL; ecdh: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_add_extra_chain_cert: function(ctx: PSSL_CTX; x509: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_get_extra_chain_certs: function(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_get_extra_chain_certs_only: function(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_clear_extra_chain_certs: function(ctx: PSSL_CTX): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set0_chain: function(ctx: PSSL_CTX; sk: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set1_chain: function(ctx: PSSL_CTX; sk: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_add0_chain_cert: function(ctx: PSSL_CTX; x509: PX509): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_add1_chain_cert: function(ctx: PSSL_CTX; x509: PX509): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_get0_chain_certs: function(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_clear_chain_certs: function(ctx: PSSL_CTX): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_build_cert_chain: function(ctx: PSSL_CTX; flags: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_select_current_cert: function(ctx: PSSL_CTX; x509: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set_current_cert: function(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set0_verify_cert_store: function(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set1_verify_cert_store: function(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set0_chain_cert_store: function(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set1_chain_cert_store: function(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set0_chain: function(s: PSSL; sk: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set1_chain: function(s: PSSL; sk: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_add0_chain_cert: function(s: PSSL; x509: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_add1_chain_cert: function(s: PSSL; x509: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_get0_chain_certs: function(s: PSSL; px509: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_clear_chain_certs: function(s: PSSL): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_build_cert_chain: function(s: PSSL; flags: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_select_current_cert: function(s: PSSL; x509: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set_current_cert: function(s: PSSL; op: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set0_verify_cert_store: function(s: PSSL; st: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set1_verify_cert_store: function(s: PSSL; st: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set0_chain_cert_store: function(s: PSSL; st: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set1_chain_cert_store: function(s: PSSL; st: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_get1_groups: function(s: PSSL; glist: PIdC_INT): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set1_groups: function(ctx: PSSL_CTX; glist: PByte; glistlen: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set1_groups_list: function(ctx: PSSL_CTX; s: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set1_groups: function(s: PSSL; glist: PByte; glistlen: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set1_groups_list: function(s: PSSL; str: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_get_shared_group: function(s: PSSL; n: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set1_sigalgs: function(ctx: PSSL_CTX; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set1_sigalgs_list: function(ctx: PSSL_CTX; s: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set1_sigalgs: function(s: PSSL; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set1_sigalgs_list: function(s: PSSL; str: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set1_client_sigalgs: function(ctx: PSSL_CTX; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set1_client_sigalgs_list: function(ctx: PSSL_CTX; s: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set1_client_sigalgs: function(s: PSSL; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set1_client_sigalgs_list: function(s: PSSL; str: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_get0_certificate_types: function(s: PSSL; clist: PByte): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_CTX_set1_client_certificate_types: function(ctx: PSSL_CTX; clist: PByte; clistlen: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_set1_client_certificate_types: function(s: PSSL; clist: PByte; clistlen: TIdC_LONG): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_get_signature_nid: function(s: PSSL; pn: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_get_peer_signature_nid: function(s: PSSL; pn: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_get_peer_tmp_key: function(s: PSSL; pk: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_get_tmp_key: function(s: PSSL; pk: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_get0_raw_cipherlist: function(s: PSSL; plst: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}
  SSL_get0_ec_point_formats: function(s: PSSL; plst: Pointer): TIdC_LONG; cdecl = nil; {removed 1.0.0}

  //typedef TIdC_INT (*tls_session_secret_cb_fn)(s: PSSL, void *secret, TIdC_INT *secret_len,
  //                                        STACK_OF(SSL_CIPHER) *peer_ciphers,
  //                                        const SSL_CIPHER **cipher, void *arg);

  SSL_CTX_get_options: function(const ctx: PSSL_CTX): TIdC_ULONG; cdecl = nil; {introduced 1.1.0}
  SSL_get_options: function(const s: PSSL): TIdC_ULONG; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_clear_options: function(ctx: PSSL_CTX; op: TIdC_ULONG): TIdC_ULONG; cdecl = nil; {introduced 1.1.0}
  SSL_clear_options: function(s: PSSL; op: TIdC_ULONG): TIdC_ULONG; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_options: function(ctx: PSSL_CTX; op: TIdC_ULONG): TIdC_ULONG; cdecl = nil; {introduced 1.1.0}
  SSL_set_options: function(s: PSSL; op: TIdC_ULONG): TIdC_ULONG; cdecl = nil; {introduced 1.1.0}

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

  SSL_CTX_sess_set_new_cb: procedure(ctx: PSSL_CTX; new_session_cb: SSL_CTX_sess_new_cb); cdecl = nil;
  SSL_CTX_sess_get_new_cb: function(ctx: PSSL_CTX): SSL_CTX_sess_new_cb; cdecl = nil;
  SSL_CTX_sess_set_remove_cb: procedure(ctx: PSSL_CTX; remove_session_cb: SSL_CTX_sess_remove_cb); cdecl = nil;
  SSL_CTX_sess_get_remove_cb: function(ctx: PSSL_CTX): SSL_CTX_sess_remove_cb; cdecl = nil;

  //void SSL_CTX_sess_set_get_cb(ctx: PSSL_CTX,
  //                             SSL_SESSION *(*get_session_cb) (struct ssl_st
  //                                                             *ssl,
  //                                                             const Byte
  //                                                             *data, TIdC_INT len,
  //                                                             TIdC_INT *copy));
  //SSL_SESSION *(*SSL_CTX_sess_get_get_cb(ctx: PSSL_CTX)) (struct ssl_st *ssl,
  //                                                       const d: PByteata,
  //                                                       TIdC_INT len, TIdC_INT *copy);
  SSL_CTX_set_info_callback: procedure(ctx: PSSL_CTX; cb: SSL_CTX_info_callback); cdecl = nil;
  SSL_CTX_get_info_callback: function(ctx: PSSL_CTX): SSL_CTX_info_callback; cdecl = nil;
  SSL_CTX_set_client_cert_cb: procedure(ctx: PSSL_CTX; client_cert_cb: SSL_CTX_client_cert_cb); cdecl = nil;
  SSL_CTX_get_client_cert_cb: function(ctx: PSSL_CTX): SSL_CTX_client_cert_cb; cdecl = nil;
  SSL_CTX_set_client_cert_engine: function(ctx: PSSL_CTX; e: PENGINE): TIdC_INT; cdecl = nil;

  SSL_CTX_set_cookie_generate_cb: procedure(ctx: PSSL_CTX; app_gen_cookie_cb: SSL_CTX_cookie_verify_cb); cdecl = nil;
  SSL_CTX_set_cookie_verify_cb: procedure(ctx: PSSL_CTX; app_verify_cookie_cb: SSL_CTX_set_cookie_verify_cb_app_verify_cookie_cb); cdecl = nil;
  SSL_CTX_set_stateless_cookie_generate_cb: procedure(ctx: PSSL_CTX; gen_stateless_cookie_cb: SSL_CTX_set_stateless_cookie_generate_cb_gen_stateless_cookie_cb); cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_stateless_cookie_verify_cb: procedure(ctx: PSSL_CTX; verify_stateless_cookie_cb: SSL_CTX_set_stateless_cookie_verify_cb_verify_stateless_cookie_cb); cdecl = nil; {introduced 1.1.0}

  //__owur TIdC_INT SSL_CTX_set_alpn_protos(ctx: PSSL_CTX, const Byte *protos,
  //                                   TIdC_UINT protos_len);
  //__owur TIdC_INT SSL_set_alpn_protos(ssl: PSSL, const Byte *protos,
  //                               TIdC_UINT protos_len);

  SSL_CTX_set_alpn_select_cb: procedure(ctx: PSSL_CTX; cb: SSL_CTX_alpn_select_cb_func; arg: Pointer); cdecl = nil;
  SSL_get0_alpn_selected: procedure(const ssl: PSSL; const data: PPByte; len: PIdC_UINT); cdecl = nil;
  SSL_CTX_set_psk_client_callback: procedure(ctx: PSSL_CTX; cb: SSL_psk_client_cb_func); cdecl = nil;
  SSL_set_psk_client_callback: procedure(ssl: PSSL; cb: SSL_psk_client_cb_func); cdecl = nil;
  SSL_CTX_set_psk_server_callback: procedure(ctx: PSSL_CTX; cb: SSL_psk_server_cb_func); cdecl = nil;
  SSL_set_psk_server_callback: procedure(ssl: PSSL; cb: SSL_psk_server_cb_func); cdecl = nil;

  //__owur TIdC_INT SSL_CTX_use_psk_identity_hint(ctx: PSSL_CTX, const PIdAnsiChar *identity_hint);
  //__owur TIdC_INT SSL_use_psk_identity_hint(s: PSSL, const PIdAnsiChar *identity_hint);
  //const PIdAnsiChar *SSL_get_psk_identity_hint(const s: PSSL);
  //const PIdAnsiChar *SSL_get_psk_identity(const s: PSSL);

  SSL_set_psk_find_session_callback: procedure(s: PSSL; cb: SSL_psk_find_session_cb_func); cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_psk_find_session_callback: procedure(ctx: PSSL_CTX; cb: SSL_psk_find_session_cb_func); cdecl = nil; {introduced 1.1.0}
  SSL_set_psk_use_session_callback: procedure(s: PSSL; cb: SSL_psk_use_session_cb_func); cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_psk_use_session_callback: procedure(ctx: PSSL_CTX; cb: SSL_psk_use_session_cb_func); cdecl = nil; {introduced 1.1.0}

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
  SSL_CTX_set_keylog_callback: procedure(ctx: PSSL_CTX; cb: SSL_CTX_keylog_cb_func); cdecl = nil; {introduced 1.1.0}
  (*
   * SSL_CTX_get_keylog_callback returns the callback configured by
   * SSL_CTX_set_keylog_callback.
   *)
  SSL_CTX_get_keylog_callback: function(const ctx: PSSL_CTX): SSL_CTX_keylog_cb_func; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_max_early_data: function(ctx: PSSL_CTX; max_early_data: TIdC_UINT32): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_get_max_early_data: function(const ctx: PSSL_CTX): TIdC_UINT32; cdecl = nil; {introduced 1.1.0}
  SSL_set_max_early_data: function(s: PSSL; max_early_data: TIdC_UINT32): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_get_max_early_data: function(const s: PSSL): TIdC_UINT32; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_recv_max_early_data: function(ctx: PSSL_CTX; recv_max_early_data: TIdC_UINT32): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_get_recv_max_early_data: function(const ctx: PSSL_CTX): TIdC_UINT32; cdecl = nil; {introduced 1.1.0}
  SSL_set_recv_max_early_data: function(s: PSSL; recv_max_early_data: TIdC_UINT32): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_get_recv_max_early_data: function(const s: PSSL): TIdC_UINT32; cdecl = nil; {introduced 1.1.0}

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
  //                                                            (PIdAnsiChar *)(arg)))
  SSL_get_app_data: function(const ssl: PSSL): Pointer ; cdecl = nil; {removed 1.0.0} 
  SSL_set_app_data: function(ssl: PSSL; data: Pointer): TIdC_INT; cdecl = nil; {removed 1.0.0}

  ///* Is the SSL_connection established? */
  //# define SSL_in_connect_init(a)          (SSL_in_init(a) && !SSL_is_server(a))
  //# define SSL_in_accept_init(a)           (SSL_in_init(a) && SSL_is_server(a))
  SSL_in_init: function(const s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_in_before: function(const s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_is_init_finished: function(const s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  (*-
   * Obtain latest Finished message
   *   -- that we sent (SSL_get_finished)
   *   -- that we expected from peer (SSL_get_peer_finished).
   * Returns length (0 == no Finished so far), copies up to 'count' bytes.
   *)
  SSL_get_finished: function(const s: PSSL; buf: Pointer; count: TIdC_SIZET): TIdC_SIZET; cdecl = nil;
  SSL_get_peer_finished: function(const s: PSSL; buf: Pointer; count: TIdC_SIZET): TIdC_SIZET; cdecl = nil;

  //# if OPENSSL_API_COMPAT < 0x10100000L
  //#  define OpenSSL_add_ssl_algorithms()   SSL_library_init()
  //#  define SSLeay_add_ssl_algorithms()    SSL_library_init()
  //# endif
  SSLeay_add_ssl_algorithms: function: TIdC_INT; cdecl = nil; {removed 1.0.0}

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
  BIO_f_ssl: function: PBIO_METHOD; cdecl = nil;
  BIO_new_ssl: function(ctx: PSSL_CTX; client: TIdC_INT): PBIO; cdecl = nil;
  BIO_new_ssl_connect: function(ctx: PSSL_CTX): PBIO; cdecl = nil;
  BIO_new_buffer_ssl_connect: function(ctx: PSSL_CTX): PBIO; cdecl = nil;
  BIO_ssl_copy_session_id: function(to_: PBIO; from: PBIO): TIdC_INT; cdecl = nil;

  SSL_CTX_set_cipher_list: function(v1: PSSL_CTX; const str: PIdAnsiChar): TIdC_INT; cdecl = nil;
  SSL_CTX_new: function(const meth: PSSL_METHOD): PSSL_CTX; cdecl = nil;
  SSL_CTX_set_timeout: function(ctx: PSSL_CTX; t: TIdC_LONG): TIdC_LONG; cdecl = nil;
  SSL_CTX_get_timeout: function(const ctx: PSSL_CTX): TIdC_LONG; cdecl = nil;
  SSL_CTX_get_cert_store: function(const v1: PSSL_CTX): PX509_STORE; cdecl = nil;
  SSL_want: function(const s: PSSL): TIdC_INT; cdecl = nil;
  SSL_clear: function(s: PSSL): TIdC_INT; cdecl = nil;

  BIO_ssl_shutdown: procedure(ssl_bio: PBIO); cdecl = nil;
  SSL_CTX_up_ref: function(ctx: PSSL_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_free: procedure(v1: PSSL_CTX); cdecl = nil;
  SSL_CTX_set_cert_store: procedure(v1: PSSL_CTX; v2: PX509_STORE); cdecl = nil;
  SSL_CTX_set1_cert_store: procedure(v1: PSSL_CTX; v2: PX509_STORE); cdecl = nil; {introduced 1.1.0}

  SSL_CTX_flush_sessions: procedure(ctx: PSSL_CTX; tm: TIdC_LONG); cdecl = nil;

  SSL_get_current_cipher: function(const s: PSSL): PSSL_CIPHER; cdecl = nil;
  SSL_get_pending_cipher: function(const s: PSSL): PSSL_CIPHER; cdecl = nil; {introduced 1.1.0}
  SSL_CIPHER_get_bits: function(const c: PSSL_CIPHER; var alg_bits: TIdC_INT): TIdC_INT; cdecl = nil;
  SSL_CIPHER_get_version: function(const c: PSSL_CIPHER): PIdAnsiChar; cdecl = nil;
  SSL_CIPHER_get_name: function(const c: PSSL_CIPHER): PIdAnsiChar; cdecl = nil;
  SSL_CIPHER_standard_name: function(const c: PSSL_CIPHER): PIdAnsiChar; cdecl = nil; {introduced 1.1.0}
  OPENSSL_cipher_name: function(const rfc_name: PIdAnsiChar): PIdAnsiChar; cdecl = nil; {introduced 1.1.0}
  SSL_CIPHER_get_id: function(const c: PSSL_CIPHER): TIdC_UINT32; cdecl = nil;
  SSL_CIPHER_get_protocol_id: function(const c: PSSL_CIPHER): TIdC_UINT16; cdecl = nil; {introduced 1.1.0}
  SSL_CIPHER_get_kx_nid: function(const c: PSSL_CIPHER): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CIPHER_get_auth_nid: function(const c: PSSL_CIPHER): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CIPHER_get_handshake_digest: function(const c: PSSL_CIPHER): PEVP_MD; cdecl = nil; {introduced 1.1.0}
  SSL_CIPHER_is_aead: function(const c: PSSL_CIPHER): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  SSL_get_fd: function(const s: PSSL): TIdC_INT; cdecl = nil;
  SSL_get_rfd: function(const s: PSSL): TIdC_INT; cdecl = nil;
  SSL_get_wfd: function(const s: PSSL): TIdC_INT; cdecl = nil;
  SSL_get_cipher_list: function(const s: PSSL; n: TIdC_INT): PIdAnsiChar; cdecl = nil;
  SSL_get_shared_ciphers: function(const s: PSSL; buf: PIdAnsiChar; size: TIdC_INT): PIdAnsiChar; cdecl = nil;
  SSL_get_read_ahead: function(const s: PSSL): TIdC_INT; cdecl = nil;
  SSL_pending: function(const s: PSSL): TIdC_INT; cdecl = nil;
  SSL_has_pending: function(const s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_set_fd: function(s: PSSL; fd: TIdC_INT): TIdC_INT; cdecl = nil;
  SSL_set_rfd: function(s: PSSL; fd: TIdC_INT): TIdC_INT; cdecl = nil;
  SSL_set_wfd: function(s: PSSL; fd: TIdC_INT): TIdC_INT; cdecl = nil;
  SSL_set0_rbio: procedure(s: PSSL; rbio: PBIO); cdecl = nil; {introduced 1.1.0}
  SSL_set0_wbio: procedure(s: PSSL; wbio: PBIO); cdecl = nil; {introduced 1.1.0}
  SSL_set_bio: procedure(s: PSSL; rbio: PBIO; wbio: PBIO); cdecl = nil;
  SSL_get_rbio: function(const s: PSSL): PBIO; cdecl = nil;
  SSL_get_wbio: function(const s: PSSL): PBIO; cdecl = nil;
  SSL_set_cipher_list: function(s: PSSL; const str: PIdAnsiChar): TIdC_INT; cdecl = nil;
  SSL_CTX_set_ciphersuites: function(ctx: PSSL_CTX; const str: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_set_ciphersuites: function(s: PSSL; const str: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_get_verify_mode: function(const s: PSSL): TIdC_INT; cdecl = nil;
  SSL_get_verify_depth: function(const s: PSSL): TIdC_INT; cdecl = nil;
  SSL_get_verify_callback: function(const s: PSSL): SSL_verify_cb; cdecl = nil;
  SSL_set_read_ahead: procedure(s: PSSL; yes: TIdC_INT); cdecl = nil;
  SSL_set_verify: procedure(s: PSSL; mode: TIdC_INT; callback: SSL_verify_cb); cdecl = nil;
  SSL_set_verify_depth: procedure(s: PSSL; depth: TIdC_INT); cdecl = nil;
  //void SSL_set_cert_cb(s: PSSL, TIdC_INT (*cb) (ssl: PSSL, void *arg), void *arg);

  SSL_use_RSAPrivateKey: function(ssl: PSSL; rsa: PRSA): TIdC_INT; cdecl = nil;
  SSL_use_RSAPrivateKey_ASN1: function(ssl: PSSL; const d: PByte; len: TIdC_LONG): TIdC_INT; cdecl = nil;
  SSL_use_PrivateKey: function(ssl: PSSL; pkey: PEVP_PKEY): TIdC_INT; cdecl = nil;
  SSL_use_PrivateKey_ASN1: function(pk: TIdC_INT; ssl: PSSL; const d: PByte; len: TIdC_LONG): TIdC_INT; cdecl = nil;
  SSL_use_certificate: function(ssl: PSSL; x: PX509): TIdC_INT; cdecl = nil;
  SSL_use_certificate_ASN1: function(ssl: PSSL; const d: PByte; len: TIdC_INT): TIdC_INT; cdecl = nil;
  //__owur TIdC_INT SSL_use_cert_and_key(ssl: PSSL, x509: PX509, EVP_PKEY *privatekey,
  //                                STACK_OF(X509) *chain, TIdC_INT override);

  (* Set serverinfo data for the current active cert. *)
  SSL_CTX_use_serverinfo: function(ctx: PSSL_CTX; const serverinfo: PByte; serverinfo_length: TIdC_SIZET): TIdC_INT; cdecl = nil;
  SSL_CTX_use_serverinfo_ex: function(ctx: PSSL_CTX; version: TIdC_UINT; const serverinfo: PByte; serverinfo_length: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_use_serverinfo_file: function(ctx: PSSL_CTX; const file_: PIdAnsiChar): TIdC_INT; cdecl = nil;

  SSL_use_RSAPrivateKey_file: function(ssl: PSSL; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT; cdecl = nil;

  SSL_use_PrivateKey_file: function(ssl: PSSL; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT; cdecl = nil;
  SSL_use_certificate_file: function(ssl: PSSL; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT; cdecl = nil;

  SSL_CTX_use_RSAPrivateKey_file: function(ctx: PSSL_CTX; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT; cdecl = nil;

  SSL_CTX_use_PrivateKey_file: function(ctx: PSSL_CTX; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT; cdecl = nil;
  SSL_CTX_use_certificate_file: function(ctx: PSSL_CTX; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT; cdecl = nil;
  (* PEM type *)
  SSL_CTX_use_certificate_chain_file: function(ctx: PSSL_CTX; const file_: PIdAnsiChar): TIdC_INT; cdecl = nil;
  SSL_use_certificate_chain_file: function(ssl: PSSL; const file_: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_load_client_CA_file: function(const file_: PIdAnsiChar): PSTACK_OF_X509_NAME; cdecl = nil;
  SSL_add_file_cert_subjects_to_stack: function(stackCAs: PSTACK_OF_X509_NAME; const file_: PIdAnsiChar):TIdC_INT; cdecl = nil;
  SSL_add_dir_cert_subjects_to_stack: function(stackCAs: PSTACK_OF_X509_NAME; const dir_: PIdAnsiChar): TIdC_INT; cdecl = nil;

  //# if OPENSSL_API_COMPAT < 0x10100000L
  //#  define SSL_load_error_strings() \
  //    OPENSSL_init_ssl(OPENSSL_INIT_LOAD_SSL_STRINGS \
  //                     | OPENSSL_INIT_LOAD_CRYPTO_STRINGS, NULL)
  //# endif
  SSL_load_error_strings: procedure; cdecl = nil; {removed 1.1.0}

  SSL_state_string: function(const s: PSSL): PIdAnsiChar; cdecl = nil;
  SSL_rstate_string: function(const s: PSSL): PIdAnsiChar; cdecl = nil;
  SSL_state_string_long: function(const s: PSSL): PIdAnsiChar; cdecl = nil;
  SSL_rstate_string_long: function(const s: PSSL): PIdAnsiChar; cdecl = nil;
  SSL_SESSION_get_time: function(const s: PSSL_SESSION): TIdC_LONG; cdecl = nil;
  SSL_SESSION_set_time: function(s: PSSL_SESSION; t: TIdC_LONG): TIdC_LONG; cdecl = nil;
  SSL_SESSION_get_timeout: function(const s: PSSL_SESSION): TIdC_LONG; cdecl = nil;
  SSL_SESSION_set_timeout: function(s: PSSL_SESSION; t: TIdC_LONG): TIdC_LONG; cdecl = nil;
  SSL_SESSION_get_protocol_version: function(const s: PSSL_SESSION): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_set_protocol_version: function(s: PSSL_SESSION; version: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  SSL_SESSION_get0_hostname: function(const s: PSSL_SESSION): PIdAnsiChar; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_set1_hostname: function(s: PSSL_SESSION; const hostname: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_get0_alpn_selected: procedure(const s: PSSL_SESSION; const alpn: PPByte; len: PIdC_SIZET); cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_set1_alpn_selected: function(s: PSSL_SESSION; const alpn: PByte; len: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_get0_cipher: function(const s: PSSL_SESSION): PSSL_CIPHER; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_set_cipher: function(s: PSSL_SESSION; const cipher: PSSL_CIPHER): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_has_ticket: function(const s: PSSL_SESSION): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_get_ticket_lifetime_hint: function(const s: PSSL_SESSION): TIdC_ULONG; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_get0_ticket: procedure(const s: PSSL_SESSION; const tick: PPByte; len: PIdC_SIZET); cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_get_max_early_data: function(const s: PSSL_SESSION): TIdC_UINT32; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_set_max_early_data: function(s: PSSL_SESSION; max_early_data: TIdC_UINT32): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_copy_session_id: function(to_: PSSL; const from: PSSL): TIdC_INT; cdecl = nil;
  SSL_SESSION_get0_peer: function(s: PSSL_SESSION): PX509; cdecl = nil;
  SSL_SESSION_set1_id_context: function(s: PSSL_SESSION; const sid_ctx: PByte; sid_ctx_len: TIdC_UINT): TIdC_INT; cdecl = nil;
  SSL_SESSION_set1_id: function(s: PSSL_SESSION; const sid: PByte; sid_len: TIdC_UINT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_is_resumable: function(const s: PSSL_SESSION): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  SSL_SESSION_new: function: PSSL_SESSION; cdecl = nil;
  SSL_SESSION_dup: function(src: PSSL_SESSION): PSSL_SESSION; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_get_id: function(const s: PSSL_SESSION; len: PIdC_UINT): PByte; cdecl = nil;
  SSL_SESSION_get0_id_context: function(const s: PSSL_SESSION; len: PIdC_UINT): PByte; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_get_compress_id: function(const s: PSSL_SESSION): TIdC_UINT; cdecl = nil;
  SSL_SESSION_print: function(fp: PBIO; const ses: PSSL_SESSION): TIdC_INT; cdecl = nil;
  SSL_SESSION_print_keylog: function(bp: PBIO; const x: PSSL_SESSION): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_up_ref: function(ses: PSSL_SESSION): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_free: procedure(ses: PSSL_SESSION); cdecl = nil;
  //__owur TIdC_INT i2d_SSL_SESSION(SSL_SESSION *in_, Byte **pp);
  SSL_set_session: function(to_: PSSL; session: PSSL_SESSION): TIdC_INT; cdecl = nil;
  SSL_CTX_add_session: function(ctx: PSSL_CTX; session: PSSL_SESSION): TIdC_INT; cdecl = nil;
  SSL_CTX_remove_session: function(ctx: PSSL_CTX; session: PSSL_SESSION): TIdC_INT; cdecl = nil;
  SSL_CTX_set_generate_session_id: function(ctx: PSSL_CTX; cb: GEN_SESSION_CB): TIdC_INT; cdecl = nil;
  SSL_set_generate_session_id: function(s: PSSL; cb: GEN_SESSION_CB): TIdC_INT; cdecl = nil;
  SSL_has_matching_session_id: function(const s: PSSL; const id: PByte; id_len: TIdC_UINT): TIdC_INT; cdecl = nil;
  d2i_SSL_SESSION: function(a: PPSSL_SESSION; const pp: PPByte; length: TIdC_LONG): PSSL_SESSION; cdecl = nil;

  SSL_get_peer_certificate: function(const s: PSSL): PX509; cdecl = nil; {removed 3.0.0}

  //__owur STACK_OF(X509) *SSL_get_peer_cert_chain(const s: PSSL);
  //
  SSL_CTX_get_verify_mode: function(const ctx: PSSL_CTX): TIdC_INT; cdecl = nil;
  SSL_CTX_get_verify_depth: function(const ctx: PSSL_CTX): TIdC_INT; cdecl = nil;
  SSL_CTX_get_verify_callback: function(const ctx: PSSL_CTX): SSL_verify_cb; cdecl = nil;
  SSL_CTX_set_verify: procedure(ctx: PSSL_CTX; mode: TIdC_INT; callback: SSL_verify_cb); cdecl = nil;
  SSL_CTX_set_verify_depth: procedure(ctx: PSSL_CTX; depth: TIdC_INT); cdecl = nil;
  SSL_CTX_set_cert_verify_callback: procedure(ctx: PSSL_CTX; cb: SSL_CTX_set_cert_verify_callback_cb; arg: Pointer); cdecl = nil;
  SSL_CTX_set_cert_cb: procedure(c: PSSL_CTX; cb: SSL_CTX_set_cert_cb_cb; arg: Pointer); cdecl = nil;
  SSL_CTX_use_RSAPrivateKey: function(ctx: PSSL_CTX; rsa: PRSA): TIdC_INT; cdecl = nil;
  SSL_CTX_use_RSAPrivateKey_ASN1: function(ctx: PSSL_CTX; const d: PByte; len: TIdC_LONG): TIdC_INT; cdecl = nil;
  SSL_CTX_use_PrivateKey: function(ctx: PSSL_CTX; pkey: PEVP_PKEY): TIdC_INT; cdecl = nil;
  SSL_CTX_use_PrivateKey_ASN1: function(pk: TIdC_INT; ctx: PSSL_CTX; const d: PByte; len: TIdC_LONG): TIdC_INT; cdecl = nil;
  SSL_CTX_use_certificate: function(ctx: PSSL_CTX; x: X509): TIdC_INT; cdecl = nil;
  SSL_CTX_use_certificate_ASN1: function(ctx: PSSL_CTX; len: TIdC_INT; const d: PByte): TIdC_INT; cdecl = nil;
  //function TIdC_INT SSL_CTX_use_cert_and_key(ctx: PSSL_CTX; x509: PX509; EVP_PKEY *privatekey; STACK_OF(X509) *chain; TIdC_INT override);

  SSL_CTX_set_default_passwd_cb: procedure(ctx: PSSL_CTX; cb: pem_password_cb); cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_default_passwd_cb_userdata: procedure(ctx: PSSL_CTX; u: Pointer); cdecl = nil; {introduced 1.1.0}
  SSL_CTX_get_default_passwd_cb: function(ctx: PSSL_CTX): pem_password_cb; cdecl = nil;  {introduced 1.1.0}
  SSL_CTX_get_default_passwd_cb_userdata: function(ctx: PSSL_CTX): Pointer; cdecl = nil; {introduced 1.1.0}
  SSL_set_default_passwd_cb: procedure(s: PSSL; cb: pem_password_cb); cdecl = nil; {introduced 1.1.0}
  SSL_set_default_passwd_cb_userdata: procedure(s: PSSL; u: Pointer); cdecl = nil; {introduced 1.1.0}
  SSL_get_default_passwd_cb: function(s: PSSL): pem_password_cb; cdecl = nil; {introduced 1.1.0}
  SSL_get_default_passwd_cb_userdata: function(s: PSSL): Pointer; cdecl = nil; {introduced 1.1.0}

  SSL_CTX_check_private_key: function(const ctx: PSSL_CTX): TIdC_INT; cdecl = nil;
  SSL_check_private_key: function(const ctx: PSSL): TIdC_INT; cdecl = nil;

  SSL_CTX_set_session_id_context: function(ctx: PSSL_CTX; const sid_ctx: PByte; sid_ctx_len: TIdC_UINT): TIdC_INT; cdecl = nil;

  SSL_new: function(ctx: PSSL_CTX): PSSL; cdecl = nil;
  SSL_up_ref: function(s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_is_dtls: function(const s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_set_session_id_context: function(ssl: PSSL; const sid_ctx: PByte; sid_ctx_len: TIdC_UINT): TIdC_INT; cdecl = nil;

  SSL_CTX_set_purpose: function(ctx: PSSL_CTX; purpose: TIdC_INT): TIdC_INT; cdecl = nil;
  SSL_set_purpose: function(ssl: PSSL; purpose: TIdC_INT): TIdC_INT; cdecl = nil;
  SSL_CTX_set_trust: function(ctx: PSSL_CTX; trust: TIdC_INT): TIdC_INT; cdecl = nil;
  SSL_set_trust: function(ssl: PSSL; trust: TIdC_INT): TIdC_INT; cdecl = nil;

  SSL_set1_host: function(s: PSSL; const hostname: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_add1_host: function(s: PSSL; const hostname: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_get0_peername: function(s: PSSL): PIdAnsiChar; cdecl = nil; {introduced 1.1.0}
  SSL_set_hostflags: procedure(s: PSSL; flags: TIdC_UINT); cdecl = nil; {introduced 1.1.0}

  SSL_CTX_dane_enable: function(ctx: PSSL_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_dane_mtype_set: function(ctx: PSSL_CTX; const md: PEVP_MD; mtype: TIdC_UINT8; ord: TIdC_UINT8): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_dane_enable: function(s: PSSL; const basedomain: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_dane_tlsa_add: function(s: PSSL; usage: TIdC_UINT8; selector: TIdC_UINT8; mtype: TIdC_UINT8; const data: PByte; dlen: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_get0_dane_authority: function(s: PSSL; mcert: PPX509; mspki: PPEVP_PKEY): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_get0_dane_tlsa: function(s: PSSL; usage: PIdC_UINT8; selector: PIdC_UINT8; mtype: PIdC_UINT8; const data: PPByte; dlen: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  (*
   * Bridge opacity barrier between libcrypt and libssl, also needed to support
   * offline testing in test/danetest.c
   *)
  SSL_get0_dane: function(ssl: PSSL): PSSL_DANE; cdecl = nil; {introduced 1.1.0}

  (*
   * DANE flags
   *)
  SSL_CTX_dane_set_flags: function(ctx: PSSL_CTX; flags: TIdC_ULONG): TIdC_ULONG; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_dane_clear_flags: function(ctx: PSSL_CTX; flags: TIdC_ULONG): TIdC_ULONG; cdecl = nil; {introduced 1.1.0}
  SSL_dane_set_flags: function(ssl: PSSL; flags: TIdC_ULONG): TIdC_ULONG; cdecl = nil; {introduced 1.1.0}
  SSL_dane_clear_flags: function(ssl: PSSL; flags: TIdC_ULONG): TIdC_ULONG; cdecl = nil; {introduced 1.1.0}

  SSL_CTX_set1_param: function(ctx: PSSL_CTX; vpm: PX509_VERIFY_PARAM): TIdC_INT; cdecl = nil;
  SSL_set1_param: function(ssl: PSSL; vpm: PX509_VERIFY_PARAM): TIdC_INT; cdecl = nil;

  SSL_CTX_get0_param: function(ctx: PSSL_CTX): PX509_VERIFY_PARAM; cdecl = nil;
  SSL_get0_param: function(ssl: PSSL): PX509_VERIFY_PARAM; cdecl = nil;

  SSL_CTX_set_srp_username: function(ctx: PSSL_CTX; name: PIdAnsiChar): TIdC_INT; cdecl = nil;
  SSL_CTX_set_srp_password: function(ctx: PSSL_CTX; password: PIdAnsiChar): TIdC_INT; cdecl = nil;
  SSL_CTX_set_srp_strength: function(ctx: PSSL_CTX; strength: TIdC_INT): TIdC_INT; cdecl = nil;

  SSL_CTX_set_srp_client_pwd_callback: function(ctx: PSSL_CTX; cb: SSL_CTX_set_srp_client_pwd_callback_cb): TIdC_INT; cdecl = nil;
  SSL_CTX_set_srp_verify_param_callback: function(ctx: PSSL_CTX; cb: SSL_CTX_set_srp_verify_param_callback_cb): TIdC_INT; cdecl = nil;
  SSL_CTX_set_srp_username_callback: function(ctx: PSSL_CTX; cb: SSL_CTX_set_srp_username_callback_cb): TIdC_INT; cdecl = nil;

  SSL_CTX_set_srp_cb_arg: function(ctx: PSSL_CTX; arg: Pointer): TIdC_INT; cdecl = nil;
  SSL_set_srp_server_param: function(s: PSSL; const N: PBIGNUm; const g: PBIGNUm; sa: PBIGNUm; v: PBIGNUm; info: PIdAnsiChar): TIdC_INT; cdecl = nil;
  SSL_set_srp_server_param_pw: function(s: PSSL; const user: PIdAnsiChar; const pass: PIdAnsiChar; const grp: PIdAnsiChar): TIdC_INT; cdecl = nil;

  //__owur BIGNUM *SSL_get_srp_g(s: PSSL);
  //__owur BIGNUM *SSL_get_srp_N(s: PSSL);
  //
  //__owur PIdAnsiChar *SSL_get_srp_username(s: PSSL);
  //__owur PIdAnsiChar *SSL_get_srp_userinfo(s: PSSL);
  //
  ///*
  // * ClientHello callback and helpers.
  // */
  SSL_CTX_set_client_hello_cb: procedure(c: PSSL_CTX; cb: SSL_client_hello_cb_fn; arg: Pointer); cdecl = nil; {introduced 1.1.0}
  SSL_client_hello_isv2: function(s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_client_hello_get0_legacy_version: function(s: PSSL): TIdC_UINT; cdecl = nil; {introduced 1.1.0}
  SSL_client_hello_get0_random: function(s: PSSL; const out_: PPByte): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  SSL_client_hello_get0_session_id: function(s: PSSL; const out_: PPByte): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  SSL_client_hello_get0_ciphers: function(s: PSSL; const out_: PPByte): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  SSL_client_hello_get0_compression_methods: function(s: PSSL; const out_: PPByte): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  SSL_client_hello_get1_extensions_present: function(s: PSSL; out_: PPIdC_INT; outlen: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_client_hello_get0_ext: function(s: PSSL; type_: TIdC_UINT; const out_: PPByte; outlen: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_certs_clear: procedure(s: PSSL); cdecl = nil;
  SSL_free: procedure(ssl: PSSL); cdecl = nil;

  (*
   * Windows application developer has to include windows.h to use these.
   *)
  SSL_waiting_for_async: function(s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_get_all_async_fds: function(s: PSSL; fds: POSSL_ASYNC_FD; numfds: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_get_changed_async_fds: function(s: PSSL; addfd: POSSL_ASYNC_FD; numaddfds: PIdC_SIZET; delfd: POSSL_ASYNC_FD; numdelfds: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_accept: function(ssl: PSSL): TIdC_INT; cdecl = nil;
  SSL_stateless: function(s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_connect: function(ssl: PSSL): TIdC_INT; cdecl = nil;
  SSL_read: function(ssl: PSSL; buf: Pointer; num: TIdC_INT): TIdC_INT; cdecl = nil;
  SSL_read_ex: function(ssl: PSSL; buf: Pointer; num: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  SSL_read_early_data: function(s: PSSL; buf: Pointer; num: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_peek: function(ssl: PSSL; buf: Pointer; num: TIdC_INT): TIdC_INT; cdecl = nil;
  SSL_peek_ex: function(ssl: PSSL; buf: Pointer; num: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_write: function(ssl: PSSL; const buf: Pointer; num: TIdC_INT): TIdC_INT; cdecl = nil;
  SSL_write_ex: function(s: PSSL; const buf: Pointer; num: TIdC_SIZET; written: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_write_early_data: function(s: PSSL; const buf: Pointer; num: TIdC_SIZET; written: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_callback_ctrl: function(v1: PSSL; v2: TIdC_INT; v3: SSL_callback_ctrl_v3): TIdC_LONG; cdecl = nil;

  SSL_ctrl: function(ssl: PSSL; cmd: TIdC_INT; larg: TIdC_LONG; parg: Pointer): TIdC_LONG; cdecl = nil;
  SSL_CTX_ctrl: function(ctx: PSSL_CTX; cmd: TIdC_INT; larg: TIdC_LONG; parg: Pointer): TIdC_LONG; cdecl = nil;
  SSL_CTX_callback_ctrl: function(v1: PSSL_CTX; v2: TIdC_INT; v3: SSL_CTX_callback_ctrl_v3): TIdC_LONG; cdecl = nil;

  SSL_get_early_data_status: function(const s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  SSL_get_error: function(const s: PSSL; ret_code: TIdC_INT): TIdC_INT; cdecl = nil;
  SSL_get_version: function(const s: PSSL): PIdAnsiChar; cdecl = nil;

  (* This sets the 'default' SSL version that SSL_new() will create *)
  SSL_CTX_set_ssl_version: function(ctx: PSSL_CTX; const meth: PSSL_METHOD): TIdC_INT; cdecl = nil;

  ///* Negotiate highest available SSL/TLS version */
  TLS_method: function: PSSL_METHOD; cdecl = nil; {introduced 1.1.0}
  TLS_server_method: function: PSSL_METHOD; cdecl = nil; {introduced 1.1.0}
  TLS_client_method: function: PSSL_METHOD; cdecl = nil; {introduced 1.1.0}

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
  SSL_key_update: function(s: PSSL; updatetype: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_get_key_update_type: function(const s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_renegotiate: function(s: PSSL): TIdC_INT; cdecl = nil;
  SSL_renegotiate_abbreviated: function(s: PSSL): TIdC_INT; cdecl = nil;
  SSL_shutdown: function(s: PSSL): TIdC_INT; cdecl = nil;
  SSL_CTX_set_post_handshake_auth: procedure(ctx: PSSL_CTX; val: TIdC_INT); cdecl = nil; {introduced 1.1.0}
  SSL_set_post_handshake_auth: procedure(s: PSSL; val: TIdC_INT); cdecl = nil; {introduced 1.1.0}

  SSL_renegotiate_pending: function(const s: PSSL): TIdC_INT; cdecl = nil;
  SSL_verify_client_post_handshake: function(s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  SSL_CTX_get_ssl_method: function(const ctx: PSSL_CTX): PSSL_METHOD; cdecl = nil;
  SSL_get_ssl_method: function(const s: PSSL): PSSL_METHOD; cdecl = nil;
  SSL_set_ssl_method: function(s: PSSL; const method: PSSL_METHOD): TIdC_INT; cdecl = nil;
  SSL_alert_type_string_long: function(value: TIdC_INT): PIdAnsiChar; cdecl = nil;
  SSL_alert_type_string: function(value: TIdC_INT): PIdAnsiChar; cdecl = nil;
  SSL_alert_desc_string_long: function(value: TIdC_INT): PIdAnsiChar; cdecl = nil;
  SSL_alert_desc_string: function(value: TIdC_INT): PIdAnsiChar; cdecl = nil;

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

  SSL_CTX_set_client_CA_list: procedure(ctx: PSSL_CTX; name_list: PSTACK_OF_X509_NAME); cdecl = nil;
  SSL_add_client_CA: function(ssl: PSSL; x: PX509): TIdC_INT; cdecl = nil;
  SSL_CTX_add_client_CA: function(ctx: PSSL_CTX; x: PX509): TIdC_INT; cdecl = nil;

  SSL_set_connect_state: procedure(s: PSSL); cdecl = nil;
  SSL_set_accept_state: procedure(s: PSSL); cdecl = nil;

  //__owur TIdC_LONG SSL_get_default_timeout(const s: PSSL);
  //
  //# if OPENSSL_API_COMPAT < 0x10100000L
  //#  define SSL_library_init() OPENSSL_init_ssl(0, NULL)
  //# endif
  SSL_library_init: function: TIdC_INT; cdecl = nil; {removed 1.1.0}

  //__owur PIdAnsiChar *SSL_CIPHER_description(const SSL_CIPHER *, PIdAnsiChar *buf, TIdC_INT size);
  //__owur STACK_OF(X509_NAME) *SSL_dup_CA_list(const STACK_OF(X509_NAME) *sk);
  SSL_CIPHER_description: function(cipher: PSSL_CIPHER; buf: PIdAnsiChar; size_ :TIdC_INT): PIdAnsiChar; cdecl = nil;

  SSL_dup: function(ssl: PSSL): PSSL; cdecl = nil;

  SSL_get_certificate: function(const ssl: PSSL): PX509; cdecl = nil;
  (*
   * EVP_PKEY
   *)
  SSL_get_privatekey: function(const ssl: PSSL): PEVP_PKEY; cdecl = nil;

  SSL_CTX_get0_certificate: function(const ctx: PSSL_CTX): PX509; cdecl = nil;
  SSL_CTX_get0_privatekey: function(const ctx: PSSL_CTX): PEVP_PKEY; cdecl = nil;

  SSL_CTX_set_quiet_shutdown: procedure(ctx: PSSL_CTX; mode: TIdC_INT); cdecl = nil;
  SSL_CTX_get_quiet_shutdown: function(const ctx: PSSL_CTX): TIdC_INT; cdecl = nil;
  SSL_set_quiet_shutdown: procedure(ssl: PSSL; mode: TIdC_INT); cdecl = nil;
  SSL_get_quiet_shutdown: function(const ssl: PSSL): TIdC_INT; cdecl = nil;
  SSL_set_shutdown: procedure(ssl: PSSL; mode: TIdC_INT); cdecl = nil;
  SSL_get_shutdown: function(const ssl: PSSL): TIdC_INT; cdecl = nil;
  SSL_version: function(const ssl: PSSL): TIdC_INT; cdecl = nil;
  SSL_client_version: function(const s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_default_verify_paths: function(ctx: PSSL_CTX): TIdC_INT; cdecl = nil;
  SSL_CTX_set_default_verify_dir: function(ctx: PSSL_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_default_verify_file: function(ctx: PSSL_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_load_verify_locations: function(ctx: PSSL_CTX; const CAfile: PIdAnsiChar; const CApath: PIdAnsiChar): TIdC_INT; cdecl = nil;
  //# define SSL_get0_session SSL_get_session/* just peek at pointer */
  SSL_get_session: function(const ssl: PSSL): PSSL_SESSION; cdecl = nil;
  (* obtain a reference count *)
  SSL_get1_session: function(ssl: PSSL): PSSL_SESSION; cdecl = nil;
  SSL_get_SSL_CTX: function(const ssl: PSSL): PSSL_CTX; cdecl = nil;
  SSL_set_SSL_CTX: function(ssl: PSSL; ctx: PSSL_CTX): PSSL_CTX; cdecl = nil;
  SSL_set_info_callback: procedure(ssl: PSSL; cb: SSL_info_callback); cdecl = nil;
  SSL_get_info_callback: function(const ssl: PSSL): SSL_info_callback; cdecl = nil;
  SSL_get_state: function(const ssl: PSSL): OSSL_HANDSHAKE_STATE; cdecl = nil; {introduced 1.1.0}

  SSL_set_verify_result: procedure(ssl: PSSL; v: TIdC_LONG); cdecl = nil;
  SSL_get_verify_result: function(const ssl: PSSL): TIdC_LONG; cdecl = nil;
  //__owur STACK_OF(X509) *SSL_get0_verified_chain(const s: PSSL);

  SSL_get_client_random: function(const ssl: PSSL; out_: PByte; outlen: TIdC_SIZET): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  SSL_get_server_random: function(const ssl: PSSL; out_: PByte; outlen: TIdC_SIZET): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_get_master_key: function(const sess: PSSL_SESSION; out_: PByte; outlen: TIdC_SIZET): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_set1_master_key: function(sess: PSSL_SESSION; const in_: PByte; len: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_get_max_fragment_length: function(const sess: PSSL_SESSION): TIdC_UINT8; cdecl = nil; {introduced 1.1.0}

  //#define SSL_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_SSL, l, p, newf, dupf, freef)
  SSL_set_ex_data: function(ssl: PSSL; idx: TIdC_INT; data: Pointer): TIdC_INT; cdecl = nil;
  SSL_get_ex_data: function(const ssl: PSSL; idx: TIdC_INT): Pointer; cdecl = nil;
  //#define SSL_SESSION_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_SSL_SESSION, l, p, newf, dupf, freef)
  SSL_SESSION_set_ex_data: function(ss: PSSL_SESSION; idx: TIdC_INT; data: Pointer): TIdC_INT; cdecl = nil;
  SSL_SESSION_get_ex_data: function(const ss: PSSL_SESSION; idx: TIdC_INT): Pointer; cdecl = nil;
  //#define SSL_CTX_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_SSL_CTX, l, p, newf, dupf, freef)
  SSL_CTX_set_ex_data: function(ssl: PSSL_CTX; idx: TIdC_INT; data: Pointer): TIdC_INT; cdecl = nil;
  SSL_CTX_get_ex_data: function(const ssl: PSSL_CTX; idx: TIdC_INT): Pointer; cdecl = nil;

  SSL_get_ex_data_X509_STORE_CTX_idx: function: TIdC_INT; cdecl = nil;

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

  SSL_CTX_set_default_read_buffer_len: procedure(ctx: PSSL_CTX; len: TIdC_SIZET); cdecl = nil; {introduced 1.1.0}
  SSL_set_default_read_buffer_len: procedure(s: PSSL; len: TIdC_SIZET); cdecl = nil; {introduced 1.1.0}

  SSL_CTX_set_tmp_dh_callback: procedure(ctx: PSSL_CTX; dh: SSL_CTX_set_tmp_dh_callback_dh); cdecl = nil;
  SSL_set_tmp_dh_callback: procedure(ssl: PSSL; dh: SSL_set_tmp_dh_callback_dh); cdecl = nil;

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

  SSL_CIPHER_find: function(ssl: PSSL; const ptr: PByte): PSSL_CIPHER; cdecl = nil;
  SSL_CIPHER_get_cipher_nid: function(const c: PSSL_CIPHEr): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CIPHER_get_digest_nid: function(const c: PSSL_CIPHEr): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  //TIdC_INT SSL_bytes_to_cipher_list(s: PSSL, const Byte *bytes, TIdC_SIZET len,
  //                             TIdC_INT isv2format, STACK_OF(SSL_CIPHER) **sk,
  //                             STACK_OF(SSL_CIPHER) **scsvs);

  (* TLS extensions functions *)
  SSL_set_session_ticket_ext: function(s: PSSL; ext_data: Pointer; ext_len: TIdC_INT): TIdC_INT; cdecl = nil;
  //
  SSL_set_session_ticket_ext_cb: function(s: PSSL; cb: tls_session_ticket_ext_cb_fn; arg: Pointer): TIdC_INT; cdecl = nil;

  ///* Pre-shared secret session resumption functions */
  //__owur TIdC_INT SSL_set_session_secret_cb(s: PSSL,
  //                                     tls_session_secret_cb_fn session_secret_cb,
  //                                     void *arg);

  SSL_CTX_set_not_resumable_session_callback: procedure(ctx: PSSL_CTX; cb: SSL_CTX_set_not_resumable_session_callback_cb); cdecl = nil; {introduced 1.1.0}
  SSL_set_not_resumable_session_callback: procedure(ssl: PSSL; cb: SSL_set_not_resumable_session_callback_cb); cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_record_padding_callback: procedure(ctx: PSSL_CTX; cb: SSL_CTX_set_record_padding_callback_cb); cdecl = nil; {introduced 1.1.0}

  SSL_CTX_set_record_padding_callback_arg: procedure(ctx: PSSL_CTX; arg: Pointer); cdecl = nil; {introduced 1.1.0}
  SSL_CTX_get_record_padding_callback_arg: function(const ctx: PSSL_CTX): Pointer; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_block_padding: function(ctx: PSSL_CTX; block_size: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  SSL_set_record_padding_callback: procedure(ssl: PSSL; cb: SSL_set_record_padding_callback_cb); cdecl = nil; {introduced 1.1.0}

  SSL_set_record_padding_callback_arg: procedure(ssl: PSSL; arg: Pointer); cdecl = nil; {introduced 1.1.0}
  SSL_get_record_padding_callback_arg: function(const ssl: PSSL): Pointer; cdecl = nil; {introduced 1.1.0}
  SSL_set_block_padding: function(ssl: PSSL; block_size: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_set_num_tickets: function(s: PSSL; num_tickets: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_get_num_tickets: function(const s: PSSL): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_num_tickets: function(ctx: PSSL_CTX; num_tickets: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_get_num_tickets: function(const ctx: PSSL_CTX): TIdC_SIZET; cdecl = nil; {introduced 1.1.0}

  //# if OPENSSL_API_COMPAT < 0x10100000L
  //#  define SSL_cache_hit(s) SSL_session_reused(s)
  //# endif

  SSL_session_reused: function(const s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_is_server: function(const s: PSSL): TIdC_INT; cdecl = nil;

  SSL_CONF_CTX_new: function: PSSL_CONF_CTX; cdecl = nil;
  SSL_CONF_CTX_finish: function(cctx: PSSL_CONF_CTX): TIdC_INT; cdecl = nil;
  SSL_CONF_CTX_free: procedure(cctx: PSSL_CONF_CTX); cdecl = nil;
  SSL_CONF_CTX_set_flags: function(cctx: PSSL_CONF_CTX; flags: TIdC_UINT): TIdC_UINT; cdecl = nil;
  SSL_CONF_CTX_clear_flags: function(cctx: PSSL_CONF_CTX; flags: TIdC_UINT): TIdC_UINT; cdecl = nil;
  SSL_CONF_CTX_set1_prefix: function(cctx: PSSL_CONF_CTX; const pre: PIdAnsiChar): TIdC_INT; cdecl = nil;
  SSL_CONF_cmd: function(cctx: PSSL_CONF_CTX; const cmd: PIdAnsiChar; const value: PIdAnsiChar): TIdC_INT; cdecl = nil;
  SSL_CONF_cmd_argv: function(cctx: PSSL_CONF_CTX; pargc: PIdC_INT; pargv: PPPIdAnsiChar): TIdC_INT; cdecl = nil;
  SSL_CONF_cmd_value_type: function(cctx: PSSL_CONF_CTX; const cmd: PIdAnsiChar): TIdC_INT; cdecl = nil;

  SSL_CONF_CTX_set_ssl: procedure(cctx: PSSL_CONF_CTX; ssl: PSSL); cdecl = nil;
  SSL_CONF_CTX_set_ssl_ctx: procedure(cctx: PSSL_CONF_CTX; ctx: PSSL_CTX); cdecl = nil;
  SSL_add_ssl_module: procedure; cdecl = nil; {introduced 1.1.0}
  SSL_config: function(s: PSSL; const name: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_config: function(ctx: PSSL_CTX; const name: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}

//  procedure SSL_trace(write_p: TIdC_INT; version: TIdC_INT; content_type: TIdC_INT; const buf: Pointer; len: TIdC_SIZET; ssl: PSSL; arg: Pointer);

  DTLSv1_listen: function(s: PSSL; client: PBIO_ADDr): TIdC_INT; cdecl = nil; {introduced 1.1.0}

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
  // * The validation type enumerates the available behaviours of the built-in SSL
  // * CT validation callback selected via SSL_enable_ct() and SSL_CTX_enable_ct().
  // * The underlying callback is a static function in_ libssl.
  // */

  ///*
  // * Enable CT by setting up a callback that implements one of the built-in
  // * validation variants.  The SSL_CT_VALIDATION_PERMISSIVE variant always
  // * continues the handshake, the application can make appropriate decisions at
  // * handshake completion.  The SSL_CT_VALIDATION_STRICT variant requires at
  // * least one valid SCT, or else handshake termination will be requested.  The
  // * handshake may continue anyway if SSL_VERIFY_NONE is in_ effect.
  // */
  SSL_enable_ct: function(s: PSSL; validation_mode: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_enable_ct: function(ctx: PSSL_CTX; validation_mode: TIdC_INT): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  ///*
  // * Report whether a non-NULL callback is enabled.
  // */
  SSL_ct_is_enabled: function(const s: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_ct_is_enabled: function(const ctx: PSSL_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  ///* Gets the SCTs received from a connection */
  //const STACK_OF(SCT) *SSL_get0_peer_scts(s: PSSL);

  SSL_CTX_set_default_ctlog_list_file: function(ctx: PSSL_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_ctlog_list_file: function(ctx: PSSL_CTX; const path: PIdAnsiChar): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set0_ctlog_store: procedure(ctx: PSSL_CTX; logs: PCTLOG_STORE); cdecl = nil; {introduced 1.1.0}

  // const CTLOG_STORE *SSL_CTX_get0_ctlog_store(const ctx: PSSL_CTX);

  // # endif /* OPENSSL_NO_CT */

  SSL_set_security_level: procedure(s: PSSL; level: TIdC_INT); cdecl = nil; {introduced 1.1.0}

  ////__owur TIdC_INT SSL_get_security_level(const s: PSSL);
  SSL_set_security_callback: procedure(s: PSSL; cb: SSL_security_callback); cdecl = nil; {introduced 1.1.0}
  SSL_get_security_callback: function(const s: PSSL): SSL_security_callback; cdecl = nil; {introduced 1.1.0}
  SSL_set0_security_ex_data: procedure(s: PSSL; ex: Pointer); cdecl = nil; {introduced 1.1.0}
  SSL_get0_security_ex_data: function(const s: PSSL): Pointer; cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_security_level: procedure(ctx: PSSL_CTX; level: TIdC_INT); cdecl = nil; {introduced 1.1.0}
  SSL_CTX_get_security_level: function(const ctx: PSSL_CTX): TIdC_INT; cdecl = nil; {introduced 1.1.0}
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

  SSL_CTX_get0_security_ex_data: function(const ctx: PSSL_CTX): Pointer; cdecl = nil; {introduced 1.1.0}

  SSL_CTX_set0_security_ex_data: procedure(ctx: PSSL_CTX; ex: Pointer); cdecl = nil; {introduced 1.1.0}

  OPENSSL_init_ssl: function(opts: TIdC_UINT64; const settings: POPENSSL_INIT_SETTINGS): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  //# ifndef OPENSSL_NO_UNIT_TEST
  //__owur const struct openssl_ssl_test_functions *SSL_test_functions(void);
  //# endif

  SSL_free_buffers: function(ssl: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_alloc_buffers: function(ssl: PSSL): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  SSL_CTX_set_session_ticket_cb: function(ctx: PSSL_CTX; gen_cb: SSL_CTX_generate_session_ticket_fn; dec_cb: SSL_CTX_decrypt_session_ticket_fn; arg: Pointer): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  SSL_SESSION_set1_ticket_appdata: function(ss: PSSL_SESSION; const data: Pointer; len: TIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}
  SSL_SESSION_get0_ticket_appdata: function(ss: PSSL_SESSION; data: PPointer; len: PIdC_SIZET): TIdC_INT; cdecl = nil; {introduced 1.1.0}

  //extern const PIdAnsiChar SSL_version_str[];

  DTLS_set_timer_cb: procedure(s: PSSL; cb: DTLS_timer_cb); cdecl = nil; {introduced 1.1.0}
  SSL_CTX_set_allow_early_data_cb: procedure(ctx: PSSL_CTX; cb: SSL_allow_early_data_cb_fN; arg: Pointer); cdecl = nil; {introduced 1.1.0}
  SSL_set_allow_early_data_cb: procedure(s: PSSL; cb: SSL_allow_early_data_cb_fN; arg: Pointer); cdecl = nil; {introduced 1.1.0}

  SSLv2_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} // SSLv2
  SSLv2_server_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} // SSLv2
  SSLv2_client_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} // SSLv2
  SSLv3_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} // SSLv3
  SSLv3_server_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} // SSLv3
  SSLv3_client_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} // SSLv3
  SSLv23_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} // SSLv3 but can rollback to v2
  SSLv23_server_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} // SSLv3 but can rollback to v2
  SSLv23_client_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} // SSLv3 but can rollback to v2
  TLSv1_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} // TLSv1.0
  TLSv1_server_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} // TLSv1.0
  TLSv1_client_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} // TLSv1.0
  TLSv1_1_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} //TLS1.1
  TLSv1_1_server_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} //TLS1.1
  TLSv1_1_client_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil} //TLS1.1
  TLSv1_2_method: function:  PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil}		// TLSv1.2
  TLSv1_2_server_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil}	// TLSv1.2 
  TLSv1_2_client_method: function: PSSL_METHOD; cdecl = nil; {removed 1.1.0 allow_nil}	// TLSv1.2

  //X509 *SSL_get0_peer_certificate(const SSL *s);
  SSL_get0_peer_certificate: function(const s: PSSL): PX509; cdecl = nil; {introduced 3.3.0}
  // X509 *SSL_get1_peer_certificate(const SSL *s);
  SSL_get1_peer_certificate: function(const s: PSSL): PX509; cdecl = nil; {introduced 3.3.0}



{$ELSE}



  //typedef TIdC_INT (*tls_session_secret_cb_fn)(s: PSSL, void *secret, TIdC_INT *secret_len,
  //                                        STACK_OF(SSL_CIPHER) *peer_ciphers,
  //                                        const SSL_CIPHER **cipher, void *arg);

  function SSL_CTX_get_options(const ctx: PSSL_CTX): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get_options(const s: PSSL): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_clear_options(ctx: PSSL_CTX; op: TIdC_ULONG): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_clear_options(s: PSSL; op: TIdC_ULONG): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_set_options(ctx: PSSL_CTX; op: TIdC_ULONG): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_set_options(s: PSSL; op: TIdC_ULONG): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

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

  procedure SSL_CTX_sess_set_new_cb(ctx: PSSL_CTX; new_session_cb: SSL_CTX_sess_new_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_sess_get_new_cb(ctx: PSSL_CTX): SSL_CTX_sess_new_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CTX_sess_set_remove_cb(ctx: PSSL_CTX; remove_session_cb: SSL_CTX_sess_remove_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_sess_get_remove_cb(ctx: PSSL_CTX): SSL_CTX_sess_remove_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  //void SSL_CTX_sess_set_get_cb(ctx: PSSL_CTX,
  //                             SSL_SESSION *(*get_session_cb) (struct ssl_st
  //                                                             *ssl,
  //                                                             const Byte
  //                                                             *data, TIdC_INT len,
  //                                                             TIdC_INT *copy));
  //SSL_SESSION *(*SSL_CTX_sess_get_get_cb(ctx: PSSL_CTX)) (struct ssl_st *ssl,
  //                                                       const d: PByteata,
  //                                                       TIdC_INT len, TIdC_INT *copy);
  procedure SSL_CTX_set_info_callback(ctx: PSSL_CTX; cb: SSL_CTX_info_callback) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_get_info_callback(ctx: PSSL_CTX): SSL_CTX_info_callback cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CTX_set_client_cert_cb(ctx: PSSL_CTX; client_cert_cb: SSL_CTX_client_cert_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_get_client_cert_cb(ctx: PSSL_CTX): SSL_CTX_client_cert_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_set_client_cert_engine(ctx: PSSL_CTX; e: PENGINE): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  procedure SSL_CTX_set_cookie_generate_cb(ctx: PSSL_CTX; app_gen_cookie_cb: SSL_CTX_cookie_verify_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CTX_set_cookie_verify_cb(ctx: PSSL_CTX; app_verify_cookie_cb: SSL_CTX_set_cookie_verify_cb_app_verify_cookie_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CTX_set_stateless_cookie_generate_cb(ctx: PSSL_CTX; gen_stateless_cookie_cb: SSL_CTX_set_stateless_cookie_generate_cb_gen_stateless_cookie_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_CTX_set_stateless_cookie_verify_cb(ctx: PSSL_CTX; verify_stateless_cookie_cb: SSL_CTX_set_stateless_cookie_verify_cb_verify_stateless_cookie_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  //__owur TIdC_INT SSL_CTX_set_alpn_protos(ctx: PSSL_CTX, const Byte *protos,
  //                                   TIdC_UINT protos_len);
  //__owur TIdC_INT SSL_set_alpn_protos(ssl: PSSL, const Byte *protos,
  //                               TIdC_UINT protos_len);

  procedure SSL_CTX_set_alpn_select_cb(ctx: PSSL_CTX; cb: SSL_CTX_alpn_select_cb_func; arg: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_get0_alpn_selected(const ssl: PSSL; const data: PPByte; len: PIdC_UINT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CTX_set_psk_client_callback(ctx: PSSL_CTX; cb: SSL_psk_client_cb_func) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_set_psk_client_callback(ssl: PSSL; cb: SSL_psk_client_cb_func) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CTX_set_psk_server_callback(ctx: PSSL_CTX; cb: SSL_psk_server_cb_func) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_set_psk_server_callback(ssl: PSSL; cb: SSL_psk_server_cb_func) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  //__owur TIdC_INT SSL_CTX_use_psk_identity_hint(ctx: PSSL_CTX, const PIdAnsiChar *identity_hint);
  //__owur TIdC_INT SSL_use_psk_identity_hint(s: PSSL, const PIdAnsiChar *identity_hint);
  //const PIdAnsiChar *SSL_get_psk_identity_hint(const s: PSSL);
  //const PIdAnsiChar *SSL_get_psk_identity(const s: PSSL);

  procedure SSL_set_psk_find_session_callback(s: PSSL; cb: SSL_psk_find_session_cb_func) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_CTX_set_psk_find_session_callback(ctx: PSSL_CTX; cb: SSL_psk_find_session_cb_func) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_set_psk_use_session_callback(s: PSSL; cb: SSL_psk_use_session_cb_func) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_CTX_set_psk_use_session_callback(ctx: PSSL_CTX; cb: SSL_psk_use_session_cb_func) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

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
  procedure SSL_CTX_set_keylog_callback(ctx: PSSL_CTX; cb: SSL_CTX_keylog_cb_func) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  (*
   * SSL_CTX_get_keylog_callback returns the callback configured by
   * SSL_CTX_set_keylog_callback.
   *)
  function SSL_CTX_get_keylog_callback(const ctx: PSSL_CTX): SSL_CTX_keylog_cb_func cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_set_max_early_data(ctx: PSSL_CTX; max_early_data: TIdC_UINT32): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_get_max_early_data(const ctx: PSSL_CTX): TIdC_UINT32 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_set_max_early_data(s: PSSL; max_early_data: TIdC_UINT32): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get_max_early_data(const s: PSSL): TIdC_UINT32 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_set_recv_max_early_data(ctx: PSSL_CTX; recv_max_early_data: TIdC_UINT32): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_get_recv_max_early_data(const ctx: PSSL_CTX): TIdC_UINT32 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_set_recv_max_early_data(s: PSSL; recv_max_early_data: TIdC_UINT32): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get_recv_max_early_data(const s: PSSL): TIdC_UINT32 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

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
  //                                                            (PIdAnsiChar *)(arg)))

  ///* Is the SSL_connection established? */
  //# define SSL_in_connect_init(a)          (SSL_in_init(a) && !SSL_is_server(a))
  //# define SSL_in_accept_init(a)           (SSL_in_init(a) && SSL_is_server(a))
  function SSL_in_init(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_in_before(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_is_init_finished(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  (*-
   * Obtain latest Finished message
   *   -- that we sent (SSL_get_finished)
   *   -- that we expected from peer (SSL_get_peer_finished).
   * Returns length (0 == no Finished so far), copies up to 'count' bytes.
   *)
  function SSL_get_finished(const s: PSSL; buf: Pointer; count: TIdC_SIZET): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_peer_finished(const s: PSSL; buf: Pointer; count: TIdC_SIZET): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

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
  function BIO_f_ssl: PBIO_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function BIO_new_ssl(ctx: PSSL_CTX; client: TIdC_INT): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function BIO_new_ssl_connect(ctx: PSSL_CTX): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function BIO_new_buffer_ssl_connect(ctx: PSSL_CTX): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function BIO_ssl_copy_session_id(to_: PBIO; from: PBIO): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_CTX_set_cipher_list(v1: PSSL_CTX; const str: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_new(const meth: PSSL_METHOD): PSSL_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_set_timeout(ctx: PSSL_CTX; t: TIdC_LONG): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_get_timeout(const ctx: PSSL_CTX): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_get_cert_store(const v1: PSSL_CTX): PX509_STORE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_want(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_clear(s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  procedure BIO_ssl_shutdown(ssl_bio: PBIO) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_up_ref(ctx: PSSL_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_CTX_free(v1: PSSL_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CTX_set_cert_store(v1: PSSL_CTX; v2: PX509_STORE) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CTX_set1_cert_store(v1: PSSL_CTX; v2: PX509_STORE) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  procedure SSL_CTX_flush_sessions(ctx: PSSL_CTX; tm: TIdC_LONG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_get_current_cipher(const s: PSSL): PSSL_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_pending_cipher(const s: PSSL): PSSL_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CIPHER_get_bits(const c: PSSL_CIPHER; var alg_bits: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CIPHER_get_version(const c: PSSL_CIPHER): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CIPHER_get_name(const c: PSSL_CIPHER): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CIPHER_standard_name(const c: PSSL_CIPHER): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function OPENSSL_cipher_name(const rfc_name: PIdAnsiChar): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CIPHER_get_id(const c: PSSL_CIPHER): TIdC_UINT32 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CIPHER_get_protocol_id(const c: PSSL_CIPHER): TIdC_UINT16 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CIPHER_get_kx_nid(const c: PSSL_CIPHER): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CIPHER_get_auth_nid(const c: PSSL_CIPHER): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CIPHER_get_handshake_digest(const c: PSSL_CIPHER): PEVP_MD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CIPHER_is_aead(const c: PSSL_CIPHER): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  function SSL_get_fd(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_rfd(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_wfd(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_cipher_list(const s: PSSL; n: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_shared_ciphers(const s: PSSL; buf: PIdAnsiChar; size: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_read_ahead(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_pending(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_has_pending(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_set_fd(s: PSSL; fd: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_set_rfd(s: PSSL; fd: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_set_wfd(s: PSSL; fd: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_set0_rbio(s: PSSL; rbio: PBIO) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_set0_wbio(s: PSSL; wbio: PBIO) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_set_bio(s: PSSL; rbio: PBIO; wbio: PBIO) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_rbio(const s: PSSL): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_wbio(const s: PSSL): PBIO cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_set_cipher_list(s: PSSL; const str: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_set_ciphersuites(ctx: PSSL_CTX; const str: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_set_ciphersuites(s: PSSL; const str: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get_verify_mode(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_verify_depth(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_verify_callback(const s: PSSL): SSL_verify_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_set_read_ahead(s: PSSL; yes: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_set_verify(s: PSSL; mode: TIdC_INT; callback: SSL_verify_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_set_verify_depth(s: PSSL; depth: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  //void SSL_set_cert_cb(s: PSSL, TIdC_INT (*cb) (ssl: PSSL, void *arg), void *arg);

  function SSL_use_RSAPrivateKey(ssl: PSSL; rsa: PRSA): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_use_RSAPrivateKey_ASN1(ssl: PSSL; const d: PByte; len: TIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_use_PrivateKey(ssl: PSSL; pkey: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_use_PrivateKey_ASN1(pk: TIdC_INT; ssl: PSSL; const d: PByte; len: TIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_use_certificate(ssl: PSSL; x: PX509): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_use_certificate_ASN1(ssl: PSSL; const d: PByte; len: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  //__owur TIdC_INT SSL_use_cert_and_key(ssl: PSSL, x509: PX509, EVP_PKEY *privatekey,
  //                                STACK_OF(X509) *chain, TIdC_INT override);

  (* Set serverinfo data for the current active cert. *)
  function SSL_CTX_use_serverinfo(ctx: PSSL_CTX; const serverinfo: PByte; serverinfo_length: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_use_serverinfo_ex(ctx: PSSL_CTX; version: TIdC_UINT; const serverinfo: PByte; serverinfo_length: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_use_serverinfo_file(ctx: PSSL_CTX; const file_: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_use_RSAPrivateKey_file(ssl: PSSL; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_use_PrivateKey_file(ssl: PSSL; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_use_certificate_file(ssl: PSSL; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_CTX_use_RSAPrivateKey_file(ctx: PSSL_CTX; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_CTX_use_PrivateKey_file(ctx: PSSL_CTX; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_use_certificate_file(ctx: PSSL_CTX; const file_: PIdAnsiChar; type_: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  (* PEM type *)
  function SSL_CTX_use_certificate_chain_file(ctx: PSSL_CTX; const file_: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_use_certificate_chain_file(ssl: PSSL; const file_: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_load_client_CA_file(const file_: PIdAnsiChar): PSTACK_OF_X509_NAME cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_add_file_cert_subjects_to_stack(stackCAs: PSTACK_OF_X509_NAME; const file_: PIdAnsiChar):TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_add_dir_cert_subjects_to_stack(stackCAs: PSTACK_OF_X509_NAME; const dir_: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  //# if OPENSSL_API_COMPAT < 0x10100000L
  //#  define SSL_load_error_strings() \
  //    OPENSSL_init_ssl(OPENSSL_INIT_LOAD_SSL_STRINGS \
  //                     | OPENSSL_INIT_LOAD_CRYPTO_STRINGS, NULL)
  //# endif

  function SSL_state_string(const s: PSSL): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_rstate_string(const s: PSSL): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_state_string_long(const s: PSSL): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_rstate_string_long(const s: PSSL): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_SESSION_get_time(const s: PSSL_SESSION): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_SESSION_set_time(s: PSSL_SESSION; t: TIdC_LONG): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_SESSION_get_timeout(const s: PSSL_SESSION): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_SESSION_set_timeout(s: PSSL_SESSION; t: TIdC_LONG): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_SESSION_get_protocol_version(const s: PSSL_SESSION): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_set_protocol_version(s: PSSL_SESSION; version: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  function SSL_SESSION_get0_hostname(const s: PSSL_SESSION): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_set1_hostname(s: PSSL_SESSION; const hostname: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_SESSION_get0_alpn_selected(const s: PSSL_SESSION; const alpn: PPByte; len: PIdC_SIZET) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_set1_alpn_selected(s: PSSL_SESSION; const alpn: PByte; len: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_get0_cipher(const s: PSSL_SESSION): PSSL_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_set_cipher(s: PSSL_SESSION; const cipher: PSSL_CIPHER): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_has_ticket(const s: PSSL_SESSION): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_get_ticket_lifetime_hint(const s: PSSL_SESSION): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_SESSION_get0_ticket(const s: PSSL_SESSION; const tick: PPByte; len: PIdC_SIZET) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_get_max_early_data(const s: PSSL_SESSION): TIdC_UINT32 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_set_max_early_data(s: PSSL_SESSION; max_early_data: TIdC_UINT32): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_copy_session_id(to_: PSSL; const from: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_SESSION_get0_peer(s: PSSL_SESSION): PX509 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_SESSION_set1_id_context(s: PSSL_SESSION; const sid_ctx: PByte; sid_ctx_len: TIdC_UINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_SESSION_set1_id(s: PSSL_SESSION; const sid: PByte; sid_len: TIdC_UINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_is_resumable(const s: PSSL_SESSION): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  function SSL_SESSION_new: PSSL_SESSION cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_SESSION_dup(src: PSSL_SESSION): PSSL_SESSION cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_get_id(const s: PSSL_SESSION; len: PIdC_UINT): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_SESSION_get0_id_context(const s: PSSL_SESSION; len: PIdC_UINT): PByte cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_get_compress_id(const s: PSSL_SESSION): TIdC_UINT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_SESSION_print(fp: PBIO; const ses: PSSL_SESSION): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_SESSION_print_keylog(bp: PBIO; const x: PSSL_SESSION): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_up_ref(ses: PSSL_SESSION): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_SESSION_free(ses: PSSL_SESSION) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  //__owur TIdC_INT i2d_SSL_SESSION(SSL_SESSION *in_, Byte **pp);
  function SSL_set_session(to_: PSSL; session: PSSL_SESSION): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_add_session(ctx: PSSL_CTX; session: PSSL_SESSION): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_remove_session(ctx: PSSL_CTX; session: PSSL_SESSION): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_set_generate_session_id(ctx: PSSL_CTX; cb: GEN_SESSION_CB): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_set_generate_session_id(s: PSSL; cb: GEN_SESSION_CB): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_has_matching_session_id(const s: PSSL; const id: PByte; id_len: TIdC_UINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function d2i_SSL_SESSION(a: PPSSL_SESSION; const pp: PPByte; length: TIdC_LONG): PSSL_SESSION cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};


  //__owur STACK_OF(X509) *SSL_get_peer_cert_chain(const s: PSSL);
  //
  function SSL_CTX_get_verify_mode(const ctx: PSSL_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_get_verify_depth(const ctx: PSSL_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_get_verify_callback(const ctx: PSSL_CTX): SSL_verify_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CTX_set_verify(ctx: PSSL_CTX; mode: TIdC_INT; callback: SSL_verify_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CTX_set_verify_depth(ctx: PSSL_CTX; depth: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CTX_set_cert_verify_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_cert_verify_callback_cb; arg: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CTX_set_cert_cb(c: PSSL_CTX; cb: SSL_CTX_set_cert_cb_cb; arg: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_use_RSAPrivateKey(ctx: PSSL_CTX; rsa: PRSA): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_use_RSAPrivateKey_ASN1(ctx: PSSL_CTX; const d: PByte; len: TIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_use_PrivateKey(ctx: PSSL_CTX; pkey: PEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_use_PrivateKey_ASN1(pk: TIdC_INT; ctx: PSSL_CTX; const d: PByte; len: TIdC_LONG): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_use_certificate(ctx: PSSL_CTX; x: X509): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_use_certificate_ASN1(ctx: PSSL_CTX; len: TIdC_INT; const d: PByte): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  //function TIdC_INT SSL_CTX_use_cert_and_key(ctx: PSSL_CTX; x509: PX509; EVP_PKEY *privatekey; STACK_OF(X509) *chain; TIdC_INT override);

  procedure SSL_CTX_set_default_passwd_cb(ctx: PSSL_CTX; cb: pem_password_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_CTX_set_default_passwd_cb_userdata(ctx: PSSL_CTX; u: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_get_default_passwd_cb(ctx: PSSL_CTX): pem_password_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};  {introduced 1.1.0}
  function SSL_CTX_get_default_passwd_cb_userdata(ctx: PSSL_CTX): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_set_default_passwd_cb(s: PSSL; cb: pem_password_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_set_default_passwd_cb_userdata(s: PSSL; u: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get_default_passwd_cb(s: PSSL): pem_password_cb cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get_default_passwd_cb_userdata(s: PSSL): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  function SSL_CTX_check_private_key(const ctx: PSSL_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_check_private_key(const ctx: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_CTX_set_session_id_context(ctx: PSSL_CTX; const sid_ctx: PByte; sid_ctx_len: TIdC_UINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_new(ctx: PSSL_CTX): PSSL cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_up_ref(s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_is_dtls(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_set_session_id_context(ssl: PSSL; const sid_ctx: PByte; sid_ctx_len: TIdC_UINT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_CTX_set_purpose(ctx: PSSL_CTX; purpose: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_set_purpose(ssl: PSSL; purpose: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_set_trust(ctx: PSSL_CTX; trust: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_set_trust(ssl: PSSL; trust: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_set1_host(s: PSSL; const hostname: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_add1_host(s: PSSL; const hostname: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get0_peername(s: PSSL): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_set_hostflags(s: PSSL; flags: TIdC_UINT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  function SSL_CTX_dane_enable(ctx: PSSL_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_dane_mtype_set(ctx: PSSL_CTX; const md: PEVP_MD; mtype: TIdC_UINT8; ord: TIdC_UINT8): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_dane_enable(s: PSSL; const basedomain: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_dane_tlsa_add(s: PSSL; usage: TIdC_UINT8; selector: TIdC_UINT8; mtype: TIdC_UINT8; const data: PByte; dlen: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get0_dane_authority(s: PSSL; mcert: PPX509; mspki: PPEVP_PKEY): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get0_dane_tlsa(s: PSSL; usage: PIdC_UINT8; selector: PIdC_UINT8; mtype: PIdC_UINT8; const data: PPByte; dlen: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  (*
   * Bridge opacity barrier between libcrypt and libssl, also needed to support
   * offline testing in test/danetest.c
   *)
  function SSL_get0_dane(ssl: PSSL): PSSL_DANE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  (*
   * DANE flags
   *)
  function SSL_CTX_dane_set_flags(ctx: PSSL_CTX; flags: TIdC_ULONG): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_dane_clear_flags(ctx: PSSL_CTX; flags: TIdC_ULONG): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_dane_set_flags(ssl: PSSL; flags: TIdC_ULONG): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_dane_clear_flags(ssl: PSSL; flags: TIdC_ULONG): TIdC_ULONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  function SSL_CTX_set1_param(ctx: PSSL_CTX; vpm: PX509_VERIFY_PARAM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_set1_param(ssl: PSSL; vpm: PX509_VERIFY_PARAM): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_CTX_get0_param(ctx: PSSL_CTX): PX509_VERIFY_PARAM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get0_param(ssl: PSSL): PX509_VERIFY_PARAM cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_CTX_set_srp_username(ctx: PSSL_CTX; name: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_set_srp_password(ctx: PSSL_CTX; password: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_set_srp_strength(ctx: PSSL_CTX; strength: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_CTX_set_srp_client_pwd_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_srp_client_pwd_callback_cb): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_set_srp_verify_param_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_srp_verify_param_callback_cb): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_set_srp_username_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_srp_username_callback_cb): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_CTX_set_srp_cb_arg(ctx: PSSL_CTX; arg: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_set_srp_server_param(s: PSSL; const N: PBIGNUm; const g: PBIGNUm; sa: PBIGNUm; v: PBIGNUm; info: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_set_srp_server_param_pw(s: PSSL; const user: PIdAnsiChar; const pass: PIdAnsiChar; const grp: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  //__owur BIGNUM *SSL_get_srp_g(s: PSSL);
  //__owur BIGNUM *SSL_get_srp_N(s: PSSL);
  //
  //__owur PIdAnsiChar *SSL_get_srp_username(s: PSSL);
  //__owur PIdAnsiChar *SSL_get_srp_userinfo(s: PSSL);
  //
  ///*
  // * ClientHello callback and helpers.
  // */
  procedure SSL_CTX_set_client_hello_cb(c: PSSL_CTX; cb: SSL_client_hello_cb_fn; arg: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_client_hello_isv2(s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_client_hello_get0_legacy_version(s: PSSL): TIdC_UINT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_client_hello_get0_random(s: PSSL; const out_: PPByte): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_client_hello_get0_session_id(s: PSSL; const out_: PPByte): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_client_hello_get0_ciphers(s: PSSL; const out_: PPByte): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_client_hello_get0_compression_methods(s: PSSL; const out_: PPByte): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_client_hello_get1_extensions_present(s: PSSL; out_: PPIdC_INT; outlen: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_client_hello_get0_ext(s: PSSL; type_: TIdC_UINT; const out_: PPByte; outlen: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_certs_clear(s: PSSL) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_free(ssl: PSSL) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  (*
   * Windows application developer has to include windows.h to use these.
   *)
  function SSL_waiting_for_async(s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get_all_async_fds(s: PSSL; fds: POSSL_ASYNC_FD; numfds: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get_changed_async_fds(s: PSSL; addfd: POSSL_ASYNC_FD; numaddfds: PIdC_SIZET; delfd: POSSL_ASYNC_FD; numdelfds: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_accept(ssl: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_stateless(s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_connect(ssl: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_read(ssl: PSSL; buf: Pointer; num: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_read_ex(ssl: PSSL; buf: Pointer; num: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  function SSL_read_early_data(s: PSSL; buf: Pointer; num: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_peek(ssl: PSSL; buf: Pointer; num: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_peek_ex(ssl: PSSL; buf: Pointer; num: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_write(ssl: PSSL; const buf: Pointer; num: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_write_ex(s: PSSL; const buf: Pointer; num: TIdC_SIZET; written: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_write_early_data(s: PSSL; const buf: Pointer; num: TIdC_SIZET; written: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_callback_ctrl(v1: PSSL; v2: TIdC_INT; v3: SSL_callback_ctrl_v3): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_ctrl(ssl: PSSL; cmd: TIdC_INT; larg: TIdC_LONG; parg: Pointer): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_ctrl(ctx: PSSL_CTX; cmd: TIdC_INT; larg: TIdC_LONG; parg: Pointer): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_callback_ctrl(v1: PSSL_CTX; v2: TIdC_INT; v3: SSL_CTX_callback_ctrl_v3): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_get_early_data_status(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  function SSL_get_error(const s: PSSL; ret_code: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_version(const s: PSSL): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  (* This sets the 'default' SSL version that SSL_new() will create *)
  function SSL_CTX_set_ssl_version(ctx: PSSL_CTX; const meth: PSSL_METHOD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  ///* Negotiate highest available SSL/TLS version */
  function TLS_method: PSSL_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function TLS_server_method: PSSL_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function TLS_client_method: PSSL_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

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
  function SSL_key_update(s: PSSL; updatetype: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get_key_update_type(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_renegotiate(s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_renegotiate_abbreviated(s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_shutdown(s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CTX_set_post_handshake_auth(ctx: PSSL_CTX; val: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_set_post_handshake_auth(s: PSSL; val: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  function SSL_renegotiate_pending(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_verify_client_post_handshake(s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  function SSL_CTX_get_ssl_method(const ctx: PSSL_CTX): PSSL_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_ssl_method(const s: PSSL): PSSL_METHOD cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_set_ssl_method(s: PSSL; const method: PSSL_METHOD): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_alert_type_string_long(value: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_alert_type_string(value: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_alert_desc_string_long(value: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_alert_desc_string(value: TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

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

  procedure SSL_CTX_set_client_CA_list(ctx: PSSL_CTX; name_list: PSTACK_OF_X509_NAME) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_add_client_CA(ssl: PSSL; x: PX509): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_add_client_CA(ctx: PSSL_CTX; x: PX509): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  procedure SSL_set_connect_state(s: PSSL) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_set_accept_state(s: PSSL) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  //__owur TIdC_LONG SSL_get_default_timeout(const s: PSSL);
  //
  //# if OPENSSL_API_COMPAT < 0x10100000L
  //#  define SSL_library_init() OPENSSL_init_ssl(0, NULL)
  //# endif

  //__owur PIdAnsiChar *SSL_CIPHER_description(const SSL_CIPHER *, PIdAnsiChar *buf, TIdC_INT size);
  //__owur STACK_OF(X509_NAME) *SSL_dup_CA_list(const STACK_OF(X509_NAME) *sk);
  function SSL_CIPHER_description(cipher: PSSL_CIPHER; buf: PIdAnsiChar; size_ :TIdC_INT): PIdAnsiChar cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_dup(ssl: PSSL): PSSL cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_get_certificate(const ssl: PSSL): PX509 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  (*
   * EVP_PKEY
   *)
  function SSL_get_privatekey(const ssl: PSSL): PEVP_PKEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_CTX_get0_certificate(const ctx: PSSL_CTX): PX509 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_get0_privatekey(const ctx: PSSL_CTX): PEVP_PKEY cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  procedure SSL_CTX_set_quiet_shutdown(ctx: PSSL_CTX; mode: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_get_quiet_shutdown(const ctx: PSSL_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_set_quiet_shutdown(ssl: PSSL; mode: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_quiet_shutdown(const ssl: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_set_shutdown(ssl: PSSL; mode: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_shutdown(const ssl: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_version(const ssl: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_client_version(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_set_default_verify_paths(ctx: PSSL_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_set_default_verify_dir(ctx: PSSL_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_set_default_verify_file(ctx: PSSL_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_load_verify_locations(ctx: PSSL_CTX; const CAfile: PIdAnsiChar; const CApath: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  //# define SSL_get0_session SSL_get_session/* just peek at pointer */
  function SSL_get_session(const ssl: PSSL): PSSL_SESSION cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  (* obtain a reference count *)
  function SSL_get1_session(ssl: PSSL): PSSL_SESSION cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_SSL_CTX(const ssl: PSSL): PSSL_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_set_SSL_CTX(ssl: PSSL; ctx: PSSL_CTX): PSSL_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_set_info_callback(ssl: PSSL; cb: SSL_info_callback) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_info_callback(const ssl: PSSL): SSL_info_callback cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_state(const ssl: PSSL): OSSL_HANDSHAKE_STATE cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  procedure SSL_set_verify_result(ssl: PSSL; v: TIdC_LONG) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_verify_result(const ssl: PSSL): TIdC_LONG cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  //__owur STACK_OF(X509) *SSL_get0_verified_chain(const s: PSSL);

  function SSL_get_client_random(const ssl: PSSL; out_: PByte; outlen: TIdC_SIZET): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get_server_random(const ssl: PSSL; out_: PByte; outlen: TIdC_SIZET): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_get_master_key(const sess: PSSL_SESSION; out_: PByte; outlen: TIdC_SIZET): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_set1_master_key(sess: PSSL_SESSION; const in_: PByte; len: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_get_max_fragment_length(const sess: PSSL_SESSION): TIdC_UINT8 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  //#define SSL_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_SSL, l, p, newf, dupf, freef)
  function SSL_set_ex_data(ssl: PSSL; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_get_ex_data(const ssl: PSSL; idx: TIdC_INT): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  //#define SSL_SESSION_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_SSL_SESSION, l, p, newf, dupf, freef)
  function SSL_SESSION_set_ex_data(ss: PSSL_SESSION; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_SESSION_get_ex_data(const ss: PSSL_SESSION; idx: TIdC_INT): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  //#define SSL_CTX_get_ex_new_index(l, p, newf, dupf, freef) \
  //    CRYPTO_get_ex_new_index(CRYPTO_EX_INDEX_SSL_CTX, l, p, newf, dupf, freef)
  function SSL_CTX_set_ex_data(ssl: PSSL_CTX; idx: TIdC_INT; data: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CTX_get_ex_data(const ssl: PSSL_CTX; idx: TIdC_INT): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_get_ex_data_X509_STORE_CTX_idx: TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

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

  procedure SSL_CTX_set_default_read_buffer_len(ctx: PSSL_CTX; len: TIdC_SIZET) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_set_default_read_buffer_len(s: PSSL; len: TIdC_SIZET) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  procedure SSL_CTX_set_tmp_dh_callback(ctx: PSSL_CTX; dh: SSL_CTX_set_tmp_dh_callback_dh) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_set_tmp_dh_callback(ssl: PSSL; dh: SSL_set_tmp_dh_callback_dh) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

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

  function SSL_CIPHER_find(ssl: PSSL; const ptr: PByte): PSSL_CIPHER cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CIPHER_get_cipher_nid(const c: PSSL_CIPHEr): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CIPHER_get_digest_nid(const c: PSSL_CIPHEr): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  //TIdC_INT SSL_bytes_to_cipher_list(s: PSSL, const Byte *bytes, TIdC_SIZET len,
  //                             TIdC_INT isv2format, STACK_OF(SSL_CIPHER) **sk,
  //                             STACK_OF(SSL_CIPHER) **scsvs);

  (* TLS extensions functions *)
  function SSL_set_session_ticket_ext(s: PSSL; ext_data: Pointer; ext_len: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  //
  function SSL_set_session_ticket_ext_cb(s: PSSL; cb: tls_session_ticket_ext_cb_fn; arg: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  ///* Pre-shared secret session resumption functions */
  //__owur TIdC_INT SSL_set_session_secret_cb(s: PSSL,
  //                                     tls_session_secret_cb_fn session_secret_cb,
  //                                     void *arg);

  procedure SSL_CTX_set_not_resumable_session_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_not_resumable_session_callback_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_set_not_resumable_session_callback(ssl: PSSL; cb: SSL_set_not_resumable_session_callback_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_CTX_set_record_padding_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_record_padding_callback_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  procedure SSL_CTX_set_record_padding_callback_arg(ctx: PSSL_CTX; arg: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_get_record_padding_callback_arg(const ctx: PSSL_CTX): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_set_block_padding(ctx: PSSL_CTX; block_size: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  procedure SSL_set_record_padding_callback(ssl: PSSL; cb: SSL_set_record_padding_callback_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  procedure SSL_set_record_padding_callback_arg(ssl: PSSL; arg: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get_record_padding_callback_arg(const ssl: PSSL): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_set_block_padding(ssl: PSSL; block_size: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_set_num_tickets(s: PSSL; num_tickets: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get_num_tickets(const s: PSSL): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_set_num_tickets(ctx: PSSL_CTX; num_tickets: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_get_num_tickets(const ctx: PSSL_CTX): TIdC_SIZET cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  //# if OPENSSL_API_COMPAT < 0x10100000L
  //#  define SSL_cache_hit(s) SSL_session_reused(s)
  //# endif

  function SSL_session_reused(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_is_server(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  function SSL_CONF_CTX_new: PSSL_CONF_CTX cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CONF_CTX_finish(cctx: PSSL_CONF_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CONF_CTX_free(cctx: PSSL_CONF_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CONF_CTX_set_flags(cctx: PSSL_CONF_CTX; flags: TIdC_UINT): TIdC_UINT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CONF_CTX_clear_flags(cctx: PSSL_CONF_CTX; flags: TIdC_UINT): TIdC_UINT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CONF_CTX_set1_prefix(cctx: PSSL_CONF_CTX; const pre: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CONF_cmd(cctx: PSSL_CONF_CTX; const cmd: PIdAnsiChar; const value: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CONF_cmd_argv(cctx: PSSL_CONF_CTX; pargc: PIdC_INT; pargv: PPPIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  function SSL_CONF_cmd_value_type(cctx: PSSL_CONF_CTX; const cmd: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};

  procedure SSL_CONF_CTX_set_ssl(cctx: PSSL_CONF_CTX; ssl: PSSL) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_CONF_CTX_set_ssl_ctx(cctx: PSSL_CONF_CTX; ctx: PSSL_CTX) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF};
  procedure SSL_add_ssl_module cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_config(s: PSSL; const name: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_config(ctx: PSSL_CTX; const name: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

//  procedure SSL_trace(write_p: TIdC_INT; version: TIdC_INT; content_type: TIdC_INT; const buf: Pointer; len: TIdC_SIZET; ssl: PSSL; arg: Pointer);

  function DTLSv1_listen(s: PSSL; client: PBIO_ADDr): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

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
  // * The validation type enumerates the available behaviours of the built-in SSL
  // * CT validation callback selected via SSL_enable_ct() and SSL_CTX_enable_ct().
  // * The underlying callback is a static function in_ libssl.
  // */

  ///*
  // * Enable CT by setting up a callback that implements one of the built-in
  // * validation variants.  The SSL_CT_VALIDATION_PERMISSIVE variant always
  // * continues the handshake, the application can make appropriate decisions at
  // * handshake completion.  The SSL_CT_VALIDATION_STRICT variant requires at
  // * least one valid SCT, or else handshake termination will be requested.  The
  // * handshake may continue anyway if SSL_VERIFY_NONE is in_ effect.
  // */
  function SSL_enable_ct(s: PSSL; validation_mode: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_enable_ct(ctx: PSSL_CTX; validation_mode: TIdC_INT): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  ///*
  // * Report whether a non-NULL callback is enabled.
  // */
  function SSL_ct_is_enabled(const s: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_ct_is_enabled(const ctx: PSSL_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  ///* Gets the SCTs received from a connection */
  //const STACK_OF(SCT) *SSL_get0_peer_scts(s: PSSL);

  function SSL_CTX_set_default_ctlog_list_file(ctx: PSSL_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_set_ctlog_list_file(ctx: PSSL_CTX; const path: PIdAnsiChar): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_CTX_set0_ctlog_store(ctx: PSSL_CTX; logs: PCTLOG_STORE) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  // const CTLOG_STORE *SSL_CTX_get0_ctlog_store(const ctx: PSSL_CTX);

  // # endif /* OPENSSL_NO_CT */

  procedure SSL_set_security_level(s: PSSL; level: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  ////__owur TIdC_INT SSL_get_security_level(const s: PSSL);
  procedure SSL_set_security_callback(s: PSSL; cb: SSL_security_callback) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get_security_callback(const s: PSSL): SSL_security_callback cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_set0_security_ex_data(s: PSSL; ex: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_get0_security_ex_data(const s: PSSL): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_CTX_set_security_level(ctx: PSSL_CTX; level: TIdC_INT) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_CTX_get_security_level(const ctx: PSSL_CTX): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
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

  function SSL_CTX_get0_security_ex_data(const ctx: PSSL_CTX): Pointer cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  procedure SSL_CTX_set0_security_ex_data(ctx: PSSL_CTX; ex: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  function OPENSSL_init_ssl(opts: TIdC_UINT64; const settings: POPENSSL_INIT_SETTINGS): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  //# ifndef OPENSSL_NO_UNIT_TEST
  //__owur const struct openssl_ssl_test_functions *SSL_test_functions(void);
  //# endif

  function SSL_free_buffers(ssl: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_alloc_buffers(ssl: PSSL): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  function SSL_CTX_set_session_ticket_cb(ctx: PSSL_CTX; gen_cb: SSL_CTX_generate_session_ticket_fn; dec_cb: SSL_CTX_decrypt_session_ticket_fn; arg: Pointer): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  function SSL_SESSION_set1_ticket_appdata(ss: PSSL_SESSION; const data: Pointer; len: TIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  function SSL_SESSION_get0_ticket_appdata(ss: PSSL_SESSION; data: PPointer; len: PIdC_SIZET): TIdC_INT cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}

  //extern const PIdAnsiChar SSL_version_str[];

  procedure DTLS_set_timer_cb(s: PSSL; cb: DTLS_timer_cb) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_CTX_set_allow_early_data_cb(ctx: PSSL_CTX; cb: SSL_allow_early_data_cb_fN; arg: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}
  procedure SSL_set_allow_early_data_cb(s: PSSL; cb: SSL_allow_early_data_cb_fN; arg: Pointer) cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 1.1.0}


  //X509 *SSL_get0_peer_certificate(const SSL *s);
  function SSL_get0_peer_certificate(const s: PSSL): PX509 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 3.3.0}
  // X509 *SSL_get1_peer_certificate(const SSL *s);
  function SSL_get1_peer_certificate(const s: PSSL): PX509 cdecl; external {$IFNDEF OPENSSL_USE_STATIC_LIBRARY}CLibSSL{$ENDIF}; {introduced 3.3.0}



function SSL_CTX_set_mode(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_clear_mode(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_sess_set_cache_size(ctx: PSSL_CTX; t: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_sess_get_cache_size(ctx: PSSL_CTX): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set_session_cache_mode(ctx: PSSL_CTX; m: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_get_session_cache_mode(ctx: PSSL_CTX): TIdC_LONG; {removed 1.0.0}
function SSL_clear_num_renegotiations(ssl: PSSL): TIdC_LONG; {removed 1.0.0}
function SSL_total_renegotiations(ssl: PSSL): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set_tmp_dh(ctx: PSSL_CTX; dh: PDH): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set_tmp_ecdh(ctx: PSSL_CTX; ecdh: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set_dh_auto(ctx: PSSL_CTX; onoff: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_set_dh_auto(s: PSSL; onoff: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_set_tmp_dh(ssl: PSSL; dh: PDH): TIdC_LONG; {removed 1.0.0}
function SSL_set_tmp_ecdh(ssl: PSSL; ecdh: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_add_extra_chain_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_get_extra_chain_certs(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_get_extra_chain_certs_only(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_clear_extra_chain_certs(ctx: PSSL_CTX): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set0_chain(ctx: PSSL_CTX; sk: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set1_chain(ctx: PSSL_CTX; sk: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_add0_chain_cert(ctx: PSSL_CTX; x509: PX509): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_add1_chain_cert(ctx: PSSL_CTX; x509: PX509): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_get0_chain_certs(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_clear_chain_certs(ctx: PSSL_CTX): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_build_cert_chain(ctx: PSSL_CTX; flags: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_select_current_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set_current_cert(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set0_verify_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set1_verify_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set0_chain_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set1_chain_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; {removed 1.0.0}
function SSL_set0_chain(s: PSSL; sk: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_set1_chain(s: PSSL; sk: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_add0_chain_cert(s: PSSL; x509: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_add1_chain_cert(s: PSSL; x509: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_get0_chain_certs(s: PSSL; px509: Pointer): TIdC_LONG; {removed 1.0.0}
function SSL_clear_chain_certs(s: PSSL): TIdC_LONG; {removed 1.0.0}
function SSL_build_cert_chain(s: PSSL; flags: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_select_current_cert(s: PSSL; x509: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_set_current_cert(s: PSSL; op: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_set0_verify_cert_store(s: PSSL; st: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_set1_verify_cert_store(s: PSSL; st: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_set0_chain_cert_store(s: PSSL; st: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_set1_chain_cert_store(s: PSSL; st: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_get1_groups(s: PSSL; glist: PIdC_INT): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set1_groups(ctx: PSSL_CTX; glist: PByte; glistlen: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set1_groups_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_set1_groups(s: PSSL; glist: PByte; glistlen: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_set1_groups_list(s: PSSL; str: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_get_shared_group(s: PSSL; n: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set1_sigalgs(ctx: PSSL_CTX; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set1_sigalgs_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_set1_sigalgs(s: PSSL; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_set1_sigalgs_list(s: PSSL; str: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set1_client_sigalgs(ctx: PSSL_CTX; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set1_client_sigalgs_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_set1_client_sigalgs(s: PSSL; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_set1_client_sigalgs_list(s: PSSL; str: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_get0_certificate_types(s: PSSL; clist: PByte): TIdC_LONG; {removed 1.0.0}
function SSL_CTX_set1_client_certificate_types(ctx: PSSL_CTX; clist: PByte; clistlen: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_set1_client_certificate_types(s: PSSL; clist: PByte; clistlen: TIdC_LONG): TIdC_LONG; {removed 1.0.0}
function SSL_get_signature_nid(s: PSSL; pn: Pointer): TIdC_LONG; {removed 1.0.0}
function SSL_get_peer_signature_nid(s: PSSL; pn: Pointer): TIdC_LONG; {removed 1.0.0}
function SSL_get_peer_tmp_key(s: PSSL; pk: Pointer): TIdC_LONG; {removed 1.0.0}
function SSL_get_tmp_key(s: PSSL; pk: Pointer): TIdC_LONG; {removed 1.0.0}
function SSL_get0_raw_cipherlist(s: PSSL; plst: Pointer): TIdC_LONG; {removed 1.0.0}
function SSL_get0_ec_point_formats(s: PSSL; plst: Pointer): TIdC_LONG; {removed 1.0.0}
  function SSL_get_app_data(const ssl: PSSL): Pointer ; {removed 1.0.0} 
  function SSL_set_app_data(ssl: PSSL; data: Pointer): TIdC_INT; {removed 1.0.0}
  function SSLeay_add_ssl_algorithms: TIdC_INT; {removed 1.0.0}
  procedure SSL_load_error_strings; {removed 1.1.0}
  function SSL_get_peer_certificate(const s: PSSL): PX509; {removed 3.0.0}
  function SSL_library_init: TIdC_INT; {removed 1.1.0}
{$ENDIF}

implementation

  {$IFNDEF USE_EXTERNAL_LIBRARY}
  uses
  classes, 
  IdSSLOpenSSLExceptionHandlers, 
  IdSSLOpenSSLLoader;
  {$ENDIF}
  
const
  SSL_CTX_get_options_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_options_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_clear_options_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_clear_options_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_options_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_options_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_stateless_cookie_generate_cb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_stateless_cookie_verify_cb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_psk_find_session_callback_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_psk_find_session_callback_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_psk_use_session_callback_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_psk_use_session_callback_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_keylog_callback_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_get_keylog_callback_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_max_early_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_get_max_early_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_max_early_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_max_early_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_recv_max_early_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_get_recv_max_early_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_recv_max_early_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_recv_max_early_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_in_init_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_in_before_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_is_init_finished_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_up_ref_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set1_cert_store_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_pending_cipher_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CIPHER_standard_name_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  OPENSSL_cipher_name_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CIPHER_get_protocol_id_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CIPHER_get_kx_nid_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CIPHER_get_auth_nid_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CIPHER_get_handshake_digest_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CIPHER_is_aead_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_has_pending_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set0_rbio_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set0_wbio_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_ciphersuites_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_ciphersuites_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_use_serverinfo_ex_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_use_certificate_chain_file_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_get_protocol_version_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_set_protocol_version_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_get0_hostname_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_set1_hostname_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_get0_alpn_selected_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_set1_alpn_selected_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_get0_cipher_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_set_cipher_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_has_ticket_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_get_ticket_lifetime_hint_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_get0_ticket_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_get_max_early_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_set_max_early_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_set1_id_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_is_resumable_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_dup_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_get0_id_context_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_print_keylog_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_up_ref_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_default_passwd_cb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_default_passwd_cb_userdata_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_get_default_passwd_cb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_get_default_passwd_cb_userdata_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_default_passwd_cb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_default_passwd_cb_userdata_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_default_passwd_cb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_default_passwd_cb_userdata_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_up_ref_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_is_dtls_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set1_host_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_add1_host_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get0_peername_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_hostflags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_dane_enable_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_dane_mtype_set_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_dane_enable_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_dane_tlsa_add_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get0_dane_authority_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get0_dane_tlsa_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get0_dane_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_dane_set_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_dane_clear_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_dane_set_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_dane_clear_flags_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_client_hello_cb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_client_hello_isv2_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_client_hello_get0_legacy_version_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_client_hello_get0_random_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_client_hello_get0_session_id_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_client_hello_get0_ciphers_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_client_hello_get0_compression_methods_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_client_hello_get1_extensions_present_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_client_hello_get0_ext_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_waiting_for_async_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_all_async_fds_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_changed_async_fds_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_stateless_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_read_ex_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_read_early_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_peek_ex_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_write_ex_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_write_early_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_early_data_status_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  TLS_method_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  TLS_server_method_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  TLS_client_method_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_key_update_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_key_update_type_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_post_handshake_auth_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_post_handshake_auth_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_verify_client_post_handshake_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_client_version_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_default_verify_dir_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_default_verify_file_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_state_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_client_random_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_server_random_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_get_master_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_set1_master_key_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_get_max_fragment_length_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_default_read_buffer_len_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_default_read_buffer_len_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CIPHER_get_cipher_nid_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CIPHER_get_digest_nid_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_not_resumable_session_callback_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_not_resumable_session_callback_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_record_padding_callback_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_record_padding_callback_arg_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_get_record_padding_callback_arg_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_block_padding_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_record_padding_callback_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_record_padding_callback_arg_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_record_padding_callback_arg_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_block_padding_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_num_tickets_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_num_tickets_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_num_tickets_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_get_num_tickets_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_session_reused_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_add_ssl_module_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_config_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_config_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DTLSv1_listen_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_enable_ct_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_enable_ct_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_ct_is_enabled_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_ct_is_enabled_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_default_ctlog_list_file_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_ctlog_list_file_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set0_ctlog_store_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_security_level_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_security_callback_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_security_callback_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set0_security_ex_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get0_security_ex_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_security_level_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_get_security_level_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_get0_security_ex_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set0_security_ex_data_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  OPENSSL_init_ssl_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_free_buffers_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_alloc_buffers_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_session_ticket_cb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_set1_ticket_appdata_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_SESSION_get0_ticket_appdata_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  DTLS_set_timer_cb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_CTX_set_allow_early_data_cb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_set_allow_early_data_cb_introduced = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get0_peer_certificate_introduced = (byte(3) shl 8 or byte(3)) shl 8 or byte(0);
  SSL_get1_peer_certificate_introduced = (byte(3) shl 8 or byte(3)) shl 8 or byte(0);
  SSL_CTX_set_mode_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_clear_mode_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_sess_set_cache_size_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_sess_get_cache_size_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set_session_cache_mode_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_get_session_cache_mode_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_clear_num_renegotiations_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_total_renegotiations_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set_tmp_dh_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set_tmp_ecdh_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set_dh_auto_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set_dh_auto_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set_tmp_dh_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set_tmp_ecdh_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_add_extra_chain_cert_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_get_extra_chain_certs_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_get_extra_chain_certs_only_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_clear_extra_chain_certs_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set0_chain_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set1_chain_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_add0_chain_cert_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_add1_chain_cert_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_get0_chain_certs_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_clear_chain_certs_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_build_cert_chain_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_select_current_cert_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set_current_cert_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set0_verify_cert_store_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set1_verify_cert_store_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set0_chain_cert_store_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set1_chain_cert_store_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set0_chain_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set1_chain_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_add0_chain_cert_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_add1_chain_cert_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_get0_chain_certs_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_clear_chain_certs_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_build_cert_chain_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_select_current_cert_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set_current_cert_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set0_verify_cert_store_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set1_verify_cert_store_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set0_chain_cert_store_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set1_chain_cert_store_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_get1_groups_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set1_groups_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set1_groups_list_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set1_groups_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set1_groups_list_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_get_shared_group_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set1_sigalgs_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set1_sigalgs_list_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set1_sigalgs_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set1_sigalgs_list_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set1_client_sigalgs_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set1_client_sigalgs_list_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set1_client_sigalgs_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set1_client_sigalgs_list_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_get0_certificate_types_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_CTX_set1_client_certificate_types_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_set1_client_certificate_types_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_get_signature_nid_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_get_peer_signature_nid_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_get_peer_tmp_key_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_get_tmp_key_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_get0_raw_cipherlist_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_get0_ec_point_formats_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_get_app_data_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0); 
  SSL_set_app_data_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSLeay_add_ssl_algorithms_removed = (byte(1) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_load_error_strings_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSL_get_peer_certificate_removed = (byte(3) shl 8 or byte(0)) shl 8 or byte(0);
  SSL_library_init_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);
  SSLv2_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); // SSLv2
  SSLv2_server_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); // SSLv2
  SSLv2_client_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); // SSLv2
  SSLv3_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); // SSLv3
  SSLv3_server_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); // SSLv3
  SSLv3_client_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); // SSLv3
  SSLv23_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); // SSLv3 but can rollback to v2
  SSLv23_server_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); // SSLv3 but can rollback to v2
  SSLv23_client_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); // SSLv3 but can rollback to v2
  TLSv1_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); // TLSv1.0
  TLSv1_server_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); // TLSv1.0
  TLSv1_client_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); // TLSv1.0
  TLSv1_1_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); //TLS1.1
  TLSv1_1_server_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); //TLS1.1
  TLSv1_1_client_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0); //TLS1.1
  TLSv1_2_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);		// TLSv1.2
  TLSv1_2_server_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);	// TLSv1.2 
  TLSv1_2_client_method_removed = (byte(1) shl 8 or byte(1)) shl 8 or byte(0);	// TLSv1.2

//#   define SSL_get_peer_certificate SSL_get1_peer_certificate
{helper_functions}

function IsOpenSSL_SSLv2_Available : Boolean;
  begin
    {$IFNDEF USE_EXTERNAL_LIBRARY}
    Result := Assigned(SSLv2_method) and
      Assigned(SSLv2_server_method) and
      Assigned(SSLv2_client_method);
    {$ELSE}
      Result := false;
    {$ENDIF}
  end;

  function IsOpenSSL_SSLv3_Available : Boolean;
  begin
    {$IFNDEF USE_EXTERNAL_LIBRARY}
    Result := Assigned(SSLv3_method) and
      Assigned(SSLv3_server_method) and
      Assigned(SSLv3_client_method);
    {$ELSE}
      Result := true;
    {$ENDIF}
  end;

  function IsOpenSSL_SSLv23_Available : Boolean;
  begin
  {$IFNDEF USE_EXTERNAL_LIBRARY}
    Result := Assigned(SSLv23_method) and
      Assigned(SSLv23_server_method) and
      Assigned(SSLv23_client_method);
  {$ELSE}
    Result := false;
    {$ENDIF}
  end;

  function IsOpenSSL_TLSv1_0_Available : Boolean;
  begin
    {$IFNDEF USE_EXTERNAL_LIBRARY}
    Result := Assigned(TLSv1_method) and
      Assigned(TLSv1_server_method) and
      Assigned(TLSv1_client_method);
    {$ELSE}
    Result := true;
    {$ENDIF}
  end;

  function IsOpenSSL_TLSv1_1_Available : Boolean;
  begin
    {$IFNDEF USE_EXTERNAL_LIBRARY}
    Result := Assigned(TLSv1_1_method) and
      Assigned(TLSv1_1_server_method) and
      Assigned(TLSv1_1_client_method);
    {$ELSE}
    Result := true;
    {$ENDIF}
  end;

  function IsOpenSSL_TLSv1_2_Available : Boolean;
  begin
     {$IFNDEF USE_EXTERNAL_LIBRARY}
     Result := Assigned(TLSv1_2_method) and
      Assigned(TLSv1_2_server_method) and
      Assigned(TLSv1_2_client_method);
     {$ELSE}
     Result := true;
     {$ENDIF}
  end;

function HasTLS_method: boolean;
begin
  {$IFNDEF USE_EXTERNAL_LIBRARY}
  if Assigned(SSLeay) then
    Result := TLS_method_introduced <= (SSLeay shr 12);
  {$ELSE}
  Result := true;
  {$ENDIF}
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
{/helper_functions}
{$IFNDEF USE_EXTERNAL_LIBRARY}

//#   define SSL_get_peer_certificate SSL_get1_peer_certificate
function _SSL_get_peer_certificate(const s: PSSL): PX509; cdecl;
begin
  Result := SSL_get1_peer_certificate(s);
end;


//# define SSL_CTX_set_mode(ctx,op)      SSL_CTX_ctrl((ctx),SSL_CTRL_MODE,(op),NULL)
function _SSL_CTX_set_mode(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_MODE, op, nil);
end;

//# define SSL_CTX_clear_mode(ctx,op)   SSL_CTX_ctrl((ctx),SSL_CTRL_CLEAR_MODE,(op),NULL)
function _SSL_CTX_clear_mode(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_CLEAR_MODE, op, nil);
end;

//# define SSL_CTX_sess_set_cache_size(ctx,t)         SSL_CTX_ctrl(ctx,SSL_CTRL_SET_SESS_CACHE_SIZE,t,NULL)
function _SSL_CTX_sess_set_cache_size(ctx: PSSL_CTX; t: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_SESS_CACHE_SIZE, t, nil);
end;

//# define SSL_CTX_sess_get_cache_size(ctx)           SSL_CTX_ctrl(ctx,SSL_CTRL_GET_SESS_CACHE_SIZE,0,NULL)
function _SSL_CTX_sess_get_cache_size(ctx: PSSL_CTX): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_GET_SESS_CACHE_SIZE, 0, nil);
end;

//# define SSL_CTX_set_session_cache_mode(ctx,m)      SSL_CTX_ctrl(ctx,SSL_CTRL_SET_SESS_CACHE_MODE,m,NULL)
function _SSL_CTX_set_session_cache_mode(ctx: PSSL_CTX; m: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_SESS_CACHE_MODE, m, nil);
end;

//# define SSL_CTX_get_session_cache_mode(ctx)        SSL_CTX_ctrl(ctx,SSL_CTRL_GET_SESS_CACHE_MODE,0,NULL)
function _SSL_CTX_get_session_cache_mode(ctx: PSSL_CTX): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_GET_SESS_CACHE_MODE, 0, nil);
end;

//# define SSL_num_renegotiations(ssl)                       SSL_ctrl((ssl),SSL_CTRL_GET_NUM_RENEGOTIATIONS,0,NULL)
function _SSL_num_renegotiations(ssl: PSSL): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(ssl, SSL_CTRL_GET_NUM_RENEGOTIATIONS, 0, nil);
end;

//# define SSL_clear_num_renegotiations(ssl)                 SSL_ctrl((ssl),SSL_CTRL_CLEAR_NUM_RENEGOTIATIONS,0,NULL)
function _SSL_clear_num_renegotiations(ssl: PSSL): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(ssl, SSL_CTRL_CLEAR_NUM_RENEGOTIATIONS, 0, nil);
end;

//# define SSL_total_renegotiations(ssl)                     SSL_ctrl((ssl),SSL_CTRL_GET_TOTAL_RENEGOTIATIONS,0,NULL)
function _SSL_total_renegotiations(ssl: PSSL): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(ssl, SSL_CTRL_GET_TOTAL_RENEGOTIATIONS, 0, nil);
end;

//# define SSL_CTX_set_tmp_dh(ctx,dh)                        SSL_CTX_ctrl(ctx,SSL_CTRL_SET_TMP_DH,0,(char *)(dh))
function _SSL_CTX_set_tmp_dh(ctx: PSSL_CTX; dh: PDH): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_TMP_DH, 0, dh);
end;

//# define SSL_CTX_set_tmp_ecdh(ctx,ecdh)                    SSL_CTX_ctrl(ctx,SSL_CTRL_SET_TMP_ECDH,0,(char *)(ecdh))
function _SSL_CTX_set_tmp_ecdh(ctx: PSSL_CTX; ecdh: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_TMP_ECDH, 0, ecdh);
end;

//# define SSL_CTX_set_dh_auto(ctx, onoff)                   SSL_CTX_ctrl(ctx,SSL_CTRL_SET_DH_AUTO,onoff,NULL)
function _SSL_CTX_set_dh_auto(ctx: PSSL_CTX; onoff: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_DH_AUTO, onoff, nil);
end;

//# define SSL_set_dh_auto(s, onoff)                         SSL_ctrl(s,SSL_CTRL_SET_DH_AUTO,onoff,NULL)
function _SSL_set_dh_auto(s: PSSL; onoff: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_DH_AUTO, onoff, nil);
end;

//# define SSL_set_tmp_dh(ssl,dh)                            SSL_ctrl(ssl,SSL_CTRL_SET_TMP_DH,0,(char *)(dh))
function _SSL_set_tmp_dh(ssl: PSSL; dh: PDH): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(ssl, SSL_CTRL_SET_TMP_DH, 0, dh);
end;

//# define SSL_set_tmp_ecdh(ssl,ecdh)                        SSL_ctrl(ssl,SSL_CTRL_SET_TMP_ECDH,0,(char *)(ecdh))
function _SSL_set_tmp_ecdh(ssl: PSSL; ecdh: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(ssl, SSL_CTRL_SET_TMP_ECDH, 0, ecdh);
end;

//# define SSL_CTX_add_extra_chain_cert(ctx,x509)            SSL_CTX_ctrl(ctx,SSL_CTRL_EXTRA_CHAIN_CERT,0,(char *)(x509))
function _SSL_CTX_add_extra_chain_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_EXTRA_CHAIN_CERT, 0, x509);
end;

//# define SSL_CTX_get_extra_chain_certs(ctx,px509)          SSL_CTX_ctrl(ctx,SSL_CTRL_GET_EXTRA_CHAIN_CERTS,0,px509)
function _SSL_CTX_get_extra_chain_certs(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_GET_EXTRA_CHAIN_CERTS, 0, px509);
end;

//# define SSL_CTX_get_extra_chain_certs_only(ctx,px509)     SSL_CTX_ctrl(ctx,SSL_CTRL_GET_EXTRA_CHAIN_CERTS,1,px509)
function _SSL_CTX_get_extra_chain_certs_only(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_GET_EXTRA_CHAIN_CERTS, 1, px509);
end;

//# define SSL_CTX_clear_extra_chain_certs(ctx)              SSL_CTX_ctrl(ctx,SSL_CTRL_CLEAR_EXTRA_CHAIN_CERTS,0,NULL)
function _SSL_CTX_clear_extra_chain_certs(ctx: PSSL_CTX): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_CLEAR_EXTRA_CHAIN_CERTS, 0, nil);
end;

//# define SSL_CTX_set0_chain(ctx,sk)                        SSL_CTX_ctrl(ctx,SSL_CTRL_CHAIN,0,(char *)(sk))
function _SSL_CTX_set0_chain(ctx: PSSL_CTX; sk: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_CHAIN, 0, sk);
end;

//# define SSL_CTX_set1_chain(ctx,sk)                        SSL_CTX_ctrl(ctx,SSL_CTRL_CHAIN,1,(char *)(sk))
function _SSL_CTX_set1_chain(ctx: PSSL_CTX; sk: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_CHAIN, 1, sk);
end;

//# define SSL_CTX_add0_chain_cert(ctx,x509)                 SSL_CTX_ctrl(ctx,SSL_CTRL_CHAIN_CERT,0,(char *)(x509))
function _SSL_CTX_add0_chain_cert(ctx: PSSL_CTX; x509: PX509): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_CHAIN_CERT, 0, x509);
end;

//# define SSL_CTX_add1_chain_cert(ctx,x509)                 SSL_CTX_ctrl(ctx,SSL_CTRL_CHAIN_CERT,1,(char *)(x509))
function _SSL_CTX_add1_chain_cert(ctx: PSSL_CTX; x509: PX509): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_CHAIN_CERT, 1, x509);
end;

//# define SSL_CTX_get0_chain_certs(ctx,px509)               SSL_CTX_ctrl(ctx,SSL_CTRL_GET_CHAIN_CERTS,0,px509)
function _SSL_CTX_get0_chain_certs(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_GET_CHAIN_CERTS, 0, px509);
end;

//# define SSL_CTX_clear_chain_certs(ctx)                    SSL_CTX_set0_chain(ctx,NULL)
function _SSL_CTX_clear_chain_certs(ctx: PSSL_CTX): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_set0_chain(ctx, nil);
end;

//# define SSL_CTX_build_cert_chain(ctx, flags)              SSL_CTX_ctrl(ctx,SSL_CTRL_BUILD_CERT_CHAIN, flags, NULL)
function _SSL_CTX_build_cert_chain(ctx: PSSL_CTX; flags: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_BUILD_CERT_CHAIN, flags, nil);
end;

//# define SSL_CTX_select_current_cert(ctx,x509)             SSL_CTX_ctrl(ctx,SSL_CTRL_SELECT_CURRENT_CERT,0,(char *)(x509))
function _SSL_CTX_select_current_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SELECT_CURRENT_CERT, 0, x509);
end;

//# define SSL_CTX_set_current_cert(ctx, op)                 SSL_CTX_ctrl(ctx,SSL_CTRL_SET_CURRENT_CERT, op, NULL)
function _SSL_CTX_set_current_cert(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_CURRENT_CERT, op, nil);
end;

//# define SSL_CTX_set0_verify_cert_store(ctx,st)            SSL_CTX_ctrl(ctx,SSL_CTRL_SET_VERIFY_CERT_STORE,0,(char *)(st))
function _SSL_CTX_set0_verify_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_VERIFY_CERT_STORE, 0, st);
end;

//# define SSL_CTX_set1_verify_cert_store(ctx,st)            SSL_CTX_ctrl(ctx,SSL_CTRL_SET_VERIFY_CERT_STORE,1,(char *)(st))
function _SSL_CTX_set1_verify_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_VERIFY_CERT_STORE, 1, st);
end;

//# define SSL_CTX_set0_chain_cert_store(ctx,st)             SSL_CTX_ctrl(ctx,SSL_CTRL_SET_CHAIN_CERT_STORE,0,(char *)(st))
function _SSL_CTX_set0_chain_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_CHAIN_CERT_STORE, 0, st);
end;

//# define SSL_CTX_set1_chain_cert_store(ctx,st)             SSL_CTX_ctrl(ctx,SSL_CTRL_SET_CHAIN_CERT_STORE,1,(char *)(st))
function _SSL_CTX_set1_chain_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_CHAIN_CERT_STORE, 1, st);
end;

//# define SSL_set0_chain(s,sk)                              SSL_ctrl(s,SSL_CTRL_CHAIN,0,(char *)(sk))
function _SSL_set0_chain(s: PSSL; sk: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_CHAIN, 0, sk);
end;

//# define SSL_set1_chain(s,sk)                              SSL_ctrl(s,SSL_CTRL_CHAIN,1,(char *)(sk))
function _SSL_set1_chain(s: PSSL; sk: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_CHAIN, 1, sk);
end;

//# define SSL_add0_chain_cert(s,x509)                       SSL_ctrl(s,SSL_CTRL_CHAIN_CERT,0,(char *)(x509))
function _SSL_add0_chain_cert(s: PSSL; x509: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_CHAIN_CERT, 0, x509);
end;

//# define SSL_add1_chain_cert(s,x509)                       SSL_ctrl(s,SSL_CTRL_CHAIN_CERT,1,(char *)(x509))
function _SSL_add1_chain_cert(s: PSSL; x509: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_CHAIN_CERT, 1, x509);
end;

//# define SSL_get0_chain_certs(s,px509)                     SSL_ctrl(s,SSL_CTRL_GET_CHAIN_CERTS,0,px509)
function _SSL_get0_chain_certs(s: PSSL; px509: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_CHAIN_CERTS, 0, px509);
end;

//# define SSL_clear_chain_certs(s)                          SSL_set0_chain(s,NULL)
function _SSL_clear_chain_certs(s: PSSL): TIdC_LONG; cdecl;
begin
  Result := SSL_set0_chain(s, nil);
end;

//# define SSL_build_cert_chain(s, flags)                    SSL_ctrl(s,SSL_CTRL_BUILD_CERT_CHAIN, flags, NULL)
function _SSL_build_cert_chain(s: PSSL; flags: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_BUILD_CERT_CHAIN, flags, nil);
end;

//# define SSL_select_current_cert(s,x509)                   SSL_ctrl(s,SSL_CTRL_SELECT_CURRENT_CERT,0,(char *)(x509))
function _SSL_select_current_cert(s: PSSL; x509: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SELECT_CURRENT_CERT, 0, x509);
end;

//# define SSL_set_current_cert(s,op)                        SSL_ctrl(s,SSL_CTRL_SET_CURRENT_CERT, op, NULL)
function _SSL_set_current_cert(s: PSSL; op: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_CURRENT_CERT, op, nil);
end;

//# define SSL_set0_verify_cert_store(s,st)                  SSL_ctrl(s,SSL_CTRL_SET_VERIFY_CERT_STORE,0,(char *)(st))
function _SSL_set0_verify_cert_store(s: PSSL; st: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_VERIFY_CERT_STORE, 0, st);
end;

//# define SSL_set1_verify_cert_store(s,st)                  SSL_ctrl(s,SSL_CTRL_SET_VERIFY_CERT_STORE,1,(char *)(st))
function _SSL_set1_verify_cert_store(s: PSSL; st: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_VERIFY_CERT_STORE, 1, st);
end;

//# define SSL_set0_chain_cert_store(s,st)                   SSL_ctrl(s,SSL_CTRL_SET_CHAIN_CERT_STORE,0,(char *)(st))
function _SSL_set0_chain_cert_store(s: PSSL; st: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_CHAIN_CERT_STORE, 0, st);
end;

//# define SSL_set1_chain_cert_store(s,st)                   SSL_ctrl(s,SSL_CTRL_SET_CHAIN_CERT_STORE,1,(char *)(st))
function _SSL_set1_chain_cert_store(s: PSSL; st: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_CHAIN_CERT_STORE, 1, st);
end;

//# define SSL_get1_groups(s, glist)                         SSL_ctrl(s,SSL_CTRL_GET_GROUPS,0,(TIdC_INT*)(glist))
function _SSL_get1_groups(s: PSSL; glist: PIdC_INT): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_GROUPS, 0, glist);
end;

//# define SSL_CTX_set1_groups(ctx, glist, glistlen)         SSL_CTX_ctrl(ctx,SSL_CTRL_SET_GROUPS,glistlen,(char *)(glist))
function _SSL_CTX_set1_groups(ctx: PSSL_CTX; glist: PByte; glistlen: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_GROUPS, glistlen, glist);
end;

//# define SSL_CTX_set1_groups_list(ctx, s)                  SSL_CTX_ctrl(ctx,SSL_CTRL_SET_GROUPS_LIST,0,(char *)(s))
function _SSL_CTX_set1_groups_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_GROUPS_LIST, 0, s);
end;

//# define SSL_set1_groups(s, glist, glistlen)               SSL_ctrl(s,SSL_CTRL_SET_GROUPS,glistlen,(char *)(glist))
function _SSL_set1_groups(s: PSSL; glist: PByte; glistlen: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_GROUPS, glistlen, glist);
end;

//# define SSL_set1_groups_list(s, str)                      SSL_ctrl(s,SSL_CTRL_SET_GROUPS_LIST,0,(char *)(str))
function _SSL_set1_groups_list(s: PSSL; str: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_GROUPS_LIST, 0, str);
end;

//# define SSL_get_shared_group(s, n)                        SSL_ctrl(s,SSL_CTRL_GET_SHARED_GROUP,n,NULL)
function _SSL_get_shared_group(s: PSSL; n: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_SHARED_GROUP, n, nil);
end;

//# define SSL_CTX_set1_sigalgs(ctx, slist, slistlen)        SSL_CTX_ctrl(ctx,SSL_CTRL_SET_SIGALGS,slistlen,(TIdC_INT *)(slist))
function _SSL_CTX_set1_sigalgs(ctx: PSSL_CTX; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_SIGALGS, slistlen, slist);
end;

//# define SSL_CTX_set1_sigalgs_list(ctx, s)                 SSL_CTX_ctrl(ctx,SSL_CTRL_SET_SIGALGS_LIST,0,(char *)(s))
function _SSL_CTX_set1_sigalgs_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_SIGALGS_LIST, 0, s);
end;

//# define SSL_set1_sigalgs(s, slist, slistlen)              SSL_ctrl(s,SSL_CTRL_SET_SIGALGS,slistlen,(TIdC_INT *)(slist))
function _SSL_set1_sigalgs(s: PSSL; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_SIGALGS, slistlen, slist);
end;

//# define SSL_set1_sigalgs_list(s, str)                     SSL_ctrl(s,SSL_CTRL_SET_SIGALGS_LIST,0,(char *)(str))
function _SSL_set1_sigalgs_list(s: PSSL; str: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_SIGALGS_LIST, 0, str);
end;

//# define SSL_CTX_set1_client_sigalgs(ctx, slist, slistlen) SSL_CTX_ctrl(ctx,SSL_CTRL_SET_CLIENT_SIGALGS,slistlen,(TIdC_INT *)(slist))
function _SSL_CTX_set1_client_sigalgs(ctx: PSSL_CTX; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_CLIENT_SIGALGS, slistlen, slist);
end;

//# define SSL_CTX_set1_client_sigalgs_list(ctx, s)          SSL_CTX_ctrl(ctx,SSL_CTRL_SET_CLIENT_SIGALGS_LIST,0,(char *)(s))
function _SSL_CTX_set1_client_sigalgs_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_CLIENT_SIGALGS_LIST, 0, s);
end;

//# define SSL_set1_client_sigalgs(s, slist, slistlen)       SSL_ctrl(s,SSL_CTRL_SET_CLIENT_SIGALGS,slistlen,(TIdC_INT *)(slist))
function _SSL_set1_client_sigalgs(s: PSSL; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_CLIENT_SIGALGS, slistlen, slist);
end;

//# define SSL_set1_client_sigalgs_list(s, str)              SSL_ctrl(s,SSL_CTRL_SET_CLIENT_SIGALGS_LIST,0,(char *)(str))
function _SSL_set1_client_sigalgs_list(s: PSSL; str: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_CLIENT_SIGALGS_LIST, 0, str);
end;

//# define SSL_get0_certificate_types(s, clist)              SSL_ctrl(s, SSL_CTRL_GET_CLIENT_CERT_TYPES, 0, (char *)(clist))
function _SSL_get0_certificate_types(s: PSSL; clist: PByte): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_CLIENT_CERT_TYPES, 0, clist);
end;

//# define SSL_CTX_set1_client_certificate_types(ctx, clist, clistlen)   SSL_CTX_ctrl(ctx,SSL_CTRL_SET_CLIENT_CERT_TYPES,clistlen, (char *)(clist))
function _SSL_CTX_set1_client_certificate_types(ctx: PSSL_CTX; clist: PByte; clistlen: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_SET_CLIENT_CERT_TYPES, clistlen, clist);
end;

//# define SSL_set1_client_certificate_types(s, clist, clistlen)         SSL_ctrl(s,SSL_CTRL_SET_CLIENT_CERT_TYPES,clistlen,(char *)(clist))
function _SSL_set1_client_certificate_types(s: PSSL; clist: PByte; clistlen: TIdC_LONG): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_SET_CLIENT_CERT_TYPES, clistlen, clist);
end;

//# define SSL_get_signature_nid(s, pn)                      SSL_ctrl(s,SSL_CTRL_GET_SIGNATURE_NID,0,pn)
function _SSL_get_signature_nid(s: PSSL; pn: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_SIGNATURE_NID, 0, pn);
end;

//# define SSL_get_peer_signature_nid(s, pn)                 SSL_ctrl(s,SSL_CTRL_GET_PEER_SIGNATURE_NID,0,pn)
function _SSL_get_peer_signature_nid(s: PSSL; pn: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_PEER_SIGNATURE_NID, 0, pn);
end;

//# define SSL_get_peer_tmp_key(s, pk)                       SSL_ctrl(s,SSL_CTRL_GET_PEER_TMP_KEY,0,pk)
function _SSL_get_peer_tmp_key(s: PSSL; pk: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_PEER_TMP_KEY, 0, pk);
end;

//# define SSL_get_tmp_key(s, pk)                            SSL_ctrl(s,SSL_CTRL_GET_TMP_KEY,0,pk)
function _SSL_get_tmp_key(s: PSSL; pk: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_TMP_KEY, 0, pk);
end;

//# define SSL_get0_raw_cipherlist(s, plst)                  SSL_ctrl(s,SSL_CTRL_GET_RAW_CIPHERLIST,0,plst)
function _SSL_get0_raw_cipherlist(s: PSSL; plst: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_RAW_CIPHERLIST, 0, plst);
end;

//# define SSL_get0_ec_point_formats(s, plst)                SSL_ctrl(s,SSL_CTRL_GET_EC_POINT_FORMATS,0,plst)
function _SSL_get0_ec_point_formats(s: PSSL; plst: Pointer): TIdC_LONG; cdecl;
begin
  Result := SSL_ctrl(s, SSL_CTRL_GET_EC_POINT_FORMATS, 0, plst);
end;


function _SSL_get_app_data(const ssl: PSSL): Pointer ; cdecl;
begin
  Result := SSL_get_ex_data(ssl,0);
end;

procedure _SSL_load_error_strings; cdecl; 
begin
  OPENSSL_init_ssl(OPENSSL_INIT_LOAD_SSL_STRINGS or OPENSSL_INIT_LOAD_CRYPTO_STRINGS,nil); 
end;

function _SSL_library_init: TIdC_INT; cdecl;
begin
  Result := OPENSSL_init_ssl(0, nil);
end;

function _SSLeay_add_ssl_algorithms: TIdC_INT; cdecl;
begin
  Result := SSL_library_init;
end;

function _SSL_set_app_data(ssl: PSSL; data: Pointer): TIdC_INT; cdecl;
begin
  Result := SSL_set_ex_data(ssl,0,data);
end;


{forward_compatibility}

type
  PSTACK_OF_SSL_CIPHER = pointer;
  Plash_of_SSL_SESSION = pointer;
  SSL_CTX_stats = record
    sess_connect: TIdC_INT;  // SSL new conn - started
    sess_connect_renegotiate: TIdC_INT;  // SSL reneg - requested
    sess_connect_good: TIdC_INT; // SSL new conne/reneg - finished
    sess_accept: TIdC_INT;    // SSL new accept - started
    sess_accept_renegotiate: TIdC_INT; // SSL reneg - requested
    sess_accept_good: TIdC_INT;  // SSL accept/reneg - finished
    sess_miss: TIdC_INT;  // session lookup misses
    sess_timeout: TIdC_INT; // reuse attempt on timeouted session
    sess_cache_full: TIdC_INT; // session removed due to full cache
    sess_hit: TIdC_INT; // session reuse actually done
    sess_cb_hit: TIdC_INT; // session-id that was not
                          // in the cache was
                          // passed back via the callback.  This
                          // indicates that the application is
                          // supplying session-id's from other
                          // processes - spooky :-)
  end;
  PSTACK_OF_COMP = pointer;
  PSSL_CTX_info_callback = pointer;
  PX509_VERIFY_PARAM = pointer;
  PCERT = pointer;
  size_t = type integer;
  PGEN_SESSION_CB = pointer;
  PSSL_CTEX_tlsext_servername_callback = pointer;
  Ptlsext_status_cb = pointer;
  Ptlsext_ticket_key_cb = pointer;
  Pssl3_buf_freelist_st = pointer;
  PSRP_CTX = ^SRP_CTX;
  SRP_CTX = record
	//* param for all the callbacks */
	  SRP_cb_arg : Pointer;
	//* set client Hello login callback */
    TLS_ext_srp_username_callback : function(para1 : PSSL; para2 : TIdC_INT; para3 : Pointer) : TIdC_INT cdecl;
	//int (*TLS_ext_srp_username_callback)(SSL *, int *, void *);
	//* set SRP N/g param callback for verification */
    SRP_verify_param_callback : function(para1 : PSSL; para2 : Pointer) : TIdC_INT cdecl;
//	int (*SRP_verify_param_callback)(SSL *, void *);
	//* set SRP client passwd callback */
    SRP_give_srp_client_pwd_callback : function(para1 : PSSL; para2 : Pointer) : PIdAnsiChar cdecl;
  //	char *(*SRP_give_srp_client_pwd_callback)(SSL *, void *);
    login : PIdAnsiChar;
   	N, g, s, B, A : PBIGNUM;
   	_a, _b, v : PBIGNUM;
	  info : PIdAnsiChar;
	  strength : TIdC_INT;
    srp_Mask : TIdC_ULONG;
	end;
  PSTACK_OF_SRTP_PROTECTION_PROFILE = pointer;

  _PSSL_CTX = ^SSL_CTX;
  SSL_CTX = record
    method: PSSL_METHOD;
    cipher_list: PSTACK_OF_SSL_CIPHER;
    // same as above but sorted for lookup
    cipher_list_by_id: PSTACK_OF_SSL_CIPHER;
    cert_store: PX509_STORE;
    sessions: Plash_of_SSL_SESSION;
    // a set of SSL_SESSIONs
    // Most session-ids that will be cached, default is
    // SSL_SESSION_CACHE_MAX_SIZE_DEFAULT. 0 is unlimited.
    session_cache_size: TIdC_ULONG;
    session_cache_head: PSSL_SESSION;
    session_cache_tail: PSSL_SESSION;
    // This can have one of 2 values, ored together,
    // SSL_SESS_CACHE_CLIENT,
    // SSL_SESS_CACHE_SERVER,
    // Default is SSL_SESSION_CACHE_SERVER, which means only
    // SSL_accept which cache SSL_SESSIONS.
    session_cache_mode: TIdC_INT;
    session_timeout: TIdC_LONG;
    // If this callback is not null, it will be called each
    // time a session id is added to the cache.  If this function
    // returns 1, it means that the callback will do a
    // SSL_SESSION_free() when it has finished using it.  Otherwise,
    // on 0, it means the callback has finished with it.
    // If remove_session_cb is not null, it will be called when
    // a session-id is removed from the cache.  After the call,
    // OpenSSL will SSL_SESSION_free() it.
    new_session_cb: function (ssl : PSSL; sess: PSSL_SESSION): TIdC_INT; cdecl;
    remove_session_cb: procedure (ctx : PSSL_CTX; sess : PSSL_SESSION); cdecl;
    get_session_cb: function (ssl : PSSL; data : PByte; len: TIdC_INT; copy : PIdC_INT) : PSSL_SESSION; cdecl;
    stats : SSL_CTX_stats;

    references: TIdC_INT;
    // if defined, these override the X509_verify_cert() calls
    app_verify_callback: function (_para1 : PX509_STORE_CTX; _para2 : Pointer) : TIdC_INT; cdecl;
    app_verify_arg: Pointer;
    // before OpenSSL 0.9.7, 'app_verify_arg' was ignored
    // ('app_verify_callback' was called with just one argument)
    // Default password callback.
    default_passwd_callback: pem_password_cb;
    // Default password callback user data.
    default_passwd_callback_userdata: Pointer;
    // get client cert callback
    client_cert_cb: function (SSL : PSSL; x509 : PPX509; pkey : PPEVP_PKEY) : TIdC_INT; cdecl;
    // verify cookie callback
    app_gen_cookie_cb: function (ssl : PSSL; cookie : PByte; cookie_len : TIdC_UINT) : TIdC_INT; cdecl;
    app_verify_cookie_cb: Pointer;
    ex_data : CRYPTO_EX_DATA;
    rsa_md5 : PEVP_MD; // For SSLv2 - name is 'ssl2-md5'
    md5: PEVP_MD; // For SSLv3/TLSv1 'ssl3-md5'
    sha1: PEVP_MD; // For SSLv3/TLSv1 'ssl3->sha1'
    extra_certs: PSTACK_OF_X509;
    comp_methods: PSTACK_OF_COMP; // stack of SSL_COMP, SSLv3/TLSv1
    // Default values used when no per-SSL value is defined follow
    info_callback: PSSL_CTX_info_callback; // used if SSL's info_callback is NULL
    // what we put in client cert requests
    client_CA : PSTACK_OF_X509_NAME;
    // Default values to use in SSL structures follow (these are copied by SSL_new)
    options : TIdC_ULONG;
    mode : TIdC_ULONG;
    max_cert_list : TIdC_LONG;
    cert : PCERT;
    read_ahead : TIdC_INT;
    // callback that allows applications to peek at protocol messages
    msg_callback : procedure (write_p, version, content_type : TIdC_INT; const buf : Pointer; len : size_t; ssl : PSSL; arg : Pointer); cdecl;
    msg_callback_arg : Pointer;
    verify_mode : TIdC_INT;
    sid_ctx_length : TIdC_UINT;
    sid_ctx : array[0..SSL_MAX_SID_CTX_LENGTH - 1] of TIdAnsiChar;
    default_verify_callback : function(ok : TIdC_INT; ctx : PX509_STORE_CTX) : TIdC_INT; cdecl; // called 'verify_callback' in the SSL
    // Default generate session ID callback.
    generate_session_id : PGEN_SESSION_CB;
    param : PX509_VERIFY_PARAM;
    {$IFDEF OMIT_THIS}
    purpose : TIdC_INT;  // Purpose setting
    trust : TIdC_INT;    // Trust setting
    {$ENDIF}

    quiet_shutdown : TIdC_INT;
	//* Maximum amount of data to send in one fragment.
	// * actual record size can be more than this due to
	// * padding and MAC overheads.
	// */
	  max_send_fragment : TIdC_UINT;
    {$IFNDEF OPENSSL_ENGINE}
	///* Engine to pass requests for client certs to
	// */
	  client_cert_engine : PENGINE;
    {$ENDIF}
    {$IFNDEF OPENSSL_NO_TLSEXT}
//* TLS extensions servername callback */
    tlsext_servername_callback : PSSL_CTEX_tlsext_servername_callback;
    tlsext_servername_arg : Pointer;
    //* RFC 4507 session ticket keys */
    tlsext_tick_key_name : array [0..(16-1)] of TIdAnsiChar;
    tlsext_tick_hmac_key : array [0..(16-1)] of TIdAnsiChar;
    tlsext_tick_aes_key : array [0..(16-1)] of TIdAnsiChar;
	//* Callback to support customisation of ticket key setting */
 //	int (*tlsext_ticket_key_cb)(SSL *ssl,
 //					unsigned char *name, unsigned char *iv,
 //					EVP_CIPHER_CTX *ectx,
 //					HMAC_CTX *hctx, int enc);
    tlsext_ticket_key_cb : Ptlsext_ticket_key_cb;
	//* certificate status request info */
	//* Callback for status request */
	//int (*tlsext_status_cb)(SSL *ssl, void *arg);
    tlsext_status_cb : Ptlsext_status_cb;
	  tlsext_status_arg : Pointer;
    {$ENDIF}
	//* draft-rescorla-tls-opaque-prf-input-00.txt information */
     tlsext_opaque_prf_input_callback : function(para1 : PSSL; peerinput : Pointer; len : size_t; arg : Pointer ) : TIdC_INT cdecl;
	//int (*tlsext_opaque_prf_input_callback)(SSL *, void *peerinput, size_t len, void *arg);
     tlsext_opaque_prf_input_callback_arg : Pointer;

{$ifndef OPENSSL_NO_PSK}
	   psk_identity_hint : PIdAnsiChar;
     psk_client_callback : function (ssl : PSSL; hint : PIdAnsiChar;
       identity : PIdAnsiChar; max_identity_len : TIdC_UINT;
       psk : PIdAnsiChar; max_psk_len : TIdC_UINT ) : TIdC_UINT cdecl;
 //	unsigned int (*psk_client_callback)(SSL *ssl, const char *hint, char *identity,
//		unsigned int max_identity_len, unsigned char *psk,
//		unsigned int max_psk_len);
     psk_server_callback : function (ssl : PSSL; identity, psk : PIdAnsiChar; max_psk_len : TIdC_UINT) : TIdC_UINT cdecl;
//	unsigned int (*psk_server_callback)(SSL *ssl, const char *identity,
//		unsigned char *psk, unsigned int max_psk_len);
{$endif}

{$ifndef OPENSSL_NO_BUF_FREELISTS}
	  freelist_max_len : TIdC_UINT;
	  wbuf_freelist : Pssl3_buf_freelist_st;
	  rbuf_freelist : Pssl3_buf_freelist_st;
{$endif}
{$ifndef OPENSSL_NO_SRP}
	  srp_ctx : SRP_CTX; //* ctx for SRP authentication */
{$endif}

{$ifndef OPENSSL_NO_TLSEXT}
//# ifndef OPENSSL_NO_NEXTPROTONEG
	//* Next protocol negotiation information */
	//* (for experimental NPN extension). */

	//* For a server, this contains a callback function by which the set of
	// * advertised protocols can be provided. */
    next_protos_advertised_cb : function(s : PSSL; out but : PIdAnsiChar;
     out len : TIdC_UINT; arg : Pointer) : TIdC_INT cdecl;
//	int (*next_protos_advertised_cb)(SSL *s, const unsigned char **buf,
//			                 unsigned int *len, void *arg);
	  next_protos_advertised_cb_arg : Pointer;
	//* For a client, this contains a callback function that selects the
	// * next protocol from the list provided by the server. */
    next_proto_select_cb : function(s : PSSL; out _out : PIdAnsiChar;
      outlen : PIdAnsiChar;
      _in : PIdAnsiChar;
      inlen : TIdC_UINT;
      arg : Pointer) : TIdC_INT cdecl;
//	int (*next_proto_select_cb)(SSL *s, unsigned char **out,
//				    unsigned char *outlen,
//				    const unsigned char *in,
//				    unsigned int inlen,
//				    void *arg);
	  next_proto_select_cb_arg : Pointer;
//# endif
        //* SRTP profiles we are willing to do from RFC 5764 */
      srtp_profiles : PSTACK_OF_SRTP_PROTECTION_PROFILE;
{$endif}
  end;

const
  SSL_CTRL_OPTIONS = 32;
  SSL_CTRL_CLEAR_OPTIONS = 77;

function FC_SSL_CTX_get_default_passwd_cb(ctx: PSSL_CTX): pem_password_cb; cdecl;
begin
  Result := _PSSL_CTX(ctx)^.default_passwd_callback;
end;

function FC_SSL_CTX_get_default_passwd_cb_userdata(ctx: PSSL_CTX): Pointer; cdecl;
begin
  Result := _PSSL_CTX(ctx)^.default_passwd_callback_userdata;
end;

procedure FC_SSL_CTX_set_default_passwd_cb(ctx: PSSL_CTX; cb: pem_password_cb); cdecl;
begin
  _PSSL_CTX(ctx)^.default_passwd_callback := cb;
end;

procedure FC_SSL_CTX_set_default_passwd_cb_userdata(ctx: PSSL_CTX; u: Pointer); cdecl;
begin
  _PSSL_CTX(ctx)^.default_passwd_callback_userdata := u;
end;

//* Note: SSL[_CTX]_set_{options,mode} use |= op on the previous value,
// * they cannot be used to clear bits. */

function FC_SSL_CTX_set_options(ctx: PSSL_CTX; op: TIdC_LONG):TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_OPTIONS, op, nil);
end;

function FC_SSL_CTX_clear_options(ctx : PSSL_CTX; op : TIdC_LONG):TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx,SSL_CTRL_CLEAR_OPTIONS,op,nil);
end;

function FC_SSL_CTX_get_options(ctx: PSSL_CTX) : TIdC_LONG; cdecl;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_OPTIONS,0,nil);
end;

function FC_SSL_CTX_get_cert_store(const ctx: PSSL_CTX): PX509_STORE; cdecl;
begin
  Result :=  _PSSL_CTX(ctx)^.cert_store;
end;

const
  SSL_MAX_KRB5_PRINCIPAL_LENGTH = 256;

type
   PSESS_CERT = pointer;
  _PSSL_SESSION = ^_SSL_SESSION;
  _SSL_SESSION = record
    ssl_version : TIdC_INT; // what ssl version session info is being kept in here?
    // only really used in SSLv2
    key_arg_length: TIdC_UINT;
    key_arg: Array[0..SSL_MAX_KEY_ARG_LENGTH-1] of Byte;
    master_key_length: TIdC_INT;
    master_key: Array[0..SSL_MAX_MASTER_KEY_LENGTH-1] of Byte;
    // session_id - valid?
    session_id_length: TIdC_UINT;
    session_id: Array[0..SSL_MAX_SSL_SESSION_ID_LENGTH-1] of Byte;
    // this is used to determine whether the session is being reused in
    // the appropriate context. It is up to the application to set this,
    // via SSL_new
    sid_ctx_length: TIdC_UINT;
    sid_ctx: array[0..SSL_MAX_SID_CTX_LENGTH-1] of Byte;
    {$IFNDEF OPENSSL_NO_KRB5}
    krb5_client_princ_len: TIdC_UINT;
    krb5_client_princ: array[0..SSL_MAX_KRB5_PRINCIPAL_LENGTH-1] of Byte;
    {$ENDIF}
{$ifndef OPENSSL_NO_PSK}
	  psk_identity_hint : PIdAnsiChar;
	  psk_identity : PIdAnsiChar;
{$endif}
    not_resumable: TIdC_INT;
    // The cert is the certificate used to establish this connection
    sess_cert :  PSESS_CERT;

	//* This is the cert for the other end.
	// * On clients, it will be the same as sess_cert->peer_key->x509
	// * (the latter is not enough as sess_cert is not retained
	// * in the external representation of sessions, see ssl_asn1.c). */
	  peer : PX509;
	//* when app_verify_callback accepts a session where the peer's certificate
	// * is not ok, we must remember the error for session reuse: */
	  verify_result : TIdC_LONG; //* only for servers */
	  references : TIdC_INT;
	  timeout : TIdC_LONG;
	  time : TIdC_LONG;
	  compress_meth : TIdC_UINT;	//* Need to lookup the method */

	  cipher : PSSL_CIPHER;
	  cipher_id : TIdC_ULONG;	//* when ASN.1 loaded, this
					// * needs to be used to load
					// * the 'cipher' structure */
    ciphers : PSTACK_OF_SSL_CIPHER; //* shared ciphers? */
    ex_data : CRYPTO_EX_DATA; // application specific data */
	//* These are used to make removal of session-ids more
	// * efficient and to implement a maximum cache size. */
	  prev, next : PSSL_SESSION;

    {$IFNDEF OPENSSL_NO_TLSEXT}
    tlsext_hostname : PIdAnsiChar;
      {$IFDEF OPENSSL_NO_EC}
	  tlsext_ecpointformatlist_length : size_t;
	  tlsext_ecpointformatlist : PIdAnsiChar; //* peer's list */
	  tlsext_ellipticcurvelist_length : size_t;
	  tlsext_ellipticcurvelist : PIdAnsiChar; //* peer's list */
      {$ENDIF} //* OPENSSL_NO_EC */

 //* RFC4507 info */
    tlsext_tick : PIdAnsiChar;//* Session ticket */
    tlsext_ticklen : size_t;//* Session ticket length */
    tlsext_tick_lifetime_hint : TIdC_LONG;//* Session lifetime hint in seconds */
    {$ENDIF}
{$ifndef OPENSSL_NO_SRP}
	  srp_username : PIdAnsiChar;
{$endif}
  end;

function FC_SSL_SESSION_get_protocol_version(const s: PSSL_SESSION): TIdC_INT; cdecl;
begin
  Result := _PSSL_SESSION(s).ssl_version;
end;

function FC_OPENSSL_init_ssl(opts: TIdC_UINT64; const settings: POPENSSL_INIT_SETTINGS): TIdC_INT; cdecl;
begin
  if opts and OPENSSL_INIT_LOAD_SSL_STRINGS <> 0 then
    SSL_load_error_strings;
  SSL_library_init;
  Result := OPENSSL_init_crypto(opts,settings);
end;

{/forward_compatibility}
{$WARN  NO_RETVAL OFF}
function ERR_SSL_CTX_set_mode(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_mode');
end;


function ERR_SSL_CTX_clear_mode(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_clear_mode');
end;


function ERR_SSL_CTX_sess_set_cache_size(ctx: PSSL_CTX; t: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_sess_set_cache_size');
end;


function ERR_SSL_CTX_sess_get_cache_size(ctx: PSSL_CTX): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_sess_get_cache_size');
end;


function ERR_SSL_CTX_set_session_cache_mode(ctx: PSSL_CTX; m: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_session_cache_mode');
end;


function ERR_SSL_CTX_get_session_cache_mode(ctx: PSSL_CTX): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get_session_cache_mode');
end;


function ERR_SSL_clear_num_renegotiations(ssl: PSSL): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_clear_num_renegotiations');
end;


function ERR_SSL_total_renegotiations(ssl: PSSL): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_total_renegotiations');
end;


function ERR_SSL_CTX_set_tmp_dh(ctx: PSSL_CTX; dh: PDH): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_tmp_dh');
end;


function ERR_SSL_CTX_set_tmp_ecdh(ctx: PSSL_CTX; ecdh: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_tmp_ecdh');
end;


function ERR_SSL_CTX_set_dh_auto(ctx: PSSL_CTX; onoff: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_dh_auto');
end;


function ERR_SSL_set_dh_auto(s: PSSL; onoff: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_dh_auto');
end;


function ERR_SSL_set_tmp_dh(ssl: PSSL; dh: PDH): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_tmp_dh');
end;


function ERR_SSL_set_tmp_ecdh(ssl: PSSL; ecdh: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_tmp_ecdh');
end;


function ERR_SSL_CTX_add_extra_chain_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_add_extra_chain_cert');
end;


function ERR_SSL_CTX_get_extra_chain_certs(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get_extra_chain_certs');
end;


function ERR_SSL_CTX_get_extra_chain_certs_only(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get_extra_chain_certs_only');
end;


function ERR_SSL_CTX_clear_extra_chain_certs(ctx: PSSL_CTX): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_clear_extra_chain_certs');
end;


function ERR_SSL_CTX_set0_chain(ctx: PSSL_CTX; sk: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set0_chain');
end;


function ERR_SSL_CTX_set1_chain(ctx: PSSL_CTX; sk: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set1_chain');
end;


function ERR_SSL_CTX_add0_chain_cert(ctx: PSSL_CTX; x509: PX509): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_add0_chain_cert');
end;


function ERR_SSL_CTX_add1_chain_cert(ctx: PSSL_CTX; x509: PX509): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_add1_chain_cert');
end;


function ERR_SSL_CTX_get0_chain_certs(ctx: PSSL_CTX; px509: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get0_chain_certs');
end;


function ERR_SSL_CTX_clear_chain_certs(ctx: PSSL_CTX): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_clear_chain_certs');
end;


function ERR_SSL_CTX_build_cert_chain(ctx: PSSL_CTX; flags: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_build_cert_chain');
end;


function ERR_SSL_CTX_select_current_cert(ctx: PSSL_CTX; x509: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_select_current_cert');
end;


function ERR_SSL_CTX_set_current_cert(ctx: PSSL_CTX; op: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_current_cert');
end;


function ERR_SSL_CTX_set0_verify_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set0_verify_cert_store');
end;


function ERR_SSL_CTX_set1_verify_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set1_verify_cert_store');
end;


function ERR_SSL_CTX_set0_chain_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set0_chain_cert_store');
end;


function ERR_SSL_CTX_set1_chain_cert_store(ctx: PSSL_CTX; st: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set1_chain_cert_store');
end;


function ERR_SSL_set0_chain(s: PSSL; sk: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set0_chain');
end;


function ERR_SSL_set1_chain(s: PSSL; sk: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set1_chain');
end;


function ERR_SSL_add0_chain_cert(s: PSSL; x509: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_add0_chain_cert');
end;


function ERR_SSL_add1_chain_cert(s: PSSL; x509: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_add1_chain_cert');
end;


function ERR_SSL_get0_chain_certs(s: PSSL; px509: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get0_chain_certs');
end;


function ERR_SSL_clear_chain_certs(s: PSSL): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_clear_chain_certs');
end;


function ERR_SSL_build_cert_chain(s: PSSL; flags: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_build_cert_chain');
end;


function ERR_SSL_select_current_cert(s: PSSL; x509: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_select_current_cert');
end;


function ERR_SSL_set_current_cert(s: PSSL; op: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_current_cert');
end;


function ERR_SSL_set0_verify_cert_store(s: PSSL; st: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set0_verify_cert_store');
end;


function ERR_SSL_set1_verify_cert_store(s: PSSL; st: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set1_verify_cert_store');
end;


function ERR_SSL_set0_chain_cert_store(s: PSSL; st: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set0_chain_cert_store');
end;


function ERR_SSL_set1_chain_cert_store(s: PSSL; st: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set1_chain_cert_store');
end;


function ERR_SSL_get1_groups(s: PSSL; glist: PIdC_INT): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get1_groups');
end;


function ERR_SSL_CTX_set1_groups(ctx: PSSL_CTX; glist: PByte; glistlen: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set1_groups');
end;


function ERR_SSL_CTX_set1_groups_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set1_groups_list');
end;


function ERR_SSL_set1_groups(s: PSSL; glist: PByte; glistlen: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set1_groups');
end;


function ERR_SSL_set1_groups_list(s: PSSL; str: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set1_groups_list');
end;


function ERR_SSL_get_shared_group(s: PSSL; n: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_shared_group');
end;


function ERR_SSL_CTX_set1_sigalgs(ctx: PSSL_CTX; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set1_sigalgs');
end;


function ERR_SSL_CTX_set1_sigalgs_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set1_sigalgs_list');
end;


function ERR_SSL_set1_sigalgs(s: PSSL; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set1_sigalgs');
end;


function ERR_SSL_set1_sigalgs_list(s: PSSL; str: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set1_sigalgs_list');
end;


function ERR_SSL_CTX_set1_client_sigalgs(ctx: PSSL_CTX; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set1_client_sigalgs');
end;


function ERR_SSL_CTX_set1_client_sigalgs_list(ctx: PSSL_CTX; s: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set1_client_sigalgs_list');
end;


function ERR_SSL_set1_client_sigalgs(s: PSSL; slist: PIdC_INT; slistlen: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set1_client_sigalgs');
end;


function ERR_SSL_set1_client_sigalgs_list(s: PSSL; str: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set1_client_sigalgs_list');
end;


function ERR_SSL_get0_certificate_types(s: PSSL; clist: PByte): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get0_certificate_types');
end;


function ERR_SSL_CTX_set1_client_certificate_types(ctx: PSSL_CTX; clist: PByte; clistlen: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set1_client_certificate_types');
end;


function ERR_SSL_set1_client_certificate_types(s: PSSL; clist: PByte; clistlen: TIdC_LONG): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set1_client_certificate_types');
end;


function ERR_SSL_get_signature_nid(s: PSSL; pn: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_signature_nid');
end;


function ERR_SSL_get_peer_signature_nid(s: PSSL; pn: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_peer_signature_nid');
end;


function ERR_SSL_get_peer_tmp_key(s: PSSL; pk: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_peer_tmp_key');
end;


function ERR_SSL_get_tmp_key(s: PSSL; pk: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_tmp_key');
end;


function ERR_SSL_get0_raw_cipherlist(s: PSSL; plst: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get0_raw_cipherlist');
end;


function ERR_SSL_get0_ec_point_formats(s: PSSL; plst: Pointer): TIdC_LONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get0_ec_point_formats');
end;


function ERR_SSL_CTX_get_options(const ctx: PSSL_CTX): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get_options');
end;


function ERR_SSL_get_options(const s: PSSL): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_options');
end;


function ERR_SSL_CTX_clear_options(ctx: PSSL_CTX; op: TIdC_ULONG): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_clear_options');
end;


function ERR_SSL_clear_options(s: PSSL; op: TIdC_ULONG): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_clear_options');
end;


function ERR_SSL_CTX_set_options(ctx: PSSL_CTX; op: TIdC_ULONG): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_options');
end;


function ERR_SSL_set_options(s: PSSL; op: TIdC_ULONG): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_options');
end;


procedure ERR_SSL_CTX_set_stateless_cookie_generate_cb(ctx: PSSL_CTX; gen_stateless_cookie_cb: SSL_CTX_set_stateless_cookie_generate_cb_gen_stateless_cookie_cb); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_stateless_cookie_generate_cb');
end;


procedure ERR_SSL_CTX_set_stateless_cookie_verify_cb(ctx: PSSL_CTX; verify_stateless_cookie_cb: SSL_CTX_set_stateless_cookie_verify_cb_verify_stateless_cookie_cb); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_stateless_cookie_verify_cb');
end;


procedure ERR_SSL_set_psk_find_session_callback(s: PSSL; cb: SSL_psk_find_session_cb_func); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_psk_find_session_callback');
end;


procedure ERR_SSL_CTX_set_psk_find_session_callback(ctx: PSSL_CTX; cb: SSL_psk_find_session_cb_func); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_psk_find_session_callback');
end;


procedure ERR_SSL_set_psk_use_session_callback(s: PSSL; cb: SSL_psk_use_session_cb_func); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_psk_use_session_callback');
end;


procedure ERR_SSL_CTX_set_psk_use_session_callback(ctx: PSSL_CTX; cb: SSL_psk_use_session_cb_func); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_psk_use_session_callback');
end;


procedure ERR_SSL_CTX_set_keylog_callback(ctx: PSSL_CTX; cb: SSL_CTX_keylog_cb_func); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_keylog_callback');
end;


function ERR_SSL_CTX_get_keylog_callback(const ctx: PSSL_CTX): SSL_CTX_keylog_cb_func; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get_keylog_callback');
end;


function ERR_SSL_CTX_set_max_early_data(ctx: PSSL_CTX; max_early_data: TIdC_UINT32): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_max_early_data');
end;


function ERR_SSL_CTX_get_max_early_data(const ctx: PSSL_CTX): TIdC_UINT32; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get_max_early_data');
end;


function ERR_SSL_set_max_early_data(s: PSSL; max_early_data: TIdC_UINT32): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_max_early_data');
end;


function ERR_SSL_get_max_early_data(const s: PSSL): TIdC_UINT32; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_max_early_data');
end;


function ERR_SSL_CTX_set_recv_max_early_data(ctx: PSSL_CTX; recv_max_early_data: TIdC_UINT32): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_recv_max_early_data');
end;


function ERR_SSL_CTX_get_recv_max_early_data(const ctx: PSSL_CTX): TIdC_UINT32; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get_recv_max_early_data');
end;


function ERR_SSL_set_recv_max_early_data(s: PSSL; recv_max_early_data: TIdC_UINT32): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_recv_max_early_data');
end;


function ERR_SSL_get_recv_max_early_data(const s: PSSL): TIdC_UINT32; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_recv_max_early_data');
end;


function ERR_SSL_get_app_data(const ssl: PSSL): Pointer ; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_app_data');
end;

 
function ERR_SSL_set_app_data(ssl: PSSL; data: Pointer): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_app_data');
end;


function ERR_SSL_in_init(const s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_in_init');
end;


function ERR_SSL_in_before(const s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_in_before');
end;


function ERR_SSL_is_init_finished(const s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_is_init_finished');
end;


function ERR_SSLeay_add_ssl_algorithms: TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSLeay_add_ssl_algorithms');
end;


function ERR_SSL_CTX_up_ref(ctx: PSSL_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_up_ref');
end;


procedure ERR_SSL_CTX_set1_cert_store(v1: PSSL_CTX; v2: PX509_STORE); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set1_cert_store');
end;


function ERR_SSL_get_pending_cipher(const s: PSSL): PSSL_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_pending_cipher');
end;


function ERR_SSL_CIPHER_standard_name(const c: PSSL_CIPHER): PIdAnsiChar; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CIPHER_standard_name');
end;


function ERR_OPENSSL_cipher_name(const rfc_name: PIdAnsiChar): PIdAnsiChar; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OPENSSL_cipher_name');
end;


function ERR_SSL_CIPHER_get_protocol_id(const c: PSSL_CIPHER): TIdC_UINT16; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CIPHER_get_protocol_id');
end;


function ERR_SSL_CIPHER_get_kx_nid(const c: PSSL_CIPHER): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CIPHER_get_kx_nid');
end;


function ERR_SSL_CIPHER_get_auth_nid(const c: PSSL_CIPHER): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CIPHER_get_auth_nid');
end;


function ERR_SSL_CIPHER_get_handshake_digest(const c: PSSL_CIPHER): PEVP_MD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CIPHER_get_handshake_digest');
end;


function ERR_SSL_CIPHER_is_aead(const c: PSSL_CIPHER): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CIPHER_is_aead');
end;


function ERR_SSL_has_pending(const s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_has_pending');
end;


procedure ERR_SSL_set0_rbio(s: PSSL; rbio: PBIO); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set0_rbio');
end;


procedure ERR_SSL_set0_wbio(s: PSSL; wbio: PBIO); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set0_wbio');
end;


function ERR_SSL_CTX_set_ciphersuites(ctx: PSSL_CTX; const str: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_ciphersuites');
end;


function ERR_SSL_set_ciphersuites(s: PSSL; const str: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_ciphersuites');
end;


function ERR_SSL_CTX_use_serverinfo_ex(ctx: PSSL_CTX; version: TIdC_UINT; const serverinfo: PByte; serverinfo_length: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_use_serverinfo_ex');
end;


function ERR_SSL_use_certificate_chain_file(ssl: PSSL; const file_: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_use_certificate_chain_file');
end;


procedure ERR_SSL_load_error_strings; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_load_error_strings');
end;


function ERR_SSL_SESSION_get_protocol_version(const s: PSSL_SESSION): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_get_protocol_version');
end;


function ERR_SSL_SESSION_set_protocol_version(s: PSSL_SESSION; version: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_set_protocol_version');
end;


function ERR_SSL_SESSION_get0_hostname(const s: PSSL_SESSION): PIdAnsiChar; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_get0_hostname');
end;


function ERR_SSL_SESSION_set1_hostname(s: PSSL_SESSION; const hostname: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_set1_hostname');
end;


procedure ERR_SSL_SESSION_get0_alpn_selected(const s: PSSL_SESSION; const alpn: PPByte; len: PIdC_SIZET); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_get0_alpn_selected');
end;


function ERR_SSL_SESSION_set1_alpn_selected(s: PSSL_SESSION; const alpn: PByte; len: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_set1_alpn_selected');
end;


function ERR_SSL_SESSION_get0_cipher(const s: PSSL_SESSION): PSSL_CIPHER; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_get0_cipher');
end;


function ERR_SSL_SESSION_set_cipher(s: PSSL_SESSION; const cipher: PSSL_CIPHER): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_set_cipher');
end;


function ERR_SSL_SESSION_has_ticket(const s: PSSL_SESSION): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_has_ticket');
end;


function ERR_SSL_SESSION_get_ticket_lifetime_hint(const s: PSSL_SESSION): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_get_ticket_lifetime_hint');
end;


procedure ERR_SSL_SESSION_get0_ticket(const s: PSSL_SESSION; const tick: PPByte; len: PIdC_SIZET); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_get0_ticket');
end;


function ERR_SSL_SESSION_get_max_early_data(const s: PSSL_SESSION): TIdC_UINT32; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_get_max_early_data');
end;


function ERR_SSL_SESSION_set_max_early_data(s: PSSL_SESSION; max_early_data: TIdC_UINT32): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_set_max_early_data');
end;


function ERR_SSL_SESSION_set1_id(s: PSSL_SESSION; const sid: PByte; sid_len: TIdC_UINT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_set1_id');
end;


function ERR_SSL_SESSION_is_resumable(const s: PSSL_SESSION): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_is_resumable');
end;


function ERR_SSL_SESSION_dup(src: PSSL_SESSION): PSSL_SESSION; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_dup');
end;


function ERR_SSL_SESSION_get0_id_context(const s: PSSL_SESSION; len: PIdC_UINT): PByte; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_get0_id_context');
end;


function ERR_SSL_SESSION_print_keylog(bp: PBIO; const x: PSSL_SESSION): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_print_keylog');
end;


function ERR_SSL_SESSION_up_ref(ses: PSSL_SESSION): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_up_ref');
end;


function ERR_SSL_get_peer_certificate(const s: PSSL): PX509; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_peer_certificate');
end;


procedure ERR_SSL_CTX_set_default_passwd_cb(ctx: PSSL_CTX; cb: pem_password_cb); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_default_passwd_cb');
end;


procedure ERR_SSL_CTX_set_default_passwd_cb_userdata(ctx: PSSL_CTX; u: Pointer); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_default_passwd_cb_userdata');
end;


function ERR_SSL_CTX_get_default_passwd_cb(ctx: PSSL_CTX): pem_password_cb; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get_default_passwd_cb');
end;


function ERR_SSL_CTX_get_default_passwd_cb_userdata(ctx: PSSL_CTX): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get_default_passwd_cb_userdata');
end;


procedure ERR_SSL_set_default_passwd_cb(s: PSSL; cb: pem_password_cb); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_default_passwd_cb');
end;


procedure ERR_SSL_set_default_passwd_cb_userdata(s: PSSL; u: Pointer); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_default_passwd_cb_userdata');
end;


function ERR_SSL_get_default_passwd_cb(s: PSSL): pem_password_cb; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_default_passwd_cb');
end;


function ERR_SSL_get_default_passwd_cb_userdata(s: PSSL): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_default_passwd_cb_userdata');
end;


function ERR_SSL_up_ref(s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_up_ref');
end;


function ERR_SSL_is_dtls(const s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_is_dtls');
end;


function ERR_SSL_set1_host(s: PSSL; const hostname: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set1_host');
end;


function ERR_SSL_add1_host(s: PSSL; const hostname: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_add1_host');
end;


function ERR_SSL_get0_peername(s: PSSL): PIdAnsiChar; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get0_peername');
end;


procedure ERR_SSL_set_hostflags(s: PSSL; flags: TIdC_UINT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_hostflags');
end;


function ERR_SSL_CTX_dane_enable(ctx: PSSL_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_dane_enable');
end;


function ERR_SSL_CTX_dane_mtype_set(ctx: PSSL_CTX; const md: PEVP_MD; mtype: TIdC_UINT8; ord: TIdC_UINT8): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_dane_mtype_set');
end;


function ERR_SSL_dane_enable(s: PSSL; const basedomain: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_dane_enable');
end;


function ERR_SSL_dane_tlsa_add(s: PSSL; usage: TIdC_UINT8; selector: TIdC_UINT8; mtype: TIdC_UINT8; const data: PByte; dlen: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_dane_tlsa_add');
end;


function ERR_SSL_get0_dane_authority(s: PSSL; mcert: PPX509; mspki: PPEVP_PKEY): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get0_dane_authority');
end;


function ERR_SSL_get0_dane_tlsa(s: PSSL; usage: PIdC_UINT8; selector: PIdC_UINT8; mtype: PIdC_UINT8; const data: PPByte; dlen: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get0_dane_tlsa');
end;


function ERR_SSL_get0_dane(ssl: PSSL): PSSL_DANE; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get0_dane');
end;


function ERR_SSL_CTX_dane_set_flags(ctx: PSSL_CTX; flags: TIdC_ULONG): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_dane_set_flags');
end;


function ERR_SSL_CTX_dane_clear_flags(ctx: PSSL_CTX; flags: TIdC_ULONG): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_dane_clear_flags');
end;


function ERR_SSL_dane_set_flags(ssl: PSSL; flags: TIdC_ULONG): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_dane_set_flags');
end;


function ERR_SSL_dane_clear_flags(ssl: PSSL; flags: TIdC_ULONG): TIdC_ULONG; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_dane_clear_flags');
end;


procedure ERR_SSL_CTX_set_client_hello_cb(c: PSSL_CTX; cb: SSL_client_hello_cb_fn; arg: Pointer); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_client_hello_cb');
end;


function ERR_SSL_client_hello_isv2(s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_client_hello_isv2');
end;


function ERR_SSL_client_hello_get0_legacy_version(s: PSSL): TIdC_UINT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_client_hello_get0_legacy_version');
end;


function ERR_SSL_client_hello_get0_random(s: PSSL; const out_: PPByte): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_client_hello_get0_random');
end;


function ERR_SSL_client_hello_get0_session_id(s: PSSL; const out_: PPByte): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_client_hello_get0_session_id');
end;


function ERR_SSL_client_hello_get0_ciphers(s: PSSL; const out_: PPByte): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_client_hello_get0_ciphers');
end;


function ERR_SSL_client_hello_get0_compression_methods(s: PSSL; const out_: PPByte): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_client_hello_get0_compression_methods');
end;


function ERR_SSL_client_hello_get1_extensions_present(s: PSSL; out_: PPIdC_INT; outlen: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_client_hello_get1_extensions_present');
end;


function ERR_SSL_client_hello_get0_ext(s: PSSL; type_: TIdC_UINT; const out_: PPByte; outlen: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_client_hello_get0_ext');
end;


function ERR_SSL_waiting_for_async(s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_waiting_for_async');
end;


function ERR_SSL_get_all_async_fds(s: PSSL; fds: POSSL_ASYNC_FD; numfds: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_all_async_fds');
end;


function ERR_SSL_get_changed_async_fds(s: PSSL; addfd: POSSL_ASYNC_FD; numaddfds: PIdC_SIZET; delfd: POSSL_ASYNC_FD; numdelfds: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_changed_async_fds');
end;


function ERR_SSL_stateless(s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_stateless');
end;


function ERR_SSL_read_ex(ssl: PSSL; buf: Pointer; num: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_read_ex');
end;


function ERR_SSL_read_early_data(s: PSSL; buf: Pointer; num: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_read_early_data');
end;


function ERR_SSL_peek_ex(ssl: PSSL; buf: Pointer; num: TIdC_SIZET; readbytes: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_peek_ex');
end;


function ERR_SSL_write_ex(s: PSSL; const buf: Pointer; num: TIdC_SIZET; written: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_write_ex');
end;


function ERR_SSL_write_early_data(s: PSSL; const buf: Pointer; num: TIdC_SIZET; written: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_write_early_data');
end;


function ERR_SSL_get_early_data_status(const s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_early_data_status');
end;


function ERR_TLS_method: PSSL_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('TLS_method');
end;


function ERR_TLS_server_method: PSSL_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('TLS_server_method');
end;


function ERR_TLS_client_method: PSSL_METHOD; 
begin
  EIdAPIFunctionNotPresent.RaiseException('TLS_client_method');
end;


function ERR_SSL_key_update(s: PSSL; updatetype: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_key_update');
end;


function ERR_SSL_get_key_update_type(const s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_key_update_type');
end;


procedure ERR_SSL_CTX_set_post_handshake_auth(ctx: PSSL_CTX; val: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_post_handshake_auth');
end;


procedure ERR_SSL_set_post_handshake_auth(s: PSSL; val: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_post_handshake_auth');
end;


function ERR_SSL_verify_client_post_handshake(s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_verify_client_post_handshake');
end;


function ERR_SSL_library_init: TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_library_init');
end;


function ERR_SSL_client_version(const s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_client_version');
end;


function ERR_SSL_CTX_set_default_verify_dir(ctx: PSSL_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_default_verify_dir');
end;


function ERR_SSL_CTX_set_default_verify_file(ctx: PSSL_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_default_verify_file');
end;


function ERR_SSL_get_state(const ssl: PSSL): OSSL_HANDSHAKE_STATE; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_state');
end;


function ERR_SSL_get_client_random(const ssl: PSSL; out_: PByte; outlen: TIdC_SIZET): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_client_random');
end;


function ERR_SSL_get_server_random(const ssl: PSSL; out_: PByte; outlen: TIdC_SIZET): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_server_random');
end;


function ERR_SSL_SESSION_get_master_key(const sess: PSSL_SESSION; out_: PByte; outlen: TIdC_SIZET): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_get_master_key');
end;


function ERR_SSL_SESSION_set1_master_key(sess: PSSL_SESSION; const in_: PByte; len: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_set1_master_key');
end;


function ERR_SSL_SESSION_get_max_fragment_length(const sess: PSSL_SESSION): TIdC_UINT8; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_get_max_fragment_length');
end;


procedure ERR_SSL_CTX_set_default_read_buffer_len(ctx: PSSL_CTX; len: TIdC_SIZET); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_default_read_buffer_len');
end;


procedure ERR_SSL_set_default_read_buffer_len(s: PSSL; len: TIdC_SIZET); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_default_read_buffer_len');
end;


function ERR_SSL_CIPHER_get_cipher_nid(const c: PSSL_CIPHEr): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CIPHER_get_cipher_nid');
end;


function ERR_SSL_CIPHER_get_digest_nid(const c: PSSL_CIPHEr): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CIPHER_get_digest_nid');
end;


procedure ERR_SSL_CTX_set_not_resumable_session_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_not_resumable_session_callback_cb); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_not_resumable_session_callback');
end;


procedure ERR_SSL_set_not_resumable_session_callback(ssl: PSSL; cb: SSL_set_not_resumable_session_callback_cb); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_not_resumable_session_callback');
end;


procedure ERR_SSL_CTX_set_record_padding_callback(ctx: PSSL_CTX; cb: SSL_CTX_set_record_padding_callback_cb); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_record_padding_callback');
end;


procedure ERR_SSL_CTX_set_record_padding_callback_arg(ctx: PSSL_CTX; arg: Pointer); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_record_padding_callback_arg');
end;


function ERR_SSL_CTX_get_record_padding_callback_arg(const ctx: PSSL_CTX): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get_record_padding_callback_arg');
end;


function ERR_SSL_CTX_set_block_padding(ctx: PSSL_CTX; block_size: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_block_padding');
end;


procedure ERR_SSL_set_record_padding_callback(ssl: PSSL; cb: SSL_set_record_padding_callback_cb); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_record_padding_callback');
end;


procedure ERR_SSL_set_record_padding_callback_arg(ssl: PSSL; arg: Pointer); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_record_padding_callback_arg');
end;


function ERR_SSL_get_record_padding_callback_arg(const ssl: PSSL): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_record_padding_callback_arg');
end;


function ERR_SSL_set_block_padding(ssl: PSSL; block_size: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_block_padding');
end;


function ERR_SSL_set_num_tickets(s: PSSL; num_tickets: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_num_tickets');
end;


function ERR_SSL_get_num_tickets(const s: PSSL): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_num_tickets');
end;


function ERR_SSL_CTX_set_num_tickets(ctx: PSSL_CTX; num_tickets: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_num_tickets');
end;


function ERR_SSL_CTX_get_num_tickets(const ctx: PSSL_CTX): TIdC_SIZET; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get_num_tickets');
end;


function ERR_SSL_session_reused(const s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_session_reused');
end;


procedure ERR_SSL_add_ssl_module; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_add_ssl_module');
end;


function ERR_SSL_config(s: PSSL; const name: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_config');
end;


function ERR_SSL_CTX_config(ctx: PSSL_CTX; const name: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_config');
end;


function ERR_DTLSv1_listen(s: PSSL; client: PBIO_ADDr): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('DTLSv1_listen');
end;


function ERR_SSL_enable_ct(s: PSSL; validation_mode: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_enable_ct');
end;


function ERR_SSL_CTX_enable_ct(ctx: PSSL_CTX; validation_mode: TIdC_INT): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_enable_ct');
end;


function ERR_SSL_ct_is_enabled(const s: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_ct_is_enabled');
end;


function ERR_SSL_CTX_ct_is_enabled(const ctx: PSSL_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_ct_is_enabled');
end;


function ERR_SSL_CTX_set_default_ctlog_list_file(ctx: PSSL_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_default_ctlog_list_file');
end;


function ERR_SSL_CTX_set_ctlog_list_file(ctx: PSSL_CTX; const path: PIdAnsiChar): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_ctlog_list_file');
end;


procedure ERR_SSL_CTX_set0_ctlog_store(ctx: PSSL_CTX; logs: PCTLOG_STORE); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set0_ctlog_store');
end;


procedure ERR_SSL_set_security_level(s: PSSL; level: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_security_level');
end;


procedure ERR_SSL_set_security_callback(s: PSSL; cb: SSL_security_callback); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_security_callback');
end;


function ERR_SSL_get_security_callback(const s: PSSL): SSL_security_callback; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get_security_callback');
end;


procedure ERR_SSL_set0_security_ex_data(s: PSSL; ex: Pointer); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set0_security_ex_data');
end;


function ERR_SSL_get0_security_ex_data(const s: PSSL): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get0_security_ex_data');
end;


procedure ERR_SSL_CTX_set_security_level(ctx: PSSL_CTX; level: TIdC_INT); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_security_level');
end;


function ERR_SSL_CTX_get_security_level(const ctx: PSSL_CTX): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get_security_level');
end;


function ERR_SSL_CTX_get0_security_ex_data(const ctx: PSSL_CTX): Pointer; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_get0_security_ex_data');
end;


procedure ERR_SSL_CTX_set0_security_ex_data(ctx: PSSL_CTX; ex: Pointer); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set0_security_ex_data');
end;


function ERR_OPENSSL_init_ssl(opts: TIdC_UINT64; const settings: POPENSSL_INIT_SETTINGS): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('OPENSSL_init_ssl');
end;


function ERR_SSL_free_buffers(ssl: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_free_buffers');
end;


function ERR_SSL_alloc_buffers(ssl: PSSL): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_alloc_buffers');
end;


function ERR_SSL_CTX_set_session_ticket_cb(ctx: PSSL_CTX; gen_cb: SSL_CTX_generate_session_ticket_fn; dec_cb: SSL_CTX_decrypt_session_ticket_fn; arg: Pointer): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_session_ticket_cb');
end;


function ERR_SSL_SESSION_set1_ticket_appdata(ss: PSSL_SESSION; const data: Pointer; len: TIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_set1_ticket_appdata');
end;


function ERR_SSL_SESSION_get0_ticket_appdata(ss: PSSL_SESSION; data: PPointer; len: PIdC_SIZET): TIdC_INT; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_SESSION_get0_ticket_appdata');
end;


procedure ERR_DTLS_set_timer_cb(s: PSSL; cb: DTLS_timer_cb); 
begin
  EIdAPIFunctionNotPresent.RaiseException('DTLS_set_timer_cb');
end;


procedure ERR_SSL_CTX_set_allow_early_data_cb(ctx: PSSL_CTX; cb: SSL_allow_early_data_cb_fN; arg: Pointer); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_CTX_set_allow_early_data_cb');
end;


procedure ERR_SSL_set_allow_early_data_cb(s: PSSL; cb: SSL_allow_early_data_cb_fN; arg: Pointer); 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_set_allow_early_data_cb');
end;


function ERR_SSL_get0_peer_certificate(const s: PSSL): PX509; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get0_peer_certificate');
end;


function ERR_SSL_get1_peer_certificate(const s: PSSL): PX509; 
begin
  EIdAPIFunctionNotPresent.RaiseException('SSL_get1_peer_certificate');
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
  SSL_CTX_sess_set_new_cb := LoadFunction('SSL_CTX_sess_set_new_cb',AFailed);
  SSL_CTX_sess_get_new_cb := LoadFunction('SSL_CTX_sess_get_new_cb',AFailed);
  SSL_CTX_sess_set_remove_cb := LoadFunction('SSL_CTX_sess_set_remove_cb',AFailed);
  SSL_CTX_sess_get_remove_cb := LoadFunction('SSL_CTX_sess_get_remove_cb',AFailed);
  SSL_CTX_set_info_callback := LoadFunction('SSL_CTX_set_info_callback',AFailed);
  SSL_CTX_get_info_callback := LoadFunction('SSL_CTX_get_info_callback',AFailed);
  SSL_CTX_set_client_cert_cb := LoadFunction('SSL_CTX_set_client_cert_cb',AFailed);
  SSL_CTX_get_client_cert_cb := LoadFunction('SSL_CTX_get_client_cert_cb',AFailed);
  SSL_CTX_set_client_cert_engine := LoadFunction('SSL_CTX_set_client_cert_engine',AFailed);
  SSL_CTX_set_cookie_generate_cb := LoadFunction('SSL_CTX_set_cookie_generate_cb',AFailed);
  SSL_CTX_set_cookie_verify_cb := LoadFunction('SSL_CTX_set_cookie_verify_cb',AFailed);
  SSL_CTX_set_alpn_select_cb := LoadFunction('SSL_CTX_set_alpn_select_cb',AFailed);
  SSL_get0_alpn_selected := LoadFunction('SSL_get0_alpn_selected',AFailed);
  SSL_CTX_set_psk_client_callback := LoadFunction('SSL_CTX_set_psk_client_callback',AFailed);
  SSL_set_psk_client_callback := LoadFunction('SSL_set_psk_client_callback',AFailed);
  SSL_CTX_set_psk_server_callback := LoadFunction('SSL_CTX_set_psk_server_callback',AFailed);
  SSL_set_psk_server_callback := LoadFunction('SSL_set_psk_server_callback',AFailed);
  SSL_get_finished := LoadFunction('SSL_get_finished',AFailed);
  SSL_get_peer_finished := LoadFunction('SSL_get_peer_finished',AFailed);
  BIO_f_ssl := LoadFunction('BIO_f_ssl',AFailed);
  BIO_new_ssl := LoadFunction('BIO_new_ssl',AFailed);
  BIO_new_ssl_connect := LoadFunction('BIO_new_ssl_connect',AFailed);
  BIO_new_buffer_ssl_connect := LoadFunction('BIO_new_buffer_ssl_connect',AFailed);
  BIO_ssl_copy_session_id := LoadFunction('BIO_ssl_copy_session_id',AFailed);
  SSL_CTX_set_cipher_list := LoadFunction('SSL_CTX_set_cipher_list',AFailed);
  SSL_CTX_new := LoadFunction('SSL_CTX_new',AFailed);
  SSL_CTX_set_timeout := LoadFunction('SSL_CTX_set_timeout',AFailed);
  SSL_CTX_get_timeout := LoadFunction('SSL_CTX_get_timeout',AFailed);
  SSL_CTX_get_cert_store := LoadFunction('SSL_CTX_get_cert_store',AFailed);
  SSL_want := LoadFunction('SSL_want',AFailed);
  SSL_clear := LoadFunction('SSL_clear',AFailed);
  BIO_ssl_shutdown := LoadFunction('BIO_ssl_shutdown',AFailed);
  SSL_CTX_free := LoadFunction('SSL_CTX_free',AFailed);
  SSL_CTX_set_cert_store := LoadFunction('SSL_CTX_set_cert_store',AFailed);
  SSL_CTX_flush_sessions := LoadFunction('SSL_CTX_flush_sessions',AFailed);
  SSL_get_current_cipher := LoadFunction('SSL_get_current_cipher',AFailed);
  SSL_CIPHER_get_bits := LoadFunction('SSL_CIPHER_get_bits',AFailed);
  SSL_CIPHER_get_version := LoadFunction('SSL_CIPHER_get_version',AFailed);
  SSL_CIPHER_get_name := LoadFunction('SSL_CIPHER_get_name',AFailed);
  SSL_CIPHER_get_id := LoadFunction('SSL_CIPHER_get_id',AFailed);
  SSL_get_fd := LoadFunction('SSL_get_fd',AFailed);
  SSL_get_rfd := LoadFunction('SSL_get_rfd',AFailed);
  SSL_get_wfd := LoadFunction('SSL_get_wfd',AFailed);
  SSL_get_cipher_list := LoadFunction('SSL_get_cipher_list',AFailed);
  SSL_get_shared_ciphers := LoadFunction('SSL_get_shared_ciphers',AFailed);
  SSL_get_read_ahead := LoadFunction('SSL_get_read_ahead',AFailed);
  SSL_pending := LoadFunction('SSL_pending',AFailed);
  SSL_set_fd := LoadFunction('SSL_set_fd',AFailed);
  SSL_set_rfd := LoadFunction('SSL_set_rfd',AFailed);
  SSL_set_wfd := LoadFunction('SSL_set_wfd',AFailed);
  SSL_set_bio := LoadFunction('SSL_set_bio',AFailed);
  SSL_get_rbio := LoadFunction('SSL_get_rbio',AFailed);
  SSL_get_wbio := LoadFunction('SSL_get_wbio',AFailed);
  SSL_set_cipher_list := LoadFunction('SSL_set_cipher_list',AFailed);
  SSL_get_verify_mode := LoadFunction('SSL_get_verify_mode',AFailed);
  SSL_get_verify_depth := LoadFunction('SSL_get_verify_depth',AFailed);
  SSL_get_verify_callback := LoadFunction('SSL_get_verify_callback',AFailed);
  SSL_set_read_ahead := LoadFunction('SSL_set_read_ahead',AFailed);
  SSL_set_verify := LoadFunction('SSL_set_verify',AFailed);
  SSL_set_verify_depth := LoadFunction('SSL_set_verify_depth',AFailed);
  SSL_use_RSAPrivateKey := LoadFunction('SSL_use_RSAPrivateKey',AFailed);
  SSL_use_RSAPrivateKey_ASN1 := LoadFunction('SSL_use_RSAPrivateKey_ASN1',AFailed);
  SSL_use_PrivateKey := LoadFunction('SSL_use_PrivateKey',AFailed);
  SSL_use_PrivateKey_ASN1 := LoadFunction('SSL_use_PrivateKey_ASN1',AFailed);
  SSL_use_certificate := LoadFunction('SSL_use_certificate',AFailed);
  SSL_use_certificate_ASN1 := LoadFunction('SSL_use_certificate_ASN1',AFailed);
  SSL_CTX_use_serverinfo := LoadFunction('SSL_CTX_use_serverinfo',AFailed);
  SSL_CTX_use_serverinfo_file := LoadFunction('SSL_CTX_use_serverinfo_file',AFailed);
  SSL_use_RSAPrivateKey_file := LoadFunction('SSL_use_RSAPrivateKey_file',AFailed);
  SSL_use_PrivateKey_file := LoadFunction('SSL_use_PrivateKey_file',AFailed);
  SSL_use_certificate_file := LoadFunction('SSL_use_certificate_file',AFailed);
  SSL_CTX_use_RSAPrivateKey_file := LoadFunction('SSL_CTX_use_RSAPrivateKey_file',AFailed);
  SSL_CTX_use_PrivateKey_file := LoadFunction('SSL_CTX_use_PrivateKey_file',AFailed);
  SSL_CTX_use_certificate_file := LoadFunction('SSL_CTX_use_certificate_file',AFailed);
  SSL_CTX_use_certificate_chain_file := LoadFunction('SSL_CTX_use_certificate_chain_file',AFailed);
  SSL_load_client_CA_file := LoadFunction('SSL_load_client_CA_file',AFailed);
  SSL_add_file_cert_subjects_to_stack := LoadFunction('SSL_add_file_cert_subjects_to_stack',AFailed);
  SSL_add_dir_cert_subjects_to_stack := LoadFunction('SSL_add_dir_cert_subjects_to_stack',AFailed);
  SSL_state_string := LoadFunction('SSL_state_string',AFailed);
  SSL_rstate_string := LoadFunction('SSL_rstate_string',AFailed);
  SSL_state_string_long := LoadFunction('SSL_state_string_long',AFailed);
  SSL_rstate_string_long := LoadFunction('SSL_rstate_string_long',AFailed);
  SSL_SESSION_get_time := LoadFunction('SSL_SESSION_get_time',AFailed);
  SSL_SESSION_set_time := LoadFunction('SSL_SESSION_set_time',AFailed);
  SSL_SESSION_get_timeout := LoadFunction('SSL_SESSION_get_timeout',AFailed);
  SSL_SESSION_set_timeout := LoadFunction('SSL_SESSION_set_timeout',AFailed);
  SSL_copy_session_id := LoadFunction('SSL_copy_session_id',AFailed);
  SSL_SESSION_get0_peer := LoadFunction('SSL_SESSION_get0_peer',AFailed);
  SSL_SESSION_set1_id_context := LoadFunction('SSL_SESSION_set1_id_context',AFailed);
  SSL_SESSION_new := LoadFunction('SSL_SESSION_new',AFailed);
  SSL_SESSION_get_id := LoadFunction('SSL_SESSION_get_id',AFailed);
  SSL_SESSION_get_compress_id := LoadFunction('SSL_SESSION_get_compress_id',AFailed);
  SSL_SESSION_print := LoadFunction('SSL_SESSION_print',AFailed);
  SSL_SESSION_free := LoadFunction('SSL_SESSION_free',AFailed);
  SSL_set_session := LoadFunction('SSL_set_session',AFailed);
  SSL_CTX_add_session := LoadFunction('SSL_CTX_add_session',AFailed);
  SSL_CTX_remove_session := LoadFunction('SSL_CTX_remove_session',AFailed);
  SSL_CTX_set_generate_session_id := LoadFunction('SSL_CTX_set_generate_session_id',AFailed);
  SSL_set_generate_session_id := LoadFunction('SSL_set_generate_session_id',AFailed);
  SSL_has_matching_session_id := LoadFunction('SSL_has_matching_session_id',AFailed);
  d2i_SSL_SESSION := LoadFunction('d2i_SSL_SESSION',AFailed);
  SSL_CTX_get_verify_mode := LoadFunction('SSL_CTX_get_verify_mode',AFailed);
  SSL_CTX_get_verify_depth := LoadFunction('SSL_CTX_get_verify_depth',AFailed);
  SSL_CTX_get_verify_callback := LoadFunction('SSL_CTX_get_verify_callback',AFailed);
  SSL_CTX_set_verify := LoadFunction('SSL_CTX_set_verify',AFailed);
  SSL_CTX_set_verify_depth := LoadFunction('SSL_CTX_set_verify_depth',AFailed);
  SSL_CTX_set_cert_verify_callback := LoadFunction('SSL_CTX_set_cert_verify_callback',AFailed);
  SSL_CTX_set_cert_cb := LoadFunction('SSL_CTX_set_cert_cb',AFailed);
  SSL_CTX_use_RSAPrivateKey := LoadFunction('SSL_CTX_use_RSAPrivateKey',AFailed);
  SSL_CTX_use_RSAPrivateKey_ASN1 := LoadFunction('SSL_CTX_use_RSAPrivateKey_ASN1',AFailed);
  SSL_CTX_use_PrivateKey := LoadFunction('SSL_CTX_use_PrivateKey',AFailed);
  SSL_CTX_use_PrivateKey_ASN1 := LoadFunction('SSL_CTX_use_PrivateKey_ASN1',AFailed);
  SSL_CTX_use_certificate := LoadFunction('SSL_CTX_use_certificate',AFailed);
  SSL_CTX_use_certificate_ASN1 := LoadFunction('SSL_CTX_use_certificate_ASN1',AFailed);
  SSL_CTX_check_private_key := LoadFunction('SSL_CTX_check_private_key',AFailed);
  SSL_check_private_key := LoadFunction('SSL_check_private_key',AFailed);
  SSL_CTX_set_session_id_context := LoadFunction('SSL_CTX_set_session_id_context',AFailed);
  SSL_new := LoadFunction('SSL_new',AFailed);
  SSL_set_session_id_context := LoadFunction('SSL_set_session_id_context',AFailed);
  SSL_CTX_set_purpose := LoadFunction('SSL_CTX_set_purpose',AFailed);
  SSL_set_purpose := LoadFunction('SSL_set_purpose',AFailed);
  SSL_CTX_set_trust := LoadFunction('SSL_CTX_set_trust',AFailed);
  SSL_set_trust := LoadFunction('SSL_set_trust',AFailed);
  SSL_CTX_set1_param := LoadFunction('SSL_CTX_set1_param',AFailed);
  SSL_set1_param := LoadFunction('SSL_set1_param',AFailed);
  SSL_CTX_get0_param := LoadFunction('SSL_CTX_get0_param',AFailed);
  SSL_get0_param := LoadFunction('SSL_get0_param',AFailed);
  SSL_CTX_set_srp_username := LoadFunction('SSL_CTX_set_srp_username',AFailed);
  SSL_CTX_set_srp_password := LoadFunction('SSL_CTX_set_srp_password',AFailed);
  SSL_CTX_set_srp_strength := LoadFunction('SSL_CTX_set_srp_strength',AFailed);
  SSL_CTX_set_srp_client_pwd_callback := LoadFunction('SSL_CTX_set_srp_client_pwd_callback',AFailed);
  SSL_CTX_set_srp_verify_param_callback := LoadFunction('SSL_CTX_set_srp_verify_param_callback',AFailed);
  SSL_CTX_set_srp_username_callback := LoadFunction('SSL_CTX_set_srp_username_callback',AFailed);
  SSL_CTX_set_srp_cb_arg := LoadFunction('SSL_CTX_set_srp_cb_arg',AFailed);
  SSL_set_srp_server_param := LoadFunction('SSL_set_srp_server_param',AFailed);
  SSL_set_srp_server_param_pw := LoadFunction('SSL_set_srp_server_param_pw',AFailed);
  SSL_certs_clear := LoadFunction('SSL_certs_clear',AFailed);
  SSL_free := LoadFunction('SSL_free',AFailed);
  SSL_accept := LoadFunction('SSL_accept',AFailed);
  SSL_connect := LoadFunction('SSL_connect',AFailed);
  SSL_read := LoadFunction('SSL_read',AFailed);
  SSL_peek := LoadFunction('SSL_peek',AFailed);
  SSL_write := LoadFunction('SSL_write',AFailed);
  SSL_callback_ctrl := LoadFunction('SSL_callback_ctrl',AFailed);
  SSL_ctrl := LoadFunction('SSL_ctrl',AFailed);
  SSL_CTX_ctrl := LoadFunction('SSL_CTX_ctrl',AFailed);
  SSL_CTX_callback_ctrl := LoadFunction('SSL_CTX_callback_ctrl',AFailed);
  SSL_get_error := LoadFunction('SSL_get_error',AFailed);
  SSL_get_version := LoadFunction('SSL_get_version',AFailed);
  SSL_CTX_set_ssl_version := LoadFunction('SSL_CTX_set_ssl_version',AFailed);
  SSL_renegotiate := LoadFunction('SSL_renegotiate',AFailed);
  SSL_renegotiate_abbreviated := LoadFunction('SSL_renegotiate_abbreviated',AFailed);
  SSL_shutdown := LoadFunction('SSL_shutdown',AFailed);
  SSL_renegotiate_pending := LoadFunction('SSL_renegotiate_pending',AFailed);
  SSL_CTX_get_ssl_method := LoadFunction('SSL_CTX_get_ssl_method',AFailed);
  SSL_get_ssl_method := LoadFunction('SSL_get_ssl_method',AFailed);
  SSL_set_ssl_method := LoadFunction('SSL_set_ssl_method',AFailed);
  SSL_alert_type_string_long := LoadFunction('SSL_alert_type_string_long',AFailed);
  SSL_alert_type_string := LoadFunction('SSL_alert_type_string',AFailed);
  SSL_alert_desc_string_long := LoadFunction('SSL_alert_desc_string_long',AFailed);
  SSL_alert_desc_string := LoadFunction('SSL_alert_desc_string',AFailed);
  SSL_CTX_set_client_CA_list := LoadFunction('SSL_CTX_set_client_CA_list',AFailed);
  SSL_add_client_CA := LoadFunction('SSL_add_client_CA',AFailed);
  SSL_CTX_add_client_CA := LoadFunction('SSL_CTX_add_client_CA',AFailed);
  SSL_set_connect_state := LoadFunction('SSL_set_connect_state',AFailed);
  SSL_set_accept_state := LoadFunction('SSL_set_accept_state',AFailed);
  SSL_CIPHER_description := LoadFunction('SSL_CIPHER_description',AFailed);
  SSL_dup := LoadFunction('SSL_dup',AFailed);
  SSL_get_certificate := LoadFunction('SSL_get_certificate',AFailed);
  SSL_get_privatekey := LoadFunction('SSL_get_privatekey',AFailed);
  SSL_CTX_get0_certificate := LoadFunction('SSL_CTX_get0_certificate',AFailed);
  SSL_CTX_get0_privatekey := LoadFunction('SSL_CTX_get0_privatekey',AFailed);
  SSL_CTX_set_quiet_shutdown := LoadFunction('SSL_CTX_set_quiet_shutdown',AFailed);
  SSL_CTX_get_quiet_shutdown := LoadFunction('SSL_CTX_get_quiet_shutdown',AFailed);
  SSL_set_quiet_shutdown := LoadFunction('SSL_set_quiet_shutdown',AFailed);
  SSL_get_quiet_shutdown := LoadFunction('SSL_get_quiet_shutdown',AFailed);
  SSL_set_shutdown := LoadFunction('SSL_set_shutdown',AFailed);
  SSL_get_shutdown := LoadFunction('SSL_get_shutdown',AFailed);
  SSL_version := LoadFunction('SSL_version',AFailed);
  SSL_CTX_set_default_verify_paths := LoadFunction('SSL_CTX_set_default_verify_paths',AFailed);
  SSL_CTX_load_verify_locations := LoadFunction('SSL_CTX_load_verify_locations',AFailed);
  SSL_get_session := LoadFunction('SSL_get_session',AFailed);
  SSL_get1_session := LoadFunction('SSL_get1_session',AFailed);
  SSL_get_SSL_CTX := LoadFunction('SSL_get_SSL_CTX',AFailed);
  SSL_set_SSL_CTX := LoadFunction('SSL_set_SSL_CTX',AFailed);
  SSL_set_info_callback := LoadFunction('SSL_set_info_callback',AFailed);
  SSL_get_info_callback := LoadFunction('SSL_get_info_callback',AFailed);
  SSL_set_verify_result := LoadFunction('SSL_set_verify_result',AFailed);
  SSL_get_verify_result := LoadFunction('SSL_get_verify_result',AFailed);
  SSL_set_ex_data := LoadFunction('SSL_set_ex_data',AFailed);
  SSL_get_ex_data := LoadFunction('SSL_get_ex_data',AFailed);
  SSL_SESSION_set_ex_data := LoadFunction('SSL_SESSION_set_ex_data',AFailed);
  SSL_SESSION_get_ex_data := LoadFunction('SSL_SESSION_get_ex_data',AFailed);
  SSL_CTX_set_ex_data := LoadFunction('SSL_CTX_set_ex_data',AFailed);
  SSL_CTX_get_ex_data := LoadFunction('SSL_CTX_get_ex_data',AFailed);
  SSL_get_ex_data_X509_STORE_CTX_idx := LoadFunction('SSL_get_ex_data_X509_STORE_CTX_idx',AFailed);
  SSL_CTX_set_tmp_dh_callback := LoadFunction('SSL_CTX_set_tmp_dh_callback',AFailed);
  SSL_set_tmp_dh_callback := LoadFunction('SSL_set_tmp_dh_callback',AFailed);
  SSL_CIPHER_find := LoadFunction('SSL_CIPHER_find',AFailed);
  SSL_set_session_ticket_ext := LoadFunction('SSL_set_session_ticket_ext',AFailed);
  SSL_set_session_ticket_ext_cb := LoadFunction('SSL_set_session_ticket_ext_cb',AFailed);
  SSL_is_server := LoadFunction('SSL_is_server',AFailed);
  SSL_CONF_CTX_new := LoadFunction('SSL_CONF_CTX_new',AFailed);
  SSL_CONF_CTX_finish := LoadFunction('SSL_CONF_CTX_finish',AFailed);
  SSL_CONF_CTX_free := LoadFunction('SSL_CONF_CTX_free',AFailed);
  SSL_CONF_CTX_set_flags := LoadFunction('SSL_CONF_CTX_set_flags',AFailed);
  SSL_CONF_CTX_clear_flags := LoadFunction('SSL_CONF_CTX_clear_flags',AFailed);
  SSL_CONF_CTX_set1_prefix := LoadFunction('SSL_CONF_CTX_set1_prefix',AFailed);
  SSL_CONF_cmd := LoadFunction('SSL_CONF_cmd',AFailed);
  SSL_CONF_cmd_argv := LoadFunction('SSL_CONF_cmd_argv',AFailed);
  SSL_CONF_cmd_value_type := LoadFunction('SSL_CONF_cmd_value_type',AFailed);
  SSL_CONF_CTX_set_ssl := LoadFunction('SSL_CONF_CTX_set_ssl',AFailed);
  SSL_CONF_CTX_set_ssl_ctx := LoadFunction('SSL_CONF_CTX_set_ssl_ctx',AFailed);
  SSL_CTX_set_mode := LoadFunction('SSL_CTX_set_mode',nil); {removed 1.0.0}
  SSL_CTX_clear_mode := LoadFunction('SSL_CTX_clear_mode',nil); {removed 1.0.0}
  SSL_CTX_sess_set_cache_size := LoadFunction('SSL_CTX_sess_set_cache_size',nil); {removed 1.0.0}
  SSL_CTX_sess_get_cache_size := LoadFunction('SSL_CTX_sess_get_cache_size',nil); {removed 1.0.0}
  SSL_CTX_set_session_cache_mode := LoadFunction('SSL_CTX_set_session_cache_mode',nil); {removed 1.0.0}
  SSL_CTX_get_session_cache_mode := LoadFunction('SSL_CTX_get_session_cache_mode',nil); {removed 1.0.0}
  SSL_clear_num_renegotiations := LoadFunction('SSL_clear_num_renegotiations',nil); {removed 1.0.0}
  SSL_total_renegotiations := LoadFunction('SSL_total_renegotiations',nil); {removed 1.0.0}
  SSL_CTX_set_tmp_dh := LoadFunction('SSL_CTX_set_tmp_dh',nil); {removed 1.0.0}
  SSL_CTX_set_tmp_ecdh := LoadFunction('SSL_CTX_set_tmp_ecdh',nil); {removed 1.0.0}
  SSL_CTX_set_dh_auto := LoadFunction('SSL_CTX_set_dh_auto',nil); {removed 1.0.0}
  SSL_set_dh_auto := LoadFunction('SSL_set_dh_auto',nil); {removed 1.0.0}
  SSL_set_tmp_dh := LoadFunction('SSL_set_tmp_dh',nil); {removed 1.0.0}
  SSL_set_tmp_ecdh := LoadFunction('SSL_set_tmp_ecdh',nil); {removed 1.0.0}
  SSL_CTX_add_extra_chain_cert := LoadFunction('SSL_CTX_add_extra_chain_cert',nil); {removed 1.0.0}
  SSL_CTX_get_extra_chain_certs := LoadFunction('SSL_CTX_get_extra_chain_certs',nil); {removed 1.0.0}
  SSL_CTX_get_extra_chain_certs_only := LoadFunction('SSL_CTX_get_extra_chain_certs_only',nil); {removed 1.0.0}
  SSL_CTX_clear_extra_chain_certs := LoadFunction('SSL_CTX_clear_extra_chain_certs',nil); {removed 1.0.0}
  SSL_CTX_set0_chain := LoadFunction('SSL_CTX_set0_chain',nil); {removed 1.0.0}
  SSL_CTX_set1_chain := LoadFunction('SSL_CTX_set1_chain',nil); {removed 1.0.0}
  SSL_CTX_add0_chain_cert := LoadFunction('SSL_CTX_add0_chain_cert',nil); {removed 1.0.0}
  SSL_CTX_add1_chain_cert := LoadFunction('SSL_CTX_add1_chain_cert',nil); {removed 1.0.0}
  SSL_CTX_get0_chain_certs := LoadFunction('SSL_CTX_get0_chain_certs',nil); {removed 1.0.0}
  SSL_CTX_clear_chain_certs := LoadFunction('SSL_CTX_clear_chain_certs',nil); {removed 1.0.0}
  SSL_CTX_build_cert_chain := LoadFunction('SSL_CTX_build_cert_chain',nil); {removed 1.0.0}
  SSL_CTX_select_current_cert := LoadFunction('SSL_CTX_select_current_cert',nil); {removed 1.0.0}
  SSL_CTX_set_current_cert := LoadFunction('SSL_CTX_set_current_cert',nil); {removed 1.0.0}
  SSL_CTX_set0_verify_cert_store := LoadFunction('SSL_CTX_set0_verify_cert_store',nil); {removed 1.0.0}
  SSL_CTX_set1_verify_cert_store := LoadFunction('SSL_CTX_set1_verify_cert_store',nil); {removed 1.0.0}
  SSL_CTX_set0_chain_cert_store := LoadFunction('SSL_CTX_set0_chain_cert_store',nil); {removed 1.0.0}
  SSL_CTX_set1_chain_cert_store := LoadFunction('SSL_CTX_set1_chain_cert_store',nil); {removed 1.0.0}
  SSL_set0_chain := LoadFunction('SSL_set0_chain',nil); {removed 1.0.0}
  SSL_set1_chain := LoadFunction('SSL_set1_chain',nil); {removed 1.0.0}
  SSL_add0_chain_cert := LoadFunction('SSL_add0_chain_cert',nil); {removed 1.0.0}
  SSL_add1_chain_cert := LoadFunction('SSL_add1_chain_cert',nil); {removed 1.0.0}
  SSL_get0_chain_certs := LoadFunction('SSL_get0_chain_certs',nil); {removed 1.0.0}
  SSL_clear_chain_certs := LoadFunction('SSL_clear_chain_certs',nil); {removed 1.0.0}
  SSL_build_cert_chain := LoadFunction('SSL_build_cert_chain',nil); {removed 1.0.0}
  SSL_select_current_cert := LoadFunction('SSL_select_current_cert',nil); {removed 1.0.0}
  SSL_set_current_cert := LoadFunction('SSL_set_current_cert',nil); {removed 1.0.0}
  SSL_set0_verify_cert_store := LoadFunction('SSL_set0_verify_cert_store',nil); {removed 1.0.0}
  SSL_set1_verify_cert_store := LoadFunction('SSL_set1_verify_cert_store',nil); {removed 1.0.0}
  SSL_set0_chain_cert_store := LoadFunction('SSL_set0_chain_cert_store',nil); {removed 1.0.0}
  SSL_set1_chain_cert_store := LoadFunction('SSL_set1_chain_cert_store',nil); {removed 1.0.0}
  SSL_get1_groups := LoadFunction('SSL_get1_groups',nil); {removed 1.0.0}
  SSL_CTX_set1_groups := LoadFunction('SSL_CTX_set1_groups',nil); {removed 1.0.0}
  SSL_CTX_set1_groups_list := LoadFunction('SSL_CTX_set1_groups_list',nil); {removed 1.0.0}
  SSL_set1_groups := LoadFunction('SSL_set1_groups',nil); {removed 1.0.0}
  SSL_set1_groups_list := LoadFunction('SSL_set1_groups_list',nil); {removed 1.0.0}
  SSL_get_shared_group := LoadFunction('SSL_get_shared_group',nil); {removed 1.0.0}
  SSL_CTX_set1_sigalgs := LoadFunction('SSL_CTX_set1_sigalgs',nil); {removed 1.0.0}
  SSL_CTX_set1_sigalgs_list := LoadFunction('SSL_CTX_set1_sigalgs_list',nil); {removed 1.0.0}
  SSL_set1_sigalgs := LoadFunction('SSL_set1_sigalgs',nil); {removed 1.0.0}
  SSL_set1_sigalgs_list := LoadFunction('SSL_set1_sigalgs_list',nil); {removed 1.0.0}
  SSL_CTX_set1_client_sigalgs := LoadFunction('SSL_CTX_set1_client_sigalgs',nil); {removed 1.0.0}
  SSL_CTX_set1_client_sigalgs_list := LoadFunction('SSL_CTX_set1_client_sigalgs_list',nil); {removed 1.0.0}
  SSL_set1_client_sigalgs := LoadFunction('SSL_set1_client_sigalgs',nil); {removed 1.0.0}
  SSL_set1_client_sigalgs_list := LoadFunction('SSL_set1_client_sigalgs_list',nil); {removed 1.0.0}
  SSL_get0_certificate_types := LoadFunction('SSL_get0_certificate_types',nil); {removed 1.0.0}
  SSL_CTX_set1_client_certificate_types := LoadFunction('SSL_CTX_set1_client_certificate_types',nil); {removed 1.0.0}
  SSL_set1_client_certificate_types := LoadFunction('SSL_set1_client_certificate_types',nil); {removed 1.0.0}
  SSL_get_signature_nid := LoadFunction('SSL_get_signature_nid',nil); {removed 1.0.0}
  SSL_get_peer_signature_nid := LoadFunction('SSL_get_peer_signature_nid',nil); {removed 1.0.0}
  SSL_get_peer_tmp_key := LoadFunction('SSL_get_peer_tmp_key',nil); {removed 1.0.0}
  SSL_get_tmp_key := LoadFunction('SSL_get_tmp_key',nil); {removed 1.0.0}
  SSL_get0_raw_cipherlist := LoadFunction('SSL_get0_raw_cipherlist',nil); {removed 1.0.0}
  SSL_get0_ec_point_formats := LoadFunction('SSL_get0_ec_point_formats',nil); {removed 1.0.0}
  SSL_CTX_get_options := LoadFunction('SSL_CTX_get_options',nil); {introduced 1.1.0}
  SSL_get_options := LoadFunction('SSL_get_options',nil); {introduced 1.1.0}
  SSL_CTX_clear_options := LoadFunction('SSL_CTX_clear_options',nil); {introduced 1.1.0}
  SSL_clear_options := LoadFunction('SSL_clear_options',nil); {introduced 1.1.0}
  SSL_CTX_set_options := LoadFunction('SSL_CTX_set_options',nil); {introduced 1.1.0}
  SSL_set_options := LoadFunction('SSL_set_options',nil); {introduced 1.1.0}
  SSL_CTX_set_stateless_cookie_generate_cb := LoadFunction('SSL_CTX_set_stateless_cookie_generate_cb',nil); {introduced 1.1.0}
  SSL_CTX_set_stateless_cookie_verify_cb := LoadFunction('SSL_CTX_set_stateless_cookie_verify_cb',nil); {introduced 1.1.0}
  SSL_set_psk_find_session_callback := LoadFunction('SSL_set_psk_find_session_callback',nil); {introduced 1.1.0}
  SSL_CTX_set_psk_find_session_callback := LoadFunction('SSL_CTX_set_psk_find_session_callback',nil); {introduced 1.1.0}
  SSL_set_psk_use_session_callback := LoadFunction('SSL_set_psk_use_session_callback',nil); {introduced 1.1.0}
  SSL_CTX_set_psk_use_session_callback := LoadFunction('SSL_CTX_set_psk_use_session_callback',nil); {introduced 1.1.0}
  SSL_CTX_set_keylog_callback := LoadFunction('SSL_CTX_set_keylog_callback',nil); {introduced 1.1.0}
  SSL_CTX_get_keylog_callback := LoadFunction('SSL_CTX_get_keylog_callback',nil); {introduced 1.1.0}
  SSL_CTX_set_max_early_data := LoadFunction('SSL_CTX_set_max_early_data',nil); {introduced 1.1.0}
  SSL_CTX_get_max_early_data := LoadFunction('SSL_CTX_get_max_early_data',nil); {introduced 1.1.0}
  SSL_set_max_early_data := LoadFunction('SSL_set_max_early_data',nil); {introduced 1.1.0}
  SSL_get_max_early_data := LoadFunction('SSL_get_max_early_data',nil); {introduced 1.1.0}
  SSL_CTX_set_recv_max_early_data := LoadFunction('SSL_CTX_set_recv_max_early_data',nil); {introduced 1.1.0}
  SSL_CTX_get_recv_max_early_data := LoadFunction('SSL_CTX_get_recv_max_early_data',nil); {introduced 1.1.0}
  SSL_set_recv_max_early_data := LoadFunction('SSL_set_recv_max_early_data',nil); {introduced 1.1.0}
  SSL_get_recv_max_early_data := LoadFunction('SSL_get_recv_max_early_data',nil); {introduced 1.1.0}
  SSL_get_app_data := LoadFunction('SSL_get_app_data',nil); {removed 1.0.0} 
  SSL_set_app_data := LoadFunction('SSL_set_app_data',nil); {removed 1.0.0}
  SSL_in_init := LoadFunction('SSL_in_init',nil); {introduced 1.1.0}
  SSL_in_before := LoadFunction('SSL_in_before',nil); {introduced 1.1.0}
  SSL_is_init_finished := LoadFunction('SSL_is_init_finished',nil); {introduced 1.1.0}
  SSLeay_add_ssl_algorithms := LoadFunction('SSLeay_add_ssl_algorithms',nil); {removed 1.0.0}
  SSL_CTX_up_ref := LoadFunction('SSL_CTX_up_ref',nil); {introduced 1.1.0}
  SSL_CTX_set1_cert_store := LoadFunction('SSL_CTX_set1_cert_store',nil); {introduced 1.1.0}
  SSL_get_pending_cipher := LoadFunction('SSL_get_pending_cipher',nil); {introduced 1.1.0}
  SSL_CIPHER_standard_name := LoadFunction('SSL_CIPHER_standard_name',nil); {introduced 1.1.0}
  OPENSSL_cipher_name := LoadFunction('OPENSSL_cipher_name',nil); {introduced 1.1.0}
  SSL_CIPHER_get_protocol_id := LoadFunction('SSL_CIPHER_get_protocol_id',nil); {introduced 1.1.0}
  SSL_CIPHER_get_kx_nid := LoadFunction('SSL_CIPHER_get_kx_nid',nil); {introduced 1.1.0}
  SSL_CIPHER_get_auth_nid := LoadFunction('SSL_CIPHER_get_auth_nid',nil); {introduced 1.1.0}
  SSL_CIPHER_get_handshake_digest := LoadFunction('SSL_CIPHER_get_handshake_digest',nil); {introduced 1.1.0}
  SSL_CIPHER_is_aead := LoadFunction('SSL_CIPHER_is_aead',nil); {introduced 1.1.0}
  SSL_has_pending := LoadFunction('SSL_has_pending',nil); {introduced 1.1.0}
  SSL_set0_rbio := LoadFunction('SSL_set0_rbio',nil); {introduced 1.1.0}
  SSL_set0_wbio := LoadFunction('SSL_set0_wbio',nil); {introduced 1.1.0}
  SSL_CTX_set_ciphersuites := LoadFunction('SSL_CTX_set_ciphersuites',nil); {introduced 1.1.0}
  SSL_set_ciphersuites := LoadFunction('SSL_set_ciphersuites',nil); {introduced 1.1.0}
  SSL_CTX_use_serverinfo_ex := LoadFunction('SSL_CTX_use_serverinfo_ex',nil); {introduced 1.1.0}
  SSL_use_certificate_chain_file := LoadFunction('SSL_use_certificate_chain_file',nil); {introduced 1.1.0}
  SSL_load_error_strings := LoadFunction('SSL_load_error_strings',nil); {removed 1.1.0}
  SSL_SESSION_get_protocol_version := LoadFunction('SSL_SESSION_get_protocol_version',nil); {introduced 1.1.0}
  SSL_SESSION_set_protocol_version := LoadFunction('SSL_SESSION_set_protocol_version',nil); {introduced 1.1.0}
  SSL_SESSION_get0_hostname := LoadFunction('SSL_SESSION_get0_hostname',nil); {introduced 1.1.0}
  SSL_SESSION_set1_hostname := LoadFunction('SSL_SESSION_set1_hostname',nil); {introduced 1.1.0}
  SSL_SESSION_get0_alpn_selected := LoadFunction('SSL_SESSION_get0_alpn_selected',nil); {introduced 1.1.0}
  SSL_SESSION_set1_alpn_selected := LoadFunction('SSL_SESSION_set1_alpn_selected',nil); {introduced 1.1.0}
  SSL_SESSION_get0_cipher := LoadFunction('SSL_SESSION_get0_cipher',nil); {introduced 1.1.0}
  SSL_SESSION_set_cipher := LoadFunction('SSL_SESSION_set_cipher',nil); {introduced 1.1.0}
  SSL_SESSION_has_ticket := LoadFunction('SSL_SESSION_has_ticket',nil); {introduced 1.1.0}
  SSL_SESSION_get_ticket_lifetime_hint := LoadFunction('SSL_SESSION_get_ticket_lifetime_hint',nil); {introduced 1.1.0}
  SSL_SESSION_get0_ticket := LoadFunction('SSL_SESSION_get0_ticket',nil); {introduced 1.1.0}
  SSL_SESSION_get_max_early_data := LoadFunction('SSL_SESSION_get_max_early_data',nil); {introduced 1.1.0}
  SSL_SESSION_set_max_early_data := LoadFunction('SSL_SESSION_set_max_early_data',nil); {introduced 1.1.0}
  SSL_SESSION_set1_id := LoadFunction('SSL_SESSION_set1_id',nil); {introduced 1.1.0}
  SSL_SESSION_is_resumable := LoadFunction('SSL_SESSION_is_resumable',nil); {introduced 1.1.0}
  SSL_SESSION_dup := LoadFunction('SSL_SESSION_dup',nil); {introduced 1.1.0}
  SSL_SESSION_get0_id_context := LoadFunction('SSL_SESSION_get0_id_context',nil); {introduced 1.1.0}
  SSL_SESSION_print_keylog := LoadFunction('SSL_SESSION_print_keylog',nil); {introduced 1.1.0}
  SSL_SESSION_up_ref := LoadFunction('SSL_SESSION_up_ref',nil); {introduced 1.1.0}
  SSL_get_peer_certificate := LoadFunction('SSL_get_peer_certificate',nil); {removed 3.0.0}
  SSL_CTX_set_default_passwd_cb := LoadFunction('SSL_CTX_set_default_passwd_cb',nil); {introduced 1.1.0}
  SSL_CTX_set_default_passwd_cb_userdata := LoadFunction('SSL_CTX_set_default_passwd_cb_userdata',nil); {introduced 1.1.0}
  SSL_CTX_get_default_passwd_cb := LoadFunction('SSL_CTX_get_default_passwd_cb',nil);  {introduced 1.1.0}
  SSL_CTX_get_default_passwd_cb_userdata := LoadFunction('SSL_CTX_get_default_passwd_cb_userdata',nil); {introduced 1.1.0}
  SSL_set_default_passwd_cb := LoadFunction('SSL_set_default_passwd_cb',nil); {introduced 1.1.0}
  SSL_set_default_passwd_cb_userdata := LoadFunction('SSL_set_default_passwd_cb_userdata',nil); {introduced 1.1.0}
  SSL_get_default_passwd_cb := LoadFunction('SSL_get_default_passwd_cb',nil); {introduced 1.1.0}
  SSL_get_default_passwd_cb_userdata := LoadFunction('SSL_get_default_passwd_cb_userdata',nil); {introduced 1.1.0}
  SSL_up_ref := LoadFunction('SSL_up_ref',nil); {introduced 1.1.0}
  SSL_is_dtls := LoadFunction('SSL_is_dtls',nil); {introduced 1.1.0}
  SSL_set1_host := LoadFunction('SSL_set1_host',nil); {introduced 1.1.0}
  SSL_add1_host := LoadFunction('SSL_add1_host',nil); {introduced 1.1.0}
  SSL_get0_peername := LoadFunction('SSL_get0_peername',nil); {introduced 1.1.0}
  SSL_set_hostflags := LoadFunction('SSL_set_hostflags',nil); {introduced 1.1.0}
  SSL_CTX_dane_enable := LoadFunction('SSL_CTX_dane_enable',nil); {introduced 1.1.0}
  SSL_CTX_dane_mtype_set := LoadFunction('SSL_CTX_dane_mtype_set',nil); {introduced 1.1.0}
  SSL_dane_enable := LoadFunction('SSL_dane_enable',nil); {introduced 1.1.0}
  SSL_dane_tlsa_add := LoadFunction('SSL_dane_tlsa_add',nil); {introduced 1.1.0}
  SSL_get0_dane_authority := LoadFunction('SSL_get0_dane_authority',nil); {introduced 1.1.0}
  SSL_get0_dane_tlsa := LoadFunction('SSL_get0_dane_tlsa',nil); {introduced 1.1.0}
  SSL_get0_dane := LoadFunction('SSL_get0_dane',nil); {introduced 1.1.0}
  SSL_CTX_dane_set_flags := LoadFunction('SSL_CTX_dane_set_flags',nil); {introduced 1.1.0}
  SSL_CTX_dane_clear_flags := LoadFunction('SSL_CTX_dane_clear_flags',nil); {introduced 1.1.0}
  SSL_dane_set_flags := LoadFunction('SSL_dane_set_flags',nil); {introduced 1.1.0}
  SSL_dane_clear_flags := LoadFunction('SSL_dane_clear_flags',nil); {introduced 1.1.0}
  SSL_CTX_set_client_hello_cb := LoadFunction('SSL_CTX_set_client_hello_cb',nil); {introduced 1.1.0}
  SSL_client_hello_isv2 := LoadFunction('SSL_client_hello_isv2',nil); {introduced 1.1.0}
  SSL_client_hello_get0_legacy_version := LoadFunction('SSL_client_hello_get0_legacy_version',nil); {introduced 1.1.0}
  SSL_client_hello_get0_random := LoadFunction('SSL_client_hello_get0_random',nil); {introduced 1.1.0}
  SSL_client_hello_get0_session_id := LoadFunction('SSL_client_hello_get0_session_id',nil); {introduced 1.1.0}
  SSL_client_hello_get0_ciphers := LoadFunction('SSL_client_hello_get0_ciphers',nil); {introduced 1.1.0}
  SSL_client_hello_get0_compression_methods := LoadFunction('SSL_client_hello_get0_compression_methods',nil); {introduced 1.1.0}
  SSL_client_hello_get1_extensions_present := LoadFunction('SSL_client_hello_get1_extensions_present',nil); {introduced 1.1.0}
  SSL_client_hello_get0_ext := LoadFunction('SSL_client_hello_get0_ext',nil); {introduced 1.1.0}
  SSL_waiting_for_async := LoadFunction('SSL_waiting_for_async',nil); {introduced 1.1.0}
  SSL_get_all_async_fds := LoadFunction('SSL_get_all_async_fds',nil); {introduced 1.1.0}
  SSL_get_changed_async_fds := LoadFunction('SSL_get_changed_async_fds',nil); {introduced 1.1.0}
  SSL_stateless := LoadFunction('SSL_stateless',nil); {introduced 1.1.0}
  SSL_read_ex := LoadFunction('SSL_read_ex',nil); {introduced 1.1.0}
  SSL_read_early_data := LoadFunction('SSL_read_early_data',nil); {introduced 1.1.0}
  SSL_peek_ex := LoadFunction('SSL_peek_ex',nil); {introduced 1.1.0}
  SSL_write_ex := LoadFunction('SSL_write_ex',nil); {introduced 1.1.0}
  SSL_write_early_data := LoadFunction('SSL_write_early_data',nil); {introduced 1.1.0}
  SSL_get_early_data_status := LoadFunction('SSL_get_early_data_status',nil); {introduced 1.1.0}
  TLS_method := LoadFunction('TLS_method',nil); {introduced 1.1.0}
  TLS_server_method := LoadFunction('TLS_server_method',nil); {introduced 1.1.0}
  TLS_client_method := LoadFunction('TLS_client_method',nil); {introduced 1.1.0}
  SSL_key_update := LoadFunction('SSL_key_update',nil); {introduced 1.1.0}
  SSL_get_key_update_type := LoadFunction('SSL_get_key_update_type',nil); {introduced 1.1.0}
  SSL_CTX_set_post_handshake_auth := LoadFunction('SSL_CTX_set_post_handshake_auth',nil); {introduced 1.1.0}
  SSL_set_post_handshake_auth := LoadFunction('SSL_set_post_handshake_auth',nil); {introduced 1.1.0}
  SSL_verify_client_post_handshake := LoadFunction('SSL_verify_client_post_handshake',nil); {introduced 1.1.0}
  SSL_library_init := LoadFunction('SSL_library_init',nil); {removed 1.1.0}
  SSL_client_version := LoadFunction('SSL_client_version',nil); {introduced 1.1.0}
  SSL_CTX_set_default_verify_dir := LoadFunction('SSL_CTX_set_default_verify_dir',nil); {introduced 1.1.0}
  SSL_CTX_set_default_verify_file := LoadFunction('SSL_CTX_set_default_verify_file',nil); {introduced 1.1.0}
  SSL_get_state := LoadFunction('SSL_get_state',nil); {introduced 1.1.0}
  SSL_get_client_random := LoadFunction('SSL_get_client_random',nil); {introduced 1.1.0}
  SSL_get_server_random := LoadFunction('SSL_get_server_random',nil); {introduced 1.1.0}
  SSL_SESSION_get_master_key := LoadFunction('SSL_SESSION_get_master_key',nil); {introduced 1.1.0}
  SSL_SESSION_set1_master_key := LoadFunction('SSL_SESSION_set1_master_key',nil); {introduced 1.1.0}
  SSL_SESSION_get_max_fragment_length := LoadFunction('SSL_SESSION_get_max_fragment_length',nil); {introduced 1.1.0}
  SSL_CTX_set_default_read_buffer_len := LoadFunction('SSL_CTX_set_default_read_buffer_len',nil); {introduced 1.1.0}
  SSL_set_default_read_buffer_len := LoadFunction('SSL_set_default_read_buffer_len',nil); {introduced 1.1.0}
  SSL_CIPHER_get_cipher_nid := LoadFunction('SSL_CIPHER_get_cipher_nid',nil); {introduced 1.1.0}
  SSL_CIPHER_get_digest_nid := LoadFunction('SSL_CIPHER_get_digest_nid',nil); {introduced 1.1.0}
  SSL_CTX_set_not_resumable_session_callback := LoadFunction('SSL_CTX_set_not_resumable_session_callback',nil); {introduced 1.1.0}
  SSL_set_not_resumable_session_callback := LoadFunction('SSL_set_not_resumable_session_callback',nil); {introduced 1.1.0}
  SSL_CTX_set_record_padding_callback := LoadFunction('SSL_CTX_set_record_padding_callback',nil); {introduced 1.1.0}
  SSL_CTX_set_record_padding_callback_arg := LoadFunction('SSL_CTX_set_record_padding_callback_arg',nil); {introduced 1.1.0}
  SSL_CTX_get_record_padding_callback_arg := LoadFunction('SSL_CTX_get_record_padding_callback_arg',nil); {introduced 1.1.0}
  SSL_CTX_set_block_padding := LoadFunction('SSL_CTX_set_block_padding',nil); {introduced 1.1.0}
  SSL_set_record_padding_callback := LoadFunction('SSL_set_record_padding_callback',nil); {introduced 1.1.0}
  SSL_set_record_padding_callback_arg := LoadFunction('SSL_set_record_padding_callback_arg',nil); {introduced 1.1.0}
  SSL_get_record_padding_callback_arg := LoadFunction('SSL_get_record_padding_callback_arg',nil); {introduced 1.1.0}
  SSL_set_block_padding := LoadFunction('SSL_set_block_padding',nil); {introduced 1.1.0}
  SSL_set_num_tickets := LoadFunction('SSL_set_num_tickets',nil); {introduced 1.1.0}
  SSL_get_num_tickets := LoadFunction('SSL_get_num_tickets',nil); {introduced 1.1.0}
  SSL_CTX_set_num_tickets := LoadFunction('SSL_CTX_set_num_tickets',nil); {introduced 1.1.0}
  SSL_CTX_get_num_tickets := LoadFunction('SSL_CTX_get_num_tickets',nil); {introduced 1.1.0}
  SSL_session_reused := LoadFunction('SSL_session_reused',nil); {introduced 1.1.0}
  SSL_add_ssl_module := LoadFunction('SSL_add_ssl_module',nil); {introduced 1.1.0}
  SSL_config := LoadFunction('SSL_config',nil); {introduced 1.1.0}
  SSL_CTX_config := LoadFunction('SSL_CTX_config',nil); {introduced 1.1.0}
  DTLSv1_listen := LoadFunction('DTLSv1_listen',nil); {introduced 1.1.0}
  SSL_enable_ct := LoadFunction('SSL_enable_ct',nil); {introduced 1.1.0}
  SSL_CTX_enable_ct := LoadFunction('SSL_CTX_enable_ct',nil); {introduced 1.1.0}
  SSL_ct_is_enabled := LoadFunction('SSL_ct_is_enabled',nil); {introduced 1.1.0}
  SSL_CTX_ct_is_enabled := LoadFunction('SSL_CTX_ct_is_enabled',nil); {introduced 1.1.0}
  SSL_CTX_set_default_ctlog_list_file := LoadFunction('SSL_CTX_set_default_ctlog_list_file',nil); {introduced 1.1.0}
  SSL_CTX_set_ctlog_list_file := LoadFunction('SSL_CTX_set_ctlog_list_file',nil); {introduced 1.1.0}
  SSL_CTX_set0_ctlog_store := LoadFunction('SSL_CTX_set0_ctlog_store',nil); {introduced 1.1.0}
  SSL_set_security_level := LoadFunction('SSL_set_security_level',nil); {introduced 1.1.0}
  SSL_set_security_callback := LoadFunction('SSL_set_security_callback',nil); {introduced 1.1.0}
  SSL_get_security_callback := LoadFunction('SSL_get_security_callback',nil); {introduced 1.1.0}
  SSL_set0_security_ex_data := LoadFunction('SSL_set0_security_ex_data',nil); {introduced 1.1.0}
  SSL_get0_security_ex_data := LoadFunction('SSL_get0_security_ex_data',nil); {introduced 1.1.0}
  SSL_CTX_set_security_level := LoadFunction('SSL_CTX_set_security_level',nil); {introduced 1.1.0}
  SSL_CTX_get_security_level := LoadFunction('SSL_CTX_get_security_level',nil); {introduced 1.1.0}
  SSL_CTX_get0_security_ex_data := LoadFunction('SSL_CTX_get0_security_ex_data',nil); {introduced 1.1.0}
  SSL_CTX_set0_security_ex_data := LoadFunction('SSL_CTX_set0_security_ex_data',nil); {introduced 1.1.0}
  OPENSSL_init_ssl := LoadFunction('OPENSSL_init_ssl',nil); {introduced 1.1.0}
  SSL_free_buffers := LoadFunction('SSL_free_buffers',nil); {introduced 1.1.0}
  SSL_alloc_buffers := LoadFunction('SSL_alloc_buffers',nil); {introduced 1.1.0}
  SSL_CTX_set_session_ticket_cb := LoadFunction('SSL_CTX_set_session_ticket_cb',nil); {introduced 1.1.0}
  SSL_SESSION_set1_ticket_appdata := LoadFunction('SSL_SESSION_set1_ticket_appdata',nil); {introduced 1.1.0}
  SSL_SESSION_get0_ticket_appdata := LoadFunction('SSL_SESSION_get0_ticket_appdata',nil); {introduced 1.1.0}
  DTLS_set_timer_cb := LoadFunction('DTLS_set_timer_cb',nil); {introduced 1.1.0}
  SSL_CTX_set_allow_early_data_cb := LoadFunction('SSL_CTX_set_allow_early_data_cb',nil); {introduced 1.1.0}
  SSL_set_allow_early_data_cb := LoadFunction('SSL_set_allow_early_data_cb',nil); {introduced 1.1.0}
  SSLv2_method := LoadFunction('SSLv2_method',nil); {removed 1.1.0 allow_nil} // SSLv2
  SSLv2_server_method := LoadFunction('SSLv2_server_method',nil); {removed 1.1.0 allow_nil} // SSLv2
  SSLv2_client_method := LoadFunction('SSLv2_client_method',nil); {removed 1.1.0 allow_nil} // SSLv2
  SSLv3_method := LoadFunction('SSLv3_method',nil); {removed 1.1.0 allow_nil} // SSLv3
  SSLv3_server_method := LoadFunction('SSLv3_server_method',nil); {removed 1.1.0 allow_nil} // SSLv3
  SSLv3_client_method := LoadFunction('SSLv3_client_method',nil); {removed 1.1.0 allow_nil} // SSLv3
  SSLv23_method := LoadFunction('SSLv23_method',nil); {removed 1.1.0 allow_nil} // SSLv3 but can rollback to v2
  SSLv23_server_method := LoadFunction('SSLv23_server_method',nil); {removed 1.1.0 allow_nil} // SSLv3 but can rollback to v2
  SSLv23_client_method := LoadFunction('SSLv23_client_method',nil); {removed 1.1.0 allow_nil} // SSLv3 but can rollback to v2
  TLSv1_method := LoadFunction('TLSv1_method',nil); {removed 1.1.0 allow_nil} // TLSv1.0
  TLSv1_server_method := LoadFunction('TLSv1_server_method',nil); {removed 1.1.0 allow_nil} // TLSv1.0
  TLSv1_client_method := LoadFunction('TLSv1_client_method',nil); {removed 1.1.0 allow_nil} // TLSv1.0
  TLSv1_1_method := LoadFunction('TLSv1_1_method',nil); {removed 1.1.0 allow_nil} //TLS1.1
  TLSv1_1_server_method := LoadFunction('TLSv1_1_server_method',nil); {removed 1.1.0 allow_nil} //TLS1.1
  TLSv1_1_client_method := LoadFunction('TLSv1_1_client_method',nil); {removed 1.1.0 allow_nil} //TLS1.1
  TLSv1_2_method := LoadFunction('TLSv1_2_method',nil); {removed 1.1.0 allow_nil}		// TLSv1.2
  TLSv1_2_server_method := LoadFunction('TLSv1_2_server_method',nil); {removed 1.1.0 allow_nil}	// TLSv1.2 
  TLSv1_2_client_method := LoadFunction('TLSv1_2_client_method',nil); {removed 1.1.0 allow_nil}	// TLSv1.2
  SSL_get0_peer_certificate := LoadFunction('SSL_get0_peer_certificate',nil); {introduced 3.3.0}
  SSL_get1_peer_certificate := LoadFunction('SSL_get1_peer_certificate',nil); {introduced 3.3.0}
  if not assigned(SSL_CTX_set_mode) then 
  begin
    {$if declared(SSL_CTX_set_mode_introduced)}
    if LibVersion < SSL_CTX_set_mode_introduced then
      {$if declared(FC_SSL_CTX_set_mode)}
      SSL_CTX_set_mode := @FC_SSL_CTX_set_mode
      {$else}
      SSL_CTX_set_mode := @ERR_SSL_CTX_set_mode
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_mode_removed)}
   if SSL_CTX_set_mode_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_mode)}
     SSL_CTX_set_mode := @_SSL_CTX_set_mode
     {$else}
       {$IF declared(ERR_SSL_CTX_set_mode)}
       SSL_CTX_set_mode := @ERR_SSL_CTX_set_mode
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_mode) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_mode');
  end;


  if not assigned(SSL_CTX_clear_mode) then 
  begin
    {$if declared(SSL_CTX_clear_mode_introduced)}
    if LibVersion < SSL_CTX_clear_mode_introduced then
      {$if declared(FC_SSL_CTX_clear_mode)}
      SSL_CTX_clear_mode := @FC_SSL_CTX_clear_mode
      {$else}
      SSL_CTX_clear_mode := @ERR_SSL_CTX_clear_mode
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_clear_mode_removed)}
   if SSL_CTX_clear_mode_removed <= LibVersion then
     {$if declared(_SSL_CTX_clear_mode)}
     SSL_CTX_clear_mode := @_SSL_CTX_clear_mode
     {$else}
       {$IF declared(ERR_SSL_CTX_clear_mode)}
       SSL_CTX_clear_mode := @ERR_SSL_CTX_clear_mode
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_clear_mode) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_clear_mode');
  end;


  if not assigned(SSL_CTX_sess_set_cache_size) then 
  begin
    {$if declared(SSL_CTX_sess_set_cache_size_introduced)}
    if LibVersion < SSL_CTX_sess_set_cache_size_introduced then
      {$if declared(FC_SSL_CTX_sess_set_cache_size)}
      SSL_CTX_sess_set_cache_size := @FC_SSL_CTX_sess_set_cache_size
      {$else}
      SSL_CTX_sess_set_cache_size := @ERR_SSL_CTX_sess_set_cache_size
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_sess_set_cache_size_removed)}
   if SSL_CTX_sess_set_cache_size_removed <= LibVersion then
     {$if declared(_SSL_CTX_sess_set_cache_size)}
     SSL_CTX_sess_set_cache_size := @_SSL_CTX_sess_set_cache_size
     {$else}
       {$IF declared(ERR_SSL_CTX_sess_set_cache_size)}
       SSL_CTX_sess_set_cache_size := @ERR_SSL_CTX_sess_set_cache_size
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_sess_set_cache_size) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_sess_set_cache_size');
  end;


  if not assigned(SSL_CTX_sess_get_cache_size) then 
  begin
    {$if declared(SSL_CTX_sess_get_cache_size_introduced)}
    if LibVersion < SSL_CTX_sess_get_cache_size_introduced then
      {$if declared(FC_SSL_CTX_sess_get_cache_size)}
      SSL_CTX_sess_get_cache_size := @FC_SSL_CTX_sess_get_cache_size
      {$else}
      SSL_CTX_sess_get_cache_size := @ERR_SSL_CTX_sess_get_cache_size
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_sess_get_cache_size_removed)}
   if SSL_CTX_sess_get_cache_size_removed <= LibVersion then
     {$if declared(_SSL_CTX_sess_get_cache_size)}
     SSL_CTX_sess_get_cache_size := @_SSL_CTX_sess_get_cache_size
     {$else}
       {$IF declared(ERR_SSL_CTX_sess_get_cache_size)}
       SSL_CTX_sess_get_cache_size := @ERR_SSL_CTX_sess_get_cache_size
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_sess_get_cache_size) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_sess_get_cache_size');
  end;


  if not assigned(SSL_CTX_set_session_cache_mode) then 
  begin
    {$if declared(SSL_CTX_set_session_cache_mode_introduced)}
    if LibVersion < SSL_CTX_set_session_cache_mode_introduced then
      {$if declared(FC_SSL_CTX_set_session_cache_mode)}
      SSL_CTX_set_session_cache_mode := @FC_SSL_CTX_set_session_cache_mode
      {$else}
      SSL_CTX_set_session_cache_mode := @ERR_SSL_CTX_set_session_cache_mode
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_session_cache_mode_removed)}
   if SSL_CTX_set_session_cache_mode_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_session_cache_mode)}
     SSL_CTX_set_session_cache_mode := @_SSL_CTX_set_session_cache_mode
     {$else}
       {$IF declared(ERR_SSL_CTX_set_session_cache_mode)}
       SSL_CTX_set_session_cache_mode := @ERR_SSL_CTX_set_session_cache_mode
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_session_cache_mode) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_session_cache_mode');
  end;


  if not assigned(SSL_CTX_get_session_cache_mode) then 
  begin
    {$if declared(SSL_CTX_get_session_cache_mode_introduced)}
    if LibVersion < SSL_CTX_get_session_cache_mode_introduced then
      {$if declared(FC_SSL_CTX_get_session_cache_mode)}
      SSL_CTX_get_session_cache_mode := @FC_SSL_CTX_get_session_cache_mode
      {$else}
      SSL_CTX_get_session_cache_mode := @ERR_SSL_CTX_get_session_cache_mode
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get_session_cache_mode_removed)}
   if SSL_CTX_get_session_cache_mode_removed <= LibVersion then
     {$if declared(_SSL_CTX_get_session_cache_mode)}
     SSL_CTX_get_session_cache_mode := @_SSL_CTX_get_session_cache_mode
     {$else}
       {$IF declared(ERR_SSL_CTX_get_session_cache_mode)}
       SSL_CTX_get_session_cache_mode := @ERR_SSL_CTX_get_session_cache_mode
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get_session_cache_mode) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get_session_cache_mode');
  end;


  if not assigned(SSL_clear_num_renegotiations) then 
  begin
    {$if declared(SSL_clear_num_renegotiations_introduced)}
    if LibVersion < SSL_clear_num_renegotiations_introduced then
      {$if declared(FC_SSL_clear_num_renegotiations)}
      SSL_clear_num_renegotiations := @FC_SSL_clear_num_renegotiations
      {$else}
      SSL_clear_num_renegotiations := @ERR_SSL_clear_num_renegotiations
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_clear_num_renegotiations_removed)}
   if SSL_clear_num_renegotiations_removed <= LibVersion then
     {$if declared(_SSL_clear_num_renegotiations)}
     SSL_clear_num_renegotiations := @_SSL_clear_num_renegotiations
     {$else}
       {$IF declared(ERR_SSL_clear_num_renegotiations)}
       SSL_clear_num_renegotiations := @ERR_SSL_clear_num_renegotiations
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_clear_num_renegotiations) and Assigned(AFailed) then 
     AFailed.Add('SSL_clear_num_renegotiations');
  end;


  if not assigned(SSL_total_renegotiations) then 
  begin
    {$if declared(SSL_total_renegotiations_introduced)}
    if LibVersion < SSL_total_renegotiations_introduced then
      {$if declared(FC_SSL_total_renegotiations)}
      SSL_total_renegotiations := @FC_SSL_total_renegotiations
      {$else}
      SSL_total_renegotiations := @ERR_SSL_total_renegotiations
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_total_renegotiations_removed)}
   if SSL_total_renegotiations_removed <= LibVersion then
     {$if declared(_SSL_total_renegotiations)}
     SSL_total_renegotiations := @_SSL_total_renegotiations
     {$else}
       {$IF declared(ERR_SSL_total_renegotiations)}
       SSL_total_renegotiations := @ERR_SSL_total_renegotiations
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_total_renegotiations) and Assigned(AFailed) then 
     AFailed.Add('SSL_total_renegotiations');
  end;


  if not assigned(SSL_CTX_set_tmp_dh) then 
  begin
    {$if declared(SSL_CTX_set_tmp_dh_introduced)}
    if LibVersion < SSL_CTX_set_tmp_dh_introduced then
      {$if declared(FC_SSL_CTX_set_tmp_dh)}
      SSL_CTX_set_tmp_dh := @FC_SSL_CTX_set_tmp_dh
      {$else}
      SSL_CTX_set_tmp_dh := @ERR_SSL_CTX_set_tmp_dh
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_tmp_dh_removed)}
   if SSL_CTX_set_tmp_dh_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_tmp_dh)}
     SSL_CTX_set_tmp_dh := @_SSL_CTX_set_tmp_dh
     {$else}
       {$IF declared(ERR_SSL_CTX_set_tmp_dh)}
       SSL_CTX_set_tmp_dh := @ERR_SSL_CTX_set_tmp_dh
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_tmp_dh) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_tmp_dh');
  end;


  if not assigned(SSL_CTX_set_tmp_ecdh) then 
  begin
    {$if declared(SSL_CTX_set_tmp_ecdh_introduced)}
    if LibVersion < SSL_CTX_set_tmp_ecdh_introduced then
      {$if declared(FC_SSL_CTX_set_tmp_ecdh)}
      SSL_CTX_set_tmp_ecdh := @FC_SSL_CTX_set_tmp_ecdh
      {$else}
      SSL_CTX_set_tmp_ecdh := @ERR_SSL_CTX_set_tmp_ecdh
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_tmp_ecdh_removed)}
   if SSL_CTX_set_tmp_ecdh_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_tmp_ecdh)}
     SSL_CTX_set_tmp_ecdh := @_SSL_CTX_set_tmp_ecdh
     {$else}
       {$IF declared(ERR_SSL_CTX_set_tmp_ecdh)}
       SSL_CTX_set_tmp_ecdh := @ERR_SSL_CTX_set_tmp_ecdh
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_tmp_ecdh) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_tmp_ecdh');
  end;


  if not assigned(SSL_CTX_set_dh_auto) then 
  begin
    {$if declared(SSL_CTX_set_dh_auto_introduced)}
    if LibVersion < SSL_CTX_set_dh_auto_introduced then
      {$if declared(FC_SSL_CTX_set_dh_auto)}
      SSL_CTX_set_dh_auto := @FC_SSL_CTX_set_dh_auto
      {$else}
      SSL_CTX_set_dh_auto := @ERR_SSL_CTX_set_dh_auto
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_dh_auto_removed)}
   if SSL_CTX_set_dh_auto_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_dh_auto)}
     SSL_CTX_set_dh_auto := @_SSL_CTX_set_dh_auto
     {$else}
       {$IF declared(ERR_SSL_CTX_set_dh_auto)}
       SSL_CTX_set_dh_auto := @ERR_SSL_CTX_set_dh_auto
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_dh_auto) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_dh_auto');
  end;


  if not assigned(SSL_set_dh_auto) then 
  begin
    {$if declared(SSL_set_dh_auto_introduced)}
    if LibVersion < SSL_set_dh_auto_introduced then
      {$if declared(FC_SSL_set_dh_auto)}
      SSL_set_dh_auto := @FC_SSL_set_dh_auto
      {$else}
      SSL_set_dh_auto := @ERR_SSL_set_dh_auto
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_dh_auto_removed)}
   if SSL_set_dh_auto_removed <= LibVersion then
     {$if declared(_SSL_set_dh_auto)}
     SSL_set_dh_auto := @_SSL_set_dh_auto
     {$else}
       {$IF declared(ERR_SSL_set_dh_auto)}
       SSL_set_dh_auto := @ERR_SSL_set_dh_auto
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_dh_auto) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_dh_auto');
  end;


  if not assigned(SSL_set_tmp_dh) then 
  begin
    {$if declared(SSL_set_tmp_dh_introduced)}
    if LibVersion < SSL_set_tmp_dh_introduced then
      {$if declared(FC_SSL_set_tmp_dh)}
      SSL_set_tmp_dh := @FC_SSL_set_tmp_dh
      {$else}
      SSL_set_tmp_dh := @ERR_SSL_set_tmp_dh
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_tmp_dh_removed)}
   if SSL_set_tmp_dh_removed <= LibVersion then
     {$if declared(_SSL_set_tmp_dh)}
     SSL_set_tmp_dh := @_SSL_set_tmp_dh
     {$else}
       {$IF declared(ERR_SSL_set_tmp_dh)}
       SSL_set_tmp_dh := @ERR_SSL_set_tmp_dh
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_tmp_dh) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_tmp_dh');
  end;


  if not assigned(SSL_set_tmp_ecdh) then 
  begin
    {$if declared(SSL_set_tmp_ecdh_introduced)}
    if LibVersion < SSL_set_tmp_ecdh_introduced then
      {$if declared(FC_SSL_set_tmp_ecdh)}
      SSL_set_tmp_ecdh := @FC_SSL_set_tmp_ecdh
      {$else}
      SSL_set_tmp_ecdh := @ERR_SSL_set_tmp_ecdh
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_tmp_ecdh_removed)}
   if SSL_set_tmp_ecdh_removed <= LibVersion then
     {$if declared(_SSL_set_tmp_ecdh)}
     SSL_set_tmp_ecdh := @_SSL_set_tmp_ecdh
     {$else}
       {$IF declared(ERR_SSL_set_tmp_ecdh)}
       SSL_set_tmp_ecdh := @ERR_SSL_set_tmp_ecdh
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_tmp_ecdh) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_tmp_ecdh');
  end;


  if not assigned(SSL_CTX_add_extra_chain_cert) then 
  begin
    {$if declared(SSL_CTX_add_extra_chain_cert_introduced)}
    if LibVersion < SSL_CTX_add_extra_chain_cert_introduced then
      {$if declared(FC_SSL_CTX_add_extra_chain_cert)}
      SSL_CTX_add_extra_chain_cert := @FC_SSL_CTX_add_extra_chain_cert
      {$else}
      SSL_CTX_add_extra_chain_cert := @ERR_SSL_CTX_add_extra_chain_cert
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_add_extra_chain_cert_removed)}
   if SSL_CTX_add_extra_chain_cert_removed <= LibVersion then
     {$if declared(_SSL_CTX_add_extra_chain_cert)}
     SSL_CTX_add_extra_chain_cert := @_SSL_CTX_add_extra_chain_cert
     {$else}
       {$IF declared(ERR_SSL_CTX_add_extra_chain_cert)}
       SSL_CTX_add_extra_chain_cert := @ERR_SSL_CTX_add_extra_chain_cert
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_add_extra_chain_cert) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_add_extra_chain_cert');
  end;


  if not assigned(SSL_CTX_get_extra_chain_certs) then 
  begin
    {$if declared(SSL_CTX_get_extra_chain_certs_introduced)}
    if LibVersion < SSL_CTX_get_extra_chain_certs_introduced then
      {$if declared(FC_SSL_CTX_get_extra_chain_certs)}
      SSL_CTX_get_extra_chain_certs := @FC_SSL_CTX_get_extra_chain_certs
      {$else}
      SSL_CTX_get_extra_chain_certs := @ERR_SSL_CTX_get_extra_chain_certs
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get_extra_chain_certs_removed)}
   if SSL_CTX_get_extra_chain_certs_removed <= LibVersion then
     {$if declared(_SSL_CTX_get_extra_chain_certs)}
     SSL_CTX_get_extra_chain_certs := @_SSL_CTX_get_extra_chain_certs
     {$else}
       {$IF declared(ERR_SSL_CTX_get_extra_chain_certs)}
       SSL_CTX_get_extra_chain_certs := @ERR_SSL_CTX_get_extra_chain_certs
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get_extra_chain_certs) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get_extra_chain_certs');
  end;


  if not assigned(SSL_CTX_get_extra_chain_certs_only) then 
  begin
    {$if declared(SSL_CTX_get_extra_chain_certs_only_introduced)}
    if LibVersion < SSL_CTX_get_extra_chain_certs_only_introduced then
      {$if declared(FC_SSL_CTX_get_extra_chain_certs_only)}
      SSL_CTX_get_extra_chain_certs_only := @FC_SSL_CTX_get_extra_chain_certs_only
      {$else}
      SSL_CTX_get_extra_chain_certs_only := @ERR_SSL_CTX_get_extra_chain_certs_only
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get_extra_chain_certs_only_removed)}
   if SSL_CTX_get_extra_chain_certs_only_removed <= LibVersion then
     {$if declared(_SSL_CTX_get_extra_chain_certs_only)}
     SSL_CTX_get_extra_chain_certs_only := @_SSL_CTX_get_extra_chain_certs_only
     {$else}
       {$IF declared(ERR_SSL_CTX_get_extra_chain_certs_only)}
       SSL_CTX_get_extra_chain_certs_only := @ERR_SSL_CTX_get_extra_chain_certs_only
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get_extra_chain_certs_only) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get_extra_chain_certs_only');
  end;


  if not assigned(SSL_CTX_clear_extra_chain_certs) then 
  begin
    {$if declared(SSL_CTX_clear_extra_chain_certs_introduced)}
    if LibVersion < SSL_CTX_clear_extra_chain_certs_introduced then
      {$if declared(FC_SSL_CTX_clear_extra_chain_certs)}
      SSL_CTX_clear_extra_chain_certs := @FC_SSL_CTX_clear_extra_chain_certs
      {$else}
      SSL_CTX_clear_extra_chain_certs := @ERR_SSL_CTX_clear_extra_chain_certs
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_clear_extra_chain_certs_removed)}
   if SSL_CTX_clear_extra_chain_certs_removed <= LibVersion then
     {$if declared(_SSL_CTX_clear_extra_chain_certs)}
     SSL_CTX_clear_extra_chain_certs := @_SSL_CTX_clear_extra_chain_certs
     {$else}
       {$IF declared(ERR_SSL_CTX_clear_extra_chain_certs)}
       SSL_CTX_clear_extra_chain_certs := @ERR_SSL_CTX_clear_extra_chain_certs
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_clear_extra_chain_certs) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_clear_extra_chain_certs');
  end;


  if not assigned(SSL_CTX_set0_chain) then 
  begin
    {$if declared(SSL_CTX_set0_chain_introduced)}
    if LibVersion < SSL_CTX_set0_chain_introduced then
      {$if declared(FC_SSL_CTX_set0_chain)}
      SSL_CTX_set0_chain := @FC_SSL_CTX_set0_chain
      {$else}
      SSL_CTX_set0_chain := @ERR_SSL_CTX_set0_chain
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set0_chain_removed)}
   if SSL_CTX_set0_chain_removed <= LibVersion then
     {$if declared(_SSL_CTX_set0_chain)}
     SSL_CTX_set0_chain := @_SSL_CTX_set0_chain
     {$else}
       {$IF declared(ERR_SSL_CTX_set0_chain)}
       SSL_CTX_set0_chain := @ERR_SSL_CTX_set0_chain
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set0_chain) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set0_chain');
  end;


  if not assigned(SSL_CTX_set1_chain) then 
  begin
    {$if declared(SSL_CTX_set1_chain_introduced)}
    if LibVersion < SSL_CTX_set1_chain_introduced then
      {$if declared(FC_SSL_CTX_set1_chain)}
      SSL_CTX_set1_chain := @FC_SSL_CTX_set1_chain
      {$else}
      SSL_CTX_set1_chain := @ERR_SSL_CTX_set1_chain
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set1_chain_removed)}
   if SSL_CTX_set1_chain_removed <= LibVersion then
     {$if declared(_SSL_CTX_set1_chain)}
     SSL_CTX_set1_chain := @_SSL_CTX_set1_chain
     {$else}
       {$IF declared(ERR_SSL_CTX_set1_chain)}
       SSL_CTX_set1_chain := @ERR_SSL_CTX_set1_chain
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set1_chain) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set1_chain');
  end;


  if not assigned(SSL_CTX_add0_chain_cert) then 
  begin
    {$if declared(SSL_CTX_add0_chain_cert_introduced)}
    if LibVersion < SSL_CTX_add0_chain_cert_introduced then
      {$if declared(FC_SSL_CTX_add0_chain_cert)}
      SSL_CTX_add0_chain_cert := @FC_SSL_CTX_add0_chain_cert
      {$else}
      SSL_CTX_add0_chain_cert := @ERR_SSL_CTX_add0_chain_cert
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_add0_chain_cert_removed)}
   if SSL_CTX_add0_chain_cert_removed <= LibVersion then
     {$if declared(_SSL_CTX_add0_chain_cert)}
     SSL_CTX_add0_chain_cert := @_SSL_CTX_add0_chain_cert
     {$else}
       {$IF declared(ERR_SSL_CTX_add0_chain_cert)}
       SSL_CTX_add0_chain_cert := @ERR_SSL_CTX_add0_chain_cert
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_add0_chain_cert) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_add0_chain_cert');
  end;


  if not assigned(SSL_CTX_add1_chain_cert) then 
  begin
    {$if declared(SSL_CTX_add1_chain_cert_introduced)}
    if LibVersion < SSL_CTX_add1_chain_cert_introduced then
      {$if declared(FC_SSL_CTX_add1_chain_cert)}
      SSL_CTX_add1_chain_cert := @FC_SSL_CTX_add1_chain_cert
      {$else}
      SSL_CTX_add1_chain_cert := @ERR_SSL_CTX_add1_chain_cert
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_add1_chain_cert_removed)}
   if SSL_CTX_add1_chain_cert_removed <= LibVersion then
     {$if declared(_SSL_CTX_add1_chain_cert)}
     SSL_CTX_add1_chain_cert := @_SSL_CTX_add1_chain_cert
     {$else}
       {$IF declared(ERR_SSL_CTX_add1_chain_cert)}
       SSL_CTX_add1_chain_cert := @ERR_SSL_CTX_add1_chain_cert
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_add1_chain_cert) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_add1_chain_cert');
  end;


  if not assigned(SSL_CTX_get0_chain_certs) then 
  begin
    {$if declared(SSL_CTX_get0_chain_certs_introduced)}
    if LibVersion < SSL_CTX_get0_chain_certs_introduced then
      {$if declared(FC_SSL_CTX_get0_chain_certs)}
      SSL_CTX_get0_chain_certs := @FC_SSL_CTX_get0_chain_certs
      {$else}
      SSL_CTX_get0_chain_certs := @ERR_SSL_CTX_get0_chain_certs
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get0_chain_certs_removed)}
   if SSL_CTX_get0_chain_certs_removed <= LibVersion then
     {$if declared(_SSL_CTX_get0_chain_certs)}
     SSL_CTX_get0_chain_certs := @_SSL_CTX_get0_chain_certs
     {$else}
       {$IF declared(ERR_SSL_CTX_get0_chain_certs)}
       SSL_CTX_get0_chain_certs := @ERR_SSL_CTX_get0_chain_certs
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get0_chain_certs) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get0_chain_certs');
  end;


  if not assigned(SSL_CTX_clear_chain_certs) then 
  begin
    {$if declared(SSL_CTX_clear_chain_certs_introduced)}
    if LibVersion < SSL_CTX_clear_chain_certs_introduced then
      {$if declared(FC_SSL_CTX_clear_chain_certs)}
      SSL_CTX_clear_chain_certs := @FC_SSL_CTX_clear_chain_certs
      {$else}
      SSL_CTX_clear_chain_certs := @ERR_SSL_CTX_clear_chain_certs
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_clear_chain_certs_removed)}
   if SSL_CTX_clear_chain_certs_removed <= LibVersion then
     {$if declared(_SSL_CTX_clear_chain_certs)}
     SSL_CTX_clear_chain_certs := @_SSL_CTX_clear_chain_certs
     {$else}
       {$IF declared(ERR_SSL_CTX_clear_chain_certs)}
       SSL_CTX_clear_chain_certs := @ERR_SSL_CTX_clear_chain_certs
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_clear_chain_certs) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_clear_chain_certs');
  end;


  if not assigned(SSL_CTX_build_cert_chain) then 
  begin
    {$if declared(SSL_CTX_build_cert_chain_introduced)}
    if LibVersion < SSL_CTX_build_cert_chain_introduced then
      {$if declared(FC_SSL_CTX_build_cert_chain)}
      SSL_CTX_build_cert_chain := @FC_SSL_CTX_build_cert_chain
      {$else}
      SSL_CTX_build_cert_chain := @ERR_SSL_CTX_build_cert_chain
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_build_cert_chain_removed)}
   if SSL_CTX_build_cert_chain_removed <= LibVersion then
     {$if declared(_SSL_CTX_build_cert_chain)}
     SSL_CTX_build_cert_chain := @_SSL_CTX_build_cert_chain
     {$else}
       {$IF declared(ERR_SSL_CTX_build_cert_chain)}
       SSL_CTX_build_cert_chain := @ERR_SSL_CTX_build_cert_chain
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_build_cert_chain) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_build_cert_chain');
  end;


  if not assigned(SSL_CTX_select_current_cert) then 
  begin
    {$if declared(SSL_CTX_select_current_cert_introduced)}
    if LibVersion < SSL_CTX_select_current_cert_introduced then
      {$if declared(FC_SSL_CTX_select_current_cert)}
      SSL_CTX_select_current_cert := @FC_SSL_CTX_select_current_cert
      {$else}
      SSL_CTX_select_current_cert := @ERR_SSL_CTX_select_current_cert
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_select_current_cert_removed)}
   if SSL_CTX_select_current_cert_removed <= LibVersion then
     {$if declared(_SSL_CTX_select_current_cert)}
     SSL_CTX_select_current_cert := @_SSL_CTX_select_current_cert
     {$else}
       {$IF declared(ERR_SSL_CTX_select_current_cert)}
       SSL_CTX_select_current_cert := @ERR_SSL_CTX_select_current_cert
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_select_current_cert) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_select_current_cert');
  end;


  if not assigned(SSL_CTX_set_current_cert) then 
  begin
    {$if declared(SSL_CTX_set_current_cert_introduced)}
    if LibVersion < SSL_CTX_set_current_cert_introduced then
      {$if declared(FC_SSL_CTX_set_current_cert)}
      SSL_CTX_set_current_cert := @FC_SSL_CTX_set_current_cert
      {$else}
      SSL_CTX_set_current_cert := @ERR_SSL_CTX_set_current_cert
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_current_cert_removed)}
   if SSL_CTX_set_current_cert_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_current_cert)}
     SSL_CTX_set_current_cert := @_SSL_CTX_set_current_cert
     {$else}
       {$IF declared(ERR_SSL_CTX_set_current_cert)}
       SSL_CTX_set_current_cert := @ERR_SSL_CTX_set_current_cert
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_current_cert) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_current_cert');
  end;


  if not assigned(SSL_CTX_set0_verify_cert_store) then 
  begin
    {$if declared(SSL_CTX_set0_verify_cert_store_introduced)}
    if LibVersion < SSL_CTX_set0_verify_cert_store_introduced then
      {$if declared(FC_SSL_CTX_set0_verify_cert_store)}
      SSL_CTX_set0_verify_cert_store := @FC_SSL_CTX_set0_verify_cert_store
      {$else}
      SSL_CTX_set0_verify_cert_store := @ERR_SSL_CTX_set0_verify_cert_store
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set0_verify_cert_store_removed)}
   if SSL_CTX_set0_verify_cert_store_removed <= LibVersion then
     {$if declared(_SSL_CTX_set0_verify_cert_store)}
     SSL_CTX_set0_verify_cert_store := @_SSL_CTX_set0_verify_cert_store
     {$else}
       {$IF declared(ERR_SSL_CTX_set0_verify_cert_store)}
       SSL_CTX_set0_verify_cert_store := @ERR_SSL_CTX_set0_verify_cert_store
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set0_verify_cert_store) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set0_verify_cert_store');
  end;


  if not assigned(SSL_CTX_set1_verify_cert_store) then 
  begin
    {$if declared(SSL_CTX_set1_verify_cert_store_introduced)}
    if LibVersion < SSL_CTX_set1_verify_cert_store_introduced then
      {$if declared(FC_SSL_CTX_set1_verify_cert_store)}
      SSL_CTX_set1_verify_cert_store := @FC_SSL_CTX_set1_verify_cert_store
      {$else}
      SSL_CTX_set1_verify_cert_store := @ERR_SSL_CTX_set1_verify_cert_store
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set1_verify_cert_store_removed)}
   if SSL_CTX_set1_verify_cert_store_removed <= LibVersion then
     {$if declared(_SSL_CTX_set1_verify_cert_store)}
     SSL_CTX_set1_verify_cert_store := @_SSL_CTX_set1_verify_cert_store
     {$else}
       {$IF declared(ERR_SSL_CTX_set1_verify_cert_store)}
       SSL_CTX_set1_verify_cert_store := @ERR_SSL_CTX_set1_verify_cert_store
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set1_verify_cert_store) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set1_verify_cert_store');
  end;


  if not assigned(SSL_CTX_set0_chain_cert_store) then 
  begin
    {$if declared(SSL_CTX_set0_chain_cert_store_introduced)}
    if LibVersion < SSL_CTX_set0_chain_cert_store_introduced then
      {$if declared(FC_SSL_CTX_set0_chain_cert_store)}
      SSL_CTX_set0_chain_cert_store := @FC_SSL_CTX_set0_chain_cert_store
      {$else}
      SSL_CTX_set0_chain_cert_store := @ERR_SSL_CTX_set0_chain_cert_store
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set0_chain_cert_store_removed)}
   if SSL_CTX_set0_chain_cert_store_removed <= LibVersion then
     {$if declared(_SSL_CTX_set0_chain_cert_store)}
     SSL_CTX_set0_chain_cert_store := @_SSL_CTX_set0_chain_cert_store
     {$else}
       {$IF declared(ERR_SSL_CTX_set0_chain_cert_store)}
       SSL_CTX_set0_chain_cert_store := @ERR_SSL_CTX_set0_chain_cert_store
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set0_chain_cert_store) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set0_chain_cert_store');
  end;


  if not assigned(SSL_CTX_set1_chain_cert_store) then 
  begin
    {$if declared(SSL_CTX_set1_chain_cert_store_introduced)}
    if LibVersion < SSL_CTX_set1_chain_cert_store_introduced then
      {$if declared(FC_SSL_CTX_set1_chain_cert_store)}
      SSL_CTX_set1_chain_cert_store := @FC_SSL_CTX_set1_chain_cert_store
      {$else}
      SSL_CTX_set1_chain_cert_store := @ERR_SSL_CTX_set1_chain_cert_store
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set1_chain_cert_store_removed)}
   if SSL_CTX_set1_chain_cert_store_removed <= LibVersion then
     {$if declared(_SSL_CTX_set1_chain_cert_store)}
     SSL_CTX_set1_chain_cert_store := @_SSL_CTX_set1_chain_cert_store
     {$else}
       {$IF declared(ERR_SSL_CTX_set1_chain_cert_store)}
       SSL_CTX_set1_chain_cert_store := @ERR_SSL_CTX_set1_chain_cert_store
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set1_chain_cert_store) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set1_chain_cert_store');
  end;


  if not assigned(SSL_set0_chain) then 
  begin
    {$if declared(SSL_set0_chain_introduced)}
    if LibVersion < SSL_set0_chain_introduced then
      {$if declared(FC_SSL_set0_chain)}
      SSL_set0_chain := @FC_SSL_set0_chain
      {$else}
      SSL_set0_chain := @ERR_SSL_set0_chain
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set0_chain_removed)}
   if SSL_set0_chain_removed <= LibVersion then
     {$if declared(_SSL_set0_chain)}
     SSL_set0_chain := @_SSL_set0_chain
     {$else}
       {$IF declared(ERR_SSL_set0_chain)}
       SSL_set0_chain := @ERR_SSL_set0_chain
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set0_chain) and Assigned(AFailed) then 
     AFailed.Add('SSL_set0_chain');
  end;


  if not assigned(SSL_set1_chain) then 
  begin
    {$if declared(SSL_set1_chain_introduced)}
    if LibVersion < SSL_set1_chain_introduced then
      {$if declared(FC_SSL_set1_chain)}
      SSL_set1_chain := @FC_SSL_set1_chain
      {$else}
      SSL_set1_chain := @ERR_SSL_set1_chain
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set1_chain_removed)}
   if SSL_set1_chain_removed <= LibVersion then
     {$if declared(_SSL_set1_chain)}
     SSL_set1_chain := @_SSL_set1_chain
     {$else}
       {$IF declared(ERR_SSL_set1_chain)}
       SSL_set1_chain := @ERR_SSL_set1_chain
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set1_chain) and Assigned(AFailed) then 
     AFailed.Add('SSL_set1_chain');
  end;


  if not assigned(SSL_add0_chain_cert) then 
  begin
    {$if declared(SSL_add0_chain_cert_introduced)}
    if LibVersion < SSL_add0_chain_cert_introduced then
      {$if declared(FC_SSL_add0_chain_cert)}
      SSL_add0_chain_cert := @FC_SSL_add0_chain_cert
      {$else}
      SSL_add0_chain_cert := @ERR_SSL_add0_chain_cert
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_add0_chain_cert_removed)}
   if SSL_add0_chain_cert_removed <= LibVersion then
     {$if declared(_SSL_add0_chain_cert)}
     SSL_add0_chain_cert := @_SSL_add0_chain_cert
     {$else}
       {$IF declared(ERR_SSL_add0_chain_cert)}
       SSL_add0_chain_cert := @ERR_SSL_add0_chain_cert
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_add0_chain_cert) and Assigned(AFailed) then 
     AFailed.Add('SSL_add0_chain_cert');
  end;


  if not assigned(SSL_add1_chain_cert) then 
  begin
    {$if declared(SSL_add1_chain_cert_introduced)}
    if LibVersion < SSL_add1_chain_cert_introduced then
      {$if declared(FC_SSL_add1_chain_cert)}
      SSL_add1_chain_cert := @FC_SSL_add1_chain_cert
      {$else}
      SSL_add1_chain_cert := @ERR_SSL_add1_chain_cert
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_add1_chain_cert_removed)}
   if SSL_add1_chain_cert_removed <= LibVersion then
     {$if declared(_SSL_add1_chain_cert)}
     SSL_add1_chain_cert := @_SSL_add1_chain_cert
     {$else}
       {$IF declared(ERR_SSL_add1_chain_cert)}
       SSL_add1_chain_cert := @ERR_SSL_add1_chain_cert
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_add1_chain_cert) and Assigned(AFailed) then 
     AFailed.Add('SSL_add1_chain_cert');
  end;


  if not assigned(SSL_get0_chain_certs) then 
  begin
    {$if declared(SSL_get0_chain_certs_introduced)}
    if LibVersion < SSL_get0_chain_certs_introduced then
      {$if declared(FC_SSL_get0_chain_certs)}
      SSL_get0_chain_certs := @FC_SSL_get0_chain_certs
      {$else}
      SSL_get0_chain_certs := @ERR_SSL_get0_chain_certs
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get0_chain_certs_removed)}
   if SSL_get0_chain_certs_removed <= LibVersion then
     {$if declared(_SSL_get0_chain_certs)}
     SSL_get0_chain_certs := @_SSL_get0_chain_certs
     {$else}
       {$IF declared(ERR_SSL_get0_chain_certs)}
       SSL_get0_chain_certs := @ERR_SSL_get0_chain_certs
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get0_chain_certs) and Assigned(AFailed) then 
     AFailed.Add('SSL_get0_chain_certs');
  end;


  if not assigned(SSL_clear_chain_certs) then 
  begin
    {$if declared(SSL_clear_chain_certs_introduced)}
    if LibVersion < SSL_clear_chain_certs_introduced then
      {$if declared(FC_SSL_clear_chain_certs)}
      SSL_clear_chain_certs := @FC_SSL_clear_chain_certs
      {$else}
      SSL_clear_chain_certs := @ERR_SSL_clear_chain_certs
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_clear_chain_certs_removed)}
   if SSL_clear_chain_certs_removed <= LibVersion then
     {$if declared(_SSL_clear_chain_certs)}
     SSL_clear_chain_certs := @_SSL_clear_chain_certs
     {$else}
       {$IF declared(ERR_SSL_clear_chain_certs)}
       SSL_clear_chain_certs := @ERR_SSL_clear_chain_certs
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_clear_chain_certs) and Assigned(AFailed) then 
     AFailed.Add('SSL_clear_chain_certs');
  end;


  if not assigned(SSL_build_cert_chain) then 
  begin
    {$if declared(SSL_build_cert_chain_introduced)}
    if LibVersion < SSL_build_cert_chain_introduced then
      {$if declared(FC_SSL_build_cert_chain)}
      SSL_build_cert_chain := @FC_SSL_build_cert_chain
      {$else}
      SSL_build_cert_chain := @ERR_SSL_build_cert_chain
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_build_cert_chain_removed)}
   if SSL_build_cert_chain_removed <= LibVersion then
     {$if declared(_SSL_build_cert_chain)}
     SSL_build_cert_chain := @_SSL_build_cert_chain
     {$else}
       {$IF declared(ERR_SSL_build_cert_chain)}
       SSL_build_cert_chain := @ERR_SSL_build_cert_chain
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_build_cert_chain) and Assigned(AFailed) then 
     AFailed.Add('SSL_build_cert_chain');
  end;


  if not assigned(SSL_select_current_cert) then 
  begin
    {$if declared(SSL_select_current_cert_introduced)}
    if LibVersion < SSL_select_current_cert_introduced then
      {$if declared(FC_SSL_select_current_cert)}
      SSL_select_current_cert := @FC_SSL_select_current_cert
      {$else}
      SSL_select_current_cert := @ERR_SSL_select_current_cert
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_select_current_cert_removed)}
   if SSL_select_current_cert_removed <= LibVersion then
     {$if declared(_SSL_select_current_cert)}
     SSL_select_current_cert := @_SSL_select_current_cert
     {$else}
       {$IF declared(ERR_SSL_select_current_cert)}
       SSL_select_current_cert := @ERR_SSL_select_current_cert
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_select_current_cert) and Assigned(AFailed) then 
     AFailed.Add('SSL_select_current_cert');
  end;


  if not assigned(SSL_set_current_cert) then 
  begin
    {$if declared(SSL_set_current_cert_introduced)}
    if LibVersion < SSL_set_current_cert_introduced then
      {$if declared(FC_SSL_set_current_cert)}
      SSL_set_current_cert := @FC_SSL_set_current_cert
      {$else}
      SSL_set_current_cert := @ERR_SSL_set_current_cert
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_current_cert_removed)}
   if SSL_set_current_cert_removed <= LibVersion then
     {$if declared(_SSL_set_current_cert)}
     SSL_set_current_cert := @_SSL_set_current_cert
     {$else}
       {$IF declared(ERR_SSL_set_current_cert)}
       SSL_set_current_cert := @ERR_SSL_set_current_cert
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_current_cert) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_current_cert');
  end;


  if not assigned(SSL_set0_verify_cert_store) then 
  begin
    {$if declared(SSL_set0_verify_cert_store_introduced)}
    if LibVersion < SSL_set0_verify_cert_store_introduced then
      {$if declared(FC_SSL_set0_verify_cert_store)}
      SSL_set0_verify_cert_store := @FC_SSL_set0_verify_cert_store
      {$else}
      SSL_set0_verify_cert_store := @ERR_SSL_set0_verify_cert_store
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set0_verify_cert_store_removed)}
   if SSL_set0_verify_cert_store_removed <= LibVersion then
     {$if declared(_SSL_set0_verify_cert_store)}
     SSL_set0_verify_cert_store := @_SSL_set0_verify_cert_store
     {$else}
       {$IF declared(ERR_SSL_set0_verify_cert_store)}
       SSL_set0_verify_cert_store := @ERR_SSL_set0_verify_cert_store
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set0_verify_cert_store) and Assigned(AFailed) then 
     AFailed.Add('SSL_set0_verify_cert_store');
  end;


  if not assigned(SSL_set1_verify_cert_store) then 
  begin
    {$if declared(SSL_set1_verify_cert_store_introduced)}
    if LibVersion < SSL_set1_verify_cert_store_introduced then
      {$if declared(FC_SSL_set1_verify_cert_store)}
      SSL_set1_verify_cert_store := @FC_SSL_set1_verify_cert_store
      {$else}
      SSL_set1_verify_cert_store := @ERR_SSL_set1_verify_cert_store
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set1_verify_cert_store_removed)}
   if SSL_set1_verify_cert_store_removed <= LibVersion then
     {$if declared(_SSL_set1_verify_cert_store)}
     SSL_set1_verify_cert_store := @_SSL_set1_verify_cert_store
     {$else}
       {$IF declared(ERR_SSL_set1_verify_cert_store)}
       SSL_set1_verify_cert_store := @ERR_SSL_set1_verify_cert_store
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set1_verify_cert_store) and Assigned(AFailed) then 
     AFailed.Add('SSL_set1_verify_cert_store');
  end;


  if not assigned(SSL_set0_chain_cert_store) then 
  begin
    {$if declared(SSL_set0_chain_cert_store_introduced)}
    if LibVersion < SSL_set0_chain_cert_store_introduced then
      {$if declared(FC_SSL_set0_chain_cert_store)}
      SSL_set0_chain_cert_store := @FC_SSL_set0_chain_cert_store
      {$else}
      SSL_set0_chain_cert_store := @ERR_SSL_set0_chain_cert_store
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set0_chain_cert_store_removed)}
   if SSL_set0_chain_cert_store_removed <= LibVersion then
     {$if declared(_SSL_set0_chain_cert_store)}
     SSL_set0_chain_cert_store := @_SSL_set0_chain_cert_store
     {$else}
       {$IF declared(ERR_SSL_set0_chain_cert_store)}
       SSL_set0_chain_cert_store := @ERR_SSL_set0_chain_cert_store
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set0_chain_cert_store) and Assigned(AFailed) then 
     AFailed.Add('SSL_set0_chain_cert_store');
  end;


  if not assigned(SSL_set1_chain_cert_store) then 
  begin
    {$if declared(SSL_set1_chain_cert_store_introduced)}
    if LibVersion < SSL_set1_chain_cert_store_introduced then
      {$if declared(FC_SSL_set1_chain_cert_store)}
      SSL_set1_chain_cert_store := @FC_SSL_set1_chain_cert_store
      {$else}
      SSL_set1_chain_cert_store := @ERR_SSL_set1_chain_cert_store
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set1_chain_cert_store_removed)}
   if SSL_set1_chain_cert_store_removed <= LibVersion then
     {$if declared(_SSL_set1_chain_cert_store)}
     SSL_set1_chain_cert_store := @_SSL_set1_chain_cert_store
     {$else}
       {$IF declared(ERR_SSL_set1_chain_cert_store)}
       SSL_set1_chain_cert_store := @ERR_SSL_set1_chain_cert_store
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set1_chain_cert_store) and Assigned(AFailed) then 
     AFailed.Add('SSL_set1_chain_cert_store');
  end;


  if not assigned(SSL_get1_groups) then 
  begin
    {$if declared(SSL_get1_groups_introduced)}
    if LibVersion < SSL_get1_groups_introduced then
      {$if declared(FC_SSL_get1_groups)}
      SSL_get1_groups := @FC_SSL_get1_groups
      {$else}
      SSL_get1_groups := @ERR_SSL_get1_groups
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get1_groups_removed)}
   if SSL_get1_groups_removed <= LibVersion then
     {$if declared(_SSL_get1_groups)}
     SSL_get1_groups := @_SSL_get1_groups
     {$else}
       {$IF declared(ERR_SSL_get1_groups)}
       SSL_get1_groups := @ERR_SSL_get1_groups
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get1_groups) and Assigned(AFailed) then 
     AFailed.Add('SSL_get1_groups');
  end;


  if not assigned(SSL_CTX_set1_groups) then 
  begin
    {$if declared(SSL_CTX_set1_groups_introduced)}
    if LibVersion < SSL_CTX_set1_groups_introduced then
      {$if declared(FC_SSL_CTX_set1_groups)}
      SSL_CTX_set1_groups := @FC_SSL_CTX_set1_groups
      {$else}
      SSL_CTX_set1_groups := @ERR_SSL_CTX_set1_groups
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set1_groups_removed)}
   if SSL_CTX_set1_groups_removed <= LibVersion then
     {$if declared(_SSL_CTX_set1_groups)}
     SSL_CTX_set1_groups := @_SSL_CTX_set1_groups
     {$else}
       {$IF declared(ERR_SSL_CTX_set1_groups)}
       SSL_CTX_set1_groups := @ERR_SSL_CTX_set1_groups
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set1_groups) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set1_groups');
  end;


  if not assigned(SSL_CTX_set1_groups_list) then 
  begin
    {$if declared(SSL_CTX_set1_groups_list_introduced)}
    if LibVersion < SSL_CTX_set1_groups_list_introduced then
      {$if declared(FC_SSL_CTX_set1_groups_list)}
      SSL_CTX_set1_groups_list := @FC_SSL_CTX_set1_groups_list
      {$else}
      SSL_CTX_set1_groups_list := @ERR_SSL_CTX_set1_groups_list
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set1_groups_list_removed)}
   if SSL_CTX_set1_groups_list_removed <= LibVersion then
     {$if declared(_SSL_CTX_set1_groups_list)}
     SSL_CTX_set1_groups_list := @_SSL_CTX_set1_groups_list
     {$else}
       {$IF declared(ERR_SSL_CTX_set1_groups_list)}
       SSL_CTX_set1_groups_list := @ERR_SSL_CTX_set1_groups_list
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set1_groups_list) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set1_groups_list');
  end;


  if not assigned(SSL_set1_groups) then 
  begin
    {$if declared(SSL_set1_groups_introduced)}
    if LibVersion < SSL_set1_groups_introduced then
      {$if declared(FC_SSL_set1_groups)}
      SSL_set1_groups := @FC_SSL_set1_groups
      {$else}
      SSL_set1_groups := @ERR_SSL_set1_groups
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set1_groups_removed)}
   if SSL_set1_groups_removed <= LibVersion then
     {$if declared(_SSL_set1_groups)}
     SSL_set1_groups := @_SSL_set1_groups
     {$else}
       {$IF declared(ERR_SSL_set1_groups)}
       SSL_set1_groups := @ERR_SSL_set1_groups
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set1_groups) and Assigned(AFailed) then 
     AFailed.Add('SSL_set1_groups');
  end;


  if not assigned(SSL_set1_groups_list) then 
  begin
    {$if declared(SSL_set1_groups_list_introduced)}
    if LibVersion < SSL_set1_groups_list_introduced then
      {$if declared(FC_SSL_set1_groups_list)}
      SSL_set1_groups_list := @FC_SSL_set1_groups_list
      {$else}
      SSL_set1_groups_list := @ERR_SSL_set1_groups_list
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set1_groups_list_removed)}
   if SSL_set1_groups_list_removed <= LibVersion then
     {$if declared(_SSL_set1_groups_list)}
     SSL_set1_groups_list := @_SSL_set1_groups_list
     {$else}
       {$IF declared(ERR_SSL_set1_groups_list)}
       SSL_set1_groups_list := @ERR_SSL_set1_groups_list
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set1_groups_list) and Assigned(AFailed) then 
     AFailed.Add('SSL_set1_groups_list');
  end;


  if not assigned(SSL_get_shared_group) then 
  begin
    {$if declared(SSL_get_shared_group_introduced)}
    if LibVersion < SSL_get_shared_group_introduced then
      {$if declared(FC_SSL_get_shared_group)}
      SSL_get_shared_group := @FC_SSL_get_shared_group
      {$else}
      SSL_get_shared_group := @ERR_SSL_get_shared_group
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_shared_group_removed)}
   if SSL_get_shared_group_removed <= LibVersion then
     {$if declared(_SSL_get_shared_group)}
     SSL_get_shared_group := @_SSL_get_shared_group
     {$else}
       {$IF declared(ERR_SSL_get_shared_group)}
       SSL_get_shared_group := @ERR_SSL_get_shared_group
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_shared_group) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_shared_group');
  end;


  if not assigned(SSL_CTX_set1_sigalgs) then 
  begin
    {$if declared(SSL_CTX_set1_sigalgs_introduced)}
    if LibVersion < SSL_CTX_set1_sigalgs_introduced then
      {$if declared(FC_SSL_CTX_set1_sigalgs)}
      SSL_CTX_set1_sigalgs := @FC_SSL_CTX_set1_sigalgs
      {$else}
      SSL_CTX_set1_sigalgs := @ERR_SSL_CTX_set1_sigalgs
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set1_sigalgs_removed)}
   if SSL_CTX_set1_sigalgs_removed <= LibVersion then
     {$if declared(_SSL_CTX_set1_sigalgs)}
     SSL_CTX_set1_sigalgs := @_SSL_CTX_set1_sigalgs
     {$else}
       {$IF declared(ERR_SSL_CTX_set1_sigalgs)}
       SSL_CTX_set1_sigalgs := @ERR_SSL_CTX_set1_sigalgs
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set1_sigalgs) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set1_sigalgs');
  end;


  if not assigned(SSL_CTX_set1_sigalgs_list) then 
  begin
    {$if declared(SSL_CTX_set1_sigalgs_list_introduced)}
    if LibVersion < SSL_CTX_set1_sigalgs_list_introduced then
      {$if declared(FC_SSL_CTX_set1_sigalgs_list)}
      SSL_CTX_set1_sigalgs_list := @FC_SSL_CTX_set1_sigalgs_list
      {$else}
      SSL_CTX_set1_sigalgs_list := @ERR_SSL_CTX_set1_sigalgs_list
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set1_sigalgs_list_removed)}
   if SSL_CTX_set1_sigalgs_list_removed <= LibVersion then
     {$if declared(_SSL_CTX_set1_sigalgs_list)}
     SSL_CTX_set1_sigalgs_list := @_SSL_CTX_set1_sigalgs_list
     {$else}
       {$IF declared(ERR_SSL_CTX_set1_sigalgs_list)}
       SSL_CTX_set1_sigalgs_list := @ERR_SSL_CTX_set1_sigalgs_list
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set1_sigalgs_list) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set1_sigalgs_list');
  end;


  if not assigned(SSL_set1_sigalgs) then 
  begin
    {$if declared(SSL_set1_sigalgs_introduced)}
    if LibVersion < SSL_set1_sigalgs_introduced then
      {$if declared(FC_SSL_set1_sigalgs)}
      SSL_set1_sigalgs := @FC_SSL_set1_sigalgs
      {$else}
      SSL_set1_sigalgs := @ERR_SSL_set1_sigalgs
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set1_sigalgs_removed)}
   if SSL_set1_sigalgs_removed <= LibVersion then
     {$if declared(_SSL_set1_sigalgs)}
     SSL_set1_sigalgs := @_SSL_set1_sigalgs
     {$else}
       {$IF declared(ERR_SSL_set1_sigalgs)}
       SSL_set1_sigalgs := @ERR_SSL_set1_sigalgs
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set1_sigalgs) and Assigned(AFailed) then 
     AFailed.Add('SSL_set1_sigalgs');
  end;


  if not assigned(SSL_set1_sigalgs_list) then 
  begin
    {$if declared(SSL_set1_sigalgs_list_introduced)}
    if LibVersion < SSL_set1_sigalgs_list_introduced then
      {$if declared(FC_SSL_set1_sigalgs_list)}
      SSL_set1_sigalgs_list := @FC_SSL_set1_sigalgs_list
      {$else}
      SSL_set1_sigalgs_list := @ERR_SSL_set1_sigalgs_list
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set1_sigalgs_list_removed)}
   if SSL_set1_sigalgs_list_removed <= LibVersion then
     {$if declared(_SSL_set1_sigalgs_list)}
     SSL_set1_sigalgs_list := @_SSL_set1_sigalgs_list
     {$else}
       {$IF declared(ERR_SSL_set1_sigalgs_list)}
       SSL_set1_sigalgs_list := @ERR_SSL_set1_sigalgs_list
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set1_sigalgs_list) and Assigned(AFailed) then 
     AFailed.Add('SSL_set1_sigalgs_list');
  end;


  if not assigned(SSL_CTX_set1_client_sigalgs) then 
  begin
    {$if declared(SSL_CTX_set1_client_sigalgs_introduced)}
    if LibVersion < SSL_CTX_set1_client_sigalgs_introduced then
      {$if declared(FC_SSL_CTX_set1_client_sigalgs)}
      SSL_CTX_set1_client_sigalgs := @FC_SSL_CTX_set1_client_sigalgs
      {$else}
      SSL_CTX_set1_client_sigalgs := @ERR_SSL_CTX_set1_client_sigalgs
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set1_client_sigalgs_removed)}
   if SSL_CTX_set1_client_sigalgs_removed <= LibVersion then
     {$if declared(_SSL_CTX_set1_client_sigalgs)}
     SSL_CTX_set1_client_sigalgs := @_SSL_CTX_set1_client_sigalgs
     {$else}
       {$IF declared(ERR_SSL_CTX_set1_client_sigalgs)}
       SSL_CTX_set1_client_sigalgs := @ERR_SSL_CTX_set1_client_sigalgs
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set1_client_sigalgs) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set1_client_sigalgs');
  end;


  if not assigned(SSL_CTX_set1_client_sigalgs_list) then 
  begin
    {$if declared(SSL_CTX_set1_client_sigalgs_list_introduced)}
    if LibVersion < SSL_CTX_set1_client_sigalgs_list_introduced then
      {$if declared(FC_SSL_CTX_set1_client_sigalgs_list)}
      SSL_CTX_set1_client_sigalgs_list := @FC_SSL_CTX_set1_client_sigalgs_list
      {$else}
      SSL_CTX_set1_client_sigalgs_list := @ERR_SSL_CTX_set1_client_sigalgs_list
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set1_client_sigalgs_list_removed)}
   if SSL_CTX_set1_client_sigalgs_list_removed <= LibVersion then
     {$if declared(_SSL_CTX_set1_client_sigalgs_list)}
     SSL_CTX_set1_client_sigalgs_list := @_SSL_CTX_set1_client_sigalgs_list
     {$else}
       {$IF declared(ERR_SSL_CTX_set1_client_sigalgs_list)}
       SSL_CTX_set1_client_sigalgs_list := @ERR_SSL_CTX_set1_client_sigalgs_list
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set1_client_sigalgs_list) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set1_client_sigalgs_list');
  end;


  if not assigned(SSL_set1_client_sigalgs) then 
  begin
    {$if declared(SSL_set1_client_sigalgs_introduced)}
    if LibVersion < SSL_set1_client_sigalgs_introduced then
      {$if declared(FC_SSL_set1_client_sigalgs)}
      SSL_set1_client_sigalgs := @FC_SSL_set1_client_sigalgs
      {$else}
      SSL_set1_client_sigalgs := @ERR_SSL_set1_client_sigalgs
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set1_client_sigalgs_removed)}
   if SSL_set1_client_sigalgs_removed <= LibVersion then
     {$if declared(_SSL_set1_client_sigalgs)}
     SSL_set1_client_sigalgs := @_SSL_set1_client_sigalgs
     {$else}
       {$IF declared(ERR_SSL_set1_client_sigalgs)}
       SSL_set1_client_sigalgs := @ERR_SSL_set1_client_sigalgs
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set1_client_sigalgs) and Assigned(AFailed) then 
     AFailed.Add('SSL_set1_client_sigalgs');
  end;


  if not assigned(SSL_set1_client_sigalgs_list) then 
  begin
    {$if declared(SSL_set1_client_sigalgs_list_introduced)}
    if LibVersion < SSL_set1_client_sigalgs_list_introduced then
      {$if declared(FC_SSL_set1_client_sigalgs_list)}
      SSL_set1_client_sigalgs_list := @FC_SSL_set1_client_sigalgs_list
      {$else}
      SSL_set1_client_sigalgs_list := @ERR_SSL_set1_client_sigalgs_list
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set1_client_sigalgs_list_removed)}
   if SSL_set1_client_sigalgs_list_removed <= LibVersion then
     {$if declared(_SSL_set1_client_sigalgs_list)}
     SSL_set1_client_sigalgs_list := @_SSL_set1_client_sigalgs_list
     {$else}
       {$IF declared(ERR_SSL_set1_client_sigalgs_list)}
       SSL_set1_client_sigalgs_list := @ERR_SSL_set1_client_sigalgs_list
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set1_client_sigalgs_list) and Assigned(AFailed) then 
     AFailed.Add('SSL_set1_client_sigalgs_list');
  end;


  if not assigned(SSL_get0_certificate_types) then 
  begin
    {$if declared(SSL_get0_certificate_types_introduced)}
    if LibVersion < SSL_get0_certificate_types_introduced then
      {$if declared(FC_SSL_get0_certificate_types)}
      SSL_get0_certificate_types := @FC_SSL_get0_certificate_types
      {$else}
      SSL_get0_certificate_types := @ERR_SSL_get0_certificate_types
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get0_certificate_types_removed)}
   if SSL_get0_certificate_types_removed <= LibVersion then
     {$if declared(_SSL_get0_certificate_types)}
     SSL_get0_certificate_types := @_SSL_get0_certificate_types
     {$else}
       {$IF declared(ERR_SSL_get0_certificate_types)}
       SSL_get0_certificate_types := @ERR_SSL_get0_certificate_types
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get0_certificate_types) and Assigned(AFailed) then 
     AFailed.Add('SSL_get0_certificate_types');
  end;


  if not assigned(SSL_CTX_set1_client_certificate_types) then 
  begin
    {$if declared(SSL_CTX_set1_client_certificate_types_introduced)}
    if LibVersion < SSL_CTX_set1_client_certificate_types_introduced then
      {$if declared(FC_SSL_CTX_set1_client_certificate_types)}
      SSL_CTX_set1_client_certificate_types := @FC_SSL_CTX_set1_client_certificate_types
      {$else}
      SSL_CTX_set1_client_certificate_types := @ERR_SSL_CTX_set1_client_certificate_types
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set1_client_certificate_types_removed)}
   if SSL_CTX_set1_client_certificate_types_removed <= LibVersion then
     {$if declared(_SSL_CTX_set1_client_certificate_types)}
     SSL_CTX_set1_client_certificate_types := @_SSL_CTX_set1_client_certificate_types
     {$else}
       {$IF declared(ERR_SSL_CTX_set1_client_certificate_types)}
       SSL_CTX_set1_client_certificate_types := @ERR_SSL_CTX_set1_client_certificate_types
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set1_client_certificate_types) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set1_client_certificate_types');
  end;


  if not assigned(SSL_set1_client_certificate_types) then 
  begin
    {$if declared(SSL_set1_client_certificate_types_introduced)}
    if LibVersion < SSL_set1_client_certificate_types_introduced then
      {$if declared(FC_SSL_set1_client_certificate_types)}
      SSL_set1_client_certificate_types := @FC_SSL_set1_client_certificate_types
      {$else}
      SSL_set1_client_certificate_types := @ERR_SSL_set1_client_certificate_types
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set1_client_certificate_types_removed)}
   if SSL_set1_client_certificate_types_removed <= LibVersion then
     {$if declared(_SSL_set1_client_certificate_types)}
     SSL_set1_client_certificate_types := @_SSL_set1_client_certificate_types
     {$else}
       {$IF declared(ERR_SSL_set1_client_certificate_types)}
       SSL_set1_client_certificate_types := @ERR_SSL_set1_client_certificate_types
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set1_client_certificate_types) and Assigned(AFailed) then 
     AFailed.Add('SSL_set1_client_certificate_types');
  end;


  if not assigned(SSL_get_signature_nid) then 
  begin
    {$if declared(SSL_get_signature_nid_introduced)}
    if LibVersion < SSL_get_signature_nid_introduced then
      {$if declared(FC_SSL_get_signature_nid)}
      SSL_get_signature_nid := @FC_SSL_get_signature_nid
      {$else}
      SSL_get_signature_nid := @ERR_SSL_get_signature_nid
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_signature_nid_removed)}
   if SSL_get_signature_nid_removed <= LibVersion then
     {$if declared(_SSL_get_signature_nid)}
     SSL_get_signature_nid := @_SSL_get_signature_nid
     {$else}
       {$IF declared(ERR_SSL_get_signature_nid)}
       SSL_get_signature_nid := @ERR_SSL_get_signature_nid
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_signature_nid) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_signature_nid');
  end;


  if not assigned(SSL_get_peer_signature_nid) then 
  begin
    {$if declared(SSL_get_peer_signature_nid_introduced)}
    if LibVersion < SSL_get_peer_signature_nid_introduced then
      {$if declared(FC_SSL_get_peer_signature_nid)}
      SSL_get_peer_signature_nid := @FC_SSL_get_peer_signature_nid
      {$else}
      SSL_get_peer_signature_nid := @ERR_SSL_get_peer_signature_nid
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_peer_signature_nid_removed)}
   if SSL_get_peer_signature_nid_removed <= LibVersion then
     {$if declared(_SSL_get_peer_signature_nid)}
     SSL_get_peer_signature_nid := @_SSL_get_peer_signature_nid
     {$else}
       {$IF declared(ERR_SSL_get_peer_signature_nid)}
       SSL_get_peer_signature_nid := @ERR_SSL_get_peer_signature_nid
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_peer_signature_nid) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_peer_signature_nid');
  end;


  if not assigned(SSL_get_peer_tmp_key) then 
  begin
    {$if declared(SSL_get_peer_tmp_key_introduced)}
    if LibVersion < SSL_get_peer_tmp_key_introduced then
      {$if declared(FC_SSL_get_peer_tmp_key)}
      SSL_get_peer_tmp_key := @FC_SSL_get_peer_tmp_key
      {$else}
      SSL_get_peer_tmp_key := @ERR_SSL_get_peer_tmp_key
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_peer_tmp_key_removed)}
   if SSL_get_peer_tmp_key_removed <= LibVersion then
     {$if declared(_SSL_get_peer_tmp_key)}
     SSL_get_peer_tmp_key := @_SSL_get_peer_tmp_key
     {$else}
       {$IF declared(ERR_SSL_get_peer_tmp_key)}
       SSL_get_peer_tmp_key := @ERR_SSL_get_peer_tmp_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_peer_tmp_key) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_peer_tmp_key');
  end;


  if not assigned(SSL_get_tmp_key) then 
  begin
    {$if declared(SSL_get_tmp_key_introduced)}
    if LibVersion < SSL_get_tmp_key_introduced then
      {$if declared(FC_SSL_get_tmp_key)}
      SSL_get_tmp_key := @FC_SSL_get_tmp_key
      {$else}
      SSL_get_tmp_key := @ERR_SSL_get_tmp_key
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_tmp_key_removed)}
   if SSL_get_tmp_key_removed <= LibVersion then
     {$if declared(_SSL_get_tmp_key)}
     SSL_get_tmp_key := @_SSL_get_tmp_key
     {$else}
       {$IF declared(ERR_SSL_get_tmp_key)}
       SSL_get_tmp_key := @ERR_SSL_get_tmp_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_tmp_key) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_tmp_key');
  end;


  if not assigned(SSL_get0_raw_cipherlist) then 
  begin
    {$if declared(SSL_get0_raw_cipherlist_introduced)}
    if LibVersion < SSL_get0_raw_cipherlist_introduced then
      {$if declared(FC_SSL_get0_raw_cipherlist)}
      SSL_get0_raw_cipherlist := @FC_SSL_get0_raw_cipherlist
      {$else}
      SSL_get0_raw_cipherlist := @ERR_SSL_get0_raw_cipherlist
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get0_raw_cipherlist_removed)}
   if SSL_get0_raw_cipherlist_removed <= LibVersion then
     {$if declared(_SSL_get0_raw_cipherlist)}
     SSL_get0_raw_cipherlist := @_SSL_get0_raw_cipherlist
     {$else}
       {$IF declared(ERR_SSL_get0_raw_cipherlist)}
       SSL_get0_raw_cipherlist := @ERR_SSL_get0_raw_cipherlist
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get0_raw_cipherlist) and Assigned(AFailed) then 
     AFailed.Add('SSL_get0_raw_cipherlist');
  end;


  if not assigned(SSL_get0_ec_point_formats) then 
  begin
    {$if declared(SSL_get0_ec_point_formats_introduced)}
    if LibVersion < SSL_get0_ec_point_formats_introduced then
      {$if declared(FC_SSL_get0_ec_point_formats)}
      SSL_get0_ec_point_formats := @FC_SSL_get0_ec_point_formats
      {$else}
      SSL_get0_ec_point_formats := @ERR_SSL_get0_ec_point_formats
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get0_ec_point_formats_removed)}
   if SSL_get0_ec_point_formats_removed <= LibVersion then
     {$if declared(_SSL_get0_ec_point_formats)}
     SSL_get0_ec_point_formats := @_SSL_get0_ec_point_formats
     {$else}
       {$IF declared(ERR_SSL_get0_ec_point_formats)}
       SSL_get0_ec_point_formats := @ERR_SSL_get0_ec_point_formats
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get0_ec_point_formats) and Assigned(AFailed) then 
     AFailed.Add('SSL_get0_ec_point_formats');
  end;


  if not assigned(SSL_CTX_get_options) then 
  begin
    {$if declared(SSL_CTX_get_options_introduced)}
    if LibVersion < SSL_CTX_get_options_introduced then
      {$if declared(FC_SSL_CTX_get_options)}
      SSL_CTX_get_options := @FC_SSL_CTX_get_options
      {$else}
      SSL_CTX_get_options := @ERR_SSL_CTX_get_options
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get_options_removed)}
   if SSL_CTX_get_options_removed <= LibVersion then
     {$if declared(_SSL_CTX_get_options)}
     SSL_CTX_get_options := @_SSL_CTX_get_options
     {$else}
       {$IF declared(ERR_SSL_CTX_get_options)}
       SSL_CTX_get_options := @ERR_SSL_CTX_get_options
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get_options) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get_options');
  end;


  if not assigned(SSL_get_options) then 
  begin
    {$if declared(SSL_get_options_introduced)}
    if LibVersion < SSL_get_options_introduced then
      {$if declared(FC_SSL_get_options)}
      SSL_get_options := @FC_SSL_get_options
      {$else}
      SSL_get_options := @ERR_SSL_get_options
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_options_removed)}
   if SSL_get_options_removed <= LibVersion then
     {$if declared(_SSL_get_options)}
     SSL_get_options := @_SSL_get_options
     {$else}
       {$IF declared(ERR_SSL_get_options)}
       SSL_get_options := @ERR_SSL_get_options
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_options) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_options');
  end;


  if not assigned(SSL_CTX_clear_options) then 
  begin
    {$if declared(SSL_CTX_clear_options_introduced)}
    if LibVersion < SSL_CTX_clear_options_introduced then
      {$if declared(FC_SSL_CTX_clear_options)}
      SSL_CTX_clear_options := @FC_SSL_CTX_clear_options
      {$else}
      SSL_CTX_clear_options := @ERR_SSL_CTX_clear_options
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_clear_options_removed)}
   if SSL_CTX_clear_options_removed <= LibVersion then
     {$if declared(_SSL_CTX_clear_options)}
     SSL_CTX_clear_options := @_SSL_CTX_clear_options
     {$else}
       {$IF declared(ERR_SSL_CTX_clear_options)}
       SSL_CTX_clear_options := @ERR_SSL_CTX_clear_options
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_clear_options) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_clear_options');
  end;


  if not assigned(SSL_clear_options) then 
  begin
    {$if declared(SSL_clear_options_introduced)}
    if LibVersion < SSL_clear_options_introduced then
      {$if declared(FC_SSL_clear_options)}
      SSL_clear_options := @FC_SSL_clear_options
      {$else}
      SSL_clear_options := @ERR_SSL_clear_options
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_clear_options_removed)}
   if SSL_clear_options_removed <= LibVersion then
     {$if declared(_SSL_clear_options)}
     SSL_clear_options := @_SSL_clear_options
     {$else}
       {$IF declared(ERR_SSL_clear_options)}
       SSL_clear_options := @ERR_SSL_clear_options
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_clear_options) and Assigned(AFailed) then 
     AFailed.Add('SSL_clear_options');
  end;


  if not assigned(SSL_CTX_set_options) then 
  begin
    {$if declared(SSL_CTX_set_options_introduced)}
    if LibVersion < SSL_CTX_set_options_introduced then
      {$if declared(FC_SSL_CTX_set_options)}
      SSL_CTX_set_options := @FC_SSL_CTX_set_options
      {$else}
      SSL_CTX_set_options := @ERR_SSL_CTX_set_options
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_options_removed)}
   if SSL_CTX_set_options_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_options)}
     SSL_CTX_set_options := @_SSL_CTX_set_options
     {$else}
       {$IF declared(ERR_SSL_CTX_set_options)}
       SSL_CTX_set_options := @ERR_SSL_CTX_set_options
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_options) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_options');
  end;


  if not assigned(SSL_set_options) then 
  begin
    {$if declared(SSL_set_options_introduced)}
    if LibVersion < SSL_set_options_introduced then
      {$if declared(FC_SSL_set_options)}
      SSL_set_options := @FC_SSL_set_options
      {$else}
      SSL_set_options := @ERR_SSL_set_options
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_options_removed)}
   if SSL_set_options_removed <= LibVersion then
     {$if declared(_SSL_set_options)}
     SSL_set_options := @_SSL_set_options
     {$else}
       {$IF declared(ERR_SSL_set_options)}
       SSL_set_options := @ERR_SSL_set_options
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_options) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_options');
  end;


  if not assigned(SSL_CTX_set_stateless_cookie_generate_cb) then 
  begin
    {$if declared(SSL_CTX_set_stateless_cookie_generate_cb_introduced)}
    if LibVersion < SSL_CTX_set_stateless_cookie_generate_cb_introduced then
      {$if declared(FC_SSL_CTX_set_stateless_cookie_generate_cb)}
      SSL_CTX_set_stateless_cookie_generate_cb := @FC_SSL_CTX_set_stateless_cookie_generate_cb
      {$else}
      SSL_CTX_set_stateless_cookie_generate_cb := @ERR_SSL_CTX_set_stateless_cookie_generate_cb
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_stateless_cookie_generate_cb_removed)}
   if SSL_CTX_set_stateless_cookie_generate_cb_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_stateless_cookie_generate_cb)}
     SSL_CTX_set_stateless_cookie_generate_cb := @_SSL_CTX_set_stateless_cookie_generate_cb
     {$else}
       {$IF declared(ERR_SSL_CTX_set_stateless_cookie_generate_cb)}
       SSL_CTX_set_stateless_cookie_generate_cb := @ERR_SSL_CTX_set_stateless_cookie_generate_cb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_stateless_cookie_generate_cb) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_stateless_cookie_generate_cb');
  end;


  if not assigned(SSL_CTX_set_stateless_cookie_verify_cb) then 
  begin
    {$if declared(SSL_CTX_set_stateless_cookie_verify_cb_introduced)}
    if LibVersion < SSL_CTX_set_stateless_cookie_verify_cb_introduced then
      {$if declared(FC_SSL_CTX_set_stateless_cookie_verify_cb)}
      SSL_CTX_set_stateless_cookie_verify_cb := @FC_SSL_CTX_set_stateless_cookie_verify_cb
      {$else}
      SSL_CTX_set_stateless_cookie_verify_cb := @ERR_SSL_CTX_set_stateless_cookie_verify_cb
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_stateless_cookie_verify_cb_removed)}
   if SSL_CTX_set_stateless_cookie_verify_cb_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_stateless_cookie_verify_cb)}
     SSL_CTX_set_stateless_cookie_verify_cb := @_SSL_CTX_set_stateless_cookie_verify_cb
     {$else}
       {$IF declared(ERR_SSL_CTX_set_stateless_cookie_verify_cb)}
       SSL_CTX_set_stateless_cookie_verify_cb := @ERR_SSL_CTX_set_stateless_cookie_verify_cb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_stateless_cookie_verify_cb) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_stateless_cookie_verify_cb');
  end;


  if not assigned(SSL_set_psk_find_session_callback) then 
  begin
    {$if declared(SSL_set_psk_find_session_callback_introduced)}
    if LibVersion < SSL_set_psk_find_session_callback_introduced then
      {$if declared(FC_SSL_set_psk_find_session_callback)}
      SSL_set_psk_find_session_callback := @FC_SSL_set_psk_find_session_callback
      {$else}
      SSL_set_psk_find_session_callback := @ERR_SSL_set_psk_find_session_callback
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_psk_find_session_callback_removed)}
   if SSL_set_psk_find_session_callback_removed <= LibVersion then
     {$if declared(_SSL_set_psk_find_session_callback)}
     SSL_set_psk_find_session_callback := @_SSL_set_psk_find_session_callback
     {$else}
       {$IF declared(ERR_SSL_set_psk_find_session_callback)}
       SSL_set_psk_find_session_callback := @ERR_SSL_set_psk_find_session_callback
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_psk_find_session_callback) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_psk_find_session_callback');
  end;


  if not assigned(SSL_CTX_set_psk_find_session_callback) then 
  begin
    {$if declared(SSL_CTX_set_psk_find_session_callback_introduced)}
    if LibVersion < SSL_CTX_set_psk_find_session_callback_introduced then
      {$if declared(FC_SSL_CTX_set_psk_find_session_callback)}
      SSL_CTX_set_psk_find_session_callback := @FC_SSL_CTX_set_psk_find_session_callback
      {$else}
      SSL_CTX_set_psk_find_session_callback := @ERR_SSL_CTX_set_psk_find_session_callback
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_psk_find_session_callback_removed)}
   if SSL_CTX_set_psk_find_session_callback_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_psk_find_session_callback)}
     SSL_CTX_set_psk_find_session_callback := @_SSL_CTX_set_psk_find_session_callback
     {$else}
       {$IF declared(ERR_SSL_CTX_set_psk_find_session_callback)}
       SSL_CTX_set_psk_find_session_callback := @ERR_SSL_CTX_set_psk_find_session_callback
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_psk_find_session_callback) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_psk_find_session_callback');
  end;


  if not assigned(SSL_set_psk_use_session_callback) then 
  begin
    {$if declared(SSL_set_psk_use_session_callback_introduced)}
    if LibVersion < SSL_set_psk_use_session_callback_introduced then
      {$if declared(FC_SSL_set_psk_use_session_callback)}
      SSL_set_psk_use_session_callback := @FC_SSL_set_psk_use_session_callback
      {$else}
      SSL_set_psk_use_session_callback := @ERR_SSL_set_psk_use_session_callback
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_psk_use_session_callback_removed)}
   if SSL_set_psk_use_session_callback_removed <= LibVersion then
     {$if declared(_SSL_set_psk_use_session_callback)}
     SSL_set_psk_use_session_callback := @_SSL_set_psk_use_session_callback
     {$else}
       {$IF declared(ERR_SSL_set_psk_use_session_callback)}
       SSL_set_psk_use_session_callback := @ERR_SSL_set_psk_use_session_callback
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_psk_use_session_callback) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_psk_use_session_callback');
  end;


  if not assigned(SSL_CTX_set_psk_use_session_callback) then 
  begin
    {$if declared(SSL_CTX_set_psk_use_session_callback_introduced)}
    if LibVersion < SSL_CTX_set_psk_use_session_callback_introduced then
      {$if declared(FC_SSL_CTX_set_psk_use_session_callback)}
      SSL_CTX_set_psk_use_session_callback := @FC_SSL_CTX_set_psk_use_session_callback
      {$else}
      SSL_CTX_set_psk_use_session_callback := @ERR_SSL_CTX_set_psk_use_session_callback
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_psk_use_session_callback_removed)}
   if SSL_CTX_set_psk_use_session_callback_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_psk_use_session_callback)}
     SSL_CTX_set_psk_use_session_callback := @_SSL_CTX_set_psk_use_session_callback
     {$else}
       {$IF declared(ERR_SSL_CTX_set_psk_use_session_callback)}
       SSL_CTX_set_psk_use_session_callback := @ERR_SSL_CTX_set_psk_use_session_callback
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_psk_use_session_callback) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_psk_use_session_callback');
  end;


  if not assigned(SSL_CTX_set_keylog_callback) then 
  begin
    {$if declared(SSL_CTX_set_keylog_callback_introduced)}
    if LibVersion < SSL_CTX_set_keylog_callback_introduced then
      {$if declared(FC_SSL_CTX_set_keylog_callback)}
      SSL_CTX_set_keylog_callback := @FC_SSL_CTX_set_keylog_callback
      {$else}
      SSL_CTX_set_keylog_callback := @ERR_SSL_CTX_set_keylog_callback
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_keylog_callback_removed)}
   if SSL_CTX_set_keylog_callback_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_keylog_callback)}
     SSL_CTX_set_keylog_callback := @_SSL_CTX_set_keylog_callback
     {$else}
       {$IF declared(ERR_SSL_CTX_set_keylog_callback)}
       SSL_CTX_set_keylog_callback := @ERR_SSL_CTX_set_keylog_callback
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_keylog_callback) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_keylog_callback');
  end;


  if not assigned(SSL_CTX_get_keylog_callback) then 
  begin
    {$if declared(SSL_CTX_get_keylog_callback_introduced)}
    if LibVersion < SSL_CTX_get_keylog_callback_introduced then
      {$if declared(FC_SSL_CTX_get_keylog_callback)}
      SSL_CTX_get_keylog_callback := @FC_SSL_CTX_get_keylog_callback
      {$else}
      SSL_CTX_get_keylog_callback := @ERR_SSL_CTX_get_keylog_callback
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get_keylog_callback_removed)}
   if SSL_CTX_get_keylog_callback_removed <= LibVersion then
     {$if declared(_SSL_CTX_get_keylog_callback)}
     SSL_CTX_get_keylog_callback := @_SSL_CTX_get_keylog_callback
     {$else}
       {$IF declared(ERR_SSL_CTX_get_keylog_callback)}
       SSL_CTX_get_keylog_callback := @ERR_SSL_CTX_get_keylog_callback
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get_keylog_callback) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get_keylog_callback');
  end;


  if not assigned(SSL_CTX_set_max_early_data) then 
  begin
    {$if declared(SSL_CTX_set_max_early_data_introduced)}
    if LibVersion < SSL_CTX_set_max_early_data_introduced then
      {$if declared(FC_SSL_CTX_set_max_early_data)}
      SSL_CTX_set_max_early_data := @FC_SSL_CTX_set_max_early_data
      {$else}
      SSL_CTX_set_max_early_data := @ERR_SSL_CTX_set_max_early_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_max_early_data_removed)}
   if SSL_CTX_set_max_early_data_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_max_early_data)}
     SSL_CTX_set_max_early_data := @_SSL_CTX_set_max_early_data
     {$else}
       {$IF declared(ERR_SSL_CTX_set_max_early_data)}
       SSL_CTX_set_max_early_data := @ERR_SSL_CTX_set_max_early_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_max_early_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_max_early_data');
  end;


  if not assigned(SSL_CTX_get_max_early_data) then 
  begin
    {$if declared(SSL_CTX_get_max_early_data_introduced)}
    if LibVersion < SSL_CTX_get_max_early_data_introduced then
      {$if declared(FC_SSL_CTX_get_max_early_data)}
      SSL_CTX_get_max_early_data := @FC_SSL_CTX_get_max_early_data
      {$else}
      SSL_CTX_get_max_early_data := @ERR_SSL_CTX_get_max_early_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get_max_early_data_removed)}
   if SSL_CTX_get_max_early_data_removed <= LibVersion then
     {$if declared(_SSL_CTX_get_max_early_data)}
     SSL_CTX_get_max_early_data := @_SSL_CTX_get_max_early_data
     {$else}
       {$IF declared(ERR_SSL_CTX_get_max_early_data)}
       SSL_CTX_get_max_early_data := @ERR_SSL_CTX_get_max_early_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get_max_early_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get_max_early_data');
  end;


  if not assigned(SSL_set_max_early_data) then 
  begin
    {$if declared(SSL_set_max_early_data_introduced)}
    if LibVersion < SSL_set_max_early_data_introduced then
      {$if declared(FC_SSL_set_max_early_data)}
      SSL_set_max_early_data := @FC_SSL_set_max_early_data
      {$else}
      SSL_set_max_early_data := @ERR_SSL_set_max_early_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_max_early_data_removed)}
   if SSL_set_max_early_data_removed <= LibVersion then
     {$if declared(_SSL_set_max_early_data)}
     SSL_set_max_early_data := @_SSL_set_max_early_data
     {$else}
       {$IF declared(ERR_SSL_set_max_early_data)}
       SSL_set_max_early_data := @ERR_SSL_set_max_early_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_max_early_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_max_early_data');
  end;


  if not assigned(SSL_get_max_early_data) then 
  begin
    {$if declared(SSL_get_max_early_data_introduced)}
    if LibVersion < SSL_get_max_early_data_introduced then
      {$if declared(FC_SSL_get_max_early_data)}
      SSL_get_max_early_data := @FC_SSL_get_max_early_data
      {$else}
      SSL_get_max_early_data := @ERR_SSL_get_max_early_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_max_early_data_removed)}
   if SSL_get_max_early_data_removed <= LibVersion then
     {$if declared(_SSL_get_max_early_data)}
     SSL_get_max_early_data := @_SSL_get_max_early_data
     {$else}
       {$IF declared(ERR_SSL_get_max_early_data)}
       SSL_get_max_early_data := @ERR_SSL_get_max_early_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_max_early_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_max_early_data');
  end;


  if not assigned(SSL_CTX_set_recv_max_early_data) then 
  begin
    {$if declared(SSL_CTX_set_recv_max_early_data_introduced)}
    if LibVersion < SSL_CTX_set_recv_max_early_data_introduced then
      {$if declared(FC_SSL_CTX_set_recv_max_early_data)}
      SSL_CTX_set_recv_max_early_data := @FC_SSL_CTX_set_recv_max_early_data
      {$else}
      SSL_CTX_set_recv_max_early_data := @ERR_SSL_CTX_set_recv_max_early_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_recv_max_early_data_removed)}
   if SSL_CTX_set_recv_max_early_data_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_recv_max_early_data)}
     SSL_CTX_set_recv_max_early_data := @_SSL_CTX_set_recv_max_early_data
     {$else}
       {$IF declared(ERR_SSL_CTX_set_recv_max_early_data)}
       SSL_CTX_set_recv_max_early_data := @ERR_SSL_CTX_set_recv_max_early_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_recv_max_early_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_recv_max_early_data');
  end;


  if not assigned(SSL_CTX_get_recv_max_early_data) then 
  begin
    {$if declared(SSL_CTX_get_recv_max_early_data_introduced)}
    if LibVersion < SSL_CTX_get_recv_max_early_data_introduced then
      {$if declared(FC_SSL_CTX_get_recv_max_early_data)}
      SSL_CTX_get_recv_max_early_data := @FC_SSL_CTX_get_recv_max_early_data
      {$else}
      SSL_CTX_get_recv_max_early_data := @ERR_SSL_CTX_get_recv_max_early_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get_recv_max_early_data_removed)}
   if SSL_CTX_get_recv_max_early_data_removed <= LibVersion then
     {$if declared(_SSL_CTX_get_recv_max_early_data)}
     SSL_CTX_get_recv_max_early_data := @_SSL_CTX_get_recv_max_early_data
     {$else}
       {$IF declared(ERR_SSL_CTX_get_recv_max_early_data)}
       SSL_CTX_get_recv_max_early_data := @ERR_SSL_CTX_get_recv_max_early_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get_recv_max_early_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get_recv_max_early_data');
  end;


  if not assigned(SSL_set_recv_max_early_data) then 
  begin
    {$if declared(SSL_set_recv_max_early_data_introduced)}
    if LibVersion < SSL_set_recv_max_early_data_introduced then
      {$if declared(FC_SSL_set_recv_max_early_data)}
      SSL_set_recv_max_early_data := @FC_SSL_set_recv_max_early_data
      {$else}
      SSL_set_recv_max_early_data := @ERR_SSL_set_recv_max_early_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_recv_max_early_data_removed)}
   if SSL_set_recv_max_early_data_removed <= LibVersion then
     {$if declared(_SSL_set_recv_max_early_data)}
     SSL_set_recv_max_early_data := @_SSL_set_recv_max_early_data
     {$else}
       {$IF declared(ERR_SSL_set_recv_max_early_data)}
       SSL_set_recv_max_early_data := @ERR_SSL_set_recv_max_early_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_recv_max_early_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_recv_max_early_data');
  end;


  if not assigned(SSL_get_recv_max_early_data) then 
  begin
    {$if declared(SSL_get_recv_max_early_data_introduced)}
    if LibVersion < SSL_get_recv_max_early_data_introduced then
      {$if declared(FC_SSL_get_recv_max_early_data)}
      SSL_get_recv_max_early_data := @FC_SSL_get_recv_max_early_data
      {$else}
      SSL_get_recv_max_early_data := @ERR_SSL_get_recv_max_early_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_recv_max_early_data_removed)}
   if SSL_get_recv_max_early_data_removed <= LibVersion then
     {$if declared(_SSL_get_recv_max_early_data)}
     SSL_get_recv_max_early_data := @_SSL_get_recv_max_early_data
     {$else}
       {$IF declared(ERR_SSL_get_recv_max_early_data)}
       SSL_get_recv_max_early_data := @ERR_SSL_get_recv_max_early_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_recv_max_early_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_recv_max_early_data');
  end;


  if not assigned(SSL_get_app_data) then 
  begin
    {$if declared(SSL_get_app_data_introduced)}
    if LibVersion < SSL_get_app_data_introduced then
      {$if declared(FC_SSL_get_app_data)}
      SSL_get_app_data := @FC_SSL_get_app_data
      {$else}
      SSL_get_app_data := @ERR_SSL_get_app_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_app_data_removed)}
   if SSL_get_app_data_removed <= LibVersion then
     {$if declared(_SSL_get_app_data)}
     SSL_get_app_data := @_SSL_get_app_data
     {$else}
       {$IF declared(ERR_SSL_get_app_data)}
       SSL_get_app_data := @ERR_SSL_get_app_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_app_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_app_data');
  end;

 
  if not assigned(SSL_set_app_data) then 
  begin
    {$if declared(SSL_set_app_data_introduced)}
    if LibVersion < SSL_set_app_data_introduced then
      {$if declared(FC_SSL_set_app_data)}
      SSL_set_app_data := @FC_SSL_set_app_data
      {$else}
      SSL_set_app_data := @ERR_SSL_set_app_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_app_data_removed)}
   if SSL_set_app_data_removed <= LibVersion then
     {$if declared(_SSL_set_app_data)}
     SSL_set_app_data := @_SSL_set_app_data
     {$else}
       {$IF declared(ERR_SSL_set_app_data)}
       SSL_set_app_data := @ERR_SSL_set_app_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_app_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_app_data');
  end;


  if not assigned(SSL_in_init) then 
  begin
    {$if declared(SSL_in_init_introduced)}
    if LibVersion < SSL_in_init_introduced then
      {$if declared(FC_SSL_in_init)}
      SSL_in_init := @FC_SSL_in_init
      {$else}
      SSL_in_init := @ERR_SSL_in_init
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_in_init_removed)}
   if SSL_in_init_removed <= LibVersion then
     {$if declared(_SSL_in_init)}
     SSL_in_init := @_SSL_in_init
     {$else}
       {$IF declared(ERR_SSL_in_init)}
       SSL_in_init := @ERR_SSL_in_init
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_in_init) and Assigned(AFailed) then 
     AFailed.Add('SSL_in_init');
  end;


  if not assigned(SSL_in_before) then 
  begin
    {$if declared(SSL_in_before_introduced)}
    if LibVersion < SSL_in_before_introduced then
      {$if declared(FC_SSL_in_before)}
      SSL_in_before := @FC_SSL_in_before
      {$else}
      SSL_in_before := @ERR_SSL_in_before
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_in_before_removed)}
   if SSL_in_before_removed <= LibVersion then
     {$if declared(_SSL_in_before)}
     SSL_in_before := @_SSL_in_before
     {$else}
       {$IF declared(ERR_SSL_in_before)}
       SSL_in_before := @ERR_SSL_in_before
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_in_before) and Assigned(AFailed) then 
     AFailed.Add('SSL_in_before');
  end;


  if not assigned(SSL_is_init_finished) then 
  begin
    {$if declared(SSL_is_init_finished_introduced)}
    if LibVersion < SSL_is_init_finished_introduced then
      {$if declared(FC_SSL_is_init_finished)}
      SSL_is_init_finished := @FC_SSL_is_init_finished
      {$else}
      SSL_is_init_finished := @ERR_SSL_is_init_finished
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_is_init_finished_removed)}
   if SSL_is_init_finished_removed <= LibVersion then
     {$if declared(_SSL_is_init_finished)}
     SSL_is_init_finished := @_SSL_is_init_finished
     {$else}
       {$IF declared(ERR_SSL_is_init_finished)}
       SSL_is_init_finished := @ERR_SSL_is_init_finished
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_is_init_finished) and Assigned(AFailed) then 
     AFailed.Add('SSL_is_init_finished');
  end;


  if not assigned(SSLeay_add_ssl_algorithms) then 
  begin
    {$if declared(SSLeay_add_ssl_algorithms_introduced)}
    if LibVersion < SSLeay_add_ssl_algorithms_introduced then
      {$if declared(FC_SSLeay_add_ssl_algorithms)}
      SSLeay_add_ssl_algorithms := @FC_SSLeay_add_ssl_algorithms
      {$else}
      SSLeay_add_ssl_algorithms := @ERR_SSLeay_add_ssl_algorithms
      {$ifend}
    else
    {$ifend}
   {$if declared(SSLeay_add_ssl_algorithms_removed)}
   if SSLeay_add_ssl_algorithms_removed <= LibVersion then
     {$if declared(_SSLeay_add_ssl_algorithms)}
     SSLeay_add_ssl_algorithms := @_SSLeay_add_ssl_algorithms
     {$else}
       {$IF declared(ERR_SSLeay_add_ssl_algorithms)}
       SSLeay_add_ssl_algorithms := @ERR_SSLeay_add_ssl_algorithms
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSLeay_add_ssl_algorithms) and Assigned(AFailed) then 
     AFailed.Add('SSLeay_add_ssl_algorithms');
  end;


  if not assigned(SSL_CTX_up_ref) then 
  begin
    {$if declared(SSL_CTX_up_ref_introduced)}
    if LibVersion < SSL_CTX_up_ref_introduced then
      {$if declared(FC_SSL_CTX_up_ref)}
      SSL_CTX_up_ref := @FC_SSL_CTX_up_ref
      {$else}
      SSL_CTX_up_ref := @ERR_SSL_CTX_up_ref
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_up_ref_removed)}
   if SSL_CTX_up_ref_removed <= LibVersion then
     {$if declared(_SSL_CTX_up_ref)}
     SSL_CTX_up_ref := @_SSL_CTX_up_ref
     {$else}
       {$IF declared(ERR_SSL_CTX_up_ref)}
       SSL_CTX_up_ref := @ERR_SSL_CTX_up_ref
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_up_ref) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_up_ref');
  end;


  if not assigned(SSL_CTX_set1_cert_store) then 
  begin
    {$if declared(SSL_CTX_set1_cert_store_introduced)}
    if LibVersion < SSL_CTX_set1_cert_store_introduced then
      {$if declared(FC_SSL_CTX_set1_cert_store)}
      SSL_CTX_set1_cert_store := @FC_SSL_CTX_set1_cert_store
      {$else}
      SSL_CTX_set1_cert_store := @ERR_SSL_CTX_set1_cert_store
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set1_cert_store_removed)}
   if SSL_CTX_set1_cert_store_removed <= LibVersion then
     {$if declared(_SSL_CTX_set1_cert_store)}
     SSL_CTX_set1_cert_store := @_SSL_CTX_set1_cert_store
     {$else}
       {$IF declared(ERR_SSL_CTX_set1_cert_store)}
       SSL_CTX_set1_cert_store := @ERR_SSL_CTX_set1_cert_store
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set1_cert_store) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set1_cert_store');
  end;


  if not assigned(SSL_get_pending_cipher) then 
  begin
    {$if declared(SSL_get_pending_cipher_introduced)}
    if LibVersion < SSL_get_pending_cipher_introduced then
      {$if declared(FC_SSL_get_pending_cipher)}
      SSL_get_pending_cipher := @FC_SSL_get_pending_cipher
      {$else}
      SSL_get_pending_cipher := @ERR_SSL_get_pending_cipher
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_pending_cipher_removed)}
   if SSL_get_pending_cipher_removed <= LibVersion then
     {$if declared(_SSL_get_pending_cipher)}
     SSL_get_pending_cipher := @_SSL_get_pending_cipher
     {$else}
       {$IF declared(ERR_SSL_get_pending_cipher)}
       SSL_get_pending_cipher := @ERR_SSL_get_pending_cipher
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_pending_cipher) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_pending_cipher');
  end;


  if not assigned(SSL_CIPHER_standard_name) then 
  begin
    {$if declared(SSL_CIPHER_standard_name_introduced)}
    if LibVersion < SSL_CIPHER_standard_name_introduced then
      {$if declared(FC_SSL_CIPHER_standard_name)}
      SSL_CIPHER_standard_name := @FC_SSL_CIPHER_standard_name
      {$else}
      SSL_CIPHER_standard_name := @ERR_SSL_CIPHER_standard_name
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CIPHER_standard_name_removed)}
   if SSL_CIPHER_standard_name_removed <= LibVersion then
     {$if declared(_SSL_CIPHER_standard_name)}
     SSL_CIPHER_standard_name := @_SSL_CIPHER_standard_name
     {$else}
       {$IF declared(ERR_SSL_CIPHER_standard_name)}
       SSL_CIPHER_standard_name := @ERR_SSL_CIPHER_standard_name
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CIPHER_standard_name) and Assigned(AFailed) then 
     AFailed.Add('SSL_CIPHER_standard_name');
  end;


  if not assigned(OPENSSL_cipher_name) then 
  begin
    {$if declared(OPENSSL_cipher_name_introduced)}
    if LibVersion < OPENSSL_cipher_name_introduced then
      {$if declared(FC_OPENSSL_cipher_name)}
      OPENSSL_cipher_name := @FC_OPENSSL_cipher_name
      {$else}
      OPENSSL_cipher_name := @ERR_OPENSSL_cipher_name
      {$ifend}
    else
    {$ifend}
   {$if declared(OPENSSL_cipher_name_removed)}
   if OPENSSL_cipher_name_removed <= LibVersion then
     {$if declared(_OPENSSL_cipher_name)}
     OPENSSL_cipher_name := @_OPENSSL_cipher_name
     {$else}
       {$IF declared(ERR_OPENSSL_cipher_name)}
       OPENSSL_cipher_name := @ERR_OPENSSL_cipher_name
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OPENSSL_cipher_name) and Assigned(AFailed) then 
     AFailed.Add('OPENSSL_cipher_name');
  end;


  if not assigned(SSL_CIPHER_get_protocol_id) then 
  begin
    {$if declared(SSL_CIPHER_get_protocol_id_introduced)}
    if LibVersion < SSL_CIPHER_get_protocol_id_introduced then
      {$if declared(FC_SSL_CIPHER_get_protocol_id)}
      SSL_CIPHER_get_protocol_id := @FC_SSL_CIPHER_get_protocol_id
      {$else}
      SSL_CIPHER_get_protocol_id := @ERR_SSL_CIPHER_get_protocol_id
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CIPHER_get_protocol_id_removed)}
   if SSL_CIPHER_get_protocol_id_removed <= LibVersion then
     {$if declared(_SSL_CIPHER_get_protocol_id)}
     SSL_CIPHER_get_protocol_id := @_SSL_CIPHER_get_protocol_id
     {$else}
       {$IF declared(ERR_SSL_CIPHER_get_protocol_id)}
       SSL_CIPHER_get_protocol_id := @ERR_SSL_CIPHER_get_protocol_id
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CIPHER_get_protocol_id) and Assigned(AFailed) then 
     AFailed.Add('SSL_CIPHER_get_protocol_id');
  end;


  if not assigned(SSL_CIPHER_get_kx_nid) then 
  begin
    {$if declared(SSL_CIPHER_get_kx_nid_introduced)}
    if LibVersion < SSL_CIPHER_get_kx_nid_introduced then
      {$if declared(FC_SSL_CIPHER_get_kx_nid)}
      SSL_CIPHER_get_kx_nid := @FC_SSL_CIPHER_get_kx_nid
      {$else}
      SSL_CIPHER_get_kx_nid := @ERR_SSL_CIPHER_get_kx_nid
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CIPHER_get_kx_nid_removed)}
   if SSL_CIPHER_get_kx_nid_removed <= LibVersion then
     {$if declared(_SSL_CIPHER_get_kx_nid)}
     SSL_CIPHER_get_kx_nid := @_SSL_CIPHER_get_kx_nid
     {$else}
       {$IF declared(ERR_SSL_CIPHER_get_kx_nid)}
       SSL_CIPHER_get_kx_nid := @ERR_SSL_CIPHER_get_kx_nid
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CIPHER_get_kx_nid) and Assigned(AFailed) then 
     AFailed.Add('SSL_CIPHER_get_kx_nid');
  end;


  if not assigned(SSL_CIPHER_get_auth_nid) then 
  begin
    {$if declared(SSL_CIPHER_get_auth_nid_introduced)}
    if LibVersion < SSL_CIPHER_get_auth_nid_introduced then
      {$if declared(FC_SSL_CIPHER_get_auth_nid)}
      SSL_CIPHER_get_auth_nid := @FC_SSL_CIPHER_get_auth_nid
      {$else}
      SSL_CIPHER_get_auth_nid := @ERR_SSL_CIPHER_get_auth_nid
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CIPHER_get_auth_nid_removed)}
   if SSL_CIPHER_get_auth_nid_removed <= LibVersion then
     {$if declared(_SSL_CIPHER_get_auth_nid)}
     SSL_CIPHER_get_auth_nid := @_SSL_CIPHER_get_auth_nid
     {$else}
       {$IF declared(ERR_SSL_CIPHER_get_auth_nid)}
       SSL_CIPHER_get_auth_nid := @ERR_SSL_CIPHER_get_auth_nid
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CIPHER_get_auth_nid) and Assigned(AFailed) then 
     AFailed.Add('SSL_CIPHER_get_auth_nid');
  end;


  if not assigned(SSL_CIPHER_get_handshake_digest) then 
  begin
    {$if declared(SSL_CIPHER_get_handshake_digest_introduced)}
    if LibVersion < SSL_CIPHER_get_handshake_digest_introduced then
      {$if declared(FC_SSL_CIPHER_get_handshake_digest)}
      SSL_CIPHER_get_handshake_digest := @FC_SSL_CIPHER_get_handshake_digest
      {$else}
      SSL_CIPHER_get_handshake_digest := @ERR_SSL_CIPHER_get_handshake_digest
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CIPHER_get_handshake_digest_removed)}
   if SSL_CIPHER_get_handshake_digest_removed <= LibVersion then
     {$if declared(_SSL_CIPHER_get_handshake_digest)}
     SSL_CIPHER_get_handshake_digest := @_SSL_CIPHER_get_handshake_digest
     {$else}
       {$IF declared(ERR_SSL_CIPHER_get_handshake_digest)}
       SSL_CIPHER_get_handshake_digest := @ERR_SSL_CIPHER_get_handshake_digest
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CIPHER_get_handshake_digest) and Assigned(AFailed) then 
     AFailed.Add('SSL_CIPHER_get_handshake_digest');
  end;


  if not assigned(SSL_CIPHER_is_aead) then 
  begin
    {$if declared(SSL_CIPHER_is_aead_introduced)}
    if LibVersion < SSL_CIPHER_is_aead_introduced then
      {$if declared(FC_SSL_CIPHER_is_aead)}
      SSL_CIPHER_is_aead := @FC_SSL_CIPHER_is_aead
      {$else}
      SSL_CIPHER_is_aead := @ERR_SSL_CIPHER_is_aead
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CIPHER_is_aead_removed)}
   if SSL_CIPHER_is_aead_removed <= LibVersion then
     {$if declared(_SSL_CIPHER_is_aead)}
     SSL_CIPHER_is_aead := @_SSL_CIPHER_is_aead
     {$else}
       {$IF declared(ERR_SSL_CIPHER_is_aead)}
       SSL_CIPHER_is_aead := @ERR_SSL_CIPHER_is_aead
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CIPHER_is_aead) and Assigned(AFailed) then 
     AFailed.Add('SSL_CIPHER_is_aead');
  end;


  if not assigned(SSL_has_pending) then 
  begin
    {$if declared(SSL_has_pending_introduced)}
    if LibVersion < SSL_has_pending_introduced then
      {$if declared(FC_SSL_has_pending)}
      SSL_has_pending := @FC_SSL_has_pending
      {$else}
      SSL_has_pending := @ERR_SSL_has_pending
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_has_pending_removed)}
   if SSL_has_pending_removed <= LibVersion then
     {$if declared(_SSL_has_pending)}
     SSL_has_pending := @_SSL_has_pending
     {$else}
       {$IF declared(ERR_SSL_has_pending)}
       SSL_has_pending := @ERR_SSL_has_pending
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_has_pending) and Assigned(AFailed) then 
     AFailed.Add('SSL_has_pending');
  end;


  if not assigned(SSL_set0_rbio) then 
  begin
    {$if declared(SSL_set0_rbio_introduced)}
    if LibVersion < SSL_set0_rbio_introduced then
      {$if declared(FC_SSL_set0_rbio)}
      SSL_set0_rbio := @FC_SSL_set0_rbio
      {$else}
      SSL_set0_rbio := @ERR_SSL_set0_rbio
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set0_rbio_removed)}
   if SSL_set0_rbio_removed <= LibVersion then
     {$if declared(_SSL_set0_rbio)}
     SSL_set0_rbio := @_SSL_set0_rbio
     {$else}
       {$IF declared(ERR_SSL_set0_rbio)}
       SSL_set0_rbio := @ERR_SSL_set0_rbio
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set0_rbio) and Assigned(AFailed) then 
     AFailed.Add('SSL_set0_rbio');
  end;


  if not assigned(SSL_set0_wbio) then 
  begin
    {$if declared(SSL_set0_wbio_introduced)}
    if LibVersion < SSL_set0_wbio_introduced then
      {$if declared(FC_SSL_set0_wbio)}
      SSL_set0_wbio := @FC_SSL_set0_wbio
      {$else}
      SSL_set0_wbio := @ERR_SSL_set0_wbio
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set0_wbio_removed)}
   if SSL_set0_wbio_removed <= LibVersion then
     {$if declared(_SSL_set0_wbio)}
     SSL_set0_wbio := @_SSL_set0_wbio
     {$else}
       {$IF declared(ERR_SSL_set0_wbio)}
       SSL_set0_wbio := @ERR_SSL_set0_wbio
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set0_wbio) and Assigned(AFailed) then 
     AFailed.Add('SSL_set0_wbio');
  end;


  if not assigned(SSL_CTX_set_ciphersuites) then 
  begin
    {$if declared(SSL_CTX_set_ciphersuites_introduced)}
    if LibVersion < SSL_CTX_set_ciphersuites_introduced then
      {$if declared(FC_SSL_CTX_set_ciphersuites)}
      SSL_CTX_set_ciphersuites := @FC_SSL_CTX_set_ciphersuites
      {$else}
      SSL_CTX_set_ciphersuites := @ERR_SSL_CTX_set_ciphersuites
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_ciphersuites_removed)}
   if SSL_CTX_set_ciphersuites_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_ciphersuites)}
     SSL_CTX_set_ciphersuites := @_SSL_CTX_set_ciphersuites
     {$else}
       {$IF declared(ERR_SSL_CTX_set_ciphersuites)}
       SSL_CTX_set_ciphersuites := @ERR_SSL_CTX_set_ciphersuites
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_ciphersuites) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_ciphersuites');
  end;


  if not assigned(SSL_set_ciphersuites) then 
  begin
    {$if declared(SSL_set_ciphersuites_introduced)}
    if LibVersion < SSL_set_ciphersuites_introduced then
      {$if declared(FC_SSL_set_ciphersuites)}
      SSL_set_ciphersuites := @FC_SSL_set_ciphersuites
      {$else}
      SSL_set_ciphersuites := @ERR_SSL_set_ciphersuites
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_ciphersuites_removed)}
   if SSL_set_ciphersuites_removed <= LibVersion then
     {$if declared(_SSL_set_ciphersuites)}
     SSL_set_ciphersuites := @_SSL_set_ciphersuites
     {$else}
       {$IF declared(ERR_SSL_set_ciphersuites)}
       SSL_set_ciphersuites := @ERR_SSL_set_ciphersuites
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_ciphersuites) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_ciphersuites');
  end;


  if not assigned(SSL_CTX_use_serverinfo_ex) then 
  begin
    {$if declared(SSL_CTX_use_serverinfo_ex_introduced)}
    if LibVersion < SSL_CTX_use_serverinfo_ex_introduced then
      {$if declared(FC_SSL_CTX_use_serverinfo_ex)}
      SSL_CTX_use_serverinfo_ex := @FC_SSL_CTX_use_serverinfo_ex
      {$else}
      SSL_CTX_use_serverinfo_ex := @ERR_SSL_CTX_use_serverinfo_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_use_serverinfo_ex_removed)}
   if SSL_CTX_use_serverinfo_ex_removed <= LibVersion then
     {$if declared(_SSL_CTX_use_serverinfo_ex)}
     SSL_CTX_use_serverinfo_ex := @_SSL_CTX_use_serverinfo_ex
     {$else}
       {$IF declared(ERR_SSL_CTX_use_serverinfo_ex)}
       SSL_CTX_use_serverinfo_ex := @ERR_SSL_CTX_use_serverinfo_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_use_serverinfo_ex) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_use_serverinfo_ex');
  end;


  if not assigned(SSL_use_certificate_chain_file) then 
  begin
    {$if declared(SSL_use_certificate_chain_file_introduced)}
    if LibVersion < SSL_use_certificate_chain_file_introduced then
      {$if declared(FC_SSL_use_certificate_chain_file)}
      SSL_use_certificate_chain_file := @FC_SSL_use_certificate_chain_file
      {$else}
      SSL_use_certificate_chain_file := @ERR_SSL_use_certificate_chain_file
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_use_certificate_chain_file_removed)}
   if SSL_use_certificate_chain_file_removed <= LibVersion then
     {$if declared(_SSL_use_certificate_chain_file)}
     SSL_use_certificate_chain_file := @_SSL_use_certificate_chain_file
     {$else}
       {$IF declared(ERR_SSL_use_certificate_chain_file)}
       SSL_use_certificate_chain_file := @ERR_SSL_use_certificate_chain_file
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_use_certificate_chain_file) and Assigned(AFailed) then 
     AFailed.Add('SSL_use_certificate_chain_file');
  end;


  if not assigned(SSL_load_error_strings) then 
  begin
    {$if declared(SSL_load_error_strings_introduced)}
    if LibVersion < SSL_load_error_strings_introduced then
      {$if declared(FC_SSL_load_error_strings)}
      SSL_load_error_strings := @FC_SSL_load_error_strings
      {$else}
      SSL_load_error_strings := @ERR_SSL_load_error_strings
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_load_error_strings_removed)}
   if SSL_load_error_strings_removed <= LibVersion then
     {$if declared(_SSL_load_error_strings)}
     SSL_load_error_strings := @_SSL_load_error_strings
     {$else}
       {$IF declared(ERR_SSL_load_error_strings)}
       SSL_load_error_strings := @ERR_SSL_load_error_strings
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_load_error_strings) and Assigned(AFailed) then 
     AFailed.Add('SSL_load_error_strings');
  end;


  if not assigned(SSL_SESSION_get_protocol_version) then 
  begin
    {$if declared(SSL_SESSION_get_protocol_version_introduced)}
    if LibVersion < SSL_SESSION_get_protocol_version_introduced then
      {$if declared(FC_SSL_SESSION_get_protocol_version)}
      SSL_SESSION_get_protocol_version := @FC_SSL_SESSION_get_protocol_version
      {$else}
      SSL_SESSION_get_protocol_version := @ERR_SSL_SESSION_get_protocol_version
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_get_protocol_version_removed)}
   if SSL_SESSION_get_protocol_version_removed <= LibVersion then
     {$if declared(_SSL_SESSION_get_protocol_version)}
     SSL_SESSION_get_protocol_version := @_SSL_SESSION_get_protocol_version
     {$else}
       {$IF declared(ERR_SSL_SESSION_get_protocol_version)}
       SSL_SESSION_get_protocol_version := @ERR_SSL_SESSION_get_protocol_version
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_get_protocol_version) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_get_protocol_version');
  end;


  if not assigned(SSL_SESSION_set_protocol_version) then 
  begin
    {$if declared(SSL_SESSION_set_protocol_version_introduced)}
    if LibVersion < SSL_SESSION_set_protocol_version_introduced then
      {$if declared(FC_SSL_SESSION_set_protocol_version)}
      SSL_SESSION_set_protocol_version := @FC_SSL_SESSION_set_protocol_version
      {$else}
      SSL_SESSION_set_protocol_version := @ERR_SSL_SESSION_set_protocol_version
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_set_protocol_version_removed)}
   if SSL_SESSION_set_protocol_version_removed <= LibVersion then
     {$if declared(_SSL_SESSION_set_protocol_version)}
     SSL_SESSION_set_protocol_version := @_SSL_SESSION_set_protocol_version
     {$else}
       {$IF declared(ERR_SSL_SESSION_set_protocol_version)}
       SSL_SESSION_set_protocol_version := @ERR_SSL_SESSION_set_protocol_version
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_set_protocol_version) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_set_protocol_version');
  end;


  if not assigned(SSL_SESSION_get0_hostname) then 
  begin
    {$if declared(SSL_SESSION_get0_hostname_introduced)}
    if LibVersion < SSL_SESSION_get0_hostname_introduced then
      {$if declared(FC_SSL_SESSION_get0_hostname)}
      SSL_SESSION_get0_hostname := @FC_SSL_SESSION_get0_hostname
      {$else}
      SSL_SESSION_get0_hostname := @ERR_SSL_SESSION_get0_hostname
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_get0_hostname_removed)}
   if SSL_SESSION_get0_hostname_removed <= LibVersion then
     {$if declared(_SSL_SESSION_get0_hostname)}
     SSL_SESSION_get0_hostname := @_SSL_SESSION_get0_hostname
     {$else}
       {$IF declared(ERR_SSL_SESSION_get0_hostname)}
       SSL_SESSION_get0_hostname := @ERR_SSL_SESSION_get0_hostname
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_get0_hostname) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_get0_hostname');
  end;


  if not assigned(SSL_SESSION_set1_hostname) then 
  begin
    {$if declared(SSL_SESSION_set1_hostname_introduced)}
    if LibVersion < SSL_SESSION_set1_hostname_introduced then
      {$if declared(FC_SSL_SESSION_set1_hostname)}
      SSL_SESSION_set1_hostname := @FC_SSL_SESSION_set1_hostname
      {$else}
      SSL_SESSION_set1_hostname := @ERR_SSL_SESSION_set1_hostname
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_set1_hostname_removed)}
   if SSL_SESSION_set1_hostname_removed <= LibVersion then
     {$if declared(_SSL_SESSION_set1_hostname)}
     SSL_SESSION_set1_hostname := @_SSL_SESSION_set1_hostname
     {$else}
       {$IF declared(ERR_SSL_SESSION_set1_hostname)}
       SSL_SESSION_set1_hostname := @ERR_SSL_SESSION_set1_hostname
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_set1_hostname) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_set1_hostname');
  end;


  if not assigned(SSL_SESSION_get0_alpn_selected) then 
  begin
    {$if declared(SSL_SESSION_get0_alpn_selected_introduced)}
    if LibVersion < SSL_SESSION_get0_alpn_selected_introduced then
      {$if declared(FC_SSL_SESSION_get0_alpn_selected)}
      SSL_SESSION_get0_alpn_selected := @FC_SSL_SESSION_get0_alpn_selected
      {$else}
      SSL_SESSION_get0_alpn_selected := @ERR_SSL_SESSION_get0_alpn_selected
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_get0_alpn_selected_removed)}
   if SSL_SESSION_get0_alpn_selected_removed <= LibVersion then
     {$if declared(_SSL_SESSION_get0_alpn_selected)}
     SSL_SESSION_get0_alpn_selected := @_SSL_SESSION_get0_alpn_selected
     {$else}
       {$IF declared(ERR_SSL_SESSION_get0_alpn_selected)}
       SSL_SESSION_get0_alpn_selected := @ERR_SSL_SESSION_get0_alpn_selected
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_get0_alpn_selected) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_get0_alpn_selected');
  end;


  if not assigned(SSL_SESSION_set1_alpn_selected) then 
  begin
    {$if declared(SSL_SESSION_set1_alpn_selected_introduced)}
    if LibVersion < SSL_SESSION_set1_alpn_selected_introduced then
      {$if declared(FC_SSL_SESSION_set1_alpn_selected)}
      SSL_SESSION_set1_alpn_selected := @FC_SSL_SESSION_set1_alpn_selected
      {$else}
      SSL_SESSION_set1_alpn_selected := @ERR_SSL_SESSION_set1_alpn_selected
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_set1_alpn_selected_removed)}
   if SSL_SESSION_set1_alpn_selected_removed <= LibVersion then
     {$if declared(_SSL_SESSION_set1_alpn_selected)}
     SSL_SESSION_set1_alpn_selected := @_SSL_SESSION_set1_alpn_selected
     {$else}
       {$IF declared(ERR_SSL_SESSION_set1_alpn_selected)}
       SSL_SESSION_set1_alpn_selected := @ERR_SSL_SESSION_set1_alpn_selected
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_set1_alpn_selected) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_set1_alpn_selected');
  end;


  if not assigned(SSL_SESSION_get0_cipher) then 
  begin
    {$if declared(SSL_SESSION_get0_cipher_introduced)}
    if LibVersion < SSL_SESSION_get0_cipher_introduced then
      {$if declared(FC_SSL_SESSION_get0_cipher)}
      SSL_SESSION_get0_cipher := @FC_SSL_SESSION_get0_cipher
      {$else}
      SSL_SESSION_get0_cipher := @ERR_SSL_SESSION_get0_cipher
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_get0_cipher_removed)}
   if SSL_SESSION_get0_cipher_removed <= LibVersion then
     {$if declared(_SSL_SESSION_get0_cipher)}
     SSL_SESSION_get0_cipher := @_SSL_SESSION_get0_cipher
     {$else}
       {$IF declared(ERR_SSL_SESSION_get0_cipher)}
       SSL_SESSION_get0_cipher := @ERR_SSL_SESSION_get0_cipher
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_get0_cipher) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_get0_cipher');
  end;


  if not assigned(SSL_SESSION_set_cipher) then 
  begin
    {$if declared(SSL_SESSION_set_cipher_introduced)}
    if LibVersion < SSL_SESSION_set_cipher_introduced then
      {$if declared(FC_SSL_SESSION_set_cipher)}
      SSL_SESSION_set_cipher := @FC_SSL_SESSION_set_cipher
      {$else}
      SSL_SESSION_set_cipher := @ERR_SSL_SESSION_set_cipher
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_set_cipher_removed)}
   if SSL_SESSION_set_cipher_removed <= LibVersion then
     {$if declared(_SSL_SESSION_set_cipher)}
     SSL_SESSION_set_cipher := @_SSL_SESSION_set_cipher
     {$else}
       {$IF declared(ERR_SSL_SESSION_set_cipher)}
       SSL_SESSION_set_cipher := @ERR_SSL_SESSION_set_cipher
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_set_cipher) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_set_cipher');
  end;


  if not assigned(SSL_SESSION_has_ticket) then 
  begin
    {$if declared(SSL_SESSION_has_ticket_introduced)}
    if LibVersion < SSL_SESSION_has_ticket_introduced then
      {$if declared(FC_SSL_SESSION_has_ticket)}
      SSL_SESSION_has_ticket := @FC_SSL_SESSION_has_ticket
      {$else}
      SSL_SESSION_has_ticket := @ERR_SSL_SESSION_has_ticket
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_has_ticket_removed)}
   if SSL_SESSION_has_ticket_removed <= LibVersion then
     {$if declared(_SSL_SESSION_has_ticket)}
     SSL_SESSION_has_ticket := @_SSL_SESSION_has_ticket
     {$else}
       {$IF declared(ERR_SSL_SESSION_has_ticket)}
       SSL_SESSION_has_ticket := @ERR_SSL_SESSION_has_ticket
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_has_ticket) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_has_ticket');
  end;


  if not assigned(SSL_SESSION_get_ticket_lifetime_hint) then 
  begin
    {$if declared(SSL_SESSION_get_ticket_lifetime_hint_introduced)}
    if LibVersion < SSL_SESSION_get_ticket_lifetime_hint_introduced then
      {$if declared(FC_SSL_SESSION_get_ticket_lifetime_hint)}
      SSL_SESSION_get_ticket_lifetime_hint := @FC_SSL_SESSION_get_ticket_lifetime_hint
      {$else}
      SSL_SESSION_get_ticket_lifetime_hint := @ERR_SSL_SESSION_get_ticket_lifetime_hint
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_get_ticket_lifetime_hint_removed)}
   if SSL_SESSION_get_ticket_lifetime_hint_removed <= LibVersion then
     {$if declared(_SSL_SESSION_get_ticket_lifetime_hint)}
     SSL_SESSION_get_ticket_lifetime_hint := @_SSL_SESSION_get_ticket_lifetime_hint
     {$else}
       {$IF declared(ERR_SSL_SESSION_get_ticket_lifetime_hint)}
       SSL_SESSION_get_ticket_lifetime_hint := @ERR_SSL_SESSION_get_ticket_lifetime_hint
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_get_ticket_lifetime_hint) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_get_ticket_lifetime_hint');
  end;


  if not assigned(SSL_SESSION_get0_ticket) then 
  begin
    {$if declared(SSL_SESSION_get0_ticket_introduced)}
    if LibVersion < SSL_SESSION_get0_ticket_introduced then
      {$if declared(FC_SSL_SESSION_get0_ticket)}
      SSL_SESSION_get0_ticket := @FC_SSL_SESSION_get0_ticket
      {$else}
      SSL_SESSION_get0_ticket := @ERR_SSL_SESSION_get0_ticket
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_get0_ticket_removed)}
   if SSL_SESSION_get0_ticket_removed <= LibVersion then
     {$if declared(_SSL_SESSION_get0_ticket)}
     SSL_SESSION_get0_ticket := @_SSL_SESSION_get0_ticket
     {$else}
       {$IF declared(ERR_SSL_SESSION_get0_ticket)}
       SSL_SESSION_get0_ticket := @ERR_SSL_SESSION_get0_ticket
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_get0_ticket) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_get0_ticket');
  end;


  if not assigned(SSL_SESSION_get_max_early_data) then 
  begin
    {$if declared(SSL_SESSION_get_max_early_data_introduced)}
    if LibVersion < SSL_SESSION_get_max_early_data_introduced then
      {$if declared(FC_SSL_SESSION_get_max_early_data)}
      SSL_SESSION_get_max_early_data := @FC_SSL_SESSION_get_max_early_data
      {$else}
      SSL_SESSION_get_max_early_data := @ERR_SSL_SESSION_get_max_early_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_get_max_early_data_removed)}
   if SSL_SESSION_get_max_early_data_removed <= LibVersion then
     {$if declared(_SSL_SESSION_get_max_early_data)}
     SSL_SESSION_get_max_early_data := @_SSL_SESSION_get_max_early_data
     {$else}
       {$IF declared(ERR_SSL_SESSION_get_max_early_data)}
       SSL_SESSION_get_max_early_data := @ERR_SSL_SESSION_get_max_early_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_get_max_early_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_get_max_early_data');
  end;


  if not assigned(SSL_SESSION_set_max_early_data) then 
  begin
    {$if declared(SSL_SESSION_set_max_early_data_introduced)}
    if LibVersion < SSL_SESSION_set_max_early_data_introduced then
      {$if declared(FC_SSL_SESSION_set_max_early_data)}
      SSL_SESSION_set_max_early_data := @FC_SSL_SESSION_set_max_early_data
      {$else}
      SSL_SESSION_set_max_early_data := @ERR_SSL_SESSION_set_max_early_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_set_max_early_data_removed)}
   if SSL_SESSION_set_max_early_data_removed <= LibVersion then
     {$if declared(_SSL_SESSION_set_max_early_data)}
     SSL_SESSION_set_max_early_data := @_SSL_SESSION_set_max_early_data
     {$else}
       {$IF declared(ERR_SSL_SESSION_set_max_early_data)}
       SSL_SESSION_set_max_early_data := @ERR_SSL_SESSION_set_max_early_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_set_max_early_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_set_max_early_data');
  end;


  if not assigned(SSL_SESSION_set1_id) then 
  begin
    {$if declared(SSL_SESSION_set1_id_introduced)}
    if LibVersion < SSL_SESSION_set1_id_introduced then
      {$if declared(FC_SSL_SESSION_set1_id)}
      SSL_SESSION_set1_id := @FC_SSL_SESSION_set1_id
      {$else}
      SSL_SESSION_set1_id := @ERR_SSL_SESSION_set1_id
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_set1_id_removed)}
   if SSL_SESSION_set1_id_removed <= LibVersion then
     {$if declared(_SSL_SESSION_set1_id)}
     SSL_SESSION_set1_id := @_SSL_SESSION_set1_id
     {$else}
       {$IF declared(ERR_SSL_SESSION_set1_id)}
       SSL_SESSION_set1_id := @ERR_SSL_SESSION_set1_id
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_set1_id) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_set1_id');
  end;


  if not assigned(SSL_SESSION_is_resumable) then 
  begin
    {$if declared(SSL_SESSION_is_resumable_introduced)}
    if LibVersion < SSL_SESSION_is_resumable_introduced then
      {$if declared(FC_SSL_SESSION_is_resumable)}
      SSL_SESSION_is_resumable := @FC_SSL_SESSION_is_resumable
      {$else}
      SSL_SESSION_is_resumable := @ERR_SSL_SESSION_is_resumable
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_is_resumable_removed)}
   if SSL_SESSION_is_resumable_removed <= LibVersion then
     {$if declared(_SSL_SESSION_is_resumable)}
     SSL_SESSION_is_resumable := @_SSL_SESSION_is_resumable
     {$else}
       {$IF declared(ERR_SSL_SESSION_is_resumable)}
       SSL_SESSION_is_resumable := @ERR_SSL_SESSION_is_resumable
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_is_resumable) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_is_resumable');
  end;


  if not assigned(SSL_SESSION_dup) then 
  begin
    {$if declared(SSL_SESSION_dup_introduced)}
    if LibVersion < SSL_SESSION_dup_introduced then
      {$if declared(FC_SSL_SESSION_dup)}
      SSL_SESSION_dup := @FC_SSL_SESSION_dup
      {$else}
      SSL_SESSION_dup := @ERR_SSL_SESSION_dup
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_dup_removed)}
   if SSL_SESSION_dup_removed <= LibVersion then
     {$if declared(_SSL_SESSION_dup)}
     SSL_SESSION_dup := @_SSL_SESSION_dup
     {$else}
       {$IF declared(ERR_SSL_SESSION_dup)}
       SSL_SESSION_dup := @ERR_SSL_SESSION_dup
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_dup) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_dup');
  end;


  if not assigned(SSL_SESSION_get0_id_context) then 
  begin
    {$if declared(SSL_SESSION_get0_id_context_introduced)}
    if LibVersion < SSL_SESSION_get0_id_context_introduced then
      {$if declared(FC_SSL_SESSION_get0_id_context)}
      SSL_SESSION_get0_id_context := @FC_SSL_SESSION_get0_id_context
      {$else}
      SSL_SESSION_get0_id_context := @ERR_SSL_SESSION_get0_id_context
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_get0_id_context_removed)}
   if SSL_SESSION_get0_id_context_removed <= LibVersion then
     {$if declared(_SSL_SESSION_get0_id_context)}
     SSL_SESSION_get0_id_context := @_SSL_SESSION_get0_id_context
     {$else}
       {$IF declared(ERR_SSL_SESSION_get0_id_context)}
       SSL_SESSION_get0_id_context := @ERR_SSL_SESSION_get0_id_context
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_get0_id_context) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_get0_id_context');
  end;


  if not assigned(SSL_SESSION_print_keylog) then 
  begin
    {$if declared(SSL_SESSION_print_keylog_introduced)}
    if LibVersion < SSL_SESSION_print_keylog_introduced then
      {$if declared(FC_SSL_SESSION_print_keylog)}
      SSL_SESSION_print_keylog := @FC_SSL_SESSION_print_keylog
      {$else}
      SSL_SESSION_print_keylog := @ERR_SSL_SESSION_print_keylog
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_print_keylog_removed)}
   if SSL_SESSION_print_keylog_removed <= LibVersion then
     {$if declared(_SSL_SESSION_print_keylog)}
     SSL_SESSION_print_keylog := @_SSL_SESSION_print_keylog
     {$else}
       {$IF declared(ERR_SSL_SESSION_print_keylog)}
       SSL_SESSION_print_keylog := @ERR_SSL_SESSION_print_keylog
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_print_keylog) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_print_keylog');
  end;


  if not assigned(SSL_SESSION_up_ref) then 
  begin
    {$if declared(SSL_SESSION_up_ref_introduced)}
    if LibVersion < SSL_SESSION_up_ref_introduced then
      {$if declared(FC_SSL_SESSION_up_ref)}
      SSL_SESSION_up_ref := @FC_SSL_SESSION_up_ref
      {$else}
      SSL_SESSION_up_ref := @ERR_SSL_SESSION_up_ref
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_up_ref_removed)}
   if SSL_SESSION_up_ref_removed <= LibVersion then
     {$if declared(_SSL_SESSION_up_ref)}
     SSL_SESSION_up_ref := @_SSL_SESSION_up_ref
     {$else}
       {$IF declared(ERR_SSL_SESSION_up_ref)}
       SSL_SESSION_up_ref := @ERR_SSL_SESSION_up_ref
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_up_ref) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_up_ref');
  end;


  if not assigned(SSL_get_peer_certificate) then 
  begin
    {$if declared(SSL_get_peer_certificate_introduced)}
    if LibVersion < SSL_get_peer_certificate_introduced then
      {$if declared(FC_SSL_get_peer_certificate)}
      SSL_get_peer_certificate := @FC_SSL_get_peer_certificate
      {$else}
      SSL_get_peer_certificate := @ERR_SSL_get_peer_certificate
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_peer_certificate_removed)}
   if SSL_get_peer_certificate_removed <= LibVersion then
     {$if declared(_SSL_get_peer_certificate)}
     SSL_get_peer_certificate := @_SSL_get_peer_certificate
     {$else}
       {$IF declared(ERR_SSL_get_peer_certificate)}
       SSL_get_peer_certificate := @ERR_SSL_get_peer_certificate
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_peer_certificate) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_peer_certificate');
  end;


  if not assigned(SSL_CTX_set_default_passwd_cb) then 
  begin
    {$if declared(SSL_CTX_set_default_passwd_cb_introduced)}
    if LibVersion < SSL_CTX_set_default_passwd_cb_introduced then
      {$if declared(FC_SSL_CTX_set_default_passwd_cb)}
      SSL_CTX_set_default_passwd_cb := @FC_SSL_CTX_set_default_passwd_cb
      {$else}
      SSL_CTX_set_default_passwd_cb := @ERR_SSL_CTX_set_default_passwd_cb
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_default_passwd_cb_removed)}
   if SSL_CTX_set_default_passwd_cb_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_default_passwd_cb)}
     SSL_CTX_set_default_passwd_cb := @_SSL_CTX_set_default_passwd_cb
     {$else}
       {$IF declared(ERR_SSL_CTX_set_default_passwd_cb)}
       SSL_CTX_set_default_passwd_cb := @ERR_SSL_CTX_set_default_passwd_cb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_default_passwd_cb) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_default_passwd_cb');
  end;


  if not assigned(SSL_CTX_set_default_passwd_cb_userdata) then 
  begin
    {$if declared(SSL_CTX_set_default_passwd_cb_userdata_introduced)}
    if LibVersion < SSL_CTX_set_default_passwd_cb_userdata_introduced then
      {$if declared(FC_SSL_CTX_set_default_passwd_cb_userdata)}
      SSL_CTX_set_default_passwd_cb_userdata := @FC_SSL_CTX_set_default_passwd_cb_userdata
      {$else}
      SSL_CTX_set_default_passwd_cb_userdata := @ERR_SSL_CTX_set_default_passwd_cb_userdata
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_default_passwd_cb_userdata_removed)}
   if SSL_CTX_set_default_passwd_cb_userdata_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_default_passwd_cb_userdata)}
     SSL_CTX_set_default_passwd_cb_userdata := @_SSL_CTX_set_default_passwd_cb_userdata
     {$else}
       {$IF declared(ERR_SSL_CTX_set_default_passwd_cb_userdata)}
       SSL_CTX_set_default_passwd_cb_userdata := @ERR_SSL_CTX_set_default_passwd_cb_userdata
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_default_passwd_cb_userdata) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_default_passwd_cb_userdata');
  end;


  if not assigned(SSL_CTX_get_default_passwd_cb) then 
  begin
    {$if declared(SSL_CTX_get_default_passwd_cb_introduced)}
    if LibVersion < SSL_CTX_get_default_passwd_cb_introduced then
      {$if declared(FC_SSL_CTX_get_default_passwd_cb)}
      SSL_CTX_get_default_passwd_cb := @FC_SSL_CTX_get_default_passwd_cb
      {$else}
      SSL_CTX_get_default_passwd_cb := @ERR_SSL_CTX_get_default_passwd_cb
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get_default_passwd_cb_removed)}
   if SSL_CTX_get_default_passwd_cb_removed <= LibVersion then
     {$if declared(_SSL_CTX_get_default_passwd_cb)}
     SSL_CTX_get_default_passwd_cb := @_SSL_CTX_get_default_passwd_cb
     {$else}
       {$IF declared(ERR_SSL_CTX_get_default_passwd_cb)}
       SSL_CTX_get_default_passwd_cb := @ERR_SSL_CTX_get_default_passwd_cb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get_default_passwd_cb) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get_default_passwd_cb');
  end;


  if not assigned(SSL_CTX_get_default_passwd_cb_userdata) then 
  begin
    {$if declared(SSL_CTX_get_default_passwd_cb_userdata_introduced)}
    if LibVersion < SSL_CTX_get_default_passwd_cb_userdata_introduced then
      {$if declared(FC_SSL_CTX_get_default_passwd_cb_userdata)}
      SSL_CTX_get_default_passwd_cb_userdata := @FC_SSL_CTX_get_default_passwd_cb_userdata
      {$else}
      SSL_CTX_get_default_passwd_cb_userdata := @ERR_SSL_CTX_get_default_passwd_cb_userdata
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get_default_passwd_cb_userdata_removed)}
   if SSL_CTX_get_default_passwd_cb_userdata_removed <= LibVersion then
     {$if declared(_SSL_CTX_get_default_passwd_cb_userdata)}
     SSL_CTX_get_default_passwd_cb_userdata := @_SSL_CTX_get_default_passwd_cb_userdata
     {$else}
       {$IF declared(ERR_SSL_CTX_get_default_passwd_cb_userdata)}
       SSL_CTX_get_default_passwd_cb_userdata := @ERR_SSL_CTX_get_default_passwd_cb_userdata
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get_default_passwd_cb_userdata) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get_default_passwd_cb_userdata');
  end;


  if not assigned(SSL_set_default_passwd_cb) then 
  begin
    {$if declared(SSL_set_default_passwd_cb_introduced)}
    if LibVersion < SSL_set_default_passwd_cb_introduced then
      {$if declared(FC_SSL_set_default_passwd_cb)}
      SSL_set_default_passwd_cb := @FC_SSL_set_default_passwd_cb
      {$else}
      SSL_set_default_passwd_cb := @ERR_SSL_set_default_passwd_cb
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_default_passwd_cb_removed)}
   if SSL_set_default_passwd_cb_removed <= LibVersion then
     {$if declared(_SSL_set_default_passwd_cb)}
     SSL_set_default_passwd_cb := @_SSL_set_default_passwd_cb
     {$else}
       {$IF declared(ERR_SSL_set_default_passwd_cb)}
       SSL_set_default_passwd_cb := @ERR_SSL_set_default_passwd_cb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_default_passwd_cb) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_default_passwd_cb');
  end;


  if not assigned(SSL_set_default_passwd_cb_userdata) then 
  begin
    {$if declared(SSL_set_default_passwd_cb_userdata_introduced)}
    if LibVersion < SSL_set_default_passwd_cb_userdata_introduced then
      {$if declared(FC_SSL_set_default_passwd_cb_userdata)}
      SSL_set_default_passwd_cb_userdata := @FC_SSL_set_default_passwd_cb_userdata
      {$else}
      SSL_set_default_passwd_cb_userdata := @ERR_SSL_set_default_passwd_cb_userdata
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_default_passwd_cb_userdata_removed)}
   if SSL_set_default_passwd_cb_userdata_removed <= LibVersion then
     {$if declared(_SSL_set_default_passwd_cb_userdata)}
     SSL_set_default_passwd_cb_userdata := @_SSL_set_default_passwd_cb_userdata
     {$else}
       {$IF declared(ERR_SSL_set_default_passwd_cb_userdata)}
       SSL_set_default_passwd_cb_userdata := @ERR_SSL_set_default_passwd_cb_userdata
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_default_passwd_cb_userdata) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_default_passwd_cb_userdata');
  end;


  if not assigned(SSL_get_default_passwd_cb) then 
  begin
    {$if declared(SSL_get_default_passwd_cb_introduced)}
    if LibVersion < SSL_get_default_passwd_cb_introduced then
      {$if declared(FC_SSL_get_default_passwd_cb)}
      SSL_get_default_passwd_cb := @FC_SSL_get_default_passwd_cb
      {$else}
      SSL_get_default_passwd_cb := @ERR_SSL_get_default_passwd_cb
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_default_passwd_cb_removed)}
   if SSL_get_default_passwd_cb_removed <= LibVersion then
     {$if declared(_SSL_get_default_passwd_cb)}
     SSL_get_default_passwd_cb := @_SSL_get_default_passwd_cb
     {$else}
       {$IF declared(ERR_SSL_get_default_passwd_cb)}
       SSL_get_default_passwd_cb := @ERR_SSL_get_default_passwd_cb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_default_passwd_cb) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_default_passwd_cb');
  end;


  if not assigned(SSL_get_default_passwd_cb_userdata) then 
  begin
    {$if declared(SSL_get_default_passwd_cb_userdata_introduced)}
    if LibVersion < SSL_get_default_passwd_cb_userdata_introduced then
      {$if declared(FC_SSL_get_default_passwd_cb_userdata)}
      SSL_get_default_passwd_cb_userdata := @FC_SSL_get_default_passwd_cb_userdata
      {$else}
      SSL_get_default_passwd_cb_userdata := @ERR_SSL_get_default_passwd_cb_userdata
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_default_passwd_cb_userdata_removed)}
   if SSL_get_default_passwd_cb_userdata_removed <= LibVersion then
     {$if declared(_SSL_get_default_passwd_cb_userdata)}
     SSL_get_default_passwd_cb_userdata := @_SSL_get_default_passwd_cb_userdata
     {$else}
       {$IF declared(ERR_SSL_get_default_passwd_cb_userdata)}
       SSL_get_default_passwd_cb_userdata := @ERR_SSL_get_default_passwd_cb_userdata
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_default_passwd_cb_userdata) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_default_passwd_cb_userdata');
  end;


  if not assigned(SSL_up_ref) then 
  begin
    {$if declared(SSL_up_ref_introduced)}
    if LibVersion < SSL_up_ref_introduced then
      {$if declared(FC_SSL_up_ref)}
      SSL_up_ref := @FC_SSL_up_ref
      {$else}
      SSL_up_ref := @ERR_SSL_up_ref
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_up_ref_removed)}
   if SSL_up_ref_removed <= LibVersion then
     {$if declared(_SSL_up_ref)}
     SSL_up_ref := @_SSL_up_ref
     {$else}
       {$IF declared(ERR_SSL_up_ref)}
       SSL_up_ref := @ERR_SSL_up_ref
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_up_ref) and Assigned(AFailed) then 
     AFailed.Add('SSL_up_ref');
  end;


  if not assigned(SSL_is_dtls) then 
  begin
    {$if declared(SSL_is_dtls_introduced)}
    if LibVersion < SSL_is_dtls_introduced then
      {$if declared(FC_SSL_is_dtls)}
      SSL_is_dtls := @FC_SSL_is_dtls
      {$else}
      SSL_is_dtls := @ERR_SSL_is_dtls
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_is_dtls_removed)}
   if SSL_is_dtls_removed <= LibVersion then
     {$if declared(_SSL_is_dtls)}
     SSL_is_dtls := @_SSL_is_dtls
     {$else}
       {$IF declared(ERR_SSL_is_dtls)}
       SSL_is_dtls := @ERR_SSL_is_dtls
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_is_dtls) and Assigned(AFailed) then 
     AFailed.Add('SSL_is_dtls');
  end;


  if not assigned(SSL_set1_host) then 
  begin
    {$if declared(SSL_set1_host_introduced)}
    if LibVersion < SSL_set1_host_introduced then
      {$if declared(FC_SSL_set1_host)}
      SSL_set1_host := @FC_SSL_set1_host
      {$else}
      SSL_set1_host := @ERR_SSL_set1_host
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set1_host_removed)}
   if SSL_set1_host_removed <= LibVersion then
     {$if declared(_SSL_set1_host)}
     SSL_set1_host := @_SSL_set1_host
     {$else}
       {$IF declared(ERR_SSL_set1_host)}
       SSL_set1_host := @ERR_SSL_set1_host
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set1_host) and Assigned(AFailed) then 
     AFailed.Add('SSL_set1_host');
  end;


  if not assigned(SSL_add1_host) then 
  begin
    {$if declared(SSL_add1_host_introduced)}
    if LibVersion < SSL_add1_host_introduced then
      {$if declared(FC_SSL_add1_host)}
      SSL_add1_host := @FC_SSL_add1_host
      {$else}
      SSL_add1_host := @ERR_SSL_add1_host
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_add1_host_removed)}
   if SSL_add1_host_removed <= LibVersion then
     {$if declared(_SSL_add1_host)}
     SSL_add1_host := @_SSL_add1_host
     {$else}
       {$IF declared(ERR_SSL_add1_host)}
       SSL_add1_host := @ERR_SSL_add1_host
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_add1_host) and Assigned(AFailed) then 
     AFailed.Add('SSL_add1_host');
  end;


  if not assigned(SSL_get0_peername) then 
  begin
    {$if declared(SSL_get0_peername_introduced)}
    if LibVersion < SSL_get0_peername_introduced then
      {$if declared(FC_SSL_get0_peername)}
      SSL_get0_peername := @FC_SSL_get0_peername
      {$else}
      SSL_get0_peername := @ERR_SSL_get0_peername
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get0_peername_removed)}
   if SSL_get0_peername_removed <= LibVersion then
     {$if declared(_SSL_get0_peername)}
     SSL_get0_peername := @_SSL_get0_peername
     {$else}
       {$IF declared(ERR_SSL_get0_peername)}
       SSL_get0_peername := @ERR_SSL_get0_peername
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get0_peername) and Assigned(AFailed) then 
     AFailed.Add('SSL_get0_peername');
  end;


  if not assigned(SSL_set_hostflags) then 
  begin
    {$if declared(SSL_set_hostflags_introduced)}
    if LibVersion < SSL_set_hostflags_introduced then
      {$if declared(FC_SSL_set_hostflags)}
      SSL_set_hostflags := @FC_SSL_set_hostflags
      {$else}
      SSL_set_hostflags := @ERR_SSL_set_hostflags
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_hostflags_removed)}
   if SSL_set_hostflags_removed <= LibVersion then
     {$if declared(_SSL_set_hostflags)}
     SSL_set_hostflags := @_SSL_set_hostflags
     {$else}
       {$IF declared(ERR_SSL_set_hostflags)}
       SSL_set_hostflags := @ERR_SSL_set_hostflags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_hostflags) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_hostflags');
  end;


  if not assigned(SSL_CTX_dane_enable) then 
  begin
    {$if declared(SSL_CTX_dane_enable_introduced)}
    if LibVersion < SSL_CTX_dane_enable_introduced then
      {$if declared(FC_SSL_CTX_dane_enable)}
      SSL_CTX_dane_enable := @FC_SSL_CTX_dane_enable
      {$else}
      SSL_CTX_dane_enable := @ERR_SSL_CTX_dane_enable
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_dane_enable_removed)}
   if SSL_CTX_dane_enable_removed <= LibVersion then
     {$if declared(_SSL_CTX_dane_enable)}
     SSL_CTX_dane_enable := @_SSL_CTX_dane_enable
     {$else}
       {$IF declared(ERR_SSL_CTX_dane_enable)}
       SSL_CTX_dane_enable := @ERR_SSL_CTX_dane_enable
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_dane_enable) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_dane_enable');
  end;


  if not assigned(SSL_CTX_dane_mtype_set) then 
  begin
    {$if declared(SSL_CTX_dane_mtype_set_introduced)}
    if LibVersion < SSL_CTX_dane_mtype_set_introduced then
      {$if declared(FC_SSL_CTX_dane_mtype_set)}
      SSL_CTX_dane_mtype_set := @FC_SSL_CTX_dane_mtype_set
      {$else}
      SSL_CTX_dane_mtype_set := @ERR_SSL_CTX_dane_mtype_set
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_dane_mtype_set_removed)}
   if SSL_CTX_dane_mtype_set_removed <= LibVersion then
     {$if declared(_SSL_CTX_dane_mtype_set)}
     SSL_CTX_dane_mtype_set := @_SSL_CTX_dane_mtype_set
     {$else}
       {$IF declared(ERR_SSL_CTX_dane_mtype_set)}
       SSL_CTX_dane_mtype_set := @ERR_SSL_CTX_dane_mtype_set
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_dane_mtype_set) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_dane_mtype_set');
  end;


  if not assigned(SSL_dane_enable) then 
  begin
    {$if declared(SSL_dane_enable_introduced)}
    if LibVersion < SSL_dane_enable_introduced then
      {$if declared(FC_SSL_dane_enable)}
      SSL_dane_enable := @FC_SSL_dane_enable
      {$else}
      SSL_dane_enable := @ERR_SSL_dane_enable
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_dane_enable_removed)}
   if SSL_dane_enable_removed <= LibVersion then
     {$if declared(_SSL_dane_enable)}
     SSL_dane_enable := @_SSL_dane_enable
     {$else}
       {$IF declared(ERR_SSL_dane_enable)}
       SSL_dane_enable := @ERR_SSL_dane_enable
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_dane_enable) and Assigned(AFailed) then 
     AFailed.Add('SSL_dane_enable');
  end;


  if not assigned(SSL_dane_tlsa_add) then 
  begin
    {$if declared(SSL_dane_tlsa_add_introduced)}
    if LibVersion < SSL_dane_tlsa_add_introduced then
      {$if declared(FC_SSL_dane_tlsa_add)}
      SSL_dane_tlsa_add := @FC_SSL_dane_tlsa_add
      {$else}
      SSL_dane_tlsa_add := @ERR_SSL_dane_tlsa_add
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_dane_tlsa_add_removed)}
   if SSL_dane_tlsa_add_removed <= LibVersion then
     {$if declared(_SSL_dane_tlsa_add)}
     SSL_dane_tlsa_add := @_SSL_dane_tlsa_add
     {$else}
       {$IF declared(ERR_SSL_dane_tlsa_add)}
       SSL_dane_tlsa_add := @ERR_SSL_dane_tlsa_add
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_dane_tlsa_add) and Assigned(AFailed) then 
     AFailed.Add('SSL_dane_tlsa_add');
  end;


  if not assigned(SSL_get0_dane_authority) then 
  begin
    {$if declared(SSL_get0_dane_authority_introduced)}
    if LibVersion < SSL_get0_dane_authority_introduced then
      {$if declared(FC_SSL_get0_dane_authority)}
      SSL_get0_dane_authority := @FC_SSL_get0_dane_authority
      {$else}
      SSL_get0_dane_authority := @ERR_SSL_get0_dane_authority
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get0_dane_authority_removed)}
   if SSL_get0_dane_authority_removed <= LibVersion then
     {$if declared(_SSL_get0_dane_authority)}
     SSL_get0_dane_authority := @_SSL_get0_dane_authority
     {$else}
       {$IF declared(ERR_SSL_get0_dane_authority)}
       SSL_get0_dane_authority := @ERR_SSL_get0_dane_authority
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get0_dane_authority) and Assigned(AFailed) then 
     AFailed.Add('SSL_get0_dane_authority');
  end;


  if not assigned(SSL_get0_dane_tlsa) then 
  begin
    {$if declared(SSL_get0_dane_tlsa_introduced)}
    if LibVersion < SSL_get0_dane_tlsa_introduced then
      {$if declared(FC_SSL_get0_dane_tlsa)}
      SSL_get0_dane_tlsa := @FC_SSL_get0_dane_tlsa
      {$else}
      SSL_get0_dane_tlsa := @ERR_SSL_get0_dane_tlsa
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get0_dane_tlsa_removed)}
   if SSL_get0_dane_tlsa_removed <= LibVersion then
     {$if declared(_SSL_get0_dane_tlsa)}
     SSL_get0_dane_tlsa := @_SSL_get0_dane_tlsa
     {$else}
       {$IF declared(ERR_SSL_get0_dane_tlsa)}
       SSL_get0_dane_tlsa := @ERR_SSL_get0_dane_tlsa
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get0_dane_tlsa) and Assigned(AFailed) then 
     AFailed.Add('SSL_get0_dane_tlsa');
  end;


  if not assigned(SSL_get0_dane) then 
  begin
    {$if declared(SSL_get0_dane_introduced)}
    if LibVersion < SSL_get0_dane_introduced then
      {$if declared(FC_SSL_get0_dane)}
      SSL_get0_dane := @FC_SSL_get0_dane
      {$else}
      SSL_get0_dane := @ERR_SSL_get0_dane
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get0_dane_removed)}
   if SSL_get0_dane_removed <= LibVersion then
     {$if declared(_SSL_get0_dane)}
     SSL_get0_dane := @_SSL_get0_dane
     {$else}
       {$IF declared(ERR_SSL_get0_dane)}
       SSL_get0_dane := @ERR_SSL_get0_dane
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get0_dane) and Assigned(AFailed) then 
     AFailed.Add('SSL_get0_dane');
  end;


  if not assigned(SSL_CTX_dane_set_flags) then 
  begin
    {$if declared(SSL_CTX_dane_set_flags_introduced)}
    if LibVersion < SSL_CTX_dane_set_flags_introduced then
      {$if declared(FC_SSL_CTX_dane_set_flags)}
      SSL_CTX_dane_set_flags := @FC_SSL_CTX_dane_set_flags
      {$else}
      SSL_CTX_dane_set_flags := @ERR_SSL_CTX_dane_set_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_dane_set_flags_removed)}
   if SSL_CTX_dane_set_flags_removed <= LibVersion then
     {$if declared(_SSL_CTX_dane_set_flags)}
     SSL_CTX_dane_set_flags := @_SSL_CTX_dane_set_flags
     {$else}
       {$IF declared(ERR_SSL_CTX_dane_set_flags)}
       SSL_CTX_dane_set_flags := @ERR_SSL_CTX_dane_set_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_dane_set_flags) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_dane_set_flags');
  end;


  if not assigned(SSL_CTX_dane_clear_flags) then 
  begin
    {$if declared(SSL_CTX_dane_clear_flags_introduced)}
    if LibVersion < SSL_CTX_dane_clear_flags_introduced then
      {$if declared(FC_SSL_CTX_dane_clear_flags)}
      SSL_CTX_dane_clear_flags := @FC_SSL_CTX_dane_clear_flags
      {$else}
      SSL_CTX_dane_clear_flags := @ERR_SSL_CTX_dane_clear_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_dane_clear_flags_removed)}
   if SSL_CTX_dane_clear_flags_removed <= LibVersion then
     {$if declared(_SSL_CTX_dane_clear_flags)}
     SSL_CTX_dane_clear_flags := @_SSL_CTX_dane_clear_flags
     {$else}
       {$IF declared(ERR_SSL_CTX_dane_clear_flags)}
       SSL_CTX_dane_clear_flags := @ERR_SSL_CTX_dane_clear_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_dane_clear_flags) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_dane_clear_flags');
  end;


  if not assigned(SSL_dane_set_flags) then 
  begin
    {$if declared(SSL_dane_set_flags_introduced)}
    if LibVersion < SSL_dane_set_flags_introduced then
      {$if declared(FC_SSL_dane_set_flags)}
      SSL_dane_set_flags := @FC_SSL_dane_set_flags
      {$else}
      SSL_dane_set_flags := @ERR_SSL_dane_set_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_dane_set_flags_removed)}
   if SSL_dane_set_flags_removed <= LibVersion then
     {$if declared(_SSL_dane_set_flags)}
     SSL_dane_set_flags := @_SSL_dane_set_flags
     {$else}
       {$IF declared(ERR_SSL_dane_set_flags)}
       SSL_dane_set_flags := @ERR_SSL_dane_set_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_dane_set_flags) and Assigned(AFailed) then 
     AFailed.Add('SSL_dane_set_flags');
  end;


  if not assigned(SSL_dane_clear_flags) then 
  begin
    {$if declared(SSL_dane_clear_flags_introduced)}
    if LibVersion < SSL_dane_clear_flags_introduced then
      {$if declared(FC_SSL_dane_clear_flags)}
      SSL_dane_clear_flags := @FC_SSL_dane_clear_flags
      {$else}
      SSL_dane_clear_flags := @ERR_SSL_dane_clear_flags
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_dane_clear_flags_removed)}
   if SSL_dane_clear_flags_removed <= LibVersion then
     {$if declared(_SSL_dane_clear_flags)}
     SSL_dane_clear_flags := @_SSL_dane_clear_flags
     {$else}
       {$IF declared(ERR_SSL_dane_clear_flags)}
       SSL_dane_clear_flags := @ERR_SSL_dane_clear_flags
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_dane_clear_flags) and Assigned(AFailed) then 
     AFailed.Add('SSL_dane_clear_flags');
  end;


  if not assigned(SSL_CTX_set_client_hello_cb) then 
  begin
    {$if declared(SSL_CTX_set_client_hello_cb_introduced)}
    if LibVersion < SSL_CTX_set_client_hello_cb_introduced then
      {$if declared(FC_SSL_CTX_set_client_hello_cb)}
      SSL_CTX_set_client_hello_cb := @FC_SSL_CTX_set_client_hello_cb
      {$else}
      SSL_CTX_set_client_hello_cb := @ERR_SSL_CTX_set_client_hello_cb
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_client_hello_cb_removed)}
   if SSL_CTX_set_client_hello_cb_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_client_hello_cb)}
     SSL_CTX_set_client_hello_cb := @_SSL_CTX_set_client_hello_cb
     {$else}
       {$IF declared(ERR_SSL_CTX_set_client_hello_cb)}
       SSL_CTX_set_client_hello_cb := @ERR_SSL_CTX_set_client_hello_cb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_client_hello_cb) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_client_hello_cb');
  end;


  if not assigned(SSL_client_hello_isv2) then 
  begin
    {$if declared(SSL_client_hello_isv2_introduced)}
    if LibVersion < SSL_client_hello_isv2_introduced then
      {$if declared(FC_SSL_client_hello_isv2)}
      SSL_client_hello_isv2 := @FC_SSL_client_hello_isv2
      {$else}
      SSL_client_hello_isv2 := @ERR_SSL_client_hello_isv2
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_client_hello_isv2_removed)}
   if SSL_client_hello_isv2_removed <= LibVersion then
     {$if declared(_SSL_client_hello_isv2)}
     SSL_client_hello_isv2 := @_SSL_client_hello_isv2
     {$else}
       {$IF declared(ERR_SSL_client_hello_isv2)}
       SSL_client_hello_isv2 := @ERR_SSL_client_hello_isv2
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_client_hello_isv2) and Assigned(AFailed) then 
     AFailed.Add('SSL_client_hello_isv2');
  end;


  if not assigned(SSL_client_hello_get0_legacy_version) then 
  begin
    {$if declared(SSL_client_hello_get0_legacy_version_introduced)}
    if LibVersion < SSL_client_hello_get0_legacy_version_introduced then
      {$if declared(FC_SSL_client_hello_get0_legacy_version)}
      SSL_client_hello_get0_legacy_version := @FC_SSL_client_hello_get0_legacy_version
      {$else}
      SSL_client_hello_get0_legacy_version := @ERR_SSL_client_hello_get0_legacy_version
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_client_hello_get0_legacy_version_removed)}
   if SSL_client_hello_get0_legacy_version_removed <= LibVersion then
     {$if declared(_SSL_client_hello_get0_legacy_version)}
     SSL_client_hello_get0_legacy_version := @_SSL_client_hello_get0_legacy_version
     {$else}
       {$IF declared(ERR_SSL_client_hello_get0_legacy_version)}
       SSL_client_hello_get0_legacy_version := @ERR_SSL_client_hello_get0_legacy_version
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_client_hello_get0_legacy_version) and Assigned(AFailed) then 
     AFailed.Add('SSL_client_hello_get0_legacy_version');
  end;


  if not assigned(SSL_client_hello_get0_random) then 
  begin
    {$if declared(SSL_client_hello_get0_random_introduced)}
    if LibVersion < SSL_client_hello_get0_random_introduced then
      {$if declared(FC_SSL_client_hello_get0_random)}
      SSL_client_hello_get0_random := @FC_SSL_client_hello_get0_random
      {$else}
      SSL_client_hello_get0_random := @ERR_SSL_client_hello_get0_random
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_client_hello_get0_random_removed)}
   if SSL_client_hello_get0_random_removed <= LibVersion then
     {$if declared(_SSL_client_hello_get0_random)}
     SSL_client_hello_get0_random := @_SSL_client_hello_get0_random
     {$else}
       {$IF declared(ERR_SSL_client_hello_get0_random)}
       SSL_client_hello_get0_random := @ERR_SSL_client_hello_get0_random
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_client_hello_get0_random) and Assigned(AFailed) then 
     AFailed.Add('SSL_client_hello_get0_random');
  end;


  if not assigned(SSL_client_hello_get0_session_id) then 
  begin
    {$if declared(SSL_client_hello_get0_session_id_introduced)}
    if LibVersion < SSL_client_hello_get0_session_id_introduced then
      {$if declared(FC_SSL_client_hello_get0_session_id)}
      SSL_client_hello_get0_session_id := @FC_SSL_client_hello_get0_session_id
      {$else}
      SSL_client_hello_get0_session_id := @ERR_SSL_client_hello_get0_session_id
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_client_hello_get0_session_id_removed)}
   if SSL_client_hello_get0_session_id_removed <= LibVersion then
     {$if declared(_SSL_client_hello_get0_session_id)}
     SSL_client_hello_get0_session_id := @_SSL_client_hello_get0_session_id
     {$else}
       {$IF declared(ERR_SSL_client_hello_get0_session_id)}
       SSL_client_hello_get0_session_id := @ERR_SSL_client_hello_get0_session_id
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_client_hello_get0_session_id) and Assigned(AFailed) then 
     AFailed.Add('SSL_client_hello_get0_session_id');
  end;


  if not assigned(SSL_client_hello_get0_ciphers) then 
  begin
    {$if declared(SSL_client_hello_get0_ciphers_introduced)}
    if LibVersion < SSL_client_hello_get0_ciphers_introduced then
      {$if declared(FC_SSL_client_hello_get0_ciphers)}
      SSL_client_hello_get0_ciphers := @FC_SSL_client_hello_get0_ciphers
      {$else}
      SSL_client_hello_get0_ciphers := @ERR_SSL_client_hello_get0_ciphers
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_client_hello_get0_ciphers_removed)}
   if SSL_client_hello_get0_ciphers_removed <= LibVersion then
     {$if declared(_SSL_client_hello_get0_ciphers)}
     SSL_client_hello_get0_ciphers := @_SSL_client_hello_get0_ciphers
     {$else}
       {$IF declared(ERR_SSL_client_hello_get0_ciphers)}
       SSL_client_hello_get0_ciphers := @ERR_SSL_client_hello_get0_ciphers
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_client_hello_get0_ciphers) and Assigned(AFailed) then 
     AFailed.Add('SSL_client_hello_get0_ciphers');
  end;


  if not assigned(SSL_client_hello_get0_compression_methods) then 
  begin
    {$if declared(SSL_client_hello_get0_compression_methods_introduced)}
    if LibVersion < SSL_client_hello_get0_compression_methods_introduced then
      {$if declared(FC_SSL_client_hello_get0_compression_methods)}
      SSL_client_hello_get0_compression_methods := @FC_SSL_client_hello_get0_compression_methods
      {$else}
      SSL_client_hello_get0_compression_methods := @ERR_SSL_client_hello_get0_compression_methods
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_client_hello_get0_compression_methods_removed)}
   if SSL_client_hello_get0_compression_methods_removed <= LibVersion then
     {$if declared(_SSL_client_hello_get0_compression_methods)}
     SSL_client_hello_get0_compression_methods := @_SSL_client_hello_get0_compression_methods
     {$else}
       {$IF declared(ERR_SSL_client_hello_get0_compression_methods)}
       SSL_client_hello_get0_compression_methods := @ERR_SSL_client_hello_get0_compression_methods
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_client_hello_get0_compression_methods) and Assigned(AFailed) then 
     AFailed.Add('SSL_client_hello_get0_compression_methods');
  end;


  if not assigned(SSL_client_hello_get1_extensions_present) then 
  begin
    {$if declared(SSL_client_hello_get1_extensions_present_introduced)}
    if LibVersion < SSL_client_hello_get1_extensions_present_introduced then
      {$if declared(FC_SSL_client_hello_get1_extensions_present)}
      SSL_client_hello_get1_extensions_present := @FC_SSL_client_hello_get1_extensions_present
      {$else}
      SSL_client_hello_get1_extensions_present := @ERR_SSL_client_hello_get1_extensions_present
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_client_hello_get1_extensions_present_removed)}
   if SSL_client_hello_get1_extensions_present_removed <= LibVersion then
     {$if declared(_SSL_client_hello_get1_extensions_present)}
     SSL_client_hello_get1_extensions_present := @_SSL_client_hello_get1_extensions_present
     {$else}
       {$IF declared(ERR_SSL_client_hello_get1_extensions_present)}
       SSL_client_hello_get1_extensions_present := @ERR_SSL_client_hello_get1_extensions_present
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_client_hello_get1_extensions_present) and Assigned(AFailed) then 
     AFailed.Add('SSL_client_hello_get1_extensions_present');
  end;


  if not assigned(SSL_client_hello_get0_ext) then 
  begin
    {$if declared(SSL_client_hello_get0_ext_introduced)}
    if LibVersion < SSL_client_hello_get0_ext_introduced then
      {$if declared(FC_SSL_client_hello_get0_ext)}
      SSL_client_hello_get0_ext := @FC_SSL_client_hello_get0_ext
      {$else}
      SSL_client_hello_get0_ext := @ERR_SSL_client_hello_get0_ext
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_client_hello_get0_ext_removed)}
   if SSL_client_hello_get0_ext_removed <= LibVersion then
     {$if declared(_SSL_client_hello_get0_ext)}
     SSL_client_hello_get0_ext := @_SSL_client_hello_get0_ext
     {$else}
       {$IF declared(ERR_SSL_client_hello_get0_ext)}
       SSL_client_hello_get0_ext := @ERR_SSL_client_hello_get0_ext
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_client_hello_get0_ext) and Assigned(AFailed) then 
     AFailed.Add('SSL_client_hello_get0_ext');
  end;


  if not assigned(SSL_waiting_for_async) then 
  begin
    {$if declared(SSL_waiting_for_async_introduced)}
    if LibVersion < SSL_waiting_for_async_introduced then
      {$if declared(FC_SSL_waiting_for_async)}
      SSL_waiting_for_async := @FC_SSL_waiting_for_async
      {$else}
      SSL_waiting_for_async := @ERR_SSL_waiting_for_async
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_waiting_for_async_removed)}
   if SSL_waiting_for_async_removed <= LibVersion then
     {$if declared(_SSL_waiting_for_async)}
     SSL_waiting_for_async := @_SSL_waiting_for_async
     {$else}
       {$IF declared(ERR_SSL_waiting_for_async)}
       SSL_waiting_for_async := @ERR_SSL_waiting_for_async
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_waiting_for_async) and Assigned(AFailed) then 
     AFailed.Add('SSL_waiting_for_async');
  end;


  if not assigned(SSL_get_all_async_fds) then 
  begin
    {$if declared(SSL_get_all_async_fds_introduced)}
    if LibVersion < SSL_get_all_async_fds_introduced then
      {$if declared(FC_SSL_get_all_async_fds)}
      SSL_get_all_async_fds := @FC_SSL_get_all_async_fds
      {$else}
      SSL_get_all_async_fds := @ERR_SSL_get_all_async_fds
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_all_async_fds_removed)}
   if SSL_get_all_async_fds_removed <= LibVersion then
     {$if declared(_SSL_get_all_async_fds)}
     SSL_get_all_async_fds := @_SSL_get_all_async_fds
     {$else}
       {$IF declared(ERR_SSL_get_all_async_fds)}
       SSL_get_all_async_fds := @ERR_SSL_get_all_async_fds
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_all_async_fds) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_all_async_fds');
  end;


  if not assigned(SSL_get_changed_async_fds) then 
  begin
    {$if declared(SSL_get_changed_async_fds_introduced)}
    if LibVersion < SSL_get_changed_async_fds_introduced then
      {$if declared(FC_SSL_get_changed_async_fds)}
      SSL_get_changed_async_fds := @FC_SSL_get_changed_async_fds
      {$else}
      SSL_get_changed_async_fds := @ERR_SSL_get_changed_async_fds
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_changed_async_fds_removed)}
   if SSL_get_changed_async_fds_removed <= LibVersion then
     {$if declared(_SSL_get_changed_async_fds)}
     SSL_get_changed_async_fds := @_SSL_get_changed_async_fds
     {$else}
       {$IF declared(ERR_SSL_get_changed_async_fds)}
       SSL_get_changed_async_fds := @ERR_SSL_get_changed_async_fds
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_changed_async_fds) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_changed_async_fds');
  end;


  if not assigned(SSL_stateless) then 
  begin
    {$if declared(SSL_stateless_introduced)}
    if LibVersion < SSL_stateless_introduced then
      {$if declared(FC_SSL_stateless)}
      SSL_stateless := @FC_SSL_stateless
      {$else}
      SSL_stateless := @ERR_SSL_stateless
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_stateless_removed)}
   if SSL_stateless_removed <= LibVersion then
     {$if declared(_SSL_stateless)}
     SSL_stateless := @_SSL_stateless
     {$else}
       {$IF declared(ERR_SSL_stateless)}
       SSL_stateless := @ERR_SSL_stateless
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_stateless) and Assigned(AFailed) then 
     AFailed.Add('SSL_stateless');
  end;


  if not assigned(SSL_read_ex) then 
  begin
    {$if declared(SSL_read_ex_introduced)}
    if LibVersion < SSL_read_ex_introduced then
      {$if declared(FC_SSL_read_ex)}
      SSL_read_ex := @FC_SSL_read_ex
      {$else}
      SSL_read_ex := @ERR_SSL_read_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_read_ex_removed)}
   if SSL_read_ex_removed <= LibVersion then
     {$if declared(_SSL_read_ex)}
     SSL_read_ex := @_SSL_read_ex
     {$else}
       {$IF declared(ERR_SSL_read_ex)}
       SSL_read_ex := @ERR_SSL_read_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_read_ex) and Assigned(AFailed) then 
     AFailed.Add('SSL_read_ex');
  end;


  if not assigned(SSL_read_early_data) then 
  begin
    {$if declared(SSL_read_early_data_introduced)}
    if LibVersion < SSL_read_early_data_introduced then
      {$if declared(FC_SSL_read_early_data)}
      SSL_read_early_data := @FC_SSL_read_early_data
      {$else}
      SSL_read_early_data := @ERR_SSL_read_early_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_read_early_data_removed)}
   if SSL_read_early_data_removed <= LibVersion then
     {$if declared(_SSL_read_early_data)}
     SSL_read_early_data := @_SSL_read_early_data
     {$else}
       {$IF declared(ERR_SSL_read_early_data)}
       SSL_read_early_data := @ERR_SSL_read_early_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_read_early_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_read_early_data');
  end;


  if not assigned(SSL_peek_ex) then 
  begin
    {$if declared(SSL_peek_ex_introduced)}
    if LibVersion < SSL_peek_ex_introduced then
      {$if declared(FC_SSL_peek_ex)}
      SSL_peek_ex := @FC_SSL_peek_ex
      {$else}
      SSL_peek_ex := @ERR_SSL_peek_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_peek_ex_removed)}
   if SSL_peek_ex_removed <= LibVersion then
     {$if declared(_SSL_peek_ex)}
     SSL_peek_ex := @_SSL_peek_ex
     {$else}
       {$IF declared(ERR_SSL_peek_ex)}
       SSL_peek_ex := @ERR_SSL_peek_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_peek_ex) and Assigned(AFailed) then 
     AFailed.Add('SSL_peek_ex');
  end;


  if not assigned(SSL_write_ex) then 
  begin
    {$if declared(SSL_write_ex_introduced)}
    if LibVersion < SSL_write_ex_introduced then
      {$if declared(FC_SSL_write_ex)}
      SSL_write_ex := @FC_SSL_write_ex
      {$else}
      SSL_write_ex := @ERR_SSL_write_ex
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_write_ex_removed)}
   if SSL_write_ex_removed <= LibVersion then
     {$if declared(_SSL_write_ex)}
     SSL_write_ex := @_SSL_write_ex
     {$else}
       {$IF declared(ERR_SSL_write_ex)}
       SSL_write_ex := @ERR_SSL_write_ex
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_write_ex) and Assigned(AFailed) then 
     AFailed.Add('SSL_write_ex');
  end;


  if not assigned(SSL_write_early_data) then 
  begin
    {$if declared(SSL_write_early_data_introduced)}
    if LibVersion < SSL_write_early_data_introduced then
      {$if declared(FC_SSL_write_early_data)}
      SSL_write_early_data := @FC_SSL_write_early_data
      {$else}
      SSL_write_early_data := @ERR_SSL_write_early_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_write_early_data_removed)}
   if SSL_write_early_data_removed <= LibVersion then
     {$if declared(_SSL_write_early_data)}
     SSL_write_early_data := @_SSL_write_early_data
     {$else}
       {$IF declared(ERR_SSL_write_early_data)}
       SSL_write_early_data := @ERR_SSL_write_early_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_write_early_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_write_early_data');
  end;


  if not assigned(SSL_get_early_data_status) then 
  begin
    {$if declared(SSL_get_early_data_status_introduced)}
    if LibVersion < SSL_get_early_data_status_introduced then
      {$if declared(FC_SSL_get_early_data_status)}
      SSL_get_early_data_status := @FC_SSL_get_early_data_status
      {$else}
      SSL_get_early_data_status := @ERR_SSL_get_early_data_status
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_early_data_status_removed)}
   if SSL_get_early_data_status_removed <= LibVersion then
     {$if declared(_SSL_get_early_data_status)}
     SSL_get_early_data_status := @_SSL_get_early_data_status
     {$else}
       {$IF declared(ERR_SSL_get_early_data_status)}
       SSL_get_early_data_status := @ERR_SSL_get_early_data_status
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_early_data_status) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_early_data_status');
  end;


  if not assigned(TLS_method) then 
  begin
    {$if declared(TLS_method_introduced)}
    if LibVersion < TLS_method_introduced then
      {$if declared(FC_TLS_method)}
      TLS_method := @FC_TLS_method
      {$else}
      TLS_method := @ERR_TLS_method
      {$ifend}
    else
    {$ifend}
   {$if declared(TLS_method_removed)}
   if TLS_method_removed <= LibVersion then
     {$if declared(_TLS_method)}
     TLS_method := @_TLS_method
     {$else}
       {$IF declared(ERR_TLS_method)}
       TLS_method := @ERR_TLS_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(TLS_method) and Assigned(AFailed) then 
     AFailed.Add('TLS_method');
  end;


  if not assigned(TLS_server_method) then 
  begin
    {$if declared(TLS_server_method_introduced)}
    if LibVersion < TLS_server_method_introduced then
      {$if declared(FC_TLS_server_method)}
      TLS_server_method := @FC_TLS_server_method
      {$else}
      TLS_server_method := @ERR_TLS_server_method
      {$ifend}
    else
    {$ifend}
   {$if declared(TLS_server_method_removed)}
   if TLS_server_method_removed <= LibVersion then
     {$if declared(_TLS_server_method)}
     TLS_server_method := @_TLS_server_method
     {$else}
       {$IF declared(ERR_TLS_server_method)}
       TLS_server_method := @ERR_TLS_server_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(TLS_server_method) and Assigned(AFailed) then 
     AFailed.Add('TLS_server_method');
  end;


  if not assigned(TLS_client_method) then 
  begin
    {$if declared(TLS_client_method_introduced)}
    if LibVersion < TLS_client_method_introduced then
      {$if declared(FC_TLS_client_method)}
      TLS_client_method := @FC_TLS_client_method
      {$else}
      TLS_client_method := @ERR_TLS_client_method
      {$ifend}
    else
    {$ifend}
   {$if declared(TLS_client_method_removed)}
   if TLS_client_method_removed <= LibVersion then
     {$if declared(_TLS_client_method)}
     TLS_client_method := @_TLS_client_method
     {$else}
       {$IF declared(ERR_TLS_client_method)}
       TLS_client_method := @ERR_TLS_client_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(TLS_client_method) and Assigned(AFailed) then 
     AFailed.Add('TLS_client_method');
  end;


  if not assigned(SSL_key_update) then 
  begin
    {$if declared(SSL_key_update_introduced)}
    if LibVersion < SSL_key_update_introduced then
      {$if declared(FC_SSL_key_update)}
      SSL_key_update := @FC_SSL_key_update
      {$else}
      SSL_key_update := @ERR_SSL_key_update
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_key_update_removed)}
   if SSL_key_update_removed <= LibVersion then
     {$if declared(_SSL_key_update)}
     SSL_key_update := @_SSL_key_update
     {$else}
       {$IF declared(ERR_SSL_key_update)}
       SSL_key_update := @ERR_SSL_key_update
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_key_update) and Assigned(AFailed) then 
     AFailed.Add('SSL_key_update');
  end;


  if not assigned(SSL_get_key_update_type) then 
  begin
    {$if declared(SSL_get_key_update_type_introduced)}
    if LibVersion < SSL_get_key_update_type_introduced then
      {$if declared(FC_SSL_get_key_update_type)}
      SSL_get_key_update_type := @FC_SSL_get_key_update_type
      {$else}
      SSL_get_key_update_type := @ERR_SSL_get_key_update_type
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_key_update_type_removed)}
   if SSL_get_key_update_type_removed <= LibVersion then
     {$if declared(_SSL_get_key_update_type)}
     SSL_get_key_update_type := @_SSL_get_key_update_type
     {$else}
       {$IF declared(ERR_SSL_get_key_update_type)}
       SSL_get_key_update_type := @ERR_SSL_get_key_update_type
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_key_update_type) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_key_update_type');
  end;


  if not assigned(SSL_CTX_set_post_handshake_auth) then 
  begin
    {$if declared(SSL_CTX_set_post_handshake_auth_introduced)}
    if LibVersion < SSL_CTX_set_post_handshake_auth_introduced then
      {$if declared(FC_SSL_CTX_set_post_handshake_auth)}
      SSL_CTX_set_post_handshake_auth := @FC_SSL_CTX_set_post_handshake_auth
      {$else}
      SSL_CTX_set_post_handshake_auth := @ERR_SSL_CTX_set_post_handshake_auth
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_post_handshake_auth_removed)}
   if SSL_CTX_set_post_handshake_auth_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_post_handshake_auth)}
     SSL_CTX_set_post_handshake_auth := @_SSL_CTX_set_post_handshake_auth
     {$else}
       {$IF declared(ERR_SSL_CTX_set_post_handshake_auth)}
       SSL_CTX_set_post_handshake_auth := @ERR_SSL_CTX_set_post_handshake_auth
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_post_handshake_auth) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_post_handshake_auth');
  end;


  if not assigned(SSL_set_post_handshake_auth) then 
  begin
    {$if declared(SSL_set_post_handshake_auth_introduced)}
    if LibVersion < SSL_set_post_handshake_auth_introduced then
      {$if declared(FC_SSL_set_post_handshake_auth)}
      SSL_set_post_handshake_auth := @FC_SSL_set_post_handshake_auth
      {$else}
      SSL_set_post_handshake_auth := @ERR_SSL_set_post_handshake_auth
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_post_handshake_auth_removed)}
   if SSL_set_post_handshake_auth_removed <= LibVersion then
     {$if declared(_SSL_set_post_handshake_auth)}
     SSL_set_post_handshake_auth := @_SSL_set_post_handshake_auth
     {$else}
       {$IF declared(ERR_SSL_set_post_handshake_auth)}
       SSL_set_post_handshake_auth := @ERR_SSL_set_post_handshake_auth
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_post_handshake_auth) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_post_handshake_auth');
  end;


  if not assigned(SSL_verify_client_post_handshake) then 
  begin
    {$if declared(SSL_verify_client_post_handshake_introduced)}
    if LibVersion < SSL_verify_client_post_handshake_introduced then
      {$if declared(FC_SSL_verify_client_post_handshake)}
      SSL_verify_client_post_handshake := @FC_SSL_verify_client_post_handshake
      {$else}
      SSL_verify_client_post_handshake := @ERR_SSL_verify_client_post_handshake
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_verify_client_post_handshake_removed)}
   if SSL_verify_client_post_handshake_removed <= LibVersion then
     {$if declared(_SSL_verify_client_post_handshake)}
     SSL_verify_client_post_handshake := @_SSL_verify_client_post_handshake
     {$else}
       {$IF declared(ERR_SSL_verify_client_post_handshake)}
       SSL_verify_client_post_handshake := @ERR_SSL_verify_client_post_handshake
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_verify_client_post_handshake) and Assigned(AFailed) then 
     AFailed.Add('SSL_verify_client_post_handshake');
  end;


  if not assigned(SSL_library_init) then 
  begin
    {$if declared(SSL_library_init_introduced)}
    if LibVersion < SSL_library_init_introduced then
      {$if declared(FC_SSL_library_init)}
      SSL_library_init := @FC_SSL_library_init
      {$else}
      SSL_library_init := @ERR_SSL_library_init
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_library_init_removed)}
   if SSL_library_init_removed <= LibVersion then
     {$if declared(_SSL_library_init)}
     SSL_library_init := @_SSL_library_init
     {$else}
       {$IF declared(ERR_SSL_library_init)}
       SSL_library_init := @ERR_SSL_library_init
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_library_init) and Assigned(AFailed) then 
     AFailed.Add('SSL_library_init');
  end;


  if not assigned(SSL_client_version) then 
  begin
    {$if declared(SSL_client_version_introduced)}
    if LibVersion < SSL_client_version_introduced then
      {$if declared(FC_SSL_client_version)}
      SSL_client_version := @FC_SSL_client_version
      {$else}
      SSL_client_version := @ERR_SSL_client_version
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_client_version_removed)}
   if SSL_client_version_removed <= LibVersion then
     {$if declared(_SSL_client_version)}
     SSL_client_version := @_SSL_client_version
     {$else}
       {$IF declared(ERR_SSL_client_version)}
       SSL_client_version := @ERR_SSL_client_version
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_client_version) and Assigned(AFailed) then 
     AFailed.Add('SSL_client_version');
  end;


  if not assigned(SSL_CTX_set_default_verify_dir) then 
  begin
    {$if declared(SSL_CTX_set_default_verify_dir_introduced)}
    if LibVersion < SSL_CTX_set_default_verify_dir_introduced then
      {$if declared(FC_SSL_CTX_set_default_verify_dir)}
      SSL_CTX_set_default_verify_dir := @FC_SSL_CTX_set_default_verify_dir
      {$else}
      SSL_CTX_set_default_verify_dir := @ERR_SSL_CTX_set_default_verify_dir
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_default_verify_dir_removed)}
   if SSL_CTX_set_default_verify_dir_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_default_verify_dir)}
     SSL_CTX_set_default_verify_dir := @_SSL_CTX_set_default_verify_dir
     {$else}
       {$IF declared(ERR_SSL_CTX_set_default_verify_dir)}
       SSL_CTX_set_default_verify_dir := @ERR_SSL_CTX_set_default_verify_dir
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_default_verify_dir) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_default_verify_dir');
  end;


  if not assigned(SSL_CTX_set_default_verify_file) then 
  begin
    {$if declared(SSL_CTX_set_default_verify_file_introduced)}
    if LibVersion < SSL_CTX_set_default_verify_file_introduced then
      {$if declared(FC_SSL_CTX_set_default_verify_file)}
      SSL_CTX_set_default_verify_file := @FC_SSL_CTX_set_default_verify_file
      {$else}
      SSL_CTX_set_default_verify_file := @ERR_SSL_CTX_set_default_verify_file
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_default_verify_file_removed)}
   if SSL_CTX_set_default_verify_file_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_default_verify_file)}
     SSL_CTX_set_default_verify_file := @_SSL_CTX_set_default_verify_file
     {$else}
       {$IF declared(ERR_SSL_CTX_set_default_verify_file)}
       SSL_CTX_set_default_verify_file := @ERR_SSL_CTX_set_default_verify_file
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_default_verify_file) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_default_verify_file');
  end;


  if not assigned(SSL_get_state) then 
  begin
    {$if declared(SSL_get_state_introduced)}
    if LibVersion < SSL_get_state_introduced then
      {$if declared(FC_SSL_get_state)}
      SSL_get_state := @FC_SSL_get_state
      {$else}
      SSL_get_state := @ERR_SSL_get_state
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_state_removed)}
   if SSL_get_state_removed <= LibVersion then
     {$if declared(_SSL_get_state)}
     SSL_get_state := @_SSL_get_state
     {$else}
       {$IF declared(ERR_SSL_get_state)}
       SSL_get_state := @ERR_SSL_get_state
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_state) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_state');
  end;


  if not assigned(SSL_get_client_random) then 
  begin
    {$if declared(SSL_get_client_random_introduced)}
    if LibVersion < SSL_get_client_random_introduced then
      {$if declared(FC_SSL_get_client_random)}
      SSL_get_client_random := @FC_SSL_get_client_random
      {$else}
      SSL_get_client_random := @ERR_SSL_get_client_random
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_client_random_removed)}
   if SSL_get_client_random_removed <= LibVersion then
     {$if declared(_SSL_get_client_random)}
     SSL_get_client_random := @_SSL_get_client_random
     {$else}
       {$IF declared(ERR_SSL_get_client_random)}
       SSL_get_client_random := @ERR_SSL_get_client_random
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_client_random) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_client_random');
  end;


  if not assigned(SSL_get_server_random) then 
  begin
    {$if declared(SSL_get_server_random_introduced)}
    if LibVersion < SSL_get_server_random_introduced then
      {$if declared(FC_SSL_get_server_random)}
      SSL_get_server_random := @FC_SSL_get_server_random
      {$else}
      SSL_get_server_random := @ERR_SSL_get_server_random
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_server_random_removed)}
   if SSL_get_server_random_removed <= LibVersion then
     {$if declared(_SSL_get_server_random)}
     SSL_get_server_random := @_SSL_get_server_random
     {$else}
       {$IF declared(ERR_SSL_get_server_random)}
       SSL_get_server_random := @ERR_SSL_get_server_random
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_server_random) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_server_random');
  end;


  if not assigned(SSL_SESSION_get_master_key) then 
  begin
    {$if declared(SSL_SESSION_get_master_key_introduced)}
    if LibVersion < SSL_SESSION_get_master_key_introduced then
      {$if declared(FC_SSL_SESSION_get_master_key)}
      SSL_SESSION_get_master_key := @FC_SSL_SESSION_get_master_key
      {$else}
      SSL_SESSION_get_master_key := @ERR_SSL_SESSION_get_master_key
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_get_master_key_removed)}
   if SSL_SESSION_get_master_key_removed <= LibVersion then
     {$if declared(_SSL_SESSION_get_master_key)}
     SSL_SESSION_get_master_key := @_SSL_SESSION_get_master_key
     {$else}
       {$IF declared(ERR_SSL_SESSION_get_master_key)}
       SSL_SESSION_get_master_key := @ERR_SSL_SESSION_get_master_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_get_master_key) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_get_master_key');
  end;


  if not assigned(SSL_SESSION_set1_master_key) then 
  begin
    {$if declared(SSL_SESSION_set1_master_key_introduced)}
    if LibVersion < SSL_SESSION_set1_master_key_introduced then
      {$if declared(FC_SSL_SESSION_set1_master_key)}
      SSL_SESSION_set1_master_key := @FC_SSL_SESSION_set1_master_key
      {$else}
      SSL_SESSION_set1_master_key := @ERR_SSL_SESSION_set1_master_key
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_set1_master_key_removed)}
   if SSL_SESSION_set1_master_key_removed <= LibVersion then
     {$if declared(_SSL_SESSION_set1_master_key)}
     SSL_SESSION_set1_master_key := @_SSL_SESSION_set1_master_key
     {$else}
       {$IF declared(ERR_SSL_SESSION_set1_master_key)}
       SSL_SESSION_set1_master_key := @ERR_SSL_SESSION_set1_master_key
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_set1_master_key) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_set1_master_key');
  end;


  if not assigned(SSL_SESSION_get_max_fragment_length) then 
  begin
    {$if declared(SSL_SESSION_get_max_fragment_length_introduced)}
    if LibVersion < SSL_SESSION_get_max_fragment_length_introduced then
      {$if declared(FC_SSL_SESSION_get_max_fragment_length)}
      SSL_SESSION_get_max_fragment_length := @FC_SSL_SESSION_get_max_fragment_length
      {$else}
      SSL_SESSION_get_max_fragment_length := @ERR_SSL_SESSION_get_max_fragment_length
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_get_max_fragment_length_removed)}
   if SSL_SESSION_get_max_fragment_length_removed <= LibVersion then
     {$if declared(_SSL_SESSION_get_max_fragment_length)}
     SSL_SESSION_get_max_fragment_length := @_SSL_SESSION_get_max_fragment_length
     {$else}
       {$IF declared(ERR_SSL_SESSION_get_max_fragment_length)}
       SSL_SESSION_get_max_fragment_length := @ERR_SSL_SESSION_get_max_fragment_length
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_get_max_fragment_length) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_get_max_fragment_length');
  end;


  if not assigned(SSL_CTX_set_default_read_buffer_len) then 
  begin
    {$if declared(SSL_CTX_set_default_read_buffer_len_introduced)}
    if LibVersion < SSL_CTX_set_default_read_buffer_len_introduced then
      {$if declared(FC_SSL_CTX_set_default_read_buffer_len)}
      SSL_CTX_set_default_read_buffer_len := @FC_SSL_CTX_set_default_read_buffer_len
      {$else}
      SSL_CTX_set_default_read_buffer_len := @ERR_SSL_CTX_set_default_read_buffer_len
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_default_read_buffer_len_removed)}
   if SSL_CTX_set_default_read_buffer_len_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_default_read_buffer_len)}
     SSL_CTX_set_default_read_buffer_len := @_SSL_CTX_set_default_read_buffer_len
     {$else}
       {$IF declared(ERR_SSL_CTX_set_default_read_buffer_len)}
       SSL_CTX_set_default_read_buffer_len := @ERR_SSL_CTX_set_default_read_buffer_len
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_default_read_buffer_len) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_default_read_buffer_len');
  end;


  if not assigned(SSL_set_default_read_buffer_len) then 
  begin
    {$if declared(SSL_set_default_read_buffer_len_introduced)}
    if LibVersion < SSL_set_default_read_buffer_len_introduced then
      {$if declared(FC_SSL_set_default_read_buffer_len)}
      SSL_set_default_read_buffer_len := @FC_SSL_set_default_read_buffer_len
      {$else}
      SSL_set_default_read_buffer_len := @ERR_SSL_set_default_read_buffer_len
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_default_read_buffer_len_removed)}
   if SSL_set_default_read_buffer_len_removed <= LibVersion then
     {$if declared(_SSL_set_default_read_buffer_len)}
     SSL_set_default_read_buffer_len := @_SSL_set_default_read_buffer_len
     {$else}
       {$IF declared(ERR_SSL_set_default_read_buffer_len)}
       SSL_set_default_read_buffer_len := @ERR_SSL_set_default_read_buffer_len
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_default_read_buffer_len) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_default_read_buffer_len');
  end;


  if not assigned(SSL_CIPHER_get_cipher_nid) then 
  begin
    {$if declared(SSL_CIPHER_get_cipher_nid_introduced)}
    if LibVersion < SSL_CIPHER_get_cipher_nid_introduced then
      {$if declared(FC_SSL_CIPHER_get_cipher_nid)}
      SSL_CIPHER_get_cipher_nid := @FC_SSL_CIPHER_get_cipher_nid
      {$else}
      SSL_CIPHER_get_cipher_nid := @ERR_SSL_CIPHER_get_cipher_nid
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CIPHER_get_cipher_nid_removed)}
   if SSL_CIPHER_get_cipher_nid_removed <= LibVersion then
     {$if declared(_SSL_CIPHER_get_cipher_nid)}
     SSL_CIPHER_get_cipher_nid := @_SSL_CIPHER_get_cipher_nid
     {$else}
       {$IF declared(ERR_SSL_CIPHER_get_cipher_nid)}
       SSL_CIPHER_get_cipher_nid := @ERR_SSL_CIPHER_get_cipher_nid
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CIPHER_get_cipher_nid) and Assigned(AFailed) then 
     AFailed.Add('SSL_CIPHER_get_cipher_nid');
  end;


  if not assigned(SSL_CIPHER_get_digest_nid) then 
  begin
    {$if declared(SSL_CIPHER_get_digest_nid_introduced)}
    if LibVersion < SSL_CIPHER_get_digest_nid_introduced then
      {$if declared(FC_SSL_CIPHER_get_digest_nid)}
      SSL_CIPHER_get_digest_nid := @FC_SSL_CIPHER_get_digest_nid
      {$else}
      SSL_CIPHER_get_digest_nid := @ERR_SSL_CIPHER_get_digest_nid
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CIPHER_get_digest_nid_removed)}
   if SSL_CIPHER_get_digest_nid_removed <= LibVersion then
     {$if declared(_SSL_CIPHER_get_digest_nid)}
     SSL_CIPHER_get_digest_nid := @_SSL_CIPHER_get_digest_nid
     {$else}
       {$IF declared(ERR_SSL_CIPHER_get_digest_nid)}
       SSL_CIPHER_get_digest_nid := @ERR_SSL_CIPHER_get_digest_nid
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CIPHER_get_digest_nid) and Assigned(AFailed) then 
     AFailed.Add('SSL_CIPHER_get_digest_nid');
  end;


  if not assigned(SSL_CTX_set_not_resumable_session_callback) then 
  begin
    {$if declared(SSL_CTX_set_not_resumable_session_callback_introduced)}
    if LibVersion < SSL_CTX_set_not_resumable_session_callback_introduced then
      {$if declared(FC_SSL_CTX_set_not_resumable_session_callback)}
      SSL_CTX_set_not_resumable_session_callback := @FC_SSL_CTX_set_not_resumable_session_callback
      {$else}
      SSL_CTX_set_not_resumable_session_callback := @ERR_SSL_CTX_set_not_resumable_session_callback
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_not_resumable_session_callback_removed)}
   if SSL_CTX_set_not_resumable_session_callback_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_not_resumable_session_callback)}
     SSL_CTX_set_not_resumable_session_callback := @_SSL_CTX_set_not_resumable_session_callback
     {$else}
       {$IF declared(ERR_SSL_CTX_set_not_resumable_session_callback)}
       SSL_CTX_set_not_resumable_session_callback := @ERR_SSL_CTX_set_not_resumable_session_callback
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_not_resumable_session_callback) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_not_resumable_session_callback');
  end;


  if not assigned(SSL_set_not_resumable_session_callback) then 
  begin
    {$if declared(SSL_set_not_resumable_session_callback_introduced)}
    if LibVersion < SSL_set_not_resumable_session_callback_introduced then
      {$if declared(FC_SSL_set_not_resumable_session_callback)}
      SSL_set_not_resumable_session_callback := @FC_SSL_set_not_resumable_session_callback
      {$else}
      SSL_set_not_resumable_session_callback := @ERR_SSL_set_not_resumable_session_callback
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_not_resumable_session_callback_removed)}
   if SSL_set_not_resumable_session_callback_removed <= LibVersion then
     {$if declared(_SSL_set_not_resumable_session_callback)}
     SSL_set_not_resumable_session_callback := @_SSL_set_not_resumable_session_callback
     {$else}
       {$IF declared(ERR_SSL_set_not_resumable_session_callback)}
       SSL_set_not_resumable_session_callback := @ERR_SSL_set_not_resumable_session_callback
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_not_resumable_session_callback) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_not_resumable_session_callback');
  end;


  if not assigned(SSL_CTX_set_record_padding_callback) then 
  begin
    {$if declared(SSL_CTX_set_record_padding_callback_introduced)}
    if LibVersion < SSL_CTX_set_record_padding_callback_introduced then
      {$if declared(FC_SSL_CTX_set_record_padding_callback)}
      SSL_CTX_set_record_padding_callback := @FC_SSL_CTX_set_record_padding_callback
      {$else}
      SSL_CTX_set_record_padding_callback := @ERR_SSL_CTX_set_record_padding_callback
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_record_padding_callback_removed)}
   if SSL_CTX_set_record_padding_callback_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_record_padding_callback)}
     SSL_CTX_set_record_padding_callback := @_SSL_CTX_set_record_padding_callback
     {$else}
       {$IF declared(ERR_SSL_CTX_set_record_padding_callback)}
       SSL_CTX_set_record_padding_callback := @ERR_SSL_CTX_set_record_padding_callback
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_record_padding_callback) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_record_padding_callback');
  end;


  if not assigned(SSL_CTX_set_record_padding_callback_arg) then 
  begin
    {$if declared(SSL_CTX_set_record_padding_callback_arg_introduced)}
    if LibVersion < SSL_CTX_set_record_padding_callback_arg_introduced then
      {$if declared(FC_SSL_CTX_set_record_padding_callback_arg)}
      SSL_CTX_set_record_padding_callback_arg := @FC_SSL_CTX_set_record_padding_callback_arg
      {$else}
      SSL_CTX_set_record_padding_callback_arg := @ERR_SSL_CTX_set_record_padding_callback_arg
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_record_padding_callback_arg_removed)}
   if SSL_CTX_set_record_padding_callback_arg_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_record_padding_callback_arg)}
     SSL_CTX_set_record_padding_callback_arg := @_SSL_CTX_set_record_padding_callback_arg
     {$else}
       {$IF declared(ERR_SSL_CTX_set_record_padding_callback_arg)}
       SSL_CTX_set_record_padding_callback_arg := @ERR_SSL_CTX_set_record_padding_callback_arg
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_record_padding_callback_arg) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_record_padding_callback_arg');
  end;


  if not assigned(SSL_CTX_get_record_padding_callback_arg) then 
  begin
    {$if declared(SSL_CTX_get_record_padding_callback_arg_introduced)}
    if LibVersion < SSL_CTX_get_record_padding_callback_arg_introduced then
      {$if declared(FC_SSL_CTX_get_record_padding_callback_arg)}
      SSL_CTX_get_record_padding_callback_arg := @FC_SSL_CTX_get_record_padding_callback_arg
      {$else}
      SSL_CTX_get_record_padding_callback_arg := @ERR_SSL_CTX_get_record_padding_callback_arg
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get_record_padding_callback_arg_removed)}
   if SSL_CTX_get_record_padding_callback_arg_removed <= LibVersion then
     {$if declared(_SSL_CTX_get_record_padding_callback_arg)}
     SSL_CTX_get_record_padding_callback_arg := @_SSL_CTX_get_record_padding_callback_arg
     {$else}
       {$IF declared(ERR_SSL_CTX_get_record_padding_callback_arg)}
       SSL_CTX_get_record_padding_callback_arg := @ERR_SSL_CTX_get_record_padding_callback_arg
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get_record_padding_callback_arg) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get_record_padding_callback_arg');
  end;


  if not assigned(SSL_CTX_set_block_padding) then 
  begin
    {$if declared(SSL_CTX_set_block_padding_introduced)}
    if LibVersion < SSL_CTX_set_block_padding_introduced then
      {$if declared(FC_SSL_CTX_set_block_padding)}
      SSL_CTX_set_block_padding := @FC_SSL_CTX_set_block_padding
      {$else}
      SSL_CTX_set_block_padding := @ERR_SSL_CTX_set_block_padding
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_block_padding_removed)}
   if SSL_CTX_set_block_padding_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_block_padding)}
     SSL_CTX_set_block_padding := @_SSL_CTX_set_block_padding
     {$else}
       {$IF declared(ERR_SSL_CTX_set_block_padding)}
       SSL_CTX_set_block_padding := @ERR_SSL_CTX_set_block_padding
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_block_padding) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_block_padding');
  end;


  if not assigned(SSL_set_record_padding_callback) then 
  begin
    {$if declared(SSL_set_record_padding_callback_introduced)}
    if LibVersion < SSL_set_record_padding_callback_introduced then
      {$if declared(FC_SSL_set_record_padding_callback)}
      SSL_set_record_padding_callback := @FC_SSL_set_record_padding_callback
      {$else}
      SSL_set_record_padding_callback := @ERR_SSL_set_record_padding_callback
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_record_padding_callback_removed)}
   if SSL_set_record_padding_callback_removed <= LibVersion then
     {$if declared(_SSL_set_record_padding_callback)}
     SSL_set_record_padding_callback := @_SSL_set_record_padding_callback
     {$else}
       {$IF declared(ERR_SSL_set_record_padding_callback)}
       SSL_set_record_padding_callback := @ERR_SSL_set_record_padding_callback
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_record_padding_callback) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_record_padding_callback');
  end;


  if not assigned(SSL_set_record_padding_callback_arg) then 
  begin
    {$if declared(SSL_set_record_padding_callback_arg_introduced)}
    if LibVersion < SSL_set_record_padding_callback_arg_introduced then
      {$if declared(FC_SSL_set_record_padding_callback_arg)}
      SSL_set_record_padding_callback_arg := @FC_SSL_set_record_padding_callback_arg
      {$else}
      SSL_set_record_padding_callback_arg := @ERR_SSL_set_record_padding_callback_arg
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_record_padding_callback_arg_removed)}
   if SSL_set_record_padding_callback_arg_removed <= LibVersion then
     {$if declared(_SSL_set_record_padding_callback_arg)}
     SSL_set_record_padding_callback_arg := @_SSL_set_record_padding_callback_arg
     {$else}
       {$IF declared(ERR_SSL_set_record_padding_callback_arg)}
       SSL_set_record_padding_callback_arg := @ERR_SSL_set_record_padding_callback_arg
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_record_padding_callback_arg) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_record_padding_callback_arg');
  end;


  if not assigned(SSL_get_record_padding_callback_arg) then 
  begin
    {$if declared(SSL_get_record_padding_callback_arg_introduced)}
    if LibVersion < SSL_get_record_padding_callback_arg_introduced then
      {$if declared(FC_SSL_get_record_padding_callback_arg)}
      SSL_get_record_padding_callback_arg := @FC_SSL_get_record_padding_callback_arg
      {$else}
      SSL_get_record_padding_callback_arg := @ERR_SSL_get_record_padding_callback_arg
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_record_padding_callback_arg_removed)}
   if SSL_get_record_padding_callback_arg_removed <= LibVersion then
     {$if declared(_SSL_get_record_padding_callback_arg)}
     SSL_get_record_padding_callback_arg := @_SSL_get_record_padding_callback_arg
     {$else}
       {$IF declared(ERR_SSL_get_record_padding_callback_arg)}
       SSL_get_record_padding_callback_arg := @ERR_SSL_get_record_padding_callback_arg
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_record_padding_callback_arg) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_record_padding_callback_arg');
  end;


  if not assigned(SSL_set_block_padding) then 
  begin
    {$if declared(SSL_set_block_padding_introduced)}
    if LibVersion < SSL_set_block_padding_introduced then
      {$if declared(FC_SSL_set_block_padding)}
      SSL_set_block_padding := @FC_SSL_set_block_padding
      {$else}
      SSL_set_block_padding := @ERR_SSL_set_block_padding
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_block_padding_removed)}
   if SSL_set_block_padding_removed <= LibVersion then
     {$if declared(_SSL_set_block_padding)}
     SSL_set_block_padding := @_SSL_set_block_padding
     {$else}
       {$IF declared(ERR_SSL_set_block_padding)}
       SSL_set_block_padding := @ERR_SSL_set_block_padding
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_block_padding) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_block_padding');
  end;


  if not assigned(SSL_set_num_tickets) then 
  begin
    {$if declared(SSL_set_num_tickets_introduced)}
    if LibVersion < SSL_set_num_tickets_introduced then
      {$if declared(FC_SSL_set_num_tickets)}
      SSL_set_num_tickets := @FC_SSL_set_num_tickets
      {$else}
      SSL_set_num_tickets := @ERR_SSL_set_num_tickets
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_num_tickets_removed)}
   if SSL_set_num_tickets_removed <= LibVersion then
     {$if declared(_SSL_set_num_tickets)}
     SSL_set_num_tickets := @_SSL_set_num_tickets
     {$else}
       {$IF declared(ERR_SSL_set_num_tickets)}
       SSL_set_num_tickets := @ERR_SSL_set_num_tickets
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_num_tickets) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_num_tickets');
  end;


  if not assigned(SSL_get_num_tickets) then 
  begin
    {$if declared(SSL_get_num_tickets_introduced)}
    if LibVersion < SSL_get_num_tickets_introduced then
      {$if declared(FC_SSL_get_num_tickets)}
      SSL_get_num_tickets := @FC_SSL_get_num_tickets
      {$else}
      SSL_get_num_tickets := @ERR_SSL_get_num_tickets
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_num_tickets_removed)}
   if SSL_get_num_tickets_removed <= LibVersion then
     {$if declared(_SSL_get_num_tickets)}
     SSL_get_num_tickets := @_SSL_get_num_tickets
     {$else}
       {$IF declared(ERR_SSL_get_num_tickets)}
       SSL_get_num_tickets := @ERR_SSL_get_num_tickets
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_num_tickets) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_num_tickets');
  end;


  if not assigned(SSL_CTX_set_num_tickets) then 
  begin
    {$if declared(SSL_CTX_set_num_tickets_introduced)}
    if LibVersion < SSL_CTX_set_num_tickets_introduced then
      {$if declared(FC_SSL_CTX_set_num_tickets)}
      SSL_CTX_set_num_tickets := @FC_SSL_CTX_set_num_tickets
      {$else}
      SSL_CTX_set_num_tickets := @ERR_SSL_CTX_set_num_tickets
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_num_tickets_removed)}
   if SSL_CTX_set_num_tickets_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_num_tickets)}
     SSL_CTX_set_num_tickets := @_SSL_CTX_set_num_tickets
     {$else}
       {$IF declared(ERR_SSL_CTX_set_num_tickets)}
       SSL_CTX_set_num_tickets := @ERR_SSL_CTX_set_num_tickets
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_num_tickets) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_num_tickets');
  end;


  if not assigned(SSL_CTX_get_num_tickets) then 
  begin
    {$if declared(SSL_CTX_get_num_tickets_introduced)}
    if LibVersion < SSL_CTX_get_num_tickets_introduced then
      {$if declared(FC_SSL_CTX_get_num_tickets)}
      SSL_CTX_get_num_tickets := @FC_SSL_CTX_get_num_tickets
      {$else}
      SSL_CTX_get_num_tickets := @ERR_SSL_CTX_get_num_tickets
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get_num_tickets_removed)}
   if SSL_CTX_get_num_tickets_removed <= LibVersion then
     {$if declared(_SSL_CTX_get_num_tickets)}
     SSL_CTX_get_num_tickets := @_SSL_CTX_get_num_tickets
     {$else}
       {$IF declared(ERR_SSL_CTX_get_num_tickets)}
       SSL_CTX_get_num_tickets := @ERR_SSL_CTX_get_num_tickets
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get_num_tickets) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get_num_tickets');
  end;


  if not assigned(SSL_session_reused) then 
  begin
    {$if declared(SSL_session_reused_introduced)}
    if LibVersion < SSL_session_reused_introduced then
      {$if declared(FC_SSL_session_reused)}
      SSL_session_reused := @FC_SSL_session_reused
      {$else}
      SSL_session_reused := @ERR_SSL_session_reused
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_session_reused_removed)}
   if SSL_session_reused_removed <= LibVersion then
     {$if declared(_SSL_session_reused)}
     SSL_session_reused := @_SSL_session_reused
     {$else}
       {$IF declared(ERR_SSL_session_reused)}
       SSL_session_reused := @ERR_SSL_session_reused
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_session_reused) and Assigned(AFailed) then 
     AFailed.Add('SSL_session_reused');
  end;


  if not assigned(SSL_add_ssl_module) then 
  begin
    {$if declared(SSL_add_ssl_module_introduced)}
    if LibVersion < SSL_add_ssl_module_introduced then
      {$if declared(FC_SSL_add_ssl_module)}
      SSL_add_ssl_module := @FC_SSL_add_ssl_module
      {$else}
      SSL_add_ssl_module := @ERR_SSL_add_ssl_module
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_add_ssl_module_removed)}
   if SSL_add_ssl_module_removed <= LibVersion then
     {$if declared(_SSL_add_ssl_module)}
     SSL_add_ssl_module := @_SSL_add_ssl_module
     {$else}
       {$IF declared(ERR_SSL_add_ssl_module)}
       SSL_add_ssl_module := @ERR_SSL_add_ssl_module
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_add_ssl_module) and Assigned(AFailed) then 
     AFailed.Add('SSL_add_ssl_module');
  end;


  if not assigned(SSL_config) then 
  begin
    {$if declared(SSL_config_introduced)}
    if LibVersion < SSL_config_introduced then
      {$if declared(FC_SSL_config)}
      SSL_config := @FC_SSL_config
      {$else}
      SSL_config := @ERR_SSL_config
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_config_removed)}
   if SSL_config_removed <= LibVersion then
     {$if declared(_SSL_config)}
     SSL_config := @_SSL_config
     {$else}
       {$IF declared(ERR_SSL_config)}
       SSL_config := @ERR_SSL_config
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_config) and Assigned(AFailed) then 
     AFailed.Add('SSL_config');
  end;


  if not assigned(SSL_CTX_config) then 
  begin
    {$if declared(SSL_CTX_config_introduced)}
    if LibVersion < SSL_CTX_config_introduced then
      {$if declared(FC_SSL_CTX_config)}
      SSL_CTX_config := @FC_SSL_CTX_config
      {$else}
      SSL_CTX_config := @ERR_SSL_CTX_config
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_config_removed)}
   if SSL_CTX_config_removed <= LibVersion then
     {$if declared(_SSL_CTX_config)}
     SSL_CTX_config := @_SSL_CTX_config
     {$else}
       {$IF declared(ERR_SSL_CTX_config)}
       SSL_CTX_config := @ERR_SSL_CTX_config
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_config) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_config');
  end;


  if not assigned(DTLSv1_listen) then 
  begin
    {$if declared(DTLSv1_listen_introduced)}
    if LibVersion < DTLSv1_listen_introduced then
      {$if declared(FC_DTLSv1_listen)}
      DTLSv1_listen := @FC_DTLSv1_listen
      {$else}
      DTLSv1_listen := @ERR_DTLSv1_listen
      {$ifend}
    else
    {$ifend}
   {$if declared(DTLSv1_listen_removed)}
   if DTLSv1_listen_removed <= LibVersion then
     {$if declared(_DTLSv1_listen)}
     DTLSv1_listen := @_DTLSv1_listen
     {$else}
       {$IF declared(ERR_DTLSv1_listen)}
       DTLSv1_listen := @ERR_DTLSv1_listen
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DTLSv1_listen) and Assigned(AFailed) then 
     AFailed.Add('DTLSv1_listen');
  end;


  if not assigned(SSL_enable_ct) then 
  begin
    {$if declared(SSL_enable_ct_introduced)}
    if LibVersion < SSL_enable_ct_introduced then
      {$if declared(FC_SSL_enable_ct)}
      SSL_enable_ct := @FC_SSL_enable_ct
      {$else}
      SSL_enable_ct := @ERR_SSL_enable_ct
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_enable_ct_removed)}
   if SSL_enable_ct_removed <= LibVersion then
     {$if declared(_SSL_enable_ct)}
     SSL_enable_ct := @_SSL_enable_ct
     {$else}
       {$IF declared(ERR_SSL_enable_ct)}
       SSL_enable_ct := @ERR_SSL_enable_ct
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_enable_ct) and Assigned(AFailed) then 
     AFailed.Add('SSL_enable_ct');
  end;


  if not assigned(SSL_CTX_enable_ct) then 
  begin
    {$if declared(SSL_CTX_enable_ct_introduced)}
    if LibVersion < SSL_CTX_enable_ct_introduced then
      {$if declared(FC_SSL_CTX_enable_ct)}
      SSL_CTX_enable_ct := @FC_SSL_CTX_enable_ct
      {$else}
      SSL_CTX_enable_ct := @ERR_SSL_CTX_enable_ct
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_enable_ct_removed)}
   if SSL_CTX_enable_ct_removed <= LibVersion then
     {$if declared(_SSL_CTX_enable_ct)}
     SSL_CTX_enable_ct := @_SSL_CTX_enable_ct
     {$else}
       {$IF declared(ERR_SSL_CTX_enable_ct)}
       SSL_CTX_enable_ct := @ERR_SSL_CTX_enable_ct
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_enable_ct) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_enable_ct');
  end;


  if not assigned(SSL_ct_is_enabled) then 
  begin
    {$if declared(SSL_ct_is_enabled_introduced)}
    if LibVersion < SSL_ct_is_enabled_introduced then
      {$if declared(FC_SSL_ct_is_enabled)}
      SSL_ct_is_enabled := @FC_SSL_ct_is_enabled
      {$else}
      SSL_ct_is_enabled := @ERR_SSL_ct_is_enabled
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_ct_is_enabled_removed)}
   if SSL_ct_is_enabled_removed <= LibVersion then
     {$if declared(_SSL_ct_is_enabled)}
     SSL_ct_is_enabled := @_SSL_ct_is_enabled
     {$else}
       {$IF declared(ERR_SSL_ct_is_enabled)}
       SSL_ct_is_enabled := @ERR_SSL_ct_is_enabled
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_ct_is_enabled) and Assigned(AFailed) then 
     AFailed.Add('SSL_ct_is_enabled');
  end;


  if not assigned(SSL_CTX_ct_is_enabled) then 
  begin
    {$if declared(SSL_CTX_ct_is_enabled_introduced)}
    if LibVersion < SSL_CTX_ct_is_enabled_introduced then
      {$if declared(FC_SSL_CTX_ct_is_enabled)}
      SSL_CTX_ct_is_enabled := @FC_SSL_CTX_ct_is_enabled
      {$else}
      SSL_CTX_ct_is_enabled := @ERR_SSL_CTX_ct_is_enabled
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_ct_is_enabled_removed)}
   if SSL_CTX_ct_is_enabled_removed <= LibVersion then
     {$if declared(_SSL_CTX_ct_is_enabled)}
     SSL_CTX_ct_is_enabled := @_SSL_CTX_ct_is_enabled
     {$else}
       {$IF declared(ERR_SSL_CTX_ct_is_enabled)}
       SSL_CTX_ct_is_enabled := @ERR_SSL_CTX_ct_is_enabled
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_ct_is_enabled) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_ct_is_enabled');
  end;


  if not assigned(SSL_CTX_set_default_ctlog_list_file) then 
  begin
    {$if declared(SSL_CTX_set_default_ctlog_list_file_introduced)}
    if LibVersion < SSL_CTX_set_default_ctlog_list_file_introduced then
      {$if declared(FC_SSL_CTX_set_default_ctlog_list_file)}
      SSL_CTX_set_default_ctlog_list_file := @FC_SSL_CTX_set_default_ctlog_list_file
      {$else}
      SSL_CTX_set_default_ctlog_list_file := @ERR_SSL_CTX_set_default_ctlog_list_file
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_default_ctlog_list_file_removed)}
   if SSL_CTX_set_default_ctlog_list_file_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_default_ctlog_list_file)}
     SSL_CTX_set_default_ctlog_list_file := @_SSL_CTX_set_default_ctlog_list_file
     {$else}
       {$IF declared(ERR_SSL_CTX_set_default_ctlog_list_file)}
       SSL_CTX_set_default_ctlog_list_file := @ERR_SSL_CTX_set_default_ctlog_list_file
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_default_ctlog_list_file) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_default_ctlog_list_file');
  end;


  if not assigned(SSL_CTX_set_ctlog_list_file) then 
  begin
    {$if declared(SSL_CTX_set_ctlog_list_file_introduced)}
    if LibVersion < SSL_CTX_set_ctlog_list_file_introduced then
      {$if declared(FC_SSL_CTX_set_ctlog_list_file)}
      SSL_CTX_set_ctlog_list_file := @FC_SSL_CTX_set_ctlog_list_file
      {$else}
      SSL_CTX_set_ctlog_list_file := @ERR_SSL_CTX_set_ctlog_list_file
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_ctlog_list_file_removed)}
   if SSL_CTX_set_ctlog_list_file_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_ctlog_list_file)}
     SSL_CTX_set_ctlog_list_file := @_SSL_CTX_set_ctlog_list_file
     {$else}
       {$IF declared(ERR_SSL_CTX_set_ctlog_list_file)}
       SSL_CTX_set_ctlog_list_file := @ERR_SSL_CTX_set_ctlog_list_file
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_ctlog_list_file) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_ctlog_list_file');
  end;


  if not assigned(SSL_CTX_set0_ctlog_store) then 
  begin
    {$if declared(SSL_CTX_set0_ctlog_store_introduced)}
    if LibVersion < SSL_CTX_set0_ctlog_store_introduced then
      {$if declared(FC_SSL_CTX_set0_ctlog_store)}
      SSL_CTX_set0_ctlog_store := @FC_SSL_CTX_set0_ctlog_store
      {$else}
      SSL_CTX_set0_ctlog_store := @ERR_SSL_CTX_set0_ctlog_store
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set0_ctlog_store_removed)}
   if SSL_CTX_set0_ctlog_store_removed <= LibVersion then
     {$if declared(_SSL_CTX_set0_ctlog_store)}
     SSL_CTX_set0_ctlog_store := @_SSL_CTX_set0_ctlog_store
     {$else}
       {$IF declared(ERR_SSL_CTX_set0_ctlog_store)}
       SSL_CTX_set0_ctlog_store := @ERR_SSL_CTX_set0_ctlog_store
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set0_ctlog_store) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set0_ctlog_store');
  end;


  if not assigned(SSL_set_security_level) then 
  begin
    {$if declared(SSL_set_security_level_introduced)}
    if LibVersion < SSL_set_security_level_introduced then
      {$if declared(FC_SSL_set_security_level)}
      SSL_set_security_level := @FC_SSL_set_security_level
      {$else}
      SSL_set_security_level := @ERR_SSL_set_security_level
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_security_level_removed)}
   if SSL_set_security_level_removed <= LibVersion then
     {$if declared(_SSL_set_security_level)}
     SSL_set_security_level := @_SSL_set_security_level
     {$else}
       {$IF declared(ERR_SSL_set_security_level)}
       SSL_set_security_level := @ERR_SSL_set_security_level
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_security_level) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_security_level');
  end;


  if not assigned(SSL_set_security_callback) then 
  begin
    {$if declared(SSL_set_security_callback_introduced)}
    if LibVersion < SSL_set_security_callback_introduced then
      {$if declared(FC_SSL_set_security_callback)}
      SSL_set_security_callback := @FC_SSL_set_security_callback
      {$else}
      SSL_set_security_callback := @ERR_SSL_set_security_callback
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_security_callback_removed)}
   if SSL_set_security_callback_removed <= LibVersion then
     {$if declared(_SSL_set_security_callback)}
     SSL_set_security_callback := @_SSL_set_security_callback
     {$else}
       {$IF declared(ERR_SSL_set_security_callback)}
       SSL_set_security_callback := @ERR_SSL_set_security_callback
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_security_callback) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_security_callback');
  end;


  if not assigned(SSL_get_security_callback) then 
  begin
    {$if declared(SSL_get_security_callback_introduced)}
    if LibVersion < SSL_get_security_callback_introduced then
      {$if declared(FC_SSL_get_security_callback)}
      SSL_get_security_callback := @FC_SSL_get_security_callback
      {$else}
      SSL_get_security_callback := @ERR_SSL_get_security_callback
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get_security_callback_removed)}
   if SSL_get_security_callback_removed <= LibVersion then
     {$if declared(_SSL_get_security_callback)}
     SSL_get_security_callback := @_SSL_get_security_callback
     {$else}
       {$IF declared(ERR_SSL_get_security_callback)}
       SSL_get_security_callback := @ERR_SSL_get_security_callback
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get_security_callback) and Assigned(AFailed) then 
     AFailed.Add('SSL_get_security_callback');
  end;


  if not assigned(SSL_set0_security_ex_data) then 
  begin
    {$if declared(SSL_set0_security_ex_data_introduced)}
    if LibVersion < SSL_set0_security_ex_data_introduced then
      {$if declared(FC_SSL_set0_security_ex_data)}
      SSL_set0_security_ex_data := @FC_SSL_set0_security_ex_data
      {$else}
      SSL_set0_security_ex_data := @ERR_SSL_set0_security_ex_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set0_security_ex_data_removed)}
   if SSL_set0_security_ex_data_removed <= LibVersion then
     {$if declared(_SSL_set0_security_ex_data)}
     SSL_set0_security_ex_data := @_SSL_set0_security_ex_data
     {$else}
       {$IF declared(ERR_SSL_set0_security_ex_data)}
       SSL_set0_security_ex_data := @ERR_SSL_set0_security_ex_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set0_security_ex_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_set0_security_ex_data');
  end;


  if not assigned(SSL_get0_security_ex_data) then 
  begin
    {$if declared(SSL_get0_security_ex_data_introduced)}
    if LibVersion < SSL_get0_security_ex_data_introduced then
      {$if declared(FC_SSL_get0_security_ex_data)}
      SSL_get0_security_ex_data := @FC_SSL_get0_security_ex_data
      {$else}
      SSL_get0_security_ex_data := @ERR_SSL_get0_security_ex_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get0_security_ex_data_removed)}
   if SSL_get0_security_ex_data_removed <= LibVersion then
     {$if declared(_SSL_get0_security_ex_data)}
     SSL_get0_security_ex_data := @_SSL_get0_security_ex_data
     {$else}
       {$IF declared(ERR_SSL_get0_security_ex_data)}
       SSL_get0_security_ex_data := @ERR_SSL_get0_security_ex_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get0_security_ex_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_get0_security_ex_data');
  end;


  if not assigned(SSL_CTX_set_security_level) then 
  begin
    {$if declared(SSL_CTX_set_security_level_introduced)}
    if LibVersion < SSL_CTX_set_security_level_introduced then
      {$if declared(FC_SSL_CTX_set_security_level)}
      SSL_CTX_set_security_level := @FC_SSL_CTX_set_security_level
      {$else}
      SSL_CTX_set_security_level := @ERR_SSL_CTX_set_security_level
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_security_level_removed)}
   if SSL_CTX_set_security_level_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_security_level)}
     SSL_CTX_set_security_level := @_SSL_CTX_set_security_level
     {$else}
       {$IF declared(ERR_SSL_CTX_set_security_level)}
       SSL_CTX_set_security_level := @ERR_SSL_CTX_set_security_level
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_security_level) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_security_level');
  end;


  if not assigned(SSL_CTX_get_security_level) then 
  begin
    {$if declared(SSL_CTX_get_security_level_introduced)}
    if LibVersion < SSL_CTX_get_security_level_introduced then
      {$if declared(FC_SSL_CTX_get_security_level)}
      SSL_CTX_get_security_level := @FC_SSL_CTX_get_security_level
      {$else}
      SSL_CTX_get_security_level := @ERR_SSL_CTX_get_security_level
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get_security_level_removed)}
   if SSL_CTX_get_security_level_removed <= LibVersion then
     {$if declared(_SSL_CTX_get_security_level)}
     SSL_CTX_get_security_level := @_SSL_CTX_get_security_level
     {$else}
       {$IF declared(ERR_SSL_CTX_get_security_level)}
       SSL_CTX_get_security_level := @ERR_SSL_CTX_get_security_level
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get_security_level) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get_security_level');
  end;


  if not assigned(SSL_CTX_get0_security_ex_data) then 
  begin
    {$if declared(SSL_CTX_get0_security_ex_data_introduced)}
    if LibVersion < SSL_CTX_get0_security_ex_data_introduced then
      {$if declared(FC_SSL_CTX_get0_security_ex_data)}
      SSL_CTX_get0_security_ex_data := @FC_SSL_CTX_get0_security_ex_data
      {$else}
      SSL_CTX_get0_security_ex_data := @ERR_SSL_CTX_get0_security_ex_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_get0_security_ex_data_removed)}
   if SSL_CTX_get0_security_ex_data_removed <= LibVersion then
     {$if declared(_SSL_CTX_get0_security_ex_data)}
     SSL_CTX_get0_security_ex_data := @_SSL_CTX_get0_security_ex_data
     {$else}
       {$IF declared(ERR_SSL_CTX_get0_security_ex_data)}
       SSL_CTX_get0_security_ex_data := @ERR_SSL_CTX_get0_security_ex_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_get0_security_ex_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_get0_security_ex_data');
  end;


  if not assigned(SSL_CTX_set0_security_ex_data) then 
  begin
    {$if declared(SSL_CTX_set0_security_ex_data_introduced)}
    if LibVersion < SSL_CTX_set0_security_ex_data_introduced then
      {$if declared(FC_SSL_CTX_set0_security_ex_data)}
      SSL_CTX_set0_security_ex_data := @FC_SSL_CTX_set0_security_ex_data
      {$else}
      SSL_CTX_set0_security_ex_data := @ERR_SSL_CTX_set0_security_ex_data
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set0_security_ex_data_removed)}
   if SSL_CTX_set0_security_ex_data_removed <= LibVersion then
     {$if declared(_SSL_CTX_set0_security_ex_data)}
     SSL_CTX_set0_security_ex_data := @_SSL_CTX_set0_security_ex_data
     {$else}
       {$IF declared(ERR_SSL_CTX_set0_security_ex_data)}
       SSL_CTX_set0_security_ex_data := @ERR_SSL_CTX_set0_security_ex_data
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set0_security_ex_data) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set0_security_ex_data');
  end;


  if not assigned(OPENSSL_init_ssl) then 
  begin
    {$if declared(OPENSSL_init_ssl_introduced)}
    if LibVersion < OPENSSL_init_ssl_introduced then
      {$if declared(FC_OPENSSL_init_ssl)}
      OPENSSL_init_ssl := @FC_OPENSSL_init_ssl
      {$else}
      OPENSSL_init_ssl := @ERR_OPENSSL_init_ssl
      {$ifend}
    else
    {$ifend}
   {$if declared(OPENSSL_init_ssl_removed)}
   if OPENSSL_init_ssl_removed <= LibVersion then
     {$if declared(_OPENSSL_init_ssl)}
     OPENSSL_init_ssl := @_OPENSSL_init_ssl
     {$else}
       {$IF declared(ERR_OPENSSL_init_ssl)}
       OPENSSL_init_ssl := @ERR_OPENSSL_init_ssl
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(OPENSSL_init_ssl) and Assigned(AFailed) then 
     AFailed.Add('OPENSSL_init_ssl');
  end;


  if not assigned(SSL_free_buffers) then 
  begin
    {$if declared(SSL_free_buffers_introduced)}
    if LibVersion < SSL_free_buffers_introduced then
      {$if declared(FC_SSL_free_buffers)}
      SSL_free_buffers := @FC_SSL_free_buffers
      {$else}
      SSL_free_buffers := @ERR_SSL_free_buffers
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_free_buffers_removed)}
   if SSL_free_buffers_removed <= LibVersion then
     {$if declared(_SSL_free_buffers)}
     SSL_free_buffers := @_SSL_free_buffers
     {$else}
       {$IF declared(ERR_SSL_free_buffers)}
       SSL_free_buffers := @ERR_SSL_free_buffers
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_free_buffers) and Assigned(AFailed) then 
     AFailed.Add('SSL_free_buffers');
  end;


  if not assigned(SSL_alloc_buffers) then 
  begin
    {$if declared(SSL_alloc_buffers_introduced)}
    if LibVersion < SSL_alloc_buffers_introduced then
      {$if declared(FC_SSL_alloc_buffers)}
      SSL_alloc_buffers := @FC_SSL_alloc_buffers
      {$else}
      SSL_alloc_buffers := @ERR_SSL_alloc_buffers
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_alloc_buffers_removed)}
   if SSL_alloc_buffers_removed <= LibVersion then
     {$if declared(_SSL_alloc_buffers)}
     SSL_alloc_buffers := @_SSL_alloc_buffers
     {$else}
       {$IF declared(ERR_SSL_alloc_buffers)}
       SSL_alloc_buffers := @ERR_SSL_alloc_buffers
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_alloc_buffers) and Assigned(AFailed) then 
     AFailed.Add('SSL_alloc_buffers');
  end;


  if not assigned(SSL_CTX_set_session_ticket_cb) then 
  begin
    {$if declared(SSL_CTX_set_session_ticket_cb_introduced)}
    if LibVersion < SSL_CTX_set_session_ticket_cb_introduced then
      {$if declared(FC_SSL_CTX_set_session_ticket_cb)}
      SSL_CTX_set_session_ticket_cb := @FC_SSL_CTX_set_session_ticket_cb
      {$else}
      SSL_CTX_set_session_ticket_cb := @ERR_SSL_CTX_set_session_ticket_cb
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_session_ticket_cb_removed)}
   if SSL_CTX_set_session_ticket_cb_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_session_ticket_cb)}
     SSL_CTX_set_session_ticket_cb := @_SSL_CTX_set_session_ticket_cb
     {$else}
       {$IF declared(ERR_SSL_CTX_set_session_ticket_cb)}
       SSL_CTX_set_session_ticket_cb := @ERR_SSL_CTX_set_session_ticket_cb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_session_ticket_cb) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_session_ticket_cb');
  end;


  if not assigned(SSL_SESSION_set1_ticket_appdata) then 
  begin
    {$if declared(SSL_SESSION_set1_ticket_appdata_introduced)}
    if LibVersion < SSL_SESSION_set1_ticket_appdata_introduced then
      {$if declared(FC_SSL_SESSION_set1_ticket_appdata)}
      SSL_SESSION_set1_ticket_appdata := @FC_SSL_SESSION_set1_ticket_appdata
      {$else}
      SSL_SESSION_set1_ticket_appdata := @ERR_SSL_SESSION_set1_ticket_appdata
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_set1_ticket_appdata_removed)}
   if SSL_SESSION_set1_ticket_appdata_removed <= LibVersion then
     {$if declared(_SSL_SESSION_set1_ticket_appdata)}
     SSL_SESSION_set1_ticket_appdata := @_SSL_SESSION_set1_ticket_appdata
     {$else}
       {$IF declared(ERR_SSL_SESSION_set1_ticket_appdata)}
       SSL_SESSION_set1_ticket_appdata := @ERR_SSL_SESSION_set1_ticket_appdata
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_set1_ticket_appdata) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_set1_ticket_appdata');
  end;


  if not assigned(SSL_SESSION_get0_ticket_appdata) then 
  begin
    {$if declared(SSL_SESSION_get0_ticket_appdata_introduced)}
    if LibVersion < SSL_SESSION_get0_ticket_appdata_introduced then
      {$if declared(FC_SSL_SESSION_get0_ticket_appdata)}
      SSL_SESSION_get0_ticket_appdata := @FC_SSL_SESSION_get0_ticket_appdata
      {$else}
      SSL_SESSION_get0_ticket_appdata := @ERR_SSL_SESSION_get0_ticket_appdata
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_SESSION_get0_ticket_appdata_removed)}
   if SSL_SESSION_get0_ticket_appdata_removed <= LibVersion then
     {$if declared(_SSL_SESSION_get0_ticket_appdata)}
     SSL_SESSION_get0_ticket_appdata := @_SSL_SESSION_get0_ticket_appdata
     {$else}
       {$IF declared(ERR_SSL_SESSION_get0_ticket_appdata)}
       SSL_SESSION_get0_ticket_appdata := @ERR_SSL_SESSION_get0_ticket_appdata
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_SESSION_get0_ticket_appdata) and Assigned(AFailed) then 
     AFailed.Add('SSL_SESSION_get0_ticket_appdata');
  end;


  if not assigned(DTLS_set_timer_cb) then 
  begin
    {$if declared(DTLS_set_timer_cb_introduced)}
    if LibVersion < DTLS_set_timer_cb_introduced then
      {$if declared(FC_DTLS_set_timer_cb)}
      DTLS_set_timer_cb := @FC_DTLS_set_timer_cb
      {$else}
      DTLS_set_timer_cb := @ERR_DTLS_set_timer_cb
      {$ifend}
    else
    {$ifend}
   {$if declared(DTLS_set_timer_cb_removed)}
   if DTLS_set_timer_cb_removed <= LibVersion then
     {$if declared(_DTLS_set_timer_cb)}
     DTLS_set_timer_cb := @_DTLS_set_timer_cb
     {$else}
       {$IF declared(ERR_DTLS_set_timer_cb)}
       DTLS_set_timer_cb := @ERR_DTLS_set_timer_cb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(DTLS_set_timer_cb) and Assigned(AFailed) then 
     AFailed.Add('DTLS_set_timer_cb');
  end;


  if not assigned(SSL_CTX_set_allow_early_data_cb) then 
  begin
    {$if declared(SSL_CTX_set_allow_early_data_cb_introduced)}
    if LibVersion < SSL_CTX_set_allow_early_data_cb_introduced then
      {$if declared(FC_SSL_CTX_set_allow_early_data_cb)}
      SSL_CTX_set_allow_early_data_cb := @FC_SSL_CTX_set_allow_early_data_cb
      {$else}
      SSL_CTX_set_allow_early_data_cb := @ERR_SSL_CTX_set_allow_early_data_cb
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_CTX_set_allow_early_data_cb_removed)}
   if SSL_CTX_set_allow_early_data_cb_removed <= LibVersion then
     {$if declared(_SSL_CTX_set_allow_early_data_cb)}
     SSL_CTX_set_allow_early_data_cb := @_SSL_CTX_set_allow_early_data_cb
     {$else}
       {$IF declared(ERR_SSL_CTX_set_allow_early_data_cb)}
       SSL_CTX_set_allow_early_data_cb := @ERR_SSL_CTX_set_allow_early_data_cb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_CTX_set_allow_early_data_cb) and Assigned(AFailed) then 
     AFailed.Add('SSL_CTX_set_allow_early_data_cb');
  end;


  if not assigned(SSL_set_allow_early_data_cb) then 
  begin
    {$if declared(SSL_set_allow_early_data_cb_introduced)}
    if LibVersion < SSL_set_allow_early_data_cb_introduced then
      {$if declared(FC_SSL_set_allow_early_data_cb)}
      SSL_set_allow_early_data_cb := @FC_SSL_set_allow_early_data_cb
      {$else}
      SSL_set_allow_early_data_cb := @ERR_SSL_set_allow_early_data_cb
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_set_allow_early_data_cb_removed)}
   if SSL_set_allow_early_data_cb_removed <= LibVersion then
     {$if declared(_SSL_set_allow_early_data_cb)}
     SSL_set_allow_early_data_cb := @_SSL_set_allow_early_data_cb
     {$else}
       {$IF declared(ERR_SSL_set_allow_early_data_cb)}
       SSL_set_allow_early_data_cb := @ERR_SSL_set_allow_early_data_cb
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_set_allow_early_data_cb) and Assigned(AFailed) then 
     AFailed.Add('SSL_set_allow_early_data_cb');
  end;


  if not assigned(SSLv2_method) then 
  begin
    {$if declared(SSLv2_method_introduced)}
    if LibVersion < SSLv2_method_introduced then
      {$if declared(FC_SSLv2_method)}
      SSLv2_method := @FC_SSLv2_method
      {$else}
      SSLv2_method := @ERR_SSLv2_method
      {$ifend}
    else
    {$ifend}
   {$if declared(SSLv2_method_removed)}
   if SSLv2_method_removed <= LibVersion then
     {$if declared(_SSLv2_method)}
     SSLv2_method := @_SSLv2_method
     {$else}
       {$IF declared(ERR_SSLv2_method)}
       SSLv2_method := @ERR_SSLv2_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSLv2_method) and Assigned(AFailed) then 
     AFailed.Add('SSLv2_method');
  end;

 // SSLv2
  if not assigned(SSLv2_server_method) then 
  begin
    {$if declared(SSLv2_server_method_introduced)}
    if LibVersion < SSLv2_server_method_introduced then
      {$if declared(FC_SSLv2_server_method)}
      SSLv2_server_method := @FC_SSLv2_server_method
      {$else}
      SSLv2_server_method := @ERR_SSLv2_server_method
      {$ifend}
    else
    {$ifend}
   {$if declared(SSLv2_server_method_removed)}
   if SSLv2_server_method_removed <= LibVersion then
     {$if declared(_SSLv2_server_method)}
     SSLv2_server_method := @_SSLv2_server_method
     {$else}
       {$IF declared(ERR_SSLv2_server_method)}
       SSLv2_server_method := @ERR_SSLv2_server_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSLv2_server_method) and Assigned(AFailed) then 
     AFailed.Add('SSLv2_server_method');
  end;

 // SSLv2
  if not assigned(SSLv2_client_method) then 
  begin
    {$if declared(SSLv2_client_method_introduced)}
    if LibVersion < SSLv2_client_method_introduced then
      {$if declared(FC_SSLv2_client_method)}
      SSLv2_client_method := @FC_SSLv2_client_method
      {$else}
      SSLv2_client_method := @ERR_SSLv2_client_method
      {$ifend}
    else
    {$ifend}
   {$if declared(SSLv2_client_method_removed)}
   if SSLv2_client_method_removed <= LibVersion then
     {$if declared(_SSLv2_client_method)}
     SSLv2_client_method := @_SSLv2_client_method
     {$else}
       {$IF declared(ERR_SSLv2_client_method)}
       SSLv2_client_method := @ERR_SSLv2_client_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSLv2_client_method) and Assigned(AFailed) then 
     AFailed.Add('SSLv2_client_method');
  end;

 // SSLv2
  if not assigned(SSLv3_method) then 
  begin
    {$if declared(SSLv3_method_introduced)}
    if LibVersion < SSLv3_method_introduced then
      {$if declared(FC_SSLv3_method)}
      SSLv3_method := @FC_SSLv3_method
      {$else}
      SSLv3_method := @ERR_SSLv3_method
      {$ifend}
    else
    {$ifend}
   {$if declared(SSLv3_method_removed)}
   if SSLv3_method_removed <= LibVersion then
     {$if declared(_SSLv3_method)}
     SSLv3_method := @_SSLv3_method
     {$else}
       {$IF declared(ERR_SSLv3_method)}
       SSLv3_method := @ERR_SSLv3_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSLv3_method) and Assigned(AFailed) then 
     AFailed.Add('SSLv3_method');
  end;

 // SSLv3
  if not assigned(SSLv3_server_method) then 
  begin
    {$if declared(SSLv3_server_method_introduced)}
    if LibVersion < SSLv3_server_method_introduced then
      {$if declared(FC_SSLv3_server_method)}
      SSLv3_server_method := @FC_SSLv3_server_method
      {$else}
      SSLv3_server_method := @ERR_SSLv3_server_method
      {$ifend}
    else
    {$ifend}
   {$if declared(SSLv3_server_method_removed)}
   if SSLv3_server_method_removed <= LibVersion then
     {$if declared(_SSLv3_server_method)}
     SSLv3_server_method := @_SSLv3_server_method
     {$else}
       {$IF declared(ERR_SSLv3_server_method)}
       SSLv3_server_method := @ERR_SSLv3_server_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSLv3_server_method) and Assigned(AFailed) then 
     AFailed.Add('SSLv3_server_method');
  end;

 // SSLv3
  if not assigned(SSLv3_client_method) then 
  begin
    {$if declared(SSLv3_client_method_introduced)}
    if LibVersion < SSLv3_client_method_introduced then
      {$if declared(FC_SSLv3_client_method)}
      SSLv3_client_method := @FC_SSLv3_client_method
      {$else}
      SSLv3_client_method := @ERR_SSLv3_client_method
      {$ifend}
    else
    {$ifend}
   {$if declared(SSLv3_client_method_removed)}
   if SSLv3_client_method_removed <= LibVersion then
     {$if declared(_SSLv3_client_method)}
     SSLv3_client_method := @_SSLv3_client_method
     {$else}
       {$IF declared(ERR_SSLv3_client_method)}
       SSLv3_client_method := @ERR_SSLv3_client_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSLv3_client_method) and Assigned(AFailed) then 
     AFailed.Add('SSLv3_client_method');
  end;

 // SSLv3
  if not assigned(SSLv23_method) then 
  begin
    {$if declared(SSLv23_method_introduced)}
    if LibVersion < SSLv23_method_introduced then
      {$if declared(FC_SSLv23_method)}
      SSLv23_method := @FC_SSLv23_method
      {$else}
      SSLv23_method := @ERR_SSLv23_method
      {$ifend}
    else
    {$ifend}
   {$if declared(SSLv23_method_removed)}
   if SSLv23_method_removed <= LibVersion then
     {$if declared(_SSLv23_method)}
     SSLv23_method := @_SSLv23_method
     {$else}
       {$IF declared(ERR_SSLv23_method)}
       SSLv23_method := @ERR_SSLv23_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSLv23_method) and Assigned(AFailed) then 
     AFailed.Add('SSLv23_method');
  end;

 // SSLv3 but can rollback to v2
  if not assigned(SSLv23_server_method) then 
  begin
    {$if declared(SSLv23_server_method_introduced)}
    if LibVersion < SSLv23_server_method_introduced then
      {$if declared(FC_SSLv23_server_method)}
      SSLv23_server_method := @FC_SSLv23_server_method
      {$else}
      SSLv23_server_method := @ERR_SSLv23_server_method
      {$ifend}
    else
    {$ifend}
   {$if declared(SSLv23_server_method_removed)}
   if SSLv23_server_method_removed <= LibVersion then
     {$if declared(_SSLv23_server_method)}
     SSLv23_server_method := @_SSLv23_server_method
     {$else}
       {$IF declared(ERR_SSLv23_server_method)}
       SSLv23_server_method := @ERR_SSLv23_server_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSLv23_server_method) and Assigned(AFailed) then 
     AFailed.Add('SSLv23_server_method');
  end;

 // SSLv3 but can rollback to v2
  if not assigned(SSLv23_client_method) then 
  begin
    {$if declared(SSLv23_client_method_introduced)}
    if LibVersion < SSLv23_client_method_introduced then
      {$if declared(FC_SSLv23_client_method)}
      SSLv23_client_method := @FC_SSLv23_client_method
      {$else}
      SSLv23_client_method := @ERR_SSLv23_client_method
      {$ifend}
    else
    {$ifend}
   {$if declared(SSLv23_client_method_removed)}
   if SSLv23_client_method_removed <= LibVersion then
     {$if declared(_SSLv23_client_method)}
     SSLv23_client_method := @_SSLv23_client_method
     {$else}
       {$IF declared(ERR_SSLv23_client_method)}
       SSLv23_client_method := @ERR_SSLv23_client_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSLv23_client_method) and Assigned(AFailed) then 
     AFailed.Add('SSLv23_client_method');
  end;

 // SSLv3 but can rollback to v2
  if not assigned(TLSv1_method) then 
  begin
    {$if declared(TLSv1_method_introduced)}
    if LibVersion < TLSv1_method_introduced then
      {$if declared(FC_TLSv1_method)}
      TLSv1_method := @FC_TLSv1_method
      {$else}
      TLSv1_method := @ERR_TLSv1_method
      {$ifend}
    else
    {$ifend}
   {$if declared(TLSv1_method_removed)}
   if TLSv1_method_removed <= LibVersion then
     {$if declared(_TLSv1_method)}
     TLSv1_method := @_TLSv1_method
     {$else}
       {$IF declared(ERR_TLSv1_method)}
       TLSv1_method := @ERR_TLSv1_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(TLSv1_method) and Assigned(AFailed) then 
     AFailed.Add('TLSv1_method');
  end;

 // TLSv1.0
  if not assigned(TLSv1_server_method) then 
  begin
    {$if declared(TLSv1_server_method_introduced)}
    if LibVersion < TLSv1_server_method_introduced then
      {$if declared(FC_TLSv1_server_method)}
      TLSv1_server_method := @FC_TLSv1_server_method
      {$else}
      TLSv1_server_method := @ERR_TLSv1_server_method
      {$ifend}
    else
    {$ifend}
   {$if declared(TLSv1_server_method_removed)}
   if TLSv1_server_method_removed <= LibVersion then
     {$if declared(_TLSv1_server_method)}
     TLSv1_server_method := @_TLSv1_server_method
     {$else}
       {$IF declared(ERR_TLSv1_server_method)}
       TLSv1_server_method := @ERR_TLSv1_server_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(TLSv1_server_method) and Assigned(AFailed) then 
     AFailed.Add('TLSv1_server_method');
  end;

 // TLSv1.0
  if not assigned(TLSv1_client_method) then 
  begin
    {$if declared(TLSv1_client_method_introduced)}
    if LibVersion < TLSv1_client_method_introduced then
      {$if declared(FC_TLSv1_client_method)}
      TLSv1_client_method := @FC_TLSv1_client_method
      {$else}
      TLSv1_client_method := @ERR_TLSv1_client_method
      {$ifend}
    else
    {$ifend}
   {$if declared(TLSv1_client_method_removed)}
   if TLSv1_client_method_removed <= LibVersion then
     {$if declared(_TLSv1_client_method)}
     TLSv1_client_method := @_TLSv1_client_method
     {$else}
       {$IF declared(ERR_TLSv1_client_method)}
       TLSv1_client_method := @ERR_TLSv1_client_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(TLSv1_client_method) and Assigned(AFailed) then 
     AFailed.Add('TLSv1_client_method');
  end;

 // TLSv1.0
  if not assigned(TLSv1_1_method) then 
  begin
    {$if declared(TLSv1_1_method_introduced)}
    if LibVersion < TLSv1_1_method_introduced then
      {$if declared(FC_TLSv1_1_method)}
      TLSv1_1_method := @FC_TLSv1_1_method
      {$else}
      TLSv1_1_method := @ERR_TLSv1_1_method
      {$ifend}
    else
    {$ifend}
   {$if declared(TLSv1_1_method_removed)}
   if TLSv1_1_method_removed <= LibVersion then
     {$if declared(_TLSv1_1_method)}
     TLSv1_1_method := @_TLSv1_1_method
     {$else}
       {$IF declared(ERR_TLSv1_1_method)}
       TLSv1_1_method := @ERR_TLSv1_1_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(TLSv1_1_method) and Assigned(AFailed) then 
     AFailed.Add('TLSv1_1_method');
  end;

 //TLS1.1
  if not assigned(TLSv1_1_server_method) then 
  begin
    {$if declared(TLSv1_1_server_method_introduced)}
    if LibVersion < TLSv1_1_server_method_introduced then
      {$if declared(FC_TLSv1_1_server_method)}
      TLSv1_1_server_method := @FC_TLSv1_1_server_method
      {$else}
      TLSv1_1_server_method := @ERR_TLSv1_1_server_method
      {$ifend}
    else
    {$ifend}
   {$if declared(TLSv1_1_server_method_removed)}
   if TLSv1_1_server_method_removed <= LibVersion then
     {$if declared(_TLSv1_1_server_method)}
     TLSv1_1_server_method := @_TLSv1_1_server_method
     {$else}
       {$IF declared(ERR_TLSv1_1_server_method)}
       TLSv1_1_server_method := @ERR_TLSv1_1_server_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(TLSv1_1_server_method) and Assigned(AFailed) then 
     AFailed.Add('TLSv1_1_server_method');
  end;

 //TLS1.1
  if not assigned(TLSv1_1_client_method) then 
  begin
    {$if declared(TLSv1_1_client_method_introduced)}
    if LibVersion < TLSv1_1_client_method_introduced then
      {$if declared(FC_TLSv1_1_client_method)}
      TLSv1_1_client_method := @FC_TLSv1_1_client_method
      {$else}
      TLSv1_1_client_method := @ERR_TLSv1_1_client_method
      {$ifend}
    else
    {$ifend}
   {$if declared(TLSv1_1_client_method_removed)}
   if TLSv1_1_client_method_removed <= LibVersion then
     {$if declared(_TLSv1_1_client_method)}
     TLSv1_1_client_method := @_TLSv1_1_client_method
     {$else}
       {$IF declared(ERR_TLSv1_1_client_method)}
       TLSv1_1_client_method := @ERR_TLSv1_1_client_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(TLSv1_1_client_method) and Assigned(AFailed) then 
     AFailed.Add('TLSv1_1_client_method');
  end;

 //TLS1.1
  if not assigned(TLSv1_2_method) then 
  begin
    {$if declared(TLSv1_2_method_introduced)}
    if LibVersion < TLSv1_2_method_introduced then
      {$if declared(FC_TLSv1_2_method)}
      TLSv1_2_method := @FC_TLSv1_2_method
      {$else}
      TLSv1_2_method := @ERR_TLSv1_2_method
      {$ifend}
    else
    {$ifend}
   {$if declared(TLSv1_2_method_removed)}
   if TLSv1_2_method_removed <= LibVersion then
     {$if declared(_TLSv1_2_method)}
     TLSv1_2_method := @_TLSv1_2_method
     {$else}
       {$IF declared(ERR_TLSv1_2_method)}
       TLSv1_2_method := @ERR_TLSv1_2_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(TLSv1_2_method) and Assigned(AFailed) then 
     AFailed.Add('TLSv1_2_method');
  end;

		// TLSv1.2
  if not assigned(TLSv1_2_server_method) then 
  begin
    {$if declared(TLSv1_2_server_method_introduced)}
    if LibVersion < TLSv1_2_server_method_introduced then
      {$if declared(FC_TLSv1_2_server_method)}
      TLSv1_2_server_method := @FC_TLSv1_2_server_method
      {$else}
      TLSv1_2_server_method := @ERR_TLSv1_2_server_method
      {$ifend}
    else
    {$ifend}
   {$if declared(TLSv1_2_server_method_removed)}
   if TLSv1_2_server_method_removed <= LibVersion then
     {$if declared(_TLSv1_2_server_method)}
     TLSv1_2_server_method := @_TLSv1_2_server_method
     {$else}
       {$IF declared(ERR_TLSv1_2_server_method)}
       TLSv1_2_server_method := @ERR_TLSv1_2_server_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(TLSv1_2_server_method) and Assigned(AFailed) then 
     AFailed.Add('TLSv1_2_server_method');
  end;

	// TLSv1.2 
  if not assigned(TLSv1_2_client_method) then 
  begin
    {$if declared(TLSv1_2_client_method_introduced)}
    if LibVersion < TLSv1_2_client_method_introduced then
      {$if declared(FC_TLSv1_2_client_method)}
      TLSv1_2_client_method := @FC_TLSv1_2_client_method
      {$else}
      TLSv1_2_client_method := @ERR_TLSv1_2_client_method
      {$ifend}
    else
    {$ifend}
   {$if declared(TLSv1_2_client_method_removed)}
   if TLSv1_2_client_method_removed <= LibVersion then
     {$if declared(_TLSv1_2_client_method)}
     TLSv1_2_client_method := @_TLSv1_2_client_method
     {$else}
       {$IF declared(ERR_TLSv1_2_client_method)}
       TLSv1_2_client_method := @ERR_TLSv1_2_client_method
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(TLSv1_2_client_method) and Assigned(AFailed) then 
     AFailed.Add('TLSv1_2_client_method');
  end;

	// TLSv1.2
  if not assigned(SSL_get0_peer_certificate) then 
  begin
    {$if declared(SSL_get0_peer_certificate_introduced)}
    if LibVersion < SSL_get0_peer_certificate_introduced then
      {$if declared(FC_SSL_get0_peer_certificate)}
      SSL_get0_peer_certificate := @FC_SSL_get0_peer_certificate
      {$else}
      SSL_get0_peer_certificate := @ERR_SSL_get0_peer_certificate
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get0_peer_certificate_removed)}
   if SSL_get0_peer_certificate_removed <= LibVersion then
     {$if declared(_SSL_get0_peer_certificate)}
     SSL_get0_peer_certificate := @_SSL_get0_peer_certificate
     {$else}
       {$IF declared(ERR_SSL_get0_peer_certificate)}
       SSL_get0_peer_certificate := @ERR_SSL_get0_peer_certificate
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get0_peer_certificate) and Assigned(AFailed) then 
     AFailed.Add('SSL_get0_peer_certificate');
  end;


  if not assigned(SSL_get1_peer_certificate) then 
  begin
    {$if declared(SSL_get1_peer_certificate_introduced)}
    if LibVersion < SSL_get1_peer_certificate_introduced then
      {$if declared(FC_SSL_get1_peer_certificate)}
      SSL_get1_peer_certificate := @FC_SSL_get1_peer_certificate
      {$else}
      SSL_get1_peer_certificate := @ERR_SSL_get1_peer_certificate
      {$ifend}
    else
    {$ifend}
   {$if declared(SSL_get1_peer_certificate_removed)}
   if SSL_get1_peer_certificate_removed <= LibVersion then
     {$if declared(_SSL_get1_peer_certificate)}
     SSL_get1_peer_certificate := @_SSL_get1_peer_certificate
     {$else}
       {$IF declared(ERR_SSL_get1_peer_certificate)}
       SSL_get1_peer_certificate := @ERR_SSL_get1_peer_certificate
       {$ifend}
     {$ifend}
    else
   {$ifend}
   if not assigned(SSL_get1_peer_certificate) and Assigned(AFailed) then 
     AFailed.Add('SSL_get1_peer_certificate');
  end;


end;

procedure Unload;
begin
  SSL_CTX_set_mode := nil; {removed 1.0.0}
  SSL_CTX_clear_mode := nil; {removed 1.0.0}
  SSL_CTX_sess_set_cache_size := nil; {removed 1.0.0}
  SSL_CTX_sess_get_cache_size := nil; {removed 1.0.0}
  SSL_CTX_set_session_cache_mode := nil; {removed 1.0.0}
  SSL_CTX_get_session_cache_mode := nil; {removed 1.0.0}
  SSL_clear_num_renegotiations := nil; {removed 1.0.0}
  SSL_total_renegotiations := nil; {removed 1.0.0}
  SSL_CTX_set_tmp_dh := nil; {removed 1.0.0}
  SSL_CTX_set_tmp_ecdh := nil; {removed 1.0.0}
  SSL_CTX_set_dh_auto := nil; {removed 1.0.0}
  SSL_set_dh_auto := nil; {removed 1.0.0}
  SSL_set_tmp_dh := nil; {removed 1.0.0}
  SSL_set_tmp_ecdh := nil; {removed 1.0.0}
  SSL_CTX_add_extra_chain_cert := nil; {removed 1.0.0}
  SSL_CTX_get_extra_chain_certs := nil; {removed 1.0.0}
  SSL_CTX_get_extra_chain_certs_only := nil; {removed 1.0.0}
  SSL_CTX_clear_extra_chain_certs := nil; {removed 1.0.0}
  SSL_CTX_set0_chain := nil; {removed 1.0.0}
  SSL_CTX_set1_chain := nil; {removed 1.0.0}
  SSL_CTX_add0_chain_cert := nil; {removed 1.0.0}
  SSL_CTX_add1_chain_cert := nil; {removed 1.0.0}
  SSL_CTX_get0_chain_certs := nil; {removed 1.0.0}
  SSL_CTX_clear_chain_certs := nil; {removed 1.0.0}
  SSL_CTX_build_cert_chain := nil; {removed 1.0.0}
  SSL_CTX_select_current_cert := nil; {removed 1.0.0}
  SSL_CTX_set_current_cert := nil; {removed 1.0.0}
  SSL_CTX_set0_verify_cert_store := nil; {removed 1.0.0}
  SSL_CTX_set1_verify_cert_store := nil; {removed 1.0.0}
  SSL_CTX_set0_chain_cert_store := nil; {removed 1.0.0}
  SSL_CTX_set1_chain_cert_store := nil; {removed 1.0.0}
  SSL_set0_chain := nil; {removed 1.0.0}
  SSL_set1_chain := nil; {removed 1.0.0}
  SSL_add0_chain_cert := nil; {removed 1.0.0}
  SSL_add1_chain_cert := nil; {removed 1.0.0}
  SSL_get0_chain_certs := nil; {removed 1.0.0}
  SSL_clear_chain_certs := nil; {removed 1.0.0}
  SSL_build_cert_chain := nil; {removed 1.0.0}
  SSL_select_current_cert := nil; {removed 1.0.0}
  SSL_set_current_cert := nil; {removed 1.0.0}
  SSL_set0_verify_cert_store := nil; {removed 1.0.0}
  SSL_set1_verify_cert_store := nil; {removed 1.0.0}
  SSL_set0_chain_cert_store := nil; {removed 1.0.0}
  SSL_set1_chain_cert_store := nil; {removed 1.0.0}
  SSL_get1_groups := nil; {removed 1.0.0}
  SSL_CTX_set1_groups := nil; {removed 1.0.0}
  SSL_CTX_set1_groups_list := nil; {removed 1.0.0}
  SSL_set1_groups := nil; {removed 1.0.0}
  SSL_set1_groups_list := nil; {removed 1.0.0}
  SSL_get_shared_group := nil; {removed 1.0.0}
  SSL_CTX_set1_sigalgs := nil; {removed 1.0.0}
  SSL_CTX_set1_sigalgs_list := nil; {removed 1.0.0}
  SSL_set1_sigalgs := nil; {removed 1.0.0}
  SSL_set1_sigalgs_list := nil; {removed 1.0.0}
  SSL_CTX_set1_client_sigalgs := nil; {removed 1.0.0}
  SSL_CTX_set1_client_sigalgs_list := nil; {removed 1.0.0}
  SSL_set1_client_sigalgs := nil; {removed 1.0.0}
  SSL_set1_client_sigalgs_list := nil; {removed 1.0.0}
  SSL_get0_certificate_types := nil; {removed 1.0.0}
  SSL_CTX_set1_client_certificate_types := nil; {removed 1.0.0}
  SSL_set1_client_certificate_types := nil; {removed 1.0.0}
  SSL_get_signature_nid := nil; {removed 1.0.0}
  SSL_get_peer_signature_nid := nil; {removed 1.0.0}
  SSL_get_peer_tmp_key := nil; {removed 1.0.0}
  SSL_get_tmp_key := nil; {removed 1.0.0}
  SSL_get0_raw_cipherlist := nil; {removed 1.0.0}
  SSL_get0_ec_point_formats := nil; {removed 1.0.0}
  SSL_CTX_get_options := nil; {introduced 1.1.0}
  SSL_get_options := nil; {introduced 1.1.0}
  SSL_CTX_clear_options := nil; {introduced 1.1.0}
  SSL_clear_options := nil; {introduced 1.1.0}
  SSL_CTX_set_options := nil; {introduced 1.1.0}
  SSL_set_options := nil; {introduced 1.1.0}
  SSL_CTX_sess_set_new_cb := nil;
  SSL_CTX_sess_get_new_cb := nil;
  SSL_CTX_sess_set_remove_cb := nil;
  SSL_CTX_sess_get_remove_cb := nil;
  SSL_CTX_set_info_callback := nil;
  SSL_CTX_get_info_callback := nil;
  SSL_CTX_set_client_cert_cb := nil;
  SSL_CTX_get_client_cert_cb := nil;
  SSL_CTX_set_client_cert_engine := nil;
  SSL_CTX_set_cookie_generate_cb := nil;
  SSL_CTX_set_cookie_verify_cb := nil;
  SSL_CTX_set_stateless_cookie_generate_cb := nil; {introduced 1.1.0}
  SSL_CTX_set_stateless_cookie_verify_cb := nil; {introduced 1.1.0}
  SSL_CTX_set_alpn_select_cb := nil;
  SSL_get0_alpn_selected := nil;
  SSL_CTX_set_psk_client_callback := nil;
  SSL_set_psk_client_callback := nil;
  SSL_CTX_set_psk_server_callback := nil;
  SSL_set_psk_server_callback := nil;
  SSL_set_psk_find_session_callback := nil; {introduced 1.1.0}
  SSL_CTX_set_psk_find_session_callback := nil; {introduced 1.1.0}
  SSL_set_psk_use_session_callback := nil; {introduced 1.1.0}
  SSL_CTX_set_psk_use_session_callback := nil; {introduced 1.1.0}
  SSL_CTX_set_keylog_callback := nil; {introduced 1.1.0}
  SSL_CTX_get_keylog_callback := nil; {introduced 1.1.0}
  SSL_CTX_set_max_early_data := nil; {introduced 1.1.0}
  SSL_CTX_get_max_early_data := nil; {introduced 1.1.0}
  SSL_set_max_early_data := nil; {introduced 1.1.0}
  SSL_get_max_early_data := nil; {introduced 1.1.0}
  SSL_CTX_set_recv_max_early_data := nil; {introduced 1.1.0}
  SSL_CTX_get_recv_max_early_data := nil; {introduced 1.1.0}
  SSL_set_recv_max_early_data := nil; {introduced 1.1.0}
  SSL_get_recv_max_early_data := nil; {introduced 1.1.0}
  SSL_get_app_data := nil; {removed 1.0.0} 
  SSL_set_app_data := nil; {removed 1.0.0}
  SSL_in_init := nil; {introduced 1.1.0}
  SSL_in_before := nil; {introduced 1.1.0}
  SSL_is_init_finished := nil; {introduced 1.1.0}
  SSL_get_finished := nil;
  SSL_get_peer_finished := nil;
  SSLeay_add_ssl_algorithms := nil; {removed 1.0.0}
  BIO_f_ssl := nil;
  BIO_new_ssl := nil;
  BIO_new_ssl_connect := nil;
  BIO_new_buffer_ssl_connect := nil;
  BIO_ssl_copy_session_id := nil;
  SSL_CTX_set_cipher_list := nil;
  SSL_CTX_new := nil;
  SSL_CTX_set_timeout := nil;
  SSL_CTX_get_timeout := nil;
  SSL_CTX_get_cert_store := nil;
  SSL_want := nil;
  SSL_clear := nil;
  BIO_ssl_shutdown := nil;
  SSL_CTX_up_ref := nil; {introduced 1.1.0}
  SSL_CTX_free := nil;
  SSL_CTX_set_cert_store := nil;
  SSL_CTX_set1_cert_store := nil; {introduced 1.1.0}
  SSL_CTX_flush_sessions := nil;
  SSL_get_current_cipher := nil;
  SSL_get_pending_cipher := nil; {introduced 1.1.0}
  SSL_CIPHER_get_bits := nil;
  SSL_CIPHER_get_version := nil;
  SSL_CIPHER_get_name := nil;
  SSL_CIPHER_standard_name := nil; {introduced 1.1.0}
  OPENSSL_cipher_name := nil; {introduced 1.1.0}
  SSL_CIPHER_get_id := nil;
  SSL_CIPHER_get_protocol_id := nil; {introduced 1.1.0}
  SSL_CIPHER_get_kx_nid := nil; {introduced 1.1.0}
  SSL_CIPHER_get_auth_nid := nil; {introduced 1.1.0}
  SSL_CIPHER_get_handshake_digest := nil; {introduced 1.1.0}
  SSL_CIPHER_is_aead := nil; {introduced 1.1.0}
  SSL_get_fd := nil;
  SSL_get_rfd := nil;
  SSL_get_wfd := nil;
  SSL_get_cipher_list := nil;
  SSL_get_shared_ciphers := nil;
  SSL_get_read_ahead := nil;
  SSL_pending := nil;
  SSL_has_pending := nil; {introduced 1.1.0}
  SSL_set_fd := nil;
  SSL_set_rfd := nil;
  SSL_set_wfd := nil;
  SSL_set0_rbio := nil; {introduced 1.1.0}
  SSL_set0_wbio := nil; {introduced 1.1.0}
  SSL_set_bio := nil;
  SSL_get_rbio := nil;
  SSL_get_wbio := nil;
  SSL_set_cipher_list := nil;
  SSL_CTX_set_ciphersuites := nil; {introduced 1.1.0}
  SSL_set_ciphersuites := nil; {introduced 1.1.0}
  SSL_get_verify_mode := nil;
  SSL_get_verify_depth := nil;
  SSL_get_verify_callback := nil;
  SSL_set_read_ahead := nil;
  SSL_set_verify := nil;
  SSL_set_verify_depth := nil;
  SSL_use_RSAPrivateKey := nil;
  SSL_use_RSAPrivateKey_ASN1 := nil;
  SSL_use_PrivateKey := nil;
  SSL_use_PrivateKey_ASN1 := nil;
  SSL_use_certificate := nil;
  SSL_use_certificate_ASN1 := nil;
  SSL_CTX_use_serverinfo := nil;
  SSL_CTX_use_serverinfo_ex := nil; {introduced 1.1.0}
  SSL_CTX_use_serverinfo_file := nil;
  SSL_use_RSAPrivateKey_file := nil;
  SSL_use_PrivateKey_file := nil;
  SSL_use_certificate_file := nil;
  SSL_CTX_use_RSAPrivateKey_file := nil;
  SSL_CTX_use_PrivateKey_file := nil;
  SSL_CTX_use_certificate_file := nil;
  SSL_CTX_use_certificate_chain_file := nil;
  SSL_use_certificate_chain_file := nil; {introduced 1.1.0}
  SSL_load_client_CA_file := nil;
  SSL_add_file_cert_subjects_to_stack := nil;
  SSL_add_dir_cert_subjects_to_stack := nil;
  SSL_load_error_strings := nil; {removed 1.1.0}
  SSL_state_string := nil;
  SSL_rstate_string := nil;
  SSL_state_string_long := nil;
  SSL_rstate_string_long := nil;
  SSL_SESSION_get_time := nil;
  SSL_SESSION_set_time := nil;
  SSL_SESSION_get_timeout := nil;
  SSL_SESSION_set_timeout := nil;
  SSL_SESSION_get_protocol_version := nil; {introduced 1.1.0}
  SSL_SESSION_set_protocol_version := nil; {introduced 1.1.0}
  SSL_SESSION_get0_hostname := nil; {introduced 1.1.0}
  SSL_SESSION_set1_hostname := nil; {introduced 1.1.0}
  SSL_SESSION_get0_alpn_selected := nil; {introduced 1.1.0}
  SSL_SESSION_set1_alpn_selected := nil; {introduced 1.1.0}
  SSL_SESSION_get0_cipher := nil; {introduced 1.1.0}
  SSL_SESSION_set_cipher := nil; {introduced 1.1.0}
  SSL_SESSION_has_ticket := nil; {introduced 1.1.0}
  SSL_SESSION_get_ticket_lifetime_hint := nil; {introduced 1.1.0}
  SSL_SESSION_get0_ticket := nil; {introduced 1.1.0}
  SSL_SESSION_get_max_early_data := nil; {introduced 1.1.0}
  SSL_SESSION_set_max_early_data := nil; {introduced 1.1.0}
  SSL_copy_session_id := nil;
  SSL_SESSION_get0_peer := nil;
  SSL_SESSION_set1_id_context := nil;
  SSL_SESSION_set1_id := nil; {introduced 1.1.0}
  SSL_SESSION_is_resumable := nil; {introduced 1.1.0}
  SSL_SESSION_new := nil;
  SSL_SESSION_dup := nil; {introduced 1.1.0}
  SSL_SESSION_get_id := nil;
  SSL_SESSION_get0_id_context := nil; {introduced 1.1.0}
  SSL_SESSION_get_compress_id := nil;
  SSL_SESSION_print := nil;
  SSL_SESSION_print_keylog := nil; {introduced 1.1.0}
  SSL_SESSION_up_ref := nil; {introduced 1.1.0}
  SSL_SESSION_free := nil;
  SSL_set_session := nil;
  SSL_CTX_add_session := nil;
  SSL_CTX_remove_session := nil;
  SSL_CTX_set_generate_session_id := nil;
  SSL_set_generate_session_id := nil;
  SSL_has_matching_session_id := nil;
  d2i_SSL_SESSION := nil;
  SSL_get_peer_certificate := nil; {removed 3.0.0}
  SSL_CTX_get_verify_mode := nil;
  SSL_CTX_get_verify_depth := nil;
  SSL_CTX_get_verify_callback := nil;
  SSL_CTX_set_verify := nil;
  SSL_CTX_set_verify_depth := nil;
  SSL_CTX_set_cert_verify_callback := nil;
  SSL_CTX_set_cert_cb := nil;
  SSL_CTX_use_RSAPrivateKey := nil;
  SSL_CTX_use_RSAPrivateKey_ASN1 := nil;
  SSL_CTX_use_PrivateKey := nil;
  SSL_CTX_use_PrivateKey_ASN1 := nil;
  SSL_CTX_use_certificate := nil;
  SSL_CTX_use_certificate_ASN1 := nil;
  SSL_CTX_set_default_passwd_cb := nil; {introduced 1.1.0}
  SSL_CTX_set_default_passwd_cb_userdata := nil; {introduced 1.1.0}
  SSL_CTX_get_default_passwd_cb := nil;  {introduced 1.1.0}
  SSL_CTX_get_default_passwd_cb_userdata := nil; {introduced 1.1.0}
  SSL_set_default_passwd_cb := nil; {introduced 1.1.0}
  SSL_set_default_passwd_cb_userdata := nil; {introduced 1.1.0}
  SSL_get_default_passwd_cb := nil; {introduced 1.1.0}
  SSL_get_default_passwd_cb_userdata := nil; {introduced 1.1.0}
  SSL_CTX_check_private_key := nil;
  SSL_check_private_key := nil;
  SSL_CTX_set_session_id_context := nil;
  SSL_new := nil;
  SSL_up_ref := nil; {introduced 1.1.0}
  SSL_is_dtls := nil; {introduced 1.1.0}
  SSL_set_session_id_context := nil;
  SSL_CTX_set_purpose := nil;
  SSL_set_purpose := nil;
  SSL_CTX_set_trust := nil;
  SSL_set_trust := nil;
  SSL_set1_host := nil; {introduced 1.1.0}
  SSL_add1_host := nil; {introduced 1.1.0}
  SSL_get0_peername := nil; {introduced 1.1.0}
  SSL_set_hostflags := nil; {introduced 1.1.0}
  SSL_CTX_dane_enable := nil; {introduced 1.1.0}
  SSL_CTX_dane_mtype_set := nil; {introduced 1.1.0}
  SSL_dane_enable := nil; {introduced 1.1.0}
  SSL_dane_tlsa_add := nil; {introduced 1.1.0}
  SSL_get0_dane_authority := nil; {introduced 1.1.0}
  SSL_get0_dane_tlsa := nil; {introduced 1.1.0}
  SSL_get0_dane := nil; {introduced 1.1.0}
  SSL_CTX_dane_set_flags := nil; {introduced 1.1.0}
  SSL_CTX_dane_clear_flags := nil; {introduced 1.1.0}
  SSL_dane_set_flags := nil; {introduced 1.1.0}
  SSL_dane_clear_flags := nil; {introduced 1.1.0}
  SSL_CTX_set1_param := nil;
  SSL_set1_param := nil;
  SSL_CTX_get0_param := nil;
  SSL_get0_param := nil;
  SSL_CTX_set_srp_username := nil;
  SSL_CTX_set_srp_password := nil;
  SSL_CTX_set_srp_strength := nil;
  SSL_CTX_set_srp_client_pwd_callback := nil;
  SSL_CTX_set_srp_verify_param_callback := nil;
  SSL_CTX_set_srp_username_callback := nil;
  SSL_CTX_set_srp_cb_arg := nil;
  SSL_set_srp_server_param := nil;
  SSL_set_srp_server_param_pw := nil;
  SSL_CTX_set_client_hello_cb := nil; {introduced 1.1.0}
  SSL_client_hello_isv2 := nil; {introduced 1.1.0}
  SSL_client_hello_get0_legacy_version := nil; {introduced 1.1.0}
  SSL_client_hello_get0_random := nil; {introduced 1.1.0}
  SSL_client_hello_get0_session_id := nil; {introduced 1.1.0}
  SSL_client_hello_get0_ciphers := nil; {introduced 1.1.0}
  SSL_client_hello_get0_compression_methods := nil; {introduced 1.1.0}
  SSL_client_hello_get1_extensions_present := nil; {introduced 1.1.0}
  SSL_client_hello_get0_ext := nil; {introduced 1.1.0}
  SSL_certs_clear := nil;
  SSL_free := nil;
  SSL_waiting_for_async := nil; {introduced 1.1.0}
  SSL_get_all_async_fds := nil; {introduced 1.1.0}
  SSL_get_changed_async_fds := nil; {introduced 1.1.0}
  SSL_accept := nil;
  SSL_stateless := nil; {introduced 1.1.0}
  SSL_connect := nil;
  SSL_read := nil;
  SSL_read_ex := nil; {introduced 1.1.0}
  SSL_read_early_data := nil; {introduced 1.1.0}
  SSL_peek := nil;
  SSL_peek_ex := nil; {introduced 1.1.0}
  SSL_write := nil;
  SSL_write_ex := nil; {introduced 1.1.0}
  SSL_write_early_data := nil; {introduced 1.1.0}
  SSL_callback_ctrl := nil;
  SSL_ctrl := nil;
  SSL_CTX_ctrl := nil;
  SSL_CTX_callback_ctrl := nil;
  SSL_get_early_data_status := nil; {introduced 1.1.0}
  SSL_get_error := nil;
  SSL_get_version := nil;
  SSL_CTX_set_ssl_version := nil;
  TLS_method := nil; {introduced 1.1.0}
  TLS_server_method := nil; {introduced 1.1.0}
  TLS_client_method := nil; {introduced 1.1.0}
  SSL_key_update := nil; {introduced 1.1.0}
  SSL_get_key_update_type := nil; {introduced 1.1.0}
  SSL_renegotiate := nil;
  SSL_renegotiate_abbreviated := nil;
  SSL_shutdown := nil;
  SSL_CTX_set_post_handshake_auth := nil; {introduced 1.1.0}
  SSL_set_post_handshake_auth := nil; {introduced 1.1.0}
  SSL_renegotiate_pending := nil;
  SSL_verify_client_post_handshake := nil; {introduced 1.1.0}
  SSL_CTX_get_ssl_method := nil;
  SSL_get_ssl_method := nil;
  SSL_set_ssl_method := nil;
  SSL_alert_type_string_long := nil;
  SSL_alert_type_string := nil;
  SSL_alert_desc_string_long := nil;
  SSL_alert_desc_string := nil;
  SSL_CTX_set_client_CA_list := nil;
  SSL_add_client_CA := nil;
  SSL_CTX_add_client_CA := nil;
  SSL_set_connect_state := nil;
  SSL_set_accept_state := nil;
  SSL_library_init := nil; {removed 1.1.0}
  SSL_CIPHER_description := nil;
  SSL_dup := nil;
  SSL_get_certificate := nil;
  SSL_get_privatekey := nil;
  SSL_CTX_get0_certificate := nil;
  SSL_CTX_get0_privatekey := nil;
  SSL_CTX_set_quiet_shutdown := nil;
  SSL_CTX_get_quiet_shutdown := nil;
  SSL_set_quiet_shutdown := nil;
  SSL_get_quiet_shutdown := nil;
  SSL_set_shutdown := nil;
  SSL_get_shutdown := nil;
  SSL_version := nil;
  SSL_client_version := nil; {introduced 1.1.0}
  SSL_CTX_set_default_verify_paths := nil;
  SSL_CTX_set_default_verify_dir := nil; {introduced 1.1.0}
  SSL_CTX_set_default_verify_file := nil; {introduced 1.1.0}
  SSL_CTX_load_verify_locations := nil;
  SSL_get_session := nil;
  SSL_get1_session := nil;
  SSL_get_SSL_CTX := nil;
  SSL_set_SSL_CTX := nil;
  SSL_set_info_callback := nil;
  SSL_get_info_callback := nil;
  SSL_get_state := nil; {introduced 1.1.0}
  SSL_set_verify_result := nil;
  SSL_get_verify_result := nil;
  SSL_get_client_random := nil; {introduced 1.1.0}
  SSL_get_server_random := nil; {introduced 1.1.0}
  SSL_SESSION_get_master_key := nil; {introduced 1.1.0}
  SSL_SESSION_set1_master_key := nil; {introduced 1.1.0}
  SSL_SESSION_get_max_fragment_length := nil; {introduced 1.1.0}
  SSL_set_ex_data := nil;
  SSL_get_ex_data := nil;
  SSL_SESSION_set_ex_data := nil;
  SSL_SESSION_get_ex_data := nil;
  SSL_CTX_set_ex_data := nil;
  SSL_CTX_get_ex_data := nil;
  SSL_get_ex_data_X509_STORE_CTX_idx := nil;
  SSL_CTX_set_default_read_buffer_len := nil; {introduced 1.1.0}
  SSL_set_default_read_buffer_len := nil; {introduced 1.1.0}
  SSL_CTX_set_tmp_dh_callback := nil;
  SSL_set_tmp_dh_callback := nil;
  SSL_CIPHER_find := nil;
  SSL_CIPHER_get_cipher_nid := nil; {introduced 1.1.0}
  SSL_CIPHER_get_digest_nid := nil; {introduced 1.1.0}
  SSL_set_session_ticket_ext := nil;
  SSL_set_session_ticket_ext_cb := nil;
  SSL_CTX_set_not_resumable_session_callback := nil; {introduced 1.1.0}
  SSL_set_not_resumable_session_callback := nil; {introduced 1.1.0}
  SSL_CTX_set_record_padding_callback := nil; {introduced 1.1.0}
  SSL_CTX_set_record_padding_callback_arg := nil; {introduced 1.1.0}
  SSL_CTX_get_record_padding_callback_arg := nil; {introduced 1.1.0}
  SSL_CTX_set_block_padding := nil; {introduced 1.1.0}
  SSL_set_record_padding_callback := nil; {introduced 1.1.0}
  SSL_set_record_padding_callback_arg := nil; {introduced 1.1.0}
  SSL_get_record_padding_callback_arg := nil; {introduced 1.1.0}
  SSL_set_block_padding := nil; {introduced 1.1.0}
  SSL_set_num_tickets := nil; {introduced 1.1.0}
  SSL_get_num_tickets := nil; {introduced 1.1.0}
  SSL_CTX_set_num_tickets := nil; {introduced 1.1.0}
  SSL_CTX_get_num_tickets := nil; {introduced 1.1.0}
  SSL_session_reused := nil; {introduced 1.1.0}
  SSL_is_server := nil;
  SSL_CONF_CTX_new := nil;
  SSL_CONF_CTX_finish := nil;
  SSL_CONF_CTX_free := nil;
  SSL_CONF_CTX_set_flags := nil;
  SSL_CONF_CTX_clear_flags := nil;
  SSL_CONF_CTX_set1_prefix := nil;
  SSL_CONF_cmd := nil;
  SSL_CONF_cmd_argv := nil;
  SSL_CONF_cmd_value_type := nil;
  SSL_CONF_CTX_set_ssl := nil;
  SSL_CONF_CTX_set_ssl_ctx := nil;
  SSL_add_ssl_module := nil; {introduced 1.1.0}
  SSL_config := nil; {introduced 1.1.0}
  SSL_CTX_config := nil; {introduced 1.1.0}
  DTLSv1_listen := nil; {introduced 1.1.0}
  SSL_enable_ct := nil; {introduced 1.1.0}
  SSL_CTX_enable_ct := nil; {introduced 1.1.0}
  SSL_ct_is_enabled := nil; {introduced 1.1.0}
  SSL_CTX_ct_is_enabled := nil; {introduced 1.1.0}
  SSL_CTX_set_default_ctlog_list_file := nil; {introduced 1.1.0}
  SSL_CTX_set_ctlog_list_file := nil; {introduced 1.1.0}
  SSL_CTX_set0_ctlog_store := nil; {introduced 1.1.0}
  SSL_set_security_level := nil; {introduced 1.1.0}
  SSL_set_security_callback := nil; {introduced 1.1.0}
  SSL_get_security_callback := nil; {introduced 1.1.0}
  SSL_set0_security_ex_data := nil; {introduced 1.1.0}
  SSL_get0_security_ex_data := nil; {introduced 1.1.0}
  SSL_CTX_set_security_level := nil; {introduced 1.1.0}
  SSL_CTX_get_security_level := nil; {introduced 1.1.0}
  SSL_CTX_get0_security_ex_data := nil; {introduced 1.1.0}
  SSL_CTX_set0_security_ex_data := nil; {introduced 1.1.0}
  OPENSSL_init_ssl := nil; {introduced 1.1.0}
  SSL_free_buffers := nil; {introduced 1.1.0}
  SSL_alloc_buffers := nil; {introduced 1.1.0}
  SSL_CTX_set_session_ticket_cb := nil; {introduced 1.1.0}
  SSL_SESSION_set1_ticket_appdata := nil; {introduced 1.1.0}
  SSL_SESSION_get0_ticket_appdata := nil; {introduced 1.1.0}
  DTLS_set_timer_cb := nil; {introduced 1.1.0}
  SSL_CTX_set_allow_early_data_cb := nil; {introduced 1.1.0}
  SSL_set_allow_early_data_cb := nil; {introduced 1.1.0}
  SSLv2_method := nil; {removed 1.1.0 allow_nil} // SSLv2
  SSLv2_server_method := nil; {removed 1.1.0 allow_nil} // SSLv2
  SSLv2_client_method := nil; {removed 1.1.0 allow_nil} // SSLv2
  SSLv3_method := nil; {removed 1.1.0 allow_nil} // SSLv3
  SSLv3_server_method := nil; {removed 1.1.0 allow_nil} // SSLv3
  SSLv3_client_method := nil; {removed 1.1.0 allow_nil} // SSLv3
  SSLv23_method := nil; {removed 1.1.0 allow_nil} // SSLv3 but can rollback to v2
  SSLv23_server_method := nil; {removed 1.1.0 allow_nil} // SSLv3 but can rollback to v2
  SSLv23_client_method := nil; {removed 1.1.0 allow_nil} // SSLv3 but can rollback to v2
  TLSv1_method := nil; {removed 1.1.0 allow_nil} // TLSv1.0
  TLSv1_server_method := nil; {removed 1.1.0 allow_nil} // TLSv1.0
  TLSv1_client_method := nil; {removed 1.1.0 allow_nil} // TLSv1.0
  TLSv1_1_method := nil; {removed 1.1.0 allow_nil} //TLS1.1
  TLSv1_1_server_method := nil; {removed 1.1.0 allow_nil} //TLS1.1
  TLSv1_1_client_method := nil; {removed 1.1.0 allow_nil} //TLS1.1
  TLSv1_2_method := nil; {removed 1.1.0 allow_nil}		// TLSv1.2
  TLSv1_2_server_method := nil; {removed 1.1.0 allow_nil}	// TLSv1.2 
  TLSv1_2_client_method := nil; {removed 1.1.0 allow_nil}	// TLSv1.2
  SSL_get0_peer_certificate := nil; {introduced 3.3.0}
  SSL_get1_peer_certificate := nil; {introduced 3.3.0}
end;
{$ELSE}
function SSL_get_peer_certificate(const s: PSSL): PX509;
begin
  Result := SSL_get1_peer_certificate(s);
end;


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
function SSL_CTX_set_tmp_dh(ctx: PSSL_CTX; dh: PDH): TIdC_LONG;
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
function SSL_set_tmp_dh(ssl: PSSL; dh: PDH): TIdC_LONG;
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
function SSL_CTX_add0_chain_cert(ctx: PSSL_CTX; x509: PX509): TIdC_LONG;
begin
  Result := SSL_CTX_ctrl(ctx, SSL_CTRL_CHAIN_CERT, 0, x509);
end;

//# define SSL_CTX_add1_chain_cert(ctx,x509)                 SSL_CTX_ctrl(ctx,SSL_CTRL_CHAIN_CERT,1,(char *)(x509))
function SSL_CTX_add1_chain_cert(ctx: PSSL_CTX; x509: PX509): TIdC_LONG;
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


function SSL_get_app_data(const ssl: PSSL): Pointer ;
begin
  Result := SSL_get_ex_data(ssl,0);
end;

procedure SSL_load_error_strings; 
begin
  OPENSSL_init_ssl(OPENSSL_INIT_LOAD_SSL_STRINGS or OPENSSL_INIT_LOAD_CRYPTO_STRINGS,nil); 
end;

function SSL_library_init: TIdC_INT;
begin
  Result := OPENSSL_init_ssl(0, nil);
end;

function SSLeay_add_ssl_algorithms: TIdC_INT;
begin
  Result := SSL_library_init;
end;

function SSL_set_app_data(ssl: PSSL; data: Pointer): TIdC_INT;
begin
  Result := SSL_set_ex_data(ssl,0,data);
end;


{$ENDIF}

{$IFNDEF USE_EXTERNAL_LIBRARY}
initialization
  Register_SSLLoader(@Load,'LibSSL');
  Register_SSLUnloader(@Unload);
{$ENDIF}
end.
