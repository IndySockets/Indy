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

unit IdOpenSSLHeaders_x509v3;

interface

// Headers for OpenSSL 1.1.1
// x509v3.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_asn1,
  IdOpenSSLHeaders_asn1t,
  IdOpenSSLHeaders_x509;

const
  (* ext_flags values *)
  X509V3_EXT_DYNAMIC      = $1;
  X509V3_EXT_CTX_DEP      = $2;
  X509V3_EXT_MULTILINE    = $4;

  // v3_ext_ctx
  CTX_TEST = $1;
  X509V3_CTX_REPLACE = $2;

  // GENERAL_NAME_st
  GEN_OTHERNAME   = 0;
  GEN_EMAIL       = 1;
  GEN_DNS         = 2;
  GEN_X400        = 3;
  GEN_DIRNAME     = 4;
  GEN_EDIPARTY    = 5;
  GEN_URI         = 6;
  GEN_IPADD       = 7;
  GEN_RID         = 8;

  (* All existing reasons *)
  CRLDP_ALL_REASONS       = $807f;

  CRL_REASON_NONE                         = -1;
  CRL_REASON_UNSPECIFIED                  = 0;
  CRL_REASON_KEY_COMPROMISE               = 1;
  CRL_REASON_CA_COMPROMISE                = 2;
  CRL_REASON_AFFILIATION_CHANGED          = 3;
  CRL_REASON_SUPERSEDED                   = 4;
  CRL_REASON_CESSATION_OF_OPERATION       = 5;
  CRL_REASON_CERTIFICATE_HOLD             = 6;
  CRL_REASON_REMOVE_FROM_CRL              = 8;
  CRL_REASON_PRIVILEGE_WITHDRAWN          = 9;
  CRL_REASON_AA_COMPROMISE                = 10;

  (* Values in idp_flags field *)
  (* IDP present *)
  IDP_PRESENT     = $1;
  (* IDP values inconsistent *)
  IDP_INVALID     = $2;
  (* onlyuser true *)
  IDP_ONLYUSER    = $4;
  (* onlyCA true *)
  IDP_ONLYCA      = $8;
  (* onlyattr true *)
  IDP_ONLYATTR    = $10;
  (* indirectCRL true *)
  IDP_INDIRECT    = $20;
  (* onlysomereasons present *)
  IDP_REASONS     = $40;

  EXT_END: array[0..13] of TIdC_INT = (-1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);

  (* X509_PURPOSE stuff *)

  EXFLAG_BCONS            = $1;
  EXFLAG_KUSAGE           = $2;
  EXFLAG_XKUSAGE          = $4;
  EXFLAG_NSCERT           = $8;

  EXFLAG_CA               = $10;
  (* Really self issued not necessarily self signed *)
  EXFLAG_SI               = $20;
  EXFLAG_V1               = $40;
  EXFLAG_INVALID          = $80;
  (* EXFLAG_SET is set to indicate that some values have been precomputed *)
  EXFLAG_SET              = $100;
  EXFLAG_CRITICAL         = $200;
  EXFLAG_PROXY            = $400;

  EXFLAG_INVALID_POLICY   = $800;
  EXFLAG_FRESHEST         = $1000;
  (* Self signed *)
  EXFLAG_SS               = $2000;

  KU_DIGITAL_SIGNATURE    = $0080;
  KU_NON_REPUDIATION      = $0040;
  KU_KEY_ENCIPHERMENT     = $0020;
  KU_DATA_ENCIPHERMENT    = $0010;
  KU_KEY_AGREEMENT        = $0008;
  KU_KEY_CERT_SIGN        = $0004;
  KU_CRL_SIGN             = $0002;
  KU_ENCIPHER_ONLY        = $0001;
  KU_DECIPHER_ONLY        = $8000;

  NS_SSL_CLIENT           = $80;
  NS_SSL_SERVER           = $40;
  NS_SMIME                = $20;
  NS_OBJSIGN              = $10;
  NS_SSL_CA               = $04;
  NS_SMIME_CA             = $02;
  NS_OBJSIGN_CA           = $01;
  NS_ANY_CA               = NS_SSL_CA or NS_SMIME_CA or NS_OBJSIGN_CA;

  XKU_SSL_SERVER          = $1;
  XKU_SSL_CLIENT          = $2;
  XKU_SMIME               = $4;
  XKU_CODE_SIGN           = $8;
  XKU_SGC                 = $10;
  XKU_OCSP_SIGN           = $20;
  XKU_TIMESTAMP           = $40;
  XKU_DVCS                = $80;
  XKU_ANYEKU              = $100;

  X509_PURPOSE_DYNAMIC    = $1;
  X509_PURPOSE_DYNAMIC_NAME       = $2;

  X509_PURPOSE_SSL_CLIENT         = 1;
  X509_PURPOSE_SSL_SERVER         = 2;
  X509_PURPOSE_NS_SSL_SERVER      = 3;
  X509_PURPOSE_SMIME_SIGN         = 4;
  X509_PURPOSE_SMIME_ENCRYPT      = 5;
  X509_PURPOSE_CRL_SIGN           = 6;
  X509_PURPOSE_ANY                = 7;
  X509_PURPOSE_OCSP_HELPER        = 8;
  X509_PURPOSE_TIMESTAMP_SIGN     = 9;

  X509_PURPOSE_MIN                = 1;
  X509_PURPOSE_MAX                = 9;

  (* Flags for X509V3_EXT_print() *)

  X509V3_EXT_UNKNOWN_MASK         = TIdC_LONG($f) shl 16;
  (* Return error for unknown extensions *)
  X509V3_EXT_DEFAULT              = 0;
  (* Print error for unknown extensions *)
  X509V3_EXT_ERROR_UNKNOWN        = TIdC_LONG(1) shl 16;
  (* ASN1 parse unknown extensions *)
  X509V3_EXT_PARSE_UNKNOWN        = TIdC_LONG(2) shl 16;
  (* BIO_dump unknown extensions *)
  X509V3_EXT_DUMP_UNKNOWN         = TIdC_LONG(3) shl 16;

  (* Flags for X509V3_add1_i2d *)

  X509V3_ADD_OP_MASK              = TIdC_LONG($f);
  X509V3_ADD_DEFAULT              = TIdC_LONG(0);
  X509V3_ADD_APPEND               = TIdC_LONG(1);
  X509V3_ADD_REPLACE              = TIdC_LONG(2);
  X509V3_ADD_REPLACE_EXISTING     = TIdC_LONG(3);
  X509V3_ADD_KEEP_EXISTING        = TIdC_LONG(4);
  X509V3_ADD_DELETE               = TIdC_LONG(5);
  X509V3_ADD_SILENT               = $10;

  (* Flags for X509_check_* functions *)

  (*
   * Always check subject name for host match even if subject alt names present
   *)
  X509_CHECK_FLAG_ALWAYS_CHECK_SUBJECT    = $1;
  (* Disable wildcard matching for dnsName fields and common name. *)
  X509_CHECK_FLAG_NO_WILDCARDS    = $2;
  (* Wildcards must not match a partial label. *)
  X509_CHECK_FLAG_NO_PARTIAL_WILDCARDS = $4;
  (* Allow (non-partial) wildcards to match multiple labels. *)
  X509_CHECK_FLAG_MULTI_LABEL_WILDCARDS = $8;
  (* Constraint verifier subdomain patterns to match a single labels. *)
  X509_CHECK_FLAG_SINGLE_LABEL_SUBDOMAINS = $10;
  (* Never check the subject CN *)
  X509_CHECK_FLAG_NEVER_CHECK_SUBJECT    = $20;
  (*
   * Match reference identifiers starting with "." to any sub-domain.
   * This is a non-public flag, turned on implicitly when the subject
   * reference identity is a DNS name.
   *)
  _X509_CHECK_FLAG_DOT_SUBDOMAINS = $8000;

  ASIdOrRange_id          = 0;
  ASIdOrRange_range       = 1;

  ASIdentifierChoice_inherit              = 0;
  ASIdentifierChoice_asIdsOrRanges        = 1;

  IPAddressOrRange_addressPrefix  = 0;
  IPAddressOrRange_addressRange   = 1;

  IPAddressChoice_inherit                 = 0;
  IPAddressChoice_addressesOrRanges       = 1;

  (*
   * API tag for elements of the ASIdentifer SEQUENCE.
   *)
  V3_ASID_ASNUM   = 0;
  V3_ASID_RDI     = 1;

  (*
   * AFI values, assigned by IANA.  It'd be nice to make the AFI
   * handling code totally generic, but there are too many little things
   * that would need to be defined for other address families for it to
   * be worth the trouble.
   *)
  IANA_AFI_IPV4   = 1;
  IANA_AFI_IPV6   = 2;

type
  (* Forward reference *)
  //Pv3_ext_method = ^v3_ext_method;
  //Pv3_ext_ctx = ^v3_ext_ctx;

  (* Useful typedefs *)

  //X509V3_EXT_NEW = function: Pointer; cdecl;
  //X509V3_EXT_FREE = procedure(v1: Pointer); cdecl;
  //X509V3_EXT_D2I = function(v1: Pointer; v2: PPByte; v3: TIdC_Long): Pointer; cdecl;
  //X509V3_EXT_I2D = function(v1: Pointer; v2: PPByte): TIdC_INT; cdecl;
//  typedef STACK_OF(CONF_VALUE) *
//      (*X509V3_EXT_I2V) (const struct v3_ext_method *method, void *ext,
//                         STACK_OF(CONF_VALUE) *extlist);
//  typedef void *(*X509V3_EXT_V2I)(const struct v3_ext_method *method,
//                                  struct v3_ext_ctx *ctx,
//                                  STACK_OF(CONF_VALUE) *values);
  //X509V3_EXT_I2S = function(method: Pv3_ext_method; ext: Pointer): PIdAnsiChar; cdecl;
  //X509V3_EXT_S2I = function(method: Pv3_ext_method; ctx: Pv3_ext_ctx; const str: PIdAnsiChar): Pointer; cdecl;
  //X509V3_EXT_I2R = function(const method: Pv3_ext_method; ext: Pointer; out_: PBIO; indent: TIdC_INT): TIdC_INT; cdecl;
  //X509V3_EXT_R2I = function(const method: Pv3_ext_method; ctx: Pv3_ext_ctx; const str: PIdAnsiChar): Pointer; cdecl;

//  (* V3 extension structure *)
//  v3_ext_method = record
//    ext_nid: TIdC_INT;
//    ext_flags: TIdC_INT;
//(* If this is set the following four fields are ignored *)
//    it: PASN1_ITEM_EXP;
//(* Old style ASN1 calls *)
//    ext_new: X509V3_EXT_NEW;
//    ext_free: X509V3_EXT_FREE;
//    d2i: X509V3_EXT_D2I;
//    i2d: X509V3_EXT_I2D;
//(* The following pair is used for string extensions *)
//    i2s: X509V3_EXT_I2S;
//    s2i: X509V3_EXT_S2I;
//(* The following pair is used for multi-valued extensions *)
//    i2v: X509V3_EXT_I2V;
//    v2i: X509V3_EXT_V2I;
//(* The following are used for raw extensions *)
//    i2r: X509V3_EXT_I2R;
//    r2i: X509V3_EXT_R2I;
//    usr_data: Pointer;             (* Any extension specific data *)
//  end;
//  X509V3_EXT_METHOD = v3_ext_method;
//  PX509V3_EXT_METHOD = ^X509V3_EXT_METHOD;
//  DEFINE_STACK_OF(X509V3_EXT_METHOD)

//  typedef struct X509V3_CONF_METHOD_st {
//      PIdAnsiChar *(*get_string) (void *db, const section: PIdAnsiChar, const value: PIdAnsiChar);
//      STACK_OF(CONF_VALUE) *(*get_section) (void *db, const section: PIdAnsiChar);
//      void (*free_string) (void *db, PIdAnsiChar *string);
//      void (*free_section) (void *db, STACK_OF(CONF_VALUE) *section);
//  } X509V3_CONF_METHOD;

// Moved to ossl_typ
//  (* Context specific info *)
//  v3_ext_ctx = record
//    flags: TIdC_INT;
//    issuer_cert: PX509;
//    subject_cert: PX509;
//    subject_req: PX509_REQ;
//    crl: PX509_CRL;
//    db_meth: PX509V3_CONF_METHOD;
//    db: Pointer;
//  (* Maybe more here *)
//  end;

  ENUMERATED_NAMES = BIT_STRING_BITNAME;

  BASIC_CONSTRAINTS_st = record
    ca: TIdC_INT;
    pathlen: PASN1_INTEGER;
  end;
  BASIC_CONSTRAINTS = BASIC_CONSTRAINTS_st;
  PBASIC_CONSTRAINTS = ^BASIC_CONSTRAINTS;

  PKEY_USAGE_PERIOD_st = record
    notBefore: PASN1_GENERALIZEDTIME;
    notAfter: PASN1_GENERALIZEDTIME;
  end;
  PKEY_USAGE_PERIOD = PKEY_USAGE_PERIOD_st;
  PPKEY_USAGE_PERIOD = ^PKEY_USAGE_PERIOD;

  otherName_st = record
    type_id: PASN1_OBJECT;
    value: PASN1_TYPE;
  end;
  OTHERNAME = otherName_st;
  POTHERNAME = ^OTHERNAME;

  EDIPartyName_st  = record
    nameAssigner: PASN1_STRING;
    partyName: PASN1_STRING;
  end;
  EDIPARTYNAME = EDIPartyName_st;
  PEDIPARTYNAME = ^EDIPARTYNAME;

  GENERAL_NAME_st_union = record
    case TIdC_INT of
      0: (ptr: PIdAnsiChar);
      1: (otherName: POTHERNAME);   (* otherName *)
      2: (rfc822Name: PASN1_IA5STRING);
      3: (dNSName: PASN1_IA5STRING);
      4: (x400Address: PASN1_TYPE);
      5: (directoryName: PX509_NAME);
      6: (ediPartyName: PEDIPARTYNAME);
      7: (uniformResourceIdentifier: PASN1_IA5STRING);
      8: (iPAddress: PASN1_OCTET_STRING);
      9: (registeredID: PASN1_OBJECT);
      (* Old names *)
      10: (ip: PASN1_OCTET_STRING);  (* iPAddress *)
      11: (dirn: PX509_NAME);        (* dirn *)
      12: (ia5: PASN1_IA5STRING);    (* rfc822Name, dNSName,
                                      * uniformResourceIdentifier *)
      13: (rid: PASN1_OBJECT);       (* registeredID *)
      14: (other: PASN1_TYPE);       (* x400Address *)
  end;
  GENERAL_NAME_st = record
    type_: TIdC_INT;
    d: GENERAL_NAME_st_union;
  end;
  GENERAL_NAME = GENERAL_NAME_st;
  PGENERAL_NAME = ^GENERAL_NAME;

  ACCESS_DESCRIPTION_st = record
    method: PASN1_OBJECT;
    location: PGENERAL_NAME;
  end;
  ACCESS_DESCRIPTION = ACCESS_DESCRIPTION_st;
  PACCESS_DESCRIPTION = ^ACCESS_DESCRIPTION;

//  typedef STACK_OF(ACCESS_DESCRIPTION) AUTHORITY_INFO_ACCESS;

//  typedef STACK_OF(ASN1_OBJECT) EXTENDED_KEY_USAGE;

//  typedef STACK_OF(ASN1_INTEGER) TLS_FEATURE;

//  DEFINE_STACK_OF(GENERAL_NAME)
//  typedef STACK_OF(GENERAL_NAME) GENERAL_NAMES;
//  DEFINE_STACK_OF(GENERAL_NAMES)

//  DEFINE_STACK_OF(ACCESS_DESCRIPTION)
//  DIST_POINT_NAME_st_union = record
//    case TIdC_INT of
//      0: (GENERAL_NAMES *fullname);
//      1: (STACK_OF(X509_NAME_ENTRY) *relativename);
//  end;
  DIST_POINT_NAME_st = record
    type_: TIdC_INT;
    (* If relativename then this contains the full distribution point name *)
    dpname: PX509_NAME;
  end;
  DIST_POINT_NAME = DIST_POINT_NAME_st;
  PDIST_POINT_NAME = ^DIST_POINT_NAME;


//  struct DIST_POINT_ST {
//      DIST_POINT_NAME *distpoint;
//      ASN1_BIT_STRING *reasons;
//      GENERAL_NAMES *CRLissuer;
//      TIdC_INT dp_reasons;
//  };

//  typedef STACK_OF(DIST_POINT) CRL_DIST_POINTS;

//  DEFINE_STACK_OF(DIST_POINT)

//  AUTHORITY_KEYID_st = record
//    keyid: PASN1_OCTET_STRING;
//    issuer: PGENERAL_NAMES;
//    serial: PASN1_INTEGER;
//  end;

  (* Strong extranet structures *)

  SXNET_ID_st = record
    zone: PASN1_INTEGER;
    user: PASN1_OCTET_STRING;
  end;
  SXNETID = SXNET_ID_st;
  PSXNETID = ^SXNETID;
//  DEFINE_STACK_OF(SXNETID)

//  SXNET_st = record
//    ASN1_INTEGER *version;
//    STACK_OF(SXNETID) *ids;
//  end;
//  SXNET = SXNET_st;
//  PSXNET = ^SXNET;

//  NOTICEREF_st = record
//    ASN1_STRING *organization;
//    STACK_OF(ASN1_INTEGER) *noticenos;
//  end;
//  NOTICEREF = NOTICEREF_st;
//  PNOTICEREF = ^NOTICEREF;

//  USERNOTICE_st = record
//    noticeref: PNOTICEREF;
//    exptext: PASN1_STRING;
//  end;
//  USERNOTICE = USERNOTICE_st;
//  PUSERNOTICE = ^USERNOTICE;

//  POLICYQUALINFO_st_union = record
//    case TIdC_INT of
//      0: (cpsuri: PASN1_IA5STRING);
//      1: (usernotice: PUSERNOTICE);
//      2: (other: PASN1_TYPE);
//  end;
//  POLICYQUALINFO_st = record
//    pqualid: PASN1_OBJECT;
//    d: POLICYQUALINFO_st_union;
//  end;
//  POLICYQUALINFO = POLICYQUALINFO_st;
//  PPOLICYQUALINFO = ^POLICYQUALINFO;
//  DEFINE_STACK_OF(POLICYQUALINFO)

//  POLICYINFO_st = record
//    ASN1_OBJECT *policyid;
//    STACK_OF(POLICYQUALINFO) *qualifiers;
//  end;
//  POLICYINFO = POLICYINFO_st;
//  PPOLICYINFO = ^POLICYINFO;
//  typedef STACK_OF(POLICYINFO) CERTIFICATEPOLICIES;
//  DEFINE_STACK_OF(POLICYINFO)

  POLICY_MAPPING_st = record
    issuerDomainPolicy: PASN1_OBJECT;
    subjectDomainPolicy: PASN1_OBJECT;
  end;
  POLICY_MAPPING = POLICY_MAPPING_st;
  PPOLICY_MAPPING = ^POLICY_MAPPING;
//  DEFINE_STACK_OF(POLICY_MAPPING)
//  typedef STACK_OF(POLICY_MAPPING) POLICY_MAPPINGS;

  GENERAL_SUBTREE_st = record
    base: PGENERAL_NAME;
    minimum: PASN1_INTEGER;
    maximum: PASN1_INTEGER;
  end;
  GENERAL_SUBTREE = GENERAL_SUBTREE_st;
  PGENERAL_SUBTREE = ^GENERAL_SUBTREE;
//  DEFINE_STACK_OF(GENERAL_SUBTREE)

//  NAME_CONSTRAINTS_st = record
//    STACK_OF(GENERAL_SUBTREE) *permittedSubtrees;
//    STACK_OF(GENERAL_SUBTREE) *excludedSubtrees;
//  end;

  POLICY_CONSTRAINTS_st = record
    requireExplicitPolicy: PASN1_INTEGER;
    inhibitPolicyMapping: PASN1_INTEGER;
  end;
  POLICY_CONSTRAINTS = POLICY_CONSTRAINTS_st;
  PPOLICY_CONSTRAINTS = ^POLICY_CONSTRAINTS;

  (* Proxy certificate structures, see RFC 3820 *)
  PROXY_POLICY_st = record
    policyLanguage: PASN1_OBJECT;
    policy: PASN1_OCTET_STRING;
  end;
  PROXY_POLICY = PROXY_POLICY_st;
  PPROXY_POLICY = ^PROXY_POLICY;
//  DECLARE_ASN1_FUNCTIONS(PROXY_POLICY)

  PROXY_CERT_INFO_EXTENSION_st = record
    pcPathLengthConstraint: PASN1_INTEGER;
    proxyPolicy: PPROXY_POLICY;
  end;
  PROXY_CERT_INFO_EXTENSION = PROXY_CERT_INFO_EXTENSION_st;
  PPROXY_CERT_INFO_EXTENSION = ^PROXY_CERT_INFO_EXTENSION;
//  DECLARE_ASN1_FUNCTIONS(PROXY_CERT_INFO_EXTENSION)

//  ISSUING_DIST_POint_st = record
//    distpoint: PDIST_POINT_NAME;
//    TIdC_INT onlyuser;
//    TIdC_INT onlyCA;
//    onlysomereasons: PASN1_BIT_STRING;
//    TIdC_INT indirectCRL;
//    TIdC_INT onlyattr;
//  end;

//  # define X509V3_conf_err(val) ERR_add_error_data(6, \
//                          "section:", (val)->section, \
//                          ",name:", (val)->name, ",value:", (val)->value)
//
//  # define X509V3_set_ctx_test(ctx) \
//                          X509V3_set_ctx(ctx, NULL, NULL, NULL, NULL, CTX_TEST)
//  # define X509V3_set_ctx_nodb(ctx) (ctx)->db = NULL;
//
//  # define EXT_BITSTRING(nid, table) { nid, 0, ASN1_ITEM_ref(ASN1_BIT_STRING), \
//                          0,0,0,0, \
//                          0,0, \
//                          (X509V3_EXT_I2V)i2v_ASN1_BIT_STRING, \
//                          (X509V3_EXT_V2I)v2i_ASN1_BIT_STRING, \
//                          NULL, NULL, \
//                          table}
//
//  # define EXT_IA5STRING(nid) { nid, 0, ASN1_ITEM_ref(ASN1_IA5STRING), \
//                          0,0,0,0, \
//                          (X509V3_EXT_I2S)i2s_ASN1_IA5STRING, \
//                          (X509V3_EXT_S2I)s2i_ASN1_IA5STRING, \
//                          0,0,0,0, \
//                          NULL}
                         
  PX509_PURPOSE = ^X509_PURPOSE;
  x509_purpose_st = record
    purpose: TIdC_INT;
    trust: TIdC_INT;                  (* Default trust ID *)
    flags: TIdC_INT;
    check_purpose: function(const v1: PX509_PURPOSE; const v2: PX509; v3: TIdC_INT): TIdC_INT; cdecl;
    name: PIdAnsiChar;
    sname: PIdAnsiChar;
    usr_data: Pointer;
  end;
  X509_PURPOSE = x509_purpose_st;
//  DEFINE_STACK_OF(X509_PURPOSE)

//  DECLARE_ASN1_FUNCTIONS(BASIC_CONSTRAINTS_st)

//  DECLARE_ASN1_FUNCTIONS(SXNET)
//  DECLARE_ASN1_FUNCTIONS(SXNETID)

  ASRange_st = record
    min, max: PASN1_INTEGER;
  end;
  ASRange = ASRange_st;
  PASRange = ^ASRange;

  ASIdOrRange_st = record
    type_: TIdC_INT;
    case u: TIdC_INT of
      0: (id: PASN1_INTEGER);
      1: (range: PASRange);
  end;
  ASIdOrRange = ASIdOrRange_st;
  PASIdOrRange = ^ASIdOrRange;
//  typedef STACK_OF(ASIdOrRange) ASIdOrRanges;
//  DEFINE_STACK_OF(ASIdOrRange)

//  ASIdentifierChoice_st = record
//    type_: TIdC_INT;
//    case u: TIdC_INT of
//      0: (inherit: PASN1_NULL);
//      1: (asIdsOrRanges: PASIdOrRanges);
//  end;
//  ASIdentifierChoice = ASIdentifierChoice_st;
//  PASIdentifierChoice = ^ASIdentifierChoice;

//  ASIdentifiers_st = record
//    asnum, rdi: PASIdentifierChoice;
//  end;
//  ASIdentifiers = ASIdentifiers_st;
//  PASIdentifiers = ^ASIdentifiers;

//  DECLARE_ASN1_FUNCTIONS(ASRange)
//  DECLARE_ASN1_FUNCTIONS(ASIdOrRange)
//  DECLARE_ASN1_FUNCTIONS(ASIdentifierChoice)
//  DECLARE_ASN1_FUNCTIONS(ASIdentifiers)

  IPAddressRange_st = record
    min, max: PASN1_BIT_STRING;
  end;
  IPAddressRange = IPAddressRange_st;
  PIPAddressRange = ^IPAddressRange;

  IPAddressOrRange_st = record
    type_: TIdC_INT;
    case u: TIdC_INT of
      0: (addressPrefix: PASN1_BIT_STRING);
      1: (addressRange: PIPAddressRange);
  end;
  IPAddressOrRange = IPAddressOrRange_st;
  PIPAddressOrRange = ^IPAddressOrRange;

//  typedef STACK_OF(IPAddressOrRange) IPAddressOrRanges;
//  DEFINE_STACK_OF(IPAddressOrRange)

//  IPAddressChoice_st = record
//    type_: TIdC_INT;
//    case u: TIdC_INT of
//      0: (inherit: PASN1_NULL);
//      1: (addressesOrRanges: PIPAddressOrRanges);
//  end;
//  IPAddressChoice = IPAddressChoice_st;
//  PIPAddressChoice = ^IPAddressChoice;

//  IPAddressFamily_st = record
//    addressFamily: PASN1_OCTET_STRING;
//    ipAddressChoice: PIPAddressChoice;
//  end;
//  IPAddressFamily = IPAddressFamily_st;
//  PIPAddressFamily = ^IPAddressFamily;

//  typedef STACK_OF(IPAddressFamily) IPAddrBlocks;
//  DEFINE_STACK_OF(IPAddressFamily)

//  DECLARE_ASN1_FUNCTIONS(IPAddressRange)
//  DECLARE_ASN1_FUNCTIONS(IPAddressOrRange)
//  DECLARE_ASN1_FUNCTIONS(IPAddressChoice)
//  DECLARE_ASN1_FUNCTIONS(IPAddressFamily)

  NamingAuthority_st = type Pointer;
  NAMING_AUTHORITY = NamingAuthority_st;
  PNAMING_AUTHORITY = ^NAMING_AUTHORITY;
  
  ProfessionInfo_st = type Pointer;
  PROFESSION_INFO = ProfessionInfo_st;
  PPROFESSION_INFO = ^PROFESSION_INFO;
  
  Admissions_st = type Pointer;
  ADMISSIONS = Admissions_st;
  PADMISSIONS = ^ADMISSIONS;
  
  AdmissionSyntax_st = type Pointer;
  ADMISSION_SYNTAX = AdmissionSyntax_st;
  PADMISSION_SYNTAX = ^ADMISSION_SYNTAX;
//  DECLARE_ASN1_FUNCTIONS(NAMING_AUTHORITY)
//  DECLARE_ASN1_FUNCTIONS(PROFESSION_INFO)
//  DECLARE_ASN1_FUNCTIONS(ADMISSIONS)
//  DECLARE_ASN1_FUNCTIONS(ADMISSION_SYNTAX)
//  DEFINE_STACK_OF(ADMISSIONS)
//  DEFINE_STACK_OF(PROFESSION_INFO)
//  typedef STACK_OF(PROFESSION_INFO) PROFESSION_INFOS;

var
//  function SXNET_add_id_asc(psx: PPSXNET; const zone: PIdAnsiChar; const user: PIdAnsiChar; userlen: TIdC_INT): TIdC_INT;
//  function SXNET_add_id_ulong(psx: PPSXNET; lzone: TIdC_ULONG; const user: PIdAnsiChar; userlen: TIdC_INT): TIdC_INT;
//  function SXNET_add_id_INTEGER(psx: PPSXNET; izone: PASN1_INTEGER; const user: PIdAnsiChar; userlen: TIdC_INT): TIdC_INT;

//  function SXNET_get_id_asc(sx: PSXNET; const zone: PIdAnsiChar): PASN1_OCTET_STRING;
//  function SXNET_get_id_ulong(sx: PSXNET; lzone: TIdC_ULONG): PASN1_OCTET_STRING;
//  function SXNET_get_id_INTEGER(sx: PSXNET; zone: PASN1_INTEGER): PASN1_OCTET_STRING;

//  DECLARE_ASN1_FUNCTIONS(AUTHORITY_KEYID)

//  DECLARE_ASN1_FUNCTIONS(PKEY_USAGE_PERIOD)

//  DECLARE_ASN1_FUNCTIONS(GENERAL_NAME)
//  GENERAL_NAME *GENERAL_NAME_dup(a: PGENERAL_NAME);
  function GENERAL_NAME_cmp(a: PGENERAL_NAME; b: PGENERAL_NAME): TIdC_INT;

//  ASN1_BIT_STRING *v2i_ASN1_BIT_STRING(method: PX509V3_EXT_METHOD; ctx: PX509V3_CTX; STACK_OF(CONF_VALUE) *nval);
//  STACK_OF(CONF_VALUE) *i2v_ASN1_BIT_STRING(method: PX509V3_EXT_METHOD; ASN1_BIT_STRING *bits; STACK_OF(CONF_VALUE) *extlist);
  //function i2s_ASN1_IA5STRING(method: PX509V3_EXT_METHOD; ia5: PASN1_IA5STRING): PIdAnsiChar;
  //function s2i_ASN1_IA5STRING(method: PX509V3_EXT_METHOD; ctx: PX509V3_CTX; const str: PIdAnsiChar): PASN1_IA5STRING;

//  STACK_OF(CONF_VALUE) *i2v_GENERAL_NAME(method: PX509V3_EXT_METHOD; gen: PGENERAL_NAME; STACK_OF(CONF_VALUE) *ret);
  function GENERAL_NAME_print(out_: PBIO; gen: PGENERAL_NAME): TIdC_INT;

//  DECLARE_ASN1_FUNCTIONS(GENERAL_NAMES)

//  STACK_OF(CONF_VALUE) *i2v_GENERAL_NAMES(method: PX509V3_EXT_METHOD, GENERAL_NAMES *gen, STACK_OF(CONF_VALUE) *extlist);
//  GENERAL_NAMES *v2i_GENERAL_NAMES(const method: PX509V3_EXT_METHOD, ctx: PX509V3_CTX, STACK_OF(CONF_VALUE) *nval);

//  DECLARE_ASN1_FUNCTIONS(OTHERNAME)
//  DECLARE_ASN1_FUNCTIONS(EDIPARTYNAME)
  function OTHERNAME_cmp(a: POTHERNAME; b: POTHERNAME): TIdC_INT;
  procedure GENERAL_NAME_set0_value(a: PGENERAL_NAME; type_: TIdC_INT; value: Pointer);
  function GENERAL_NAME_get0_value(const a: PGENERAL_NAME; ptype: PIdC_INT): Pointer;
  function GENERAL_NAME_set0_othername(gen: PGENERAL_NAME; oid: PASN1_OBJECT; value: PASN1_TYPE): TIdC_INT;
  function GENERAL_NAME_get0_otherName(const gen: PGENERAL_NAME; poid: PPASN1_OBJECT; pvalue: PPASN1_TYPE): TIdC_INT;

  //function i2s_ASN1_OCTET_STRING(method: PX509V3_EXT_METHOD; const ia5: PASN1_OCTET_STRING): PIdAnsiChar;
  //function s2i_ASN1_OCTET_STRING(method: PX509V3_EXT_METHOD; ctx: PX509V3_CTX; const str: PIdAnsiChar): PASN1_OCTET_STRING;

//  DECLARE_ASN1_FUNCTIONS(EXTENDED_KEY_USAGE)
  function i2a_ACCESS_DESCRIPTION(bp: PBIO; const a: PACCESS_DESCRIPTION): TIdC_INT;

//  DECLARE_ASN1_ALLOC_FUNCTIONS(TLS_FEATURE)

//  DECLARE_ASN1_FUNCTIONS(CERTIFICATEPOLICIES)
//  DECLARE_ASN1_FUNCTIONS(POLICYINFO)
//  DECLARE_ASN1_FUNCTIONS(POLICYQUALINFO)
//  DECLARE_ASN1_FUNCTIONS(USERNOTICE)
//  DECLARE_ASN1_FUNCTIONS(NOTICEREF)

//  DECLARE_ASN1_FUNCTIONS(CRL_DIST_POINTS)
//  DECLARE_ASN1_FUNCTIONS(DIST_POINT)
//  DECLARE_ASN1_FUNCTIONS(DIST_POINT_NAME)
//  DECLARE_ASN1_FUNCTIONS(ISSUING_DIST_POINT)

  function DIST_POINT_set_dpname(dpn: PDIST_POINT_NAME; iname: PX509_NAME): TIdC_INT;

  function NAME_CONSTRAINTS_check(x: PX509; nc: PNAME_CONSTRAINTS): TIdC_INT;
  function NAME_CONSTRAINTS_check_CN(x: PX509; nc: PNAME_CONSTRAINTS): TIdC_INT;

//  DECLARE_ASN1_FUNCTIONS(ACCESS_DESCRIPTION)
//  DECLARE_ASN1_FUNCTIONS(AUTHORITY_INFO_ACCESS)

//  DECLARE_ASN1_ITEM(POLICY_MAPPING)
//  DECLARE_ASN1_ALLOC_FUNCTIONS(POLICY_MAPPING)
//  DECLARE_ASN1_ITEM(POLICY_MAPPINGS)

//  DECLARE_ASN1_ITEM(GENERAL_SUBTREE)
//  DECLARE_ASN1_ALLOC_FUNCTIONS(GENERAL_SUBTREE)

//  DECLARE_ASN1_ITEM(NAME_CONSTRAINTS)
//  DECLARE_ASN1_ALLOC_FUNCTIONS(NAME_CONSTRAINTS)

//  DECLARE_ASN1_ALLOC_FUNCTIONS(POLICY_CONSTRAINTS)
//  DECLARE_ASN1_ITEM(POLICY_CONSTRAINTS)

  //function a2i_GENERAL_NAME(out_: PGENERAL_NAME; const method: PX509V3_EXT_METHOD; ctx: PX509V3_CTX; TIdC_INT gen_type; const value: PIdAnsiChar; is_nc: TIdC_INT): GENERAL_NAME;

  //function v2i_GENERAL_NAME(const method: PX509V3_EXT_METHOD; ctx: PX509V3_CTX; cnf: PCONF_VALUE): PGENERAL_NAME;
  //function v2i_GENERAL_NAME_ex(out_: PGENERAL_NAME; const method: PX509V3_EXT_METHOD; ctx: PX509V3_CTX; cnf: PCONF_VALUE; is_nc: TIdC_INT): PGENERAL_NAME;
  //procedure X509V3_conf_free(val: PCONF_VALUE);

  function X509V3_EXT_nconf_nid(conf: PCONF; ctx: PX509V3_CTX; ext_nid: TIdC_INT; const value: PIdAnsiChar): PX509_EXTENSION;
  function X509V3_EXT_nconf(conf: PCONF; ctx: PX509V3_CTX; const name: PIdAnsiChar; const value: PIdAnsiChar): PX509_EXTENSION;
//  TIdC_INT X509V3_EXT_add_nconf_sk(conf: PCONF; ctx: PX509V3_CTX; const section: PIdAnsiChar; STACK_OF(X509_EXTENSION) **sk);
  function X509V3_EXT_add_nconf(conf: PCONF; ctx: PX509V3_CTX; const section: PIdAnsiChar; cert: PX509): TIdC_INT;
  function X509V3_EXT_REQ_add_nconf(conf: PCONF; ctx: PX509V3_CTX; const section: PIdAnsiChar; req: PX509_REQ): TIdC_INT;
  function X509V3_EXT_CRL_add_nconf(conf: PCONF; ctx: PX509V3_CTX; const section: PIdAnsiChar; crl: PX509_CRL): TIdC_INT;

  function X509V3_EXT_conf_nid(conf: Pointer; ctx: PX509V3_CTX; ext_nid: TIdC_INT; const value: PIdAnsiChar): PX509_EXTENSION;
//  X509_EXTENSION *X509V3_EXT_conf_nid(LHASH_OF(CONF_VALUE) *conf; ctx: PX509V3_CTX; ext_nid: TIdC_INT; const value: PIdAnsiChar);
  function X509V3_EXT_conf(conf: Pointer; ctx: PX509V3_CTX; const name: PIdAnsiChar; const value: PIdAnsiChar): PX509_EXTENSION;
//  X509_EXTENSION *X509V3_EXT_conf(LHASH_OF(CONF_VALUE) *conf; ctx: PX509V3_CTX; const name: PIdAnsiChar; const value: PIdAnsiChar);
  function X509V3_EXT_add_conf(conf: Pointer; ctx: PX509V3_CTX; const section: PIdAnsiChar; cert: PX509): TIdC_INT;
//  TIdC_INT X509V3_EXT_add_conf(LHASH_OF(CONF_VALUE) *conf; ctx: PX509V3_CTX; const section: PIdAnsiChar; cert: PX509);
  function X509V3_EXT_REQ_add_conf(conf: Pointer; ctx: PX509V3_CTX; const section: PIdAnsiChar; req: PX509_REQ): TIdC_INT;
//  TIdC_INT X509V3_EXT_REQ_add_conf(LHASH_OF(CONF_VALUE) *conf; ctx: PX509V3_CTX; const section: PIdAnsiChar; req: PX509_REQ);
  function X509V3_EXT_CRL_add_conf(conf: Pointer; ctx: PX509V3_CTX; const section: PIdAnsiChar; crl: PX509_CRL): TIdC_INT;
//  TIdC_INT X509V3_EXT_CRL_add_conf(LHASH_OF(CONF_VALUE) *conf; ctx: PX509V3_CTX; const section: PIdAnsiChar; crl: PX509_CRL);

//  TIdC_INT X509V3_add_value_bool_nf(const name: PIdAnsiChar; TIdC_INT asn1_bool; STACK_OF(CONF_VALUE) **extlist);
  //function X509V3_get_value_bool(const value: PCONF_VALUE; asn1_bool: PIdC_INT): TIdC_INT;
  //function X509V3_get_value_int(const value: PCONF_VALUE; aint: PPASN1_INTEGER): TIdC_INT;
  procedure X509V3_set_nconf(ctx: PX509V3_CTX; conf: PCONF);
//  void X509V3_set_conf_lhash(ctx: PX509V3_CTX; LHASH_OF(CONF_VALUE) *lhash);

  function X509V3_get_string(ctx: PX509V3_CTX; const name: PIdAnsiChar; const section: PIdAnsiChar): PIdAnsiChar;
//  STACK_OF(CONF_VALUE) *X509V3_get_section(ctx: PX509V3_CTX; const section: PIdAnsiChar);
  procedure X509V3_string_free(ctx: PX509V3_CTX; str: PIdAnsiChar);
//  void X509V3_section_free(ctx: PX509V3_CTX; STACK_OF(CONF_VALUE) *section);
  procedure X509V3_set_ctx(ctx: PX509V3_CTX; issuer: PX509; subject: PX509; req: PX509_REQ; crl: PX509_CRL; flags: TIdC_INT);

//  TIdC_INT X509V3_add_value(const name: PIdAnsiChar; const value: PIdAnsiChar; STACK_OF(CONF_VALUE) **extlist);
//  TIdC_INT X509V3_add_value_uPIdAnsiChar(const name: PIdAnsiChar; const Byte *value; STACK_OF(CONF_VALUE) **extlist);
//  TIdC_INT X509V3_add_value_bool(const name: PIdAnsiChar; TIdC_INT asn1_bool; STACK_OF(CONF_VALUE) **extlist);
//  TIdC_INT X509V3_add_value_int(const name: PIdAnsiChar; const aint: PASN1_INTEGER; STACK_OF(CONF_VALUE) **extlist);
  //function i2s_ASN1_INTEGER(meth: PX509V3_EXT_METHOD; const aint: PASN1_INTEGER): PIdAnsiChar;
  //function s2i_ASN1_INTEGER(meth: PX509V3_EXT_METHOD; const value: PIdAnsiChar): PASN1_INTEGER;
  //function i2s_ASN1_ENUMERATED(meth: PX509V3_EXT_METHOD; const aint: PASN1_ENUMERATED): PIdAnsiChar;
  //function i2s_ASN1_ENUMERATED_TABLE(meth: PX509V3_EXT_METHOD; const aint: PASN1_ENUMERATED): PIdAnsiChar;
  //function X509V3_EXT_add(ext: PX509V3_EXT_METHOD): TIdC_INT;
  //function X509V3_EXT_add_list(extlist: PX509V3_EXT_METHOD): TIdC_INT;
  function X509V3_EXT_add_alias(nid_to: TIdC_INT; nid_from: TIdC_INT): TIdC_INT;
  procedure X509V3_EXT_cleanup;

  //function X509V3_EXT_get(ext: PX509_EXTENSION): PX509V3_EXT_METHOD;
  //function X509V3_EXT_get_nid(nid: TIdC_INT): PX509V3_EXT_METHOD;
  function X509V3_add_standard_extensions: TIdC_INT;
//  STACK_OF(CONF_VALUE) *X509V3_parse_list(const line: PIdAnsiChar);
  function X509V3_EXT_d2i(ext: PX509_EXTENSION): Pointer;
//  void *X509V3_get_d2i(const STACK_OF(X509_EXTENSION) *x; nid: TIdC_INT; TIdC_INT *crit; TIdC_INT *idx);

  function X509V3_EXT_i2d(ext_nid: TIdC_INT; crit: TIdC_INT; ext_struc: Pointer): PX509_EXTENSION;
//  TIdC_INT X509V3_add1_i2d(STACK_OF(X509_EXTENSION) **x; nid: TIdC_INT; value: Pointer; crit: TIdC_INT; TIdC_ULONG flags);

//  void X509V3_EXT_val_prn(out_: PBIO; STACK_OF(CONF_VALUE) *val; indent: TIdC_INT; TIdC_INT ml);
  function X509V3_EXT_print(out_: PBIO; ext: PX509_EXTENSION; flag: TIdC_ULONG; indent: TIdC_INT): TIdC_INT;
//  TIdC_INT X509V3_extensions_print(out_: PBIO; const PIdAnsiChar *title; const STACK_OF(X509_EXTENSION) *exts; flag: TIdC_ULONG; indent: TIdC_INT);

  function X509_check_ca(x: PX509): TIdC_INT;
  function X509_check_purpose(x: PX509; id: TIdC_INT; ca: TIdC_INT): TIdC_INT;
  function X509_supported_extension(ex: PX509_EXTENSION): TIdC_INT;
  function X509_PURPOSE_set(p: PIdC_INT; purpose: TIdC_INT): TIdC_INT;
  function X509_check_issued(issuer: PX509; subject: PX509): TIdC_INT;
  function X509_check_akid(issuer: PX509; akid: PAUTHORITY_KEYID): TIdC_INT;
  procedure X509_set_proxy_flag(x: PX509);
  procedure X509_set_proxy_pathlen(x: PX509; l: TIdC_LONG);
  function X509_get_proxy_pathlen(x: PX509): TIdC_LONG;

  function X509_get_extension_flags(x: PX509): TIdC_UINT32;
  function X509_get_key_usage(x: PX509): TIdC_UINT32;
  function X509_get_extended_key_usage(x: PX509): TIdC_UINT32;
  function X509_get0_subject_key_id(x: PX509): PASN1_OCTET_STRING;
  function X509_get0_authority_key_id(x: PX509): PASN1_OCTET_STRING;
  //function X509_get0_authority_issuer(x: PX509): PGENERAL_NAMES;
  function X509_get0_authority_serial(x: PX509): PASN1_INTEGER;

  function X509_PURPOSE_get_count: TIdC_INT;
  function X509_PURPOSE_get0(idx: TIdC_INT): PX509_PURPOSE;
  function X509_PURPOSE_get_by_sname(const sname: PIdAnsiChar): TIdC_INT;
  function X509_PURPOSE_get_by_id(id: TIdC_INT): TIdC_INT;
//  TIdC_INT X509_PURPOSE_add(id: TIdC_INT, TIdC_INT trust, flags: TIdC_INT, TIdC_INT (*ck) (const X509_PURPOSE *, const X509 *, TIdC_INT), const name: PIdAnsiChar, const sname: PIdAnsiChar, void *arg);
  function X509_PURPOSE_get0_name(const xp: PX509_PURPOSE): PIdAnsiChar;
  function X509_PURPOSE_get0_sname(const xp: PX509_PURPOSE): PIdAnsiChar;
  function X509_PURPOSE_get_trust(const xp: PX509_PURPOSE): TIdC_INT;
  procedure X509_PURPOSE_cleanup;
  function X509_PURPOSE_get_id(const v1: PX509_PURPOSE): TIdC_INT;

//  STACK_OF(OPENSSL_STRING) *X509_get1_email(x: PX509);
//  STACK_OF(OPENSSL_STRING) *X509_REQ_get1_email(X509_REQ *x);
//  void X509_email_free(STACK_OF(OPENSSL_STRING) *sk);
//  STACK_OF(OPENSSL_STRING) *X509_get1_ocsp(x: PX509);

  function X509_check_host(x: PX509; const chk: PIdAnsiChar; chklen: TIdC_SIZET; flags: TIdC_UINT; peername: PPIdAnsiChar): TIdC_INT;
  function X509_check_email(x: PX509; const chk: PIdAnsiChar; chklen: TIdC_SIZET; flags: TIdC_UINT): TIdC_INT;
  function X509_check_ip(x: PX509; const chk: PByte; chklen: TIdC_SIZET; flags: TIdC_UINT): TIdC_INT;
  function X509_check_ip_asc(x: PX509; const ipasc: PIdAnsiChar; flags: TIdC_UINT): TIdC_INT;

  function a2i_IPADDRESS(const ipasc: PIdAnsiChar): PASN1_OCTET_STRING;
  function a2i_IPADDRESS_NC(const ipasc: PIdAnsiChar): PASN1_OCTET_STRING;
//  TIdC_INT X509V3_NAME_from_section(X509_NAME *nm; STACK_OF(CONF_VALUE) *dn_sk; TIdC_ULONG chtype);

  procedure X509_POLICY_NODE_print(out_: PBIO; node: PX509_POLICY_NODE; indent: TIdC_INT);
//  DEFINE_STACK_OF(X509_POLICY_NODE)

  (*
   * Utilities to construct and extract values from RFC3779 extensions,
   * since some of the encodings (particularly for IP address prefixes
   * and ranges) are a bit tedious to work with directly.
   *)
  //function X509v3_asid_add_inherit(asid: PASIdentifiers; which: TIdC_INT): TIdC_INT;
  //function X509v3_asid_add_id_or_range(asid: PASIdentifiers; which: TIdC_INT; min: PASN1_INTEGER; max: PASN1_INTEGER): TIdC_INT;
  //function X509v3_addr_add_inherit(addr: PIPAddrBlocks; const afi: TIdC_UINT; const safi: PIdC_UINT): TIdC_INT;
  //function X509v3_addr_add_prefix(addr: PIPAddrBlocks; const afi: TIdC_UINT; const safi: PIdC_UINT; a: PByte; const prefixlen: TIdC_INT): TIdC_INT;
  //function X509v3_addr_add_range(addr: PIPAddrBlocks; const afi: TIdC_UINT; const safi: PIdC_UINT; min: PByte; max: PByte): TIdC_INT;
  //function X509v3_addr_get_afi(const f: PIPAddressFamily): TIdC_UINT;
  function X509v3_addr_get_range(aor: PIPAddressOrRange; const afi: TIdC_UINT; min: PByte; max: Byte; const length: TIdC_INT): TIdC_INT;

  (*
   * Canonical forms.
   *)
  //function X509v3_asid_is_canonical(asid: PASIdentifiers): TIdC_INT;
  //function X509v3_addr_is_canonical(addr: PIPAddrBlocks): TIdC_INT;
  //function X509v3_asid_canonize(asid: PASIdentifiers): TIdC_INT;
  //function X509v3_addr_canonize(addr: PIPAddrBlocks): TIdC_INT;

  (*
   * Tests for inheritance and containment.
   *)
  //function X509v3_asid_inherits(asid: PASIdentifiers): TIdC_INT;
  //function X509v3_addr_inherits(addr: PIPAddrBlocks): TIdC_INT;
  //function X509v3_asid_subset(a: PASIdentifiers; b: PASIdentifiers): TIdC_INT;
  //function X509v3_addr_subset(a: PIPAddrBlocks; b: PIPAddrBlocks): TIdC_INT;

  (*
   * Check whether RFC 3779 extensions nest properly in chains.
   *)
  function X509v3_asid_validate_path(v1: PX509_STORE_CTX): TIdC_INT;
  function X509v3_addr_validate_path(v1: PX509_STORE_CTX): TIdC_INT;
//  TIdC_INT X509v3_asid_validate_resource_set(STACK_OF(X509) *chain; ASIdentifiers *ext; TIdC_INT allow_inheritance);
//  TIdC_INT X509v3_addr_validate_resource_set(STACK_OF(X509) *chain; IPAddrBlocks *ext; TIdC_INT allow_inheritance);


//  DEFINE_STACK_OF(ASN1_STRING)

  (*
   * Admission Syntax
   *)
  function NAMING_AUTHORITY_get0_authorityId(const n: PNAMING_AUTHORITY): PASN1_OBJECT;
  function NAMING_AUTHORITY_get0_authorityURL(const n: PNAMING_AUTHORITY): PASN1_IA5STRING;
  function NAMING_AUTHORITY_get0_authorityText(const n: PNAMING_AUTHORITY): PASN1_STRING;
  procedure NAMING_AUTHORITY_set0_authorityId(n: PNAMING_AUTHORITY; namingAuthorityId: PASN1_OBJECT);
  procedure NAMING_AUTHORITY_set0_authorityURL(n: PNAMING_AUTHORITY; namingAuthorityUrl: PASN1_IA5STRING);
  procedure NAMING_AUTHORITY_set0_authorityText(n: PNAMING_AUTHORITY; namingAuthorityText: PASN1_STRING);

  function ADMISSION_SYNTAX_get0_admissionAuthority(const as_: ADMISSION_SYNTAX): PGENERAL_NAME;
  procedure ADMISSION_SYNTAX_set0_admissionAuthority(as_: ADMISSION_SYNTAX; aa: PGENERAL_NAME);
//  const STACK_OF(ADMISSIONS) *ADMISSION_SYNTAX_get0_contentsOfAdmissions(const as_: ADMISSION_SYNTAX);
//  void ADMISSION_SYNTAX_set0_contentsOfAdmissions(as_: ADMISSION_SYNTAX; STACK_OF(ADMISSIONS) *a);
  function ADMISSIONS_get0_admissionAuthority(const a: PADMISSIONS): PGENERAL_NAME;
  procedure ADMISSIONS_set0_admissionAuthority(a: PADMISSIONS; aa: PGENERAL_NAME);
  function ADMISSIONS_get0_namingAuthority(const a: PADMISSIONS): PNAMING_AUTHORITY;
  procedure ADMISSIONS_set0_namingAuthority(a: PADMISSIONS; na: PNAMING_AUTHORITY);
  //function ADMISSIONS_get0_professionInfos(const a: PADMISSIONS): PPROFESSION_INFOS;
  //procedure ADMISSIONS_set0_professionInfos(a: PADMISSIONS; pi: PPROFESSION_INFOS);
  function PROFESSION_INFO_get0_addProfessionInfo(const pi: PPROFESSION_INFO): PASN1_OCTET_STRING;
  procedure PROFESSION_INFO_set0_addProfessionInfo(pi: PPROFESSION_INFO; aos: PASN1_OCTET_STRING);
  function PROFESSION_INFO_get0_namingAuthority(const pi: PPROFESSION_INFO): PNAMING_AUTHORITY;
  procedure PROFESSION_INFO_set0_namingAuthority(pi: PPROFESSION_INFO; na: PNAMING_AUTHORITY);
//  const STACK_OF(ASN1_STRING) *PROFESSION_INFO_get0_professionItems(const pi: PPROFESSION_INFO);
//  void PROFESSION_INFO_set0_professionItems(pi: PPROFESSION_INFO; STACK_OF(ASN1_STRING) *as);
//  const STACK_OF(ASN1_OBJECT) *PROFESSION_INFO_get0_professionOIDs(const pi: PPROFESSION_INFO);
//  void PROFESSION_INFO_set0_professionOIDs(pi: PPROFESSION_INFO; STACK_OF(ASN1_OBJECT) *po);
  function PROFESSION_INFO_get0_registrationNumber(const pi: PPROFESSION_INFO): PASN1_PRINTABLESTRING;
  procedure PROFESSION_INFO_set0_registrationNumber(pi: PPROFESSION_INFO; rn: PASN1_PRINTABLESTRING);


implementation

end.
