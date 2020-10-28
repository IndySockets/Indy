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

unit IdOpenSSLHeaders_cms;

interface

// Headers for OpenSSL 1.1.1
// cms.h

{$i IdCompilerDefines.inc}

uses
  Classes,
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

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);
procedure UnLoad;

var
  CMS_get0_type: function(const cms: PCMS_ContentInfo): PASN1_OBJECT cdecl = nil;

  CMS_dataInit: function(cms: PCMS_ContentInfo; icont: PBIO): PBIO cdecl = nil;
  CMS_dataFinal: function(cms: PCMS_ContentInfo; bio: PBIO): TIdC_INT cdecl = nil;

  CMS_get0_content: function(cms: PCMS_ContentInfo): PPASN1_OCTET_STRING cdecl = nil;
  CMS_is_detached: function(cms: PCMS_ContentInfo): TIdC_INT cdecl = nil;
  CMS_set_detached: function(cms: PCMS_ContentInfo; detached: TIdC_INT): TIdC_INT cdecl = nil;

  CMS_stream: function(cms: PCMS_ContentInfo; boundary: PPPByte): TIdC_INT cdecl = nil;
  d2i_CMS_bio: function(bp: PBIO; cms: PPCMS_ContentInfo): PCMS_ContentInfo cdecl = nil;
  i2d_CMS_bio: function(bp: PBIO; cms: PCMS_ContentInfo): TIdC_INT cdecl = nil;

  BIO_new_CMS: function(&out: PBIO; cms: PCMS_ContentInfo): PBIO cdecl = nil;
  i2d_CMS_bio_stream: function(&out: PBIO; cms: PCMS_ContentInfo; in_: PBIO; flags: TIdC_INT): TIdC_INT cdecl = nil;
  PEM_write_bio_CMS_stream: function(&out: PBIO; cms: PCMS_ContentInfo; in_: PBIO; flags: TIdC_INT): TIdC_INT cdecl = nil;
  SMIME_read_CMS: function(bio: PBIO; bcont: PPBIO): PCMS_ContentInfo cdecl = nil;
  SMIME_write_CMS: function(bio: PBIO; cms: PCMS_ContentInfo; data: PBIO; flags: TIdC_INT): TIdC_INT cdecl = nil;

  CMS_final: function(cms: PCMS_ContentInfo; data: PBIO; dcont: PBIO; flags: TIdC_UINT): TIdC_INT cdecl = nil;

//  function CMS_sign(signcert: PX509; pkey: PEVP_PKEY; {STACK_OF(x509) *certs;} data: PBIO; flags: TIdC_UINT): PCMS_ContentInfo;

//  function CMS_sign_receipt(si: PCMS_SignerInfo; signcert: PX509; pkey: PEVP_PKEY; {STACK_OF(X509) *certs;} flags: TIdC_UINT): PCMS_ContentInfo;

  CMS_data: function(cms: PCMS_ContentInfo; out_: PBIO; flags: TIdC_UINT): TIdC_INT cdecl = nil;
  CMS_data_create: function(&in: PBIO; flags: TIdC_UINT): PCMS_ContentInfo cdecl = nil;

  CMS_digest_verify: function(cms: PCMS_ContentInfo; dcont: PBIO; out_: PBIO; flags: TIdC_UINT): TIdC_INT cdecl = nil;
  CMS_digest_create: function(&in: PBIO; const md: PEVP_MD; flags: TIdC_UINT): PCMS_ContentInfo cdecl = nil;

  CMS_EncryptedData_decrypt: function(cms: PCMS_ContentInfo; const key: PByte; keylen: TIdC_SIZET; dcont: PBIO; out_: PBIO; flags: TIdC_UINT): TIdC_INT cdecl = nil;

  CMS_EncryptedData_encrypt: function(&in: PBIO; const cipher: PEVP_CIPHER; const key: PByte; keylen: TIdC_SIZET; flags: TIdC_UINT): PCMS_ContentInfo cdecl = nil;

  CMS_EncryptedData_set1_key: function(cms: PCMS_ContentInfo; const ciph: PEVP_CIPHER; const key: PByte; keylen: TIdC_SIZET): TIdC_INT cdecl = nil;

//  function CMS_verify(cms: PCMS_ContentInfo; {STACK_OF(X509) *certs;} store: PX509_STORE; dcont: PBIO; out_: PBIO; flags: TIdC_UINT): TIdC_INT;

//  function CMS_verify_receipt(rcms: PCMS_ContentInfo; ocms: PCMS_ContentInfo; {STACK_OF(x509) *certs;} store: PX509_STORE; flags: TIdC_UINT): TIdC_INT;

  // STACK_OF(X509) *CMS_get0_signers(CMS_ContentInfo *cms);

//  function CMS_encrypt({STACK_OF(x509) *certs;} in_: PBIO; const cipher: PEVP_CIPHER; flags: TIdC_UINT): PCMS_ContentInfo;

  CMS_decrypt: function(cms: PCMS_ContentInfo; pkey: PEVP_PKEY; cert: PX509; dcont: PBIO; out_: PBIO; flags: TIdC_UINT): TIdC_INT cdecl = nil;

  CMS_decrypt_set1_pkey: function(cms: PCMS_ContentInfo; pk: PEVP_PKEY; cert: PX509): TIdC_INT cdecl = nil;
  CMS_decrypt_set1_key: function(cms: PCMS_ContentInfo; key: PByte; keylen: TIdC_SIZET; const id: PByte; idlen: TIdC_SIZET): TIdC_INT cdecl = nil;
  CMS_decrypt_set1_password: function(cms: PCMS_ContentInfo; pass: PByte; passlen: ossl_ssize_t): TIdC_INT cdecl = nil;

  //STACK_OF(CMS_RecipientInfo) *CMS_get0_RecipientInfos(CMS_ContentInfo *cms);
  CMS_RecipientInfo_type: function(ri: PCMS_RecipientInfo): TIdC_INT cdecl = nil;
  CMS_RecipientInfo_get0_pkey_ctx: function(ri: PCMS_RecipientInfo): PEVP_PKEY_CTX cdecl = nil;
  CMS_EnvelopedData_create: function(const cipher: PEVP_CIPHER): PCMS_ContentInfo cdecl = nil;
  CMS_add1_recipient_cert: function(cms: PCMS_ContentInfo; recip: PX509; flags: TIdC_UINT): PCMS_RecipientInfo cdecl = nil;
  CMS_RecipientInfo_set0_pkey: function(ri: PCMS_RecipientInfo; pkey: PEVP_PKEY): TIdC_INT cdecl = nil;
  CMS_RecipientInfo_ktri_cert_cmp: function(ri: PCMS_RecipientInfo; cert: PX509): TIdC_INT cdecl = nil;
  CMS_RecipientInfo_ktri_get0_algs: function(ri: PCMS_RecipientInfo; pk: PPEVP_PKEY; recip: PPX509; palg: PPX509_ALGOR): TIdC_INT cdecl = nil;
  CMS_RecipientInfo_ktri_get0_signer_id: function(ri: PPCMS_RecipientInfo; keyid: PPASN1_OCTET_STRING; issuer: PPX509_NAME; sno: PPASN1_INTEGER): TIdC_INT cdecl = nil;

  CMS_add0_recipient_key: function(cms: PCMS_ContentInfo; nid: TIdC_INT; key: PByte; keylen: TIdC_SIZET; id: PByte; idlen: TIdC_SIZET; date: PASN1_GENERALIZEDTIME; otherTypeId: PASN1_OBJECT; otherType: ASN1_TYPE): PCMS_RecipientInfo cdecl = nil;

  CMS_RecipientInfo_kekri_get0_id: function(ri: PCMS_RecipientInfo; palg: PPX509_ALGOR; pid: PPASN1_OCTET_STRING; pdate: PPASN1_GENERALIZEDTIME; potherid: PPASN1_OBJECT; pothertype: PASN1_TYPE): TIdC_INT cdecl = nil;

  CMS_RecipientInfo_set0_key: function(ri: PCMS_RecipientInfo; key: PByte; keylen: TIdC_SIZET): TIdC_INT cdecl = nil;

  CMS_RecipientInfo_kekri_id_cmp: function(ri: PCMS_RecipientInfo; const id: PByte; idlen: TIdC_SIZET): TIdC_INT cdecl = nil;

  CMS_RecipientInfo_set0_password: function(ri: PCMS_RecipientInfo; pass: PByte; passlen: ossl_ssize_t): TIdC_INT cdecl = nil;

  CMS_add0_recipient_password: function(cms: PCMS_ContentInfo; iter: TIdC_INT; wrap_nid: TIdC_INT; pbe_nid: TIdC_INT; pass: PByte; passlen: ossl_ssize_t; const kekciph: PEVP_CIPHER): PCMS_RecipientInfo cdecl = nil;

  CMS_RecipientInfo_decrypt: function(cms: PCMS_ContentInfo; ri: PCMS_RecipientInfo): TIdC_INT cdecl = nil;
  CMS_RecipientInfo_encrypt: function(cms: PCMS_ContentInfo; ri: PCMS_RecipientInfo): TIdC_INT cdecl = nil;

  CMS_uncompress: function(cms: PCMS_ContentInfo; dcont: PBIO; out_: PBIO; flags: TIdC_UINT): TIdC_INT cdecl = nil;
  CMS_compress: function(&in: PBIO; comp_nid: TIdC_INT; flags: TIdC_UINT): PCMS_ContentInfo cdecl = nil;

  CMS_set1_eContentType: function(cms: CMS_ContentInfo; const oit: PASN1_OBJECT): TIdC_INT cdecl = nil;
  CMS_get0_eContentType: function(cms: PCMS_ContentInfo): PASN1_OBJECT cdecl = nil;

  CMS_add0_CertificateChoices: function(cms: PCMS_ContentInfo): PCMS_CertificateChoices cdecl = nil;
  CMS_add0_cert: function(cms: PCMS_ContentInfo; cert: PX509): TIdC_INT cdecl = nil;
  CMS_add1_cert: function(cms: PCMS_ContentInfo; cert: PX509): TIdC_INT cdecl = nil;
  // STACK_OF(X509) *CMS_get1_certs(CMS_ContentInfo *cms);

  CMS_add0_RevocationInfoChoice: function(cms: PCMS_ContentInfo): PCMS_RevocationInfoChoice cdecl = nil;
  CMS_add0_crl: function(cms: PCMS_ContentInfo; crl: PX509_CRL): TIdC_INT cdecl = nil;
  CMS_add1_crl: function(cms: PCMS_ContentInfo; crl: PX509_CRL): TIdC_INT cdecl = nil;
  // STACK_OF(X509_CRL) *CMS_get1_crls(CMS_ContentInfo *cms);

  CMS_SignedData_init: function(cms: PCMS_ContentInfo): TIdC_INT cdecl = nil;
  CMS_add1_signer: function(cms: PCMS_ContentInfo; signer: PX509; pk: PEVP_PKEY; const md: PEVP_MD; flags: TIdC_UINT): PCMS_SignerInfo cdecl = nil;
  CMS_SignerInfo_get0_pkey_ctx: function(si: PCMS_SignerInfo): PEVP_PKEY_CTX cdecl = nil;
  CMS_SignerInfo_get0_md_ctx: function(si: PCMS_SignerInfo): PEVP_MD_CTX cdecl = nil;
  // STACK_OF(CMS_SignerInfo) *CMS_get0_SignerInfos(CMS_ContentInfo *cms);

  CMS_SignerInfo_set1_signer_cert: procedure(si: PCMS_SignerInfo; signer: PX509) cdecl = nil;
  CMS_SignerInfo_get0_signer_id: function(si: PCMS_SignerInfo; keyid: PPASN1_OCTET_STRING; issuer: PPX509_NAME; sno: PPASN1_INTEGER): TIdC_INT cdecl = nil;
  CMS_SignerInfo_cert_cmp: function(si: PCMS_SignerInfo; cert: PX509): TIdC_INT cdecl = nil;
//  function CMS_set1_signers_certs(cms: PCMS_ContentInfo; {STACK_OF(X509) *certs;} flags: TIdC_UINT): TIdC_INT;
  CMS_SignerInfo_get0_algs: procedure(si: PCMS_SignerInfo; pk: PPEVP_PKEY; signer: PPX509; pdig: PPX509_ALGOR; psig: PPX509_ALGOR) cdecl = nil;
  CMS_SignerInfo_get0_signature: function(si: PCMS_SignerInfo): PASN1_OCTET_STRING cdecl = nil;
  CMS_SignerInfo_sign: function(si: PCMS_SignerInfo): TIdC_INT cdecl = nil;
  CMS_SignerInfo_verify: function(si: PCMS_SignerInfo): TIdC_INT cdecl = nil;
  CMS_SignerInfo_verify_content: function(si: PCMS_SignerInfo; chain: PBIO): TIdC_INT cdecl = nil;

//  function CMS_add_smimecap(si: PCMS_SignerInfo{; STACK_OF(X509_ALGOR) *algs}): TIdC_INT;
//  function CMS_add_simple_smimecap({STACK_OF(X509_ALGOR) **algs;} algnid: TIdC_INT; keysize: TIdC_INT): TIdC_INT;
//  function CMS_add_standard_smimecap({STACK_OF(X509_ALGOR) **smcap}): TIdC_INT;

  CMS_signed_get_attr_count: function(const si: PCMS_SignerInfo): TIdC_INT cdecl = nil;
  CMS_signed_get_attr_by_NID: function(const si: PCMS_SignerInfo; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  CMS_signed_get_attr_by_OBJ: function(const si: PCMS_SignerInfo; const obj: ASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  CMS_signed_get_attr: function(const si: PCMS_SignerInfo; loc: TIdC_INT): PX509_ATTRIBUTE cdecl = nil;
  CMS_signed_delete_attr: function(const si: PCMS_SignerInfo; loc: TIdC_INT): PX509_ATTRIBUTE cdecl = nil;
  CMS_signed_add1_attr: function(si: PCMS_SignerInfo; loc: TIdC_INT): TIdC_INT cdecl = nil;
  CMS_signed_add1_attr_by_OBJ: function(si: PCMS_SignerInfo; const obj: PASN1_OBJECT; type_: TIdC_INT; const bytes: Pointer; len: TIdC_INT): TIdC_INT cdecl = nil;
  CMS_signed_add1_attr_by_NID: function(si: PCMS_SignerInfo; nid: TIdC_INT; type_: TIdC_INT; const bytes: Pointer; len: TIdC_INT): TIdC_INT cdecl = nil;
  CMS_signed_add1_attr_by_txt: function(si: PCMS_SignerInfo; const attrname: PAnsiChar; type_: TIdC_INT; const bytes: Pointer; len: TIdC_INT): TIdC_INT cdecl = nil;
  CMS_signed_get0_data_by_OBJ: function(si: PCMS_SignerInfo; const oid: PASN1_OBJECT; lastpos: TIdC_INT; type_: TIdC_INT): Pointer cdecl = nil;

  CMS_unsigned_get_attr_count: function(const si: PCMS_SignerInfo): TIdC_INT cdecl = nil;
  CMS_unsigned_get_attr_by_NID: function(const si: PCMS_SignerInfo; nid: TIdC_INT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  CMS_unsigned_get_attr_by_OBJ: function(const si: PCMS_SignerInfo; const obj: PASN1_OBJECT; lastpos: TIdC_INT): TIdC_INT cdecl = nil;
  CMS_unsigned_get_attr: function(const si: PCMS_SignerInfo; loc: TIdC_INT): PX509_ATTRIBUTE cdecl = nil;
  CMS_unsigned_delete_attr: function(si: PCMS_SignerInfo; loc: TIdC_INT): PX509_ATTRIBUTE cdecl = nil;
  CMS_unsigned_add1_attr: function(si: PCMS_SignerInfo; attr: PX509_ATTRIBUTE): TIdC_INT cdecl = nil;
  CMS_unsigned_add1_attr_by_OBJ: function(si: PCMS_SignerInfo; const obj: PASN1_OBJECT; type_: TIdC_INT; const bytes: Pointer; len: TIdC_INT): TIdC_INT cdecl = nil;
  CMS_unsigned_add1_attr_by_NID: function(si: PCMS_SignerInfo; nid: TIdC_INT; type_: TIdC_INT; const bytes: Pointer; len: TIdC_INT): TIdC_INT cdecl = nil;
  CMS_unsigned_add1_attr_by_txt: function(si: PCMS_SignerInfo; const attrname: PAnsiChar; type_: TIdC_INT; const bytes: Pointer; len: TIdC_INT): TIdC_INT cdecl = nil;
  CMS_unsigned_get0_data_by_OBJ: function(si: PCMS_SignerInfo; oid: PASN1_OBJECT; lastpos: TIdC_INT; type_: TIdC_INT): Pointer cdecl = nil;

  CMS_get1_ReceiptRequest: function(si: PCMS_SignerInfo; prr: PPCMS_ReceiptRequest): TIdC_INT cdecl = nil;
//  function CMS_ReceiptRequest_create0(id: PByte; idlen: TIdC_INT; allorfirst: TIdC_INT
//    {;STACK_OF(GENERAL_NAMES) *receiptList;} {STACK_OF(GENERAL_NAMES) *receiptsTo}): PCMS_ReceiptRequest;
  CMS_add1_ReceiptRequest: function(si: PCMS_SignerInfo; rr: PCMS_ReceiptRequest): TIdC_INT cdecl = nil;
//  procedure CMS_ReceiptRequest_get0_values(rr: PCMS_ReceiptRequest; pcid: PPASN1_STRING;
//    pallorfirst: PIdC_INT {;STACK_OF(GENERAL_NAMES) **plist;}
//    {STACK_OF(GENERAL_NAMES) **prto});
//  function CMS_RecipientInfo_kari_get0_alg(ri: PCMS_RecipientInfo; palg: PPX509_ALGOR;
//    pukm: PPASN1_OCTET_STRING): TIdC_INT;
//  // STACK_OF(CMS_RecipientEncryptedKey) *CMS_RecipientInfo_kari_get0_reks(CMS_RecipientInfo *ri);

  CMS_RecipientInfo_kari_get0_orig_id: function(ri: PCMS_RecipientInfo; pubalg: PPX509_ALGOR; pubkey: PASN1_BIT_STRING; keyid: PPASN1_OCTET_STRING; issuer: PPX509_NAME; sno: PPASN1_INTEGER): TIdC_INT cdecl = nil;

  CMS_RecipientInfo_kari_orig_id_cmp: function(ri: PCMS_RecipientInfo; cert: PX509): TIdC_INT cdecl = nil;

  CMS_RecipientEncryptedKey_get0_id: function(rek: PCMS_RecipientEncryptedKey; keyid: PPASN1_OCTET_STRING; tm: PPASN1_GENERALIZEDTIME; other: PPCMS_OtherKeyAttribute; issuer: PPX509_NAME; sno: PPASN1_INTEGER): TIdC_INT cdecl = nil;
  CMS_RecipientEncryptedKey_cert_cmp: function(rek: PCMS_RecipientEncryptedKey; cert: PX509): TIdC_INT cdecl = nil;
  CMS_RecipientInfo_kari_set0_pkey: function(ri: PCMS_RecipientInfo; pk: PEVP_PKEY): TIdC_INT cdecl = nil;
  CMS_RecipientInfo_kari_get0_ctx: function(ri: PCMS_RecipientInfo): PEVP_CIPHER_CTX cdecl = nil;
  CMS_RecipientInfo_kari_decrypt: function(cms: PCMS_ContentInfo; ri: PCMS_RecipientInfo; rek: PCMS_RecipientEncryptedKey): TIdC_INT cdecl = nil;

  CMS_SharedInfo_encode: function(pder: PPByte; kekalg: PX509_ALGOR; ukm: PASN1_OCTET_STRING; keylen: TIdC_INT): TIdC_INT cdecl = nil;

  ///* Backward compatibility for spelling errors. */
  //# define CMS_R_UNKNOWN_DIGEST_ALGORITM CMS_R_UNKNOWN_DIGEST_ALGORITHM
  //# define CMS_R_UNSUPPORTED_RECPIENTINFO_TYPE \ CMS_R_UNSUPPORTED_RECIPIENTINFO_TYPE

implementation

procedure Load(const ADllHandle: TIdLibHandle; const AFailed: TStringList);

  function LoadFunction(const AMethodName: string; const AFailed: TStringList): Pointer;
  begin
    Result := LoadLibFunction(ADllHandle, AMethodName);
    if not Assigned(Result) then
      AFailed.Add(AMethodName);
  end;

begin
  CMS_get0_type := LoadFunction('CMS_get0_type', AFailed);
  CMS_dataInit := LoadFunction('CMS_dataInit', AFailed);
  CMS_dataFinal := LoadFunction('CMS_dataFinal', AFailed);
  CMS_get0_content := LoadFunction('CMS_get0_content', AFailed);
  CMS_is_detached := LoadFunction('CMS_is_detached', AFailed);
  CMS_set_detached := LoadFunction('CMS_set_detached', AFailed);
  CMS_stream := LoadFunction('CMS_stream', AFailed);
  d2i_CMS_bio := LoadFunction('d2i_CMS_bio', AFailed);
  i2d_CMS_bio := LoadFunction('i2d_CMS_bio', AFailed);
  BIO_new_CMS := LoadFunction('BIO_new_CMS', AFailed);
  i2d_CMS_bio_stream := LoadFunction('i2d_CMS_bio_stream', AFailed);
  PEM_write_bio_CMS_stream := LoadFunction('PEM_write_bio_CMS_stream', AFailed);
  SMIME_read_CMS := LoadFunction('SMIME_read_CMS', AFailed);
  SMIME_write_CMS := LoadFunction('SMIME_write_CMS', AFailed);
  CMS_final := LoadFunction('CMS_final', AFailed);
  CMS_data := LoadFunction('CMS_data', AFailed);
  CMS_data_create := LoadFunction('CMS_data_create', AFailed);
  CMS_digest_verify := LoadFunction('CMS_digest_verify', AFailed);
  CMS_digest_create := LoadFunction('CMS_digest_create', AFailed);
  CMS_EncryptedData_decrypt := LoadFunction('CMS_EncryptedData_decrypt', AFailed);
  CMS_EncryptedData_encrypt := LoadFunction('CMS_EncryptedData_encrypt', AFailed);
  CMS_EncryptedData_set1_key := LoadFunction('CMS_EncryptedData_set1_key', AFailed);
  CMS_decrypt := LoadFunction('CMS_decrypt', AFailed);
  CMS_decrypt_set1_pkey := LoadFunction('CMS_decrypt_set1_pkey', AFailed);
  CMS_decrypt_set1_key := LoadFunction('CMS_decrypt_set1_key', AFailed);
  CMS_decrypt_set1_password := LoadFunction('CMS_decrypt_set1_password', AFailed);
  CMS_RecipientInfo_type := LoadFunction('CMS_RecipientInfo_type', AFailed);
  CMS_RecipientInfo_get0_pkey_ctx := LoadFunction('CMS_RecipientInfo_get0_pkey_ctx', AFailed);
  CMS_EnvelopedData_create := LoadFunction('CMS_EnvelopedData_create', AFailed);
  CMS_add1_recipient_cert := LoadFunction('CMS_add1_recipient_cert', AFailed);
  CMS_RecipientInfo_set0_pkey := LoadFunction('CMS_RecipientInfo_set0_pkey', AFailed);
  CMS_RecipientInfo_ktri_cert_cmp := LoadFunction('CMS_RecipientInfo_ktri_cert_cmp', AFailed);
  CMS_RecipientInfo_ktri_get0_algs := LoadFunction('CMS_RecipientInfo_ktri_get0_algs', AFailed);
  CMS_RecipientInfo_ktri_get0_signer_id := LoadFunction('CMS_RecipientInfo_ktri_get0_signer_id', AFailed);
  CMS_add0_recipient_key := LoadFunction('CMS_add0_recipient_key', AFailed);
  CMS_RecipientInfo_kekri_get0_id := LoadFunction('CMS_RecipientInfo_kekri_get0_id', AFailed);
  CMS_RecipientInfo_set0_key := LoadFunction('CMS_RecipientInfo_set0_key', AFailed);
  CMS_RecipientInfo_kekri_id_cmp := LoadFunction('CMS_RecipientInfo_kekri_id_cmp', AFailed);
  CMS_RecipientInfo_set0_password := LoadFunction('CMS_RecipientInfo_set0_password', AFailed);
  CMS_add0_recipient_password := LoadFunction('CMS_add0_recipient_password', AFailed);
  CMS_RecipientInfo_decrypt := LoadFunction('CMS_RecipientInfo_decrypt', AFailed);
  CMS_RecipientInfo_encrypt := LoadFunction('CMS_RecipientInfo_encrypt', AFailed);
  CMS_uncompress := LoadFunction('CMS_uncompress', AFailed);
  CMS_compress := LoadFunction('CMS_compress', AFailed);
  CMS_set1_eContentType := LoadFunction('CMS_set1_eContentType', AFailed);
  CMS_get0_eContentType := LoadFunction('CMS_get0_eContentType', AFailed);
  CMS_add0_CertificateChoices := LoadFunction('CMS_add0_CertificateChoices', AFailed);
  CMS_add0_cert := LoadFunction('CMS_add0_cert', AFailed);
  CMS_add1_cert := LoadFunction('CMS_add1_cert', AFailed);
  CMS_add0_RevocationInfoChoice := LoadFunction('CMS_add0_RevocationInfoChoice', AFailed);
  CMS_add0_crl := LoadFunction('CMS_add0_crl', AFailed);
  CMS_add1_crl := LoadFunction('CMS_add1_crl', AFailed);
  CMS_SignedData_init := LoadFunction('CMS_SignedData_init', AFailed);
  CMS_add1_signer := LoadFunction('CMS_add1_signer', AFailed);
  CMS_SignerInfo_get0_pkey_ctx := LoadFunction('CMS_SignerInfo_get0_pkey_ctx', AFailed);
  CMS_SignerInfo_get0_md_ctx := LoadFunction('CMS_SignerInfo_get0_md_ctx', AFailed);
  CMS_SignerInfo_set1_signer_cert := LoadFunction('CMS_SignerInfo_set1_signer_cert', AFailed);
  CMS_SignerInfo_get0_signer_id := LoadFunction('CMS_SignerInfo_get0_signer_id', AFailed);
  CMS_SignerInfo_cert_cmp := LoadFunction('CMS_SignerInfo_cert_cmp', AFailed);
  CMS_SignerInfo_get0_algs := LoadFunction('CMS_SignerInfo_get0_algs', AFailed);
  CMS_SignerInfo_get0_signature := LoadFunction('CMS_SignerInfo_get0_signature', AFailed);
  CMS_SignerInfo_sign := LoadFunction('CMS_SignerInfo_sign', AFailed);
  CMS_SignerInfo_verify := LoadFunction('CMS_SignerInfo_verify', AFailed);
  CMS_SignerInfo_verify_content := LoadFunction('CMS_SignerInfo_verify_content', AFailed);
  CMS_signed_get_attr_count := LoadFunction('CMS_signed_get_attr_count', AFailed);
  CMS_signed_get_attr_by_NID := LoadFunction('CMS_signed_get_attr_by_NID', AFailed);
  CMS_signed_get_attr_by_OBJ := LoadFunction('CMS_signed_get_attr_by_OBJ', AFailed);
  CMS_signed_get_attr := LoadFunction('CMS_signed_get_attr', AFailed);
  CMS_signed_delete_attr := LoadFunction('CMS_signed_delete_attr', AFailed);
  CMS_signed_add1_attr := LoadFunction('CMS_signed_add1_attr', AFailed);
  CMS_signed_add1_attr_by_OBJ := LoadFunction('CMS_signed_add1_attr_by_OBJ', AFailed);
  CMS_signed_add1_attr_by_NID := LoadFunction('CMS_signed_add1_attr_by_NID', AFailed);
  CMS_signed_add1_attr_by_txt := LoadFunction('CMS_signed_add1_attr_by_txt', AFailed);
  CMS_signed_get0_data_by_OBJ := LoadFunction('CMS_signed_get0_data_by_OBJ', AFailed);
  CMS_unsigned_get_attr_count := LoadFunction('CMS_unsigned_get_attr_count', AFailed);
  CMS_unsigned_get_attr_by_NID := LoadFunction('CMS_unsigned_get_attr_by_NID', AFailed);
  CMS_unsigned_get_attr_by_OBJ := LoadFunction('CMS_unsigned_get_attr_by_OBJ', AFailed);
  CMS_unsigned_get_attr := LoadFunction('CMS_unsigned_get_attr', AFailed);
  CMS_unsigned_delete_attr := LoadFunction('CMS_unsigned_delete_attr', AFailed);
  CMS_unsigned_add1_attr := LoadFunction('CMS_unsigned_add1_attr', AFailed);
  CMS_unsigned_add1_attr_by_OBJ := LoadFunction('CMS_unsigned_add1_attr_by_OBJ', AFailed);
  CMS_unsigned_add1_attr_by_NID := LoadFunction('CMS_unsigned_add1_attr_by_NID', AFailed);
  CMS_unsigned_add1_attr_by_txt := LoadFunction('CMS_unsigned_add1_attr_by_txt', AFailed);
  CMS_unsigned_get0_data_by_OBJ := LoadFunction('CMS_unsigned_get0_data_by_OBJ', AFailed);
  CMS_get1_ReceiptRequest := LoadFunction('CMS_get1_ReceiptRequest', AFailed);
  CMS_add1_ReceiptRequest := LoadFunction('CMS_add1_ReceiptRequest', AFailed);
  CMS_RecipientInfo_kari_get0_orig_id := LoadFunction('CMS_RecipientInfo_kari_get0_orig_id', AFailed);
  CMS_RecipientInfo_kari_orig_id_cmp := LoadFunction('CMS_RecipientInfo_kari_orig_id_cmp', AFailed);
  CMS_RecipientEncryptedKey_get0_id := LoadFunction('CMS_RecipientEncryptedKey_get0_id', AFailed);
  CMS_RecipientEncryptedKey_cert_cmp := LoadFunction('CMS_RecipientEncryptedKey_cert_cmp', AFailed);
  CMS_RecipientInfo_kari_set0_pkey := LoadFunction('CMS_RecipientInfo_kari_set0_pkey', AFailed);
  CMS_RecipientInfo_kari_get0_ctx := LoadFunction('CMS_RecipientInfo_kari_get0_ctx', AFailed);
  CMS_RecipientInfo_kari_decrypt := LoadFunction('CMS_RecipientInfo_kari_decrypt', AFailed);
  CMS_SharedInfo_encode := LoadFunction('CMS_SharedInfo_encode', AFailed);
end;

procedure UnLoad;
begin
  CMS_get0_type := nil;
  CMS_dataInit := nil;
  CMS_dataFinal := nil;
  CMS_get0_content := nil;
  CMS_is_detached := nil;
  CMS_set_detached := nil;
  CMS_stream := nil;
  d2i_CMS_bio := nil;
  i2d_CMS_bio := nil;
  BIO_new_CMS := nil;
  i2d_CMS_bio_stream := nil;
  PEM_write_bio_CMS_stream := nil;
  SMIME_read_CMS := nil;
  SMIME_write_CMS := nil;
  CMS_final := nil;
  CMS_data := nil;
  CMS_data_create := nil;
  CMS_digest_verify := nil;
  CMS_digest_create := nil;
  CMS_EncryptedData_decrypt := nil;
  CMS_EncryptedData_encrypt := nil;
  CMS_EncryptedData_set1_key := nil;
  CMS_decrypt := nil;
  CMS_decrypt_set1_pkey := nil;
  CMS_decrypt_set1_key := nil;
  CMS_decrypt_set1_password := nil;
  CMS_RecipientInfo_type := nil;
  CMS_RecipientInfo_get0_pkey_ctx := nil;
  CMS_EnvelopedData_create := nil;
  CMS_add1_recipient_cert := nil;
  CMS_RecipientInfo_set0_pkey := nil;
  CMS_RecipientInfo_ktri_cert_cmp := nil;
  CMS_RecipientInfo_ktri_get0_algs := nil;
  CMS_RecipientInfo_ktri_get0_signer_id := nil;
  CMS_add0_recipient_key := nil;
  CMS_RecipientInfo_kekri_get0_id := nil;
  CMS_RecipientInfo_set0_key := nil;
  CMS_RecipientInfo_kekri_id_cmp := nil;
  CMS_RecipientInfo_set0_password := nil;
  CMS_add0_recipient_password := nil;
  CMS_RecipientInfo_decrypt := nil;
  CMS_RecipientInfo_encrypt := nil;
  CMS_uncompress := nil;
  CMS_compress := nil;
  CMS_set1_eContentType := nil;
  CMS_get0_eContentType := nil;
  CMS_add0_CertificateChoices := nil;
  CMS_add0_cert := nil;
  CMS_add1_cert := nil;
  CMS_add0_RevocationInfoChoice := nil;
  CMS_add0_crl := nil;
  CMS_add1_crl := nil;
  CMS_SignedData_init := nil;
  CMS_add1_signer := nil;
  CMS_SignerInfo_get0_pkey_ctx := nil;
  CMS_SignerInfo_get0_md_ctx := nil;
  CMS_SignerInfo_set1_signer_cert := nil;
  CMS_SignerInfo_get0_signer_id := nil;
  CMS_SignerInfo_cert_cmp := nil;
  CMS_SignerInfo_get0_algs := nil;
  CMS_SignerInfo_get0_signature := nil;
  CMS_SignerInfo_sign := nil;
  CMS_SignerInfo_verify := nil;
  CMS_SignerInfo_verify_content := nil;
  CMS_signed_get_attr_count := nil;
  CMS_signed_get_attr_by_NID := nil;
  CMS_signed_get_attr_by_OBJ := nil;
  CMS_signed_get_attr := nil;
  CMS_signed_delete_attr := nil;
  CMS_signed_add1_attr := nil;
  CMS_signed_add1_attr_by_OBJ := nil;
  CMS_signed_add1_attr_by_NID := nil;
  CMS_signed_add1_attr_by_txt := nil;
  CMS_signed_get0_data_by_OBJ := nil;
  CMS_unsigned_get_attr_count := nil;
  CMS_unsigned_get_attr_by_NID := nil;
  CMS_unsigned_get_attr_by_OBJ := nil;
  CMS_unsigned_get_attr := nil;
  CMS_unsigned_delete_attr := nil;
  CMS_unsigned_add1_attr := nil;
  CMS_unsigned_add1_attr_by_OBJ := nil;
  CMS_unsigned_add1_attr_by_NID := nil;
  CMS_unsigned_add1_attr_by_txt := nil;
  CMS_unsigned_get0_data_by_OBJ := nil;
  CMS_get1_ReceiptRequest := nil;
  CMS_add1_ReceiptRequest := nil;
  CMS_RecipientInfo_kari_get0_orig_id := nil;
  CMS_RecipientInfo_kari_orig_id_cmp := nil;
  CMS_RecipientEncryptedKey_get0_id := nil;
  CMS_RecipientEncryptedKey_cert_cmp := nil;
  CMS_RecipientInfo_kari_set0_pkey := nil;
  CMS_RecipientInfo_kari_get0_ctx := nil;
  CMS_RecipientInfo_kari_decrypt := nil;
  CMS_SharedInfo_encode := nil;
end;

end.
