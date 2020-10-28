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

unit IdOpenSSLHeaders_cms;

interface

// Headers for OpenSSL 1.1.1
// cms.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ,
  IdOpenSSLHeaders_x509;

type
  CMS_ContentInfo_st = type Pointer;
  CMS_ContentInfo = CMS_ContentInfo_st;
  PCMS_ContentInfo = ^CMS_ContentInfo;
  PPCMS_ContentInfo = ^PCMS_ContentInfo;

  CMS_SignerInfo_st = type Pointer;
  CMS_SignerInfo = CMS_SignerInfo_st;
  PCMS_SignerInfo = ^CMS_SignerInfo;

  CMS_CertificateChoices_st = type Pointer;
  CMS_CertificateChoices = CMS_CertificateChoices_st;
  PCMS_CertificateChoices = ^CMS_CertificateChoices;

  CMS_RevocationInfoChoice_st = type Pointer;
  CMS_RevocationInfoChoice = CMS_RevocationInfoChoice_st;
  PCMS_RevocationInfoChoice = ^CMS_RevocationInfoChoice;

  CMS_RecipientInfo_st = type Pointer;
  CMS_RecipientInfo = CMS_RecipientInfo_st;
  PCMS_RecipientInfo = ^CMS_RecipientInfo;
  PPCMS_RecipientInfo = ^PCMS_RecipientInfo;

  CMS_ReceiptRequest_st = type Pointer;
  CMS_ReceiptRequest = CMS_ReceiptRequest_st;
  PCMS_ReceiptRequest = ^CMS_ReceiptRequest;
  PPCMS_ReceiptRequest = ^PCMS_ReceiptRequest;

  CMS_Receipt_st = type Pointer;
  CMS_Receipt = CMS_Receipt_st;
  PCMS_Receipt = ^CMS_Receipt;

  CMS_RecipientEncryptedKey_st = type Pointer;
  CMS_RecipientEncryptedKey = CMS_RecipientEncryptedKey_st;
  PCMS_RecipientEncryptedKey = ^CMS_RecipientEncryptedKey;

  CMS_OtherKeyAttribute_st = type Pointer;
  CMS_OtherKeyAttribute = CMS_OtherKeyAttribute_st;
  PCMS_OtherKeyAttribute = ^CMS_OtherKeyAttribute;
  PPCMS_OtherKeyAttribute = ^PCMS_OtherKeyAttribute;

//DEFINE_STACK_OF(CMS_SignerInfo)
//DEFINE_STACK_OF(CMS_RecipientEncryptedKey)
//DEFINE_STACK_OF(CMS_RecipientInfo)
//DEFINE_STACK_OF(CMS_RevocationInfoChoice)
//DECLARE_ASN1_FUNCTIONS(CMS_ContentInfo)
//DECLARE_ASN1_FUNCTIONS(CMS_ReceiptRequest)
//DECLARE_ASN1_PRINT_FUNCTION(CMS_ContentInfo)

const
  CMS_SIGNERINFO_ISSUER_SERIAL    = 0;
  CMS_SIGNERINFO_KEYIDENTIFIER    = 1;

  CMS_RECIPINFO_NONE              = -1;
  CMS_RECIPINFO_TRANS             = 0;
  CMS_RECIPINFO_AGREE             = 1;
  CMS_RECIPINFO_KEK               = 2;
  CMS_RECIPINFO_PASS              = 3;
  CMS_RECIPINFO_OTHER             = 4;

// S/MIME related flags /

  CMS_TEXT                        = $1;
  CMS_NOCERTS                     = $2;
  CMS_NO_CONTENT_VERIFY           = $4;
  CMS_NO_ATTR_VERIFY              = $8;
  CMS_NOSIGS                      = (CMS_NO_CONTENT_VERIFY or CMS_NO_ATTR_VERIFY);
  CMS_NOINTERN                    = $10;
  CMS_NO_SIGNER_CERT_VERIFY       = $20;
  CMS_NOVERIFY                    = $20;
  CMS_DETACHED                    = $40;
  CMS_BINARY                      = $80;
  CMS_NOATTR                      = $100;
  CMS_NOSMIMECAP                  = $200;
  CMS_NOOLDMIMETYPE               = $400;
  CMS_CRLFEOL                     = $800;
  CMS_STREAM_CONST                = $1000;
  CMS_NOCRL                       = $2000;
  CMS_PARTIAL                     = $4000;
  CMS_REUSE_DIGEST                = $8000;
  CMS_USE_KEYID                   = $10000;
  CMS_DEBUG_DECRYPT               = $20000;
  CMS_KEY_PARAM                   = $40000;
  CMS_ASCIICRLF                   = $80000;

var
  function CMS_get0_type(const cms: PCMS_ContentInfo): PASN1_OBJECT;

  function CMS_dataInit(cms: PCMS_ContentInfo; icont: PBIO): PBIO;
  function CMS_dataFinal(cms: PCMS_ContentInfo; bio: PBIO): TIdC_INT;

  function CMS_get0_content(cms: PCMS_ContentInfo): PPASN1_OCTET_STRING;
  function CMS_is_detached(cms: PCMS_ContentInfo): TIdC_INT;
  function CMS_set_detached(cms: PCMS_ContentInfo; detached: TIdC_INT): TIdC_INT;

  function CMS_stream(cms: PCMS_ContentInfo; boundary: PPPByte): TIdC_INT;
  function d2i_CMS_bio(bp: PBIO; cms: PPCMS_ContentInfo): PCMS_ContentInfo;
  function i2d_CMS_bio(bp: PBIO; cms: PCMS_ContentInfo): TIdC_INT;

  function BIO_new_CMS(&out: PBIO; cms: PCMS_ContentInfo): PBIO;
  function i2d_CMS_bio_stream(&out: PBIO; cms: PCMS_ContentInfo; in_: PBIO; flags: TIdC_INT): TIdC_INT;
  function PEM_write_bio_CMS_stream(&out: PBIO; cms: PCMS_ContentInfo; in_: PBIO; flags: TIdC_INT): TIdC_INT;
  function SMIME_read_CMS(bio: PBIO; bcont: PPBIO): PCMS_ContentInfo;
  function SMIME_write_CMS(bio: PBIO; cms: PCMS_ContentInfo; data: PBIO; flags: TIdC_INT): TIdC_INT;

  function CMS_final(cms: PCMS_ContentInfo; data: PBIO; dcont: PBIO; flags: TIdC_UINT): TIdC_INT;

//  function CMS_sign(signcert: PX509; pkey: PEVP_PKEY; {STACK_OF(x509) *certs;} data: PBIO; flags: TIdC_UINT): PCMS_ContentInfo;

//  function CMS_sign_receipt(si: PCMS_SignerInfo; signcert: PX509; pkey: PEVP_PKEY; {STACK_OF(X509) *certs;} flags: TIdC_UINT): PCMS_ContentInfo;

  function CMS_data(cms: PCMS_ContentInfo; out_: PBIO; flags: TIdC_UINT): TIdC_INT;
  function CMS_data_create(&in: PBIO; flags: TIdC_UINT): PCMS_ContentInfo;

  function CMS_digest_verify(cms: PCMS_ContentInfo; dcont: PBIO; out_: PBIO; flags: TIdC_UINT): TIdC_INT;
  function CMS_digest_create(&in: PBIO; const md: PEVP_MD; flags: TIdC_UINT): PCMS_ContentInfo;

  function CMS_EncryptedData_decrypt(cms: PCMS_ContentInfo; const key: PByte; keylen: TIdC_SIZET; dcont: PBIO; out_: PBIO; flags: TIdC_UINT): TIdC_INT;

  function CMS_EncryptedData_encrypt(&in: PBIO; const cipher: PEVP_CIPHER; const key: PByte; keylen: TIdC_SIZET; flags: TIdC_UINT): PCMS_ContentInfo;

  function CMS_EncryptedData_set1_key(cms: PCMS_ContentInfo; const ciph: PEVP_CIPHER; const key: PByte; keylen: TIdC_SIZET): TIdC_INT;

//  function CMS_verify(cms: PCMS_ContentInfo; {STACK_OF(X509) *certs;} store: PX509_STORE; dcont: PBIO; out_: PBIO; flags: TIdC_UINT): TIdC_INT;

//  function CMS_verify_receipt(rcms: PCMS_ContentInfo; ocms: PCMS_ContentInfo; {STACK_OF(x509) *certs;} store: PX509_STORE; flags: TIdC_UINT): TIdC_INT;

  // STACK_OF(X509) *CMS_get0_signers(CMS_ContentInfo *cms);

//  function CMS_encrypt({STACK_OF(x509) *certs;} in_: PBIO; const cipher: PEVP_CIPHER; flags: TIdC_UINT): PCMS_ContentInfo;

  function CMS_decrypt(cms: PCMS_ContentInfo; pkey: PEVP_PKEY; cert: PX509; dcont: PBIO; out_: PBIO; flags: TIdC_UINT): TIdC_INT;

  function CMS_decrypt_set1_pkey(cms: PCMS_ContentInfo; pk: PEVP_PKEY; cert: PX509): TIdC_INT;
  function CMS_decrypt_set1_key(cms: PCMS_ContentInfo; key: PByte; keylen: TIdC_SIZET; const id: PByte; idlen: TIdC_SIZET): TIdC_INT;
  function CMS_decrypt_set1_password(cms: PCMS_ContentInfo; pass: PByte; passlen: ossl_ssize_t): TIdC_INT;

  //STACK_OF(CMS_RecipientInfo) *CMS_get0_RecipientInfos(CMS_ContentInfo *cms);
  function CMS_RecipientInfo_type(ri: PCMS_RecipientInfo): TIdC_INT;
  function CMS_RecipientInfo_get0_pkey_ctx(ri: PCMS_RecipientInfo): PEVP_PKEY_CTX;
  function CMS_EnvelopedData_create(const cipher: PEVP_CIPHER): PCMS_ContentInfo;
  function CMS_add1_recipient_cert(cms: PCMS_ContentInfo; recip: PX509; flags: TIdC_UINT): PCMS_RecipientInfo;
  function CMS_RecipientInfo_set0_pkey(ri: PCMS_RecipientInfo; pkey: PEVP_PKEY): TIdC_INT;
  function CMS_RecipientInfo_ktri_cert_cmp(ri: PCMS_RecipientInfo; cert: PX509): TIdC_INT;
  function CMS_RecipientInfo_ktri_get0_algs(ri: PCMS_RecipientInfo; pk: PPEVP_PKEY; recip: PPX509; palg: PPX509_ALGOR): TIdC_INT;
  function CMS_RecipientInfo_ktri_get0_signer_id(ri: PPCMS_RecipientInfo; keyid: PPASN1_OCTET_STRING; issuer: PPX509_NAME; sno: PPASN1_INTEGER): TIdC_INT;

  function CMS_add0_recipient_key(cms: PCMS_ContentInfo; nid: TIdC_INT; key: PByte; keylen: TIdC_SIZET; id: PByte; idlen: TIdC_SIZET; date: PASN1_GENERALIZEDTIME; otherTypeId: PASN1_OBJECT; otherType: ASN1_TYPE): PCMS_RecipientInfo;

  function CMS_RecipientInfo_kekri_get0_id(ri: PCMS_RecipientInfo; palg: PPX509_ALGOR; pid: PPASN1_OCTET_STRING; pdate: PPASN1_GENERALIZEDTIME; potherid: PPASN1_OBJECT; pothertype: PASN1_TYPE): TIdC_INT;

  function CMS_RecipientInfo_set0_key(ri: PCMS_RecipientInfo; key: PByte; keylen: TIdC_SIZET): TIdC_INT;

  function CMS_RecipientInfo_kekri_id_cmp(ri: PCMS_RecipientInfo; const id: PByte; idlen: TIdC_SIZET): TIdC_INT;

  function CMS_RecipientInfo_set0_password(ri: PCMS_RecipientInfo; pass: PByte; passlen: ossl_ssize_t): TIdC_INT;

  function CMS_add0_recipient_password(cms: PCMS_ContentInfo; iter: TIdC_INT; wrap_nid: TIdC_INT; pbe_nid: TIdC_INT; pass: PByte; passlen: ossl_ssize_t; const kekciph: PEVP_CIPHER): PCMS_RecipientInfo;

  function CMS_RecipientInfo_decrypt(cms: PCMS_ContentInfo; ri: PCMS_RecipientInfo): TIdC_INT;
  function CMS_RecipientInfo_encrypt(cms: PCMS_ContentInfo; ri: PCMS_RecipientInfo): TIdC_INT;

  function CMS_uncompress(cms: PCMS_ContentInfo; dcont: PBIO; out_: PBIO; flags: TIdC_UINT): TIdC_INT;
  function CMS_compress(&in: PBIO; comp_nid: TIdC_INT; flags: TIdC_UINT): PCMS_ContentInfo;

  function CMS_set1_eContentType(cms: CMS_ContentInfo; const oit: PASN1_OBJECT): TIdC_INT;
  function CMS_get0_eContentType(cms: PCMS_ContentInfo): PASN1_OBJECT;

  function CMS_add0_CertificateChoices(cms: PCMS_ContentInfo): PCMS_CertificateChoices;
  function CMS_add0_cert(cms: PCMS_ContentInfo; cert: PX509): TIdC_INT;
  function CMS_add1_cert(cms: PCMS_ContentInfo; cert: PX509): TIdC_INT;
  // STACK_OF(X509) *CMS_get1_certs(CMS_ContentInfo *cms);

  function CMS_add0_RevocationInfoChoice(cms: PCMS_ContentInfo): PCMS_RevocationInfoChoice;
  function CMS_add0_crl(cms: PCMS_ContentInfo; crl: PX509_CRL): TIdC_INT;
  function CMS_add1_crl(cms: PCMS_ContentInfo; crl: PX509_CRL): TIdC_INT;
  // STACK_OF(X509_CRL) *CMS_get1_crls(CMS_ContentInfo *cms);

  function CMS_SignedData_init(cms: PCMS_ContentInfo): TIdC_INT;
  function CMS_add1_signer(cms: PCMS_ContentInfo; signer: PX509; pk: PEVP_PKEY; const md: PEVP_MD; flags: TIdC_UINT): PCMS_SignerInfo;
  function CMS_SignerInfo_get0_pkey_ctx(si: PCMS_SignerInfo): PEVP_PKEY_CTX;
  function CMS_SignerInfo_get0_md_ctx(si: PCMS_SignerInfo): PEVP_MD_CTX;
  // STACK_OF(CMS_SignerInfo) *CMS_get0_SignerInfos(CMS_ContentInfo *cms);

  procedure CMS_SignerInfo_set1_signer_cert(si: PCMS_SignerInfo; signer: PX509);
  function CMS_SignerInfo_get0_signer_id(si: PCMS_SignerInfo; keyid: PPASN1_OCTET_STRING; issuer: PPX509_NAME; sno: PPASN1_INTEGER): TIdC_INT;
  function CMS_SignerInfo_cert_cmp(si: PCMS_SignerInfo; cert: PX509): TIdC_INT;
//  function CMS_set1_signers_certs(cms: PCMS_ContentInfo; {STACK_OF(X509) *certs;} flags: TIdC_UINT): TIdC_INT;
  procedure CMS_SignerInfo_get0_algs(si: PCMS_SignerInfo; pk: PPEVP_PKEY; signer: PPX509; pdig: PPX509_ALGOR; psig: PPX509_ALGOR);
  function CMS_SignerInfo_get0_signature(si: PCMS_SignerInfo): PASN1_OCTET_STRING;
  function CMS_SignerInfo_sign(si: PCMS_SignerInfo): TIdC_INT;
  function CMS_SignerInfo_verify(si: PCMS_SignerInfo): TIdC_INT;
  function CMS_SignerInfo_verify_content(si: PCMS_SignerInfo; chain: PBIO): TIdC_INT;

//  function CMS_add_smimecap(si: PCMS_SignerInfo{; STACK_OF(X509_ALGOR) *algs}): TIdC_INT;
//  function CMS_add_simple_smimecap({STACK_OF(X509_ALGOR) **algs;} algnid: TIdC_INT; keysize: TIdC_INT): TIdC_INT;
//  function CMS_add_standard_smimecap({STACK_OF(X509_ALGOR) **smcap}): TIdC_INT;

  function CMS_signed_get_attr_count(const si: PCMS_SignerInfo): TIdC_INT;
  function CMS_signed_get_attr_by_NID(const si: PCMS_SignerInfo; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT;
  function CMS_signed_get_attr_by_OBJ(const si: PCMS_SignerInfo; const obj: ASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT;
  function CMS_signed_get_attr(const si: PCMS_SignerInfo; loc: TIdC_INT): PX509_ATTRIBUTE;
  function CMS_signed_delete_attr(const si: PCMS_SignerInfo; loc: TIdC_INT): PX509_ATTRIBUTE;
  function CMS_signed_add1_attr(si: PCMS_SignerInfo; loc: TIdC_INT): TIdC_INT;
  function CMS_signed_add1_attr_by_OBJ(si: PCMS_SignerInfo; const obj: PASN1_OBJECT; type_: TIdC_INT; const bytes: Pointer; len: TIdC_INT): TIdC_INT;
  function CMS_signed_add1_attr_by_NID(si: PCMS_SignerInfo; nid: TIdC_INT; type_: TIdC_INT; const bytes: Pointer; len: TIdC_INT): TIdC_INT;
  function CMS_signed_add1_attr_by_txt(si: PCMS_SignerInfo; const attrname: PAnsiChar; type_: TIdC_INT; const bytes: Pointer; len: TIdC_INT): TIdC_INT;
  function CMS_signed_get0_data_by_OBJ(si: PCMS_SignerInfo; const oid: PASN1_OBJECT; lastpos: TIdC_INT; type_: TIdC_INT): Pointer;

  function CMS_unsigned_get_attr_count(const si: PCMS_SignerInfo): TIdC_INT;
  function CMS_unsigned_get_attr_by_NID(const si: PCMS_SignerInfo; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT;
  function CMS_unsigned_get_attr_by_OBJ(const si: PCMS_SignerInfo; const obj: PASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT;
  function CMS_unsigned_get_attr(const si: PCMS_SignerInfo; loc: TIdC_INT): PX509_ATTRIBUTE;
  function CMS_unsigned_delete_attr(si: PCMS_SignerInfo; loc: TIdC_INT): PX509_ATTRIBUTE;
  function CMS_unsigned_add1_attr(si: PCMS_SignerInfo; attr: PX509_ATTRIBUTE): TIdC_INT;
  function CMS_unsigned_add1_attr_by_OBJ(si: PCMS_SignerInfo; const obj: PASN1_OBJECT; type_: TIdC_INT; const bytes: Pointer; len: TIdC_INT): TIdC_INT;
  function CMS_unsigned_add1_attr_by_NID(si: PCMS_SignerInfo; nid: TIdC_INT; type_: TIdC_INT; const bytes: Pointer; len: TIdC_INT): TIdC_INT;
  function CMS_unsigned_add1_attr_by_txt(si: PCMS_SignerInfo; const attrname: PAnsiChar; type_: TIdC_INT; const bytes: Pointer; len: TIdC_INT): TIdC_INT;
  function CMS_unsigned_get0_data_by_OBJ(si: PCMS_SignerInfo; oid: PASN1_OBJECT; lastpos: TIdC_INT; type_: TIdC_INT): Pointer;

  function CMS_get1_ReceiptRequest(si: PCMS_SignerInfo; prr: PPCMS_ReceiptRequest): TIdC_INT;
//  function CMS_ReceiptRequest_create0(id: PByte; idlen: TIdC_INT; allorfirst: TIdC_INT
//    {;STACK_OF(GENERAL_NAMES) *receiptList;} {STACK_OF(GENERAL_NAMES) *receiptsTo}): PCMS_ReceiptRequest;
  function CMS_add1_ReceiptRequest(si: PCMS_SignerInfo; rr: PCMS_ReceiptRequest): TIdC_INT;
//  procedure CMS_ReceiptRequest_get0_values(rr: PCMS_ReceiptRequest; pcid: PPASN1_STRING;
//    pallorfirst: PIdC_INT {;STACK_OF(GENERAL_NAMES) **plist;}
//    {STACK_OF(GENERAL_NAMES) **prto});
//  function CMS_RecipientInfo_kari_get0_alg(ri: PCMS_RecipientInfo; palg: PPX509_ALGOR;
//    pukm: PPASN1_OCTET_STRING): TIdC_INT;
//  // STACK_OF(CMS_RecipientEncryptedKey) *CMS_RecipientInfo_kari_get0_reks(CMS_RecipientInfo *ri);

  function CMS_RecipientInfo_kari_get0_orig_id(ri: PCMS_RecipientInfo; pubalg: PPX509_ALGOR; pubkey: PASN1_BIT_STRING; keyid: PPASN1_OCTET_STRING; issuer: PPX509_NAME; sno: PPASN1_INTEGER): TIdC_INT;

  function CMS_RecipientInfo_kari_orig_id_cmp(ri: PCMS_RecipientInfo; cert: PX509): TIdC_INT;

  function CMS_RecipientEncryptedKey_get0_id(rek: PCMS_RecipientEncryptedKey; keyid: PPASN1_OCTET_STRING; tm: PPASN1_GENERALIZEDTIME; other: PPCMS_OtherKeyAttribute; issuer: PPX509_NAME; sno: PPASN1_INTEGER): TIdC_INT;
  function CMS_RecipientEncryptedKey_cert_cmp(rek: PCMS_RecipientEncryptedKey; cert: PX509): TIdC_INT;
  function CMS_RecipientInfo_kari_set0_pkey(ri: PCMS_RecipientInfo; pk: PEVP_PKEY): TIdC_INT;
  function CMS_RecipientInfo_kari_get0_ctx(ri: PCMS_RecipientInfo): PEVP_CIPHER_CTX;
  function CMS_RecipientInfo_kari_decrypt(cms: PCMS_ContentInfo; ri: PCMS_RecipientInfo; rek: PCMS_RecipientEncryptedKey): TIdC_INT;

  function CMS_SharedInfo_encode(pder: PPByte; kekalg: PX509_ALGOR; ukm: PASN1_OCTET_STRING; keylen: TIdC_INT): TIdC_INT;

  ///* Backward compatibility for spelling errors. */
  //# define CMS_R_UNKNOWN_DIGEST_ALGORITM CMS_R_UNKNOWN_DIGEST_ALGORITHM
  //# define CMS_R_UNSUPPORTED_RECPIENTINFO_TYPE \ CMS_R_UNSUPPORTED_RECIPIENTINFO_TYPE

implementation

end.
