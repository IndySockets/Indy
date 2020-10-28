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

unit IdOpenSSLHeaders_pkcs7;

interface

// Headers for OpenSSL 1.1.1
// pkcs7.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts,
  IdOpenSSLHeaders_ossl_typ;

const
  PKCS7_S_HEADER = 0;
  PKCS7_S_BODY   = 1;
  PKCS7_S_TAIL   = 2;

  PKCS7_OP_SET_DETACHED_SIGNATURE = 1;
  PKCS7_OP_GET_DETACHED_SIGNATURE = 2;

  (* S/MIME related flags *)
  PKCS7_TEXT            =     $1;
  PKCS7_NOCERTS         =     $2;
  PKCS7_NOSIGS          =     $4;
  PKCS7_NOCHAIN         =     $8;
  PKCS7_NOINTERN        =    $10;
  PKCS7_NOVERIFY        =    $20;
  PKCS7_DETACHED        =    $40;
  PKCS7_BINARY          =    $80;
  PKCS7_NOATTR          =   $100;
  PKCS7_NOSMIMECAP      =   $200;
  PKCS7_NOOLDMIMETYPE   =   $400;
  PKCS7_CRLFEOL         =   $800;
  // Added '_CONST' to avoid name clashes
  PKCS7_STREAM_CONST    =  $1000;
  PKCS7_NOCRL           =  $2000;
  PKCS7_PARTIAL         =  $4000;
  PKCS7_REUSE_DIGEST    =  $8000;
  PKCS7_NO_DUAL_CONTENT = $10000;

  (* Flags: for compatibility with older code *)
  SMIME_TEXT      = PKCS7_TEXT;
  SMIME_NOCERTS   = PKCS7_NOCERTS;
  SMIME_NOSIGS    = PKCS7_NOSIGS;
  SMIME_NOCHAIN   = PKCS7_NOCHAIN;
  SMIME_NOINTERN  = PKCS7_NOINTERN;
  SMIME_NOVERIFY  = PKCS7_NOVERIFY;
  SMIME_DETACHED  = PKCS7_DETACHED;
  SMIME_BINARY    = PKCS7_BINARY;
  SMIME_NOATTR    = PKCS7_NOATTR;

  (* CRLF ASCII canonicalisation *)
  SMIME_ASCIICRLF = $80000;

type
  PPKCS7 = ^PKCS7;
  PPPKCS7 = ^PPKCS7;

  PPKCS7_DIGEST = ^PKCS7_DIGEST;
  PPPKCS7_DIGEST = ^PPKCS7_DIGEST;

  pkcs7_issuer_and_serial_st = record
    issue: PX509_NAME;
    serial: PASN1_INTEGER;
  end;
  PKCS7_ISSUER_AND_SERIAL = pkcs7_issuer_and_serial_st;
  PPKCS7_ISSUER_AND_SERIAL = ^PKCS7_ISSUER_AND_SERIAL;
  PPPKCS7_ISSUER_AND_SERIAL = ^PPKCS7_ISSUER_AND_SERIAL;

  pkcs7_signer_info_st = record
    version: PASN1_INTEGER;
    issuer_and_serial: PPKCS7_ISSUER_AND_SERIAL;
    digest_alg: PX509_ALGOR;
    auth_attr: Pointer; //PSTACK_OF_X509_ATTRIBUTE;
    digest_enc_alg: PX509_ALGOR;
    enc_digest: PASN1_OCTET_STRING;
    unauth_attr: Pointer; //PSTACK_OF_X509_ATTRIBUTE;
    pkey: PEVP_PKEY;
  end;
  PKCS7_SIGNER_INFO = pkcs7_issuer_and_serial_st;
  PPKCS7_SIGNER_INFO = ^PKCS7_SIGNER_INFO;
  PPPKCS7_SIGNER_INFO = ^PPKCS7_SIGNER_INFO;

  pkcs7_recip_info_st = record
    version: PASN1_INTEGER;
    issuer_and_serial: PPKCS7_ISSUER_AND_SERIAL;
    key_enc_algor: PX509_ALGOR;
    enc_key: PASN1_OCTET_STRING;
    cert: PX509;
  end;
  PKCS7_RECIP_INFO = pkcs7_recip_info_st;
  PPKCS7_RECIP_INFO = ^PKCS7_RECIP_INFO;
  PPPKCS7_RECIP_INFO = ^PPKCS7_RECIP_INFO;

  pkcs7_signed_st = record
    version: PASN1_INTEGER;
    md_algs: Pointer; //PSTACK_OF_X509_ALGOR;
    cert: Pointer; //PSTACK_OF_X509;
    crl: Pointer; //PSTACK_OF_X509_CRL;
    signer_info: Pointer; //PSTACK_OF_PKCS7_SIGNER_INFO;
    contents: PPKCS7;
  end;
  PKCS7_SIGNED = pkcs7_signed_st;
  PPKCS7_SIGNED = ^PKCS7_SIGNED;
  PPPKCS7_SIGNED = ^PPKCS7_SIGNED;

  pkcs7_enc_content_st = record
    content_type: PASN1_OBJECT;
    algorithm: PX509_ALGOR;
    enc_data: PASN1_OCTET_STRING;
    cipher: PEVP_CIPHER;
  end;
  PKCS7_ENC_CONTENT = pkcs7_enc_content_st;
  PPKCS7_ENC_CONTENT = ^PKCS7_ENC_CONTENT;
  PPPKCS7_ENC_CONTENT = ^PPKCS7_ENC_CONTENT;

  pkcs7_enveloped_st = record
    version: PASN1_INTEGER;
    recipientinfo: Pointer; //PSTACK_OF_PKCS7_RECIP_INFO;
    enc_data: PPKCS7_ENC_CONTENT;
  end;
  PKCS7_ENVELOPE = pkcs7_enveloped_st;
  PPKCS7_ENVELOPE = ^PKCS7_ENVELOPE;
  PPPKCS7_ENVELOPE = ^PPKCS7_ENVELOPE;

  pkcs7_signedandenveloped_st = record
    version: PASN1_INTEGER;
    md_algs: Pointer; //PSTACK_OF_X509_ALGOR;
    cert: Pointer; //PSTACK_OF_X509;
    crl: Pointer; //PSTACK_OF_X509_CRL;
    signer_info: Pointer; //PSTACK_OF_PKCS7_SIGNER_INFO;
    enc_data: PPKCS7_ENC_CONTENT;
    recipientinfo: Pointer; //PSTACK_OF_PKCS7_RECIP_INFO;
  end;
  PKCS7_SIGN_ENVELOPE = pkcs7_signedandenveloped_st;
  PPKCS7_SIGN_ENVELOPE = ^PKCS7_SIGN_ENVELOPE;
  PPPKCS7_SIGN_ENVELOPE = ^PPKCS7_SIGN_ENVELOPE;

  pkcs7_encrypted_st = record
    version: PASN1_INTEGER;
    enc_data: PPKCS7_ENC_CONTENT;
  end;
  // Added '_STRUCT' to avoid name clashes
  PKCS7_ENCRYPT_STRUCT = pkcs7_encrypted_st;
  PPKCS7_ENCRYPT_STRUCT = ^PKCS7_ENCRYPT_STRUCT;
  PPPKCS7_ENCRYPT_STRUCT = ^PPKCS7_ENCRYPT_STRUCT;

  pkcs7_st_d = record
    case Integer of
    0: (ptr: PIdAnsiChar);
    1: (data: PASN1_OCTET_STRING);
    2: (sign: PPKCS7_SIGNED);
    3: (enveloped: PPKCS7_ENVELOPE);
    4: (signed_and_enveloped: PPKCS7_SIGN_ENVELOPE);
    5: (digest: PPKCS7_DIGEST);
    6: (encrypted: PPKCS7_ENCRYPT_STRUCT);
    7: (other: PASN1_TYPE);
  end;
  pkcs7_st = record
    asn1: PByte;
    length: TIdC_LONG;
    state: TIdC_INT;
    detached: TIdC_INT;
    type_: PASN1_OBJECT;
    d: pkcs7_st_d;
  end;
  PKCS7 = pkcs7_st;

  pkcs7_digest_st = record
    version: PASN1_INTEGER;
    md: PX509_ALGOR;
    contents: PPKCS7;
    digest: PASN1_OCTET_STRING;
  end;
  PKCS7_DIGEST = pkcs7_digest_st;

var
  //function PKCS7_ISSUER_AND_SERIAL_new: PPKCS7_ISSUER_AND_SERIAL;
  //procedure PKCS7_ISSUER_AND_SERIAL_free(a: PPKCS7_ISSUER_AND_SERIAL);
  //function d2i_PKCS7_ISSUER_AND_SERIAL(a: PPPKCS7_ISSUER_AND_SERIAL; const in_: PByte; len: TIdC_LONG): PPKCS7_ISSUER_AND_SERIAL;
  //function i2d_PKCS7_ISSUER_AND_SERIAL(const a: PPKCS7_ISSUER_AND_SERIAL; out_: PByte): TIdC_INT;
  //function PKCS7_ISSUER_AND_SERIAL_it: PASN1_ITEM;

  function PKCS7_ISSUER_AND_SERIAL_digest(data: PPKCS7_ISSUER_AND_SERIAL; const type_: PEVP_MD; md: PByte; len: PIdC_UINT): TIdC_INT;

  function PKCS7_dup(p7: PPKCS7): PPKCS7;
  function d2i_PKCS7_bio(bp: PBIO; p7: PPPKCS7): PPKCS7;
  function i2d_PKCS7_bio(bp: PBIO; p7: PPKCS7): TIdC_INT;
  function i2d_PKCS7_bio_stream(&out: PBIO; p7: PPKCS7; in_: PBIO; flags: TIdC_INT): TIdC_INT;
  function PEM_write_bio_PKCS7_stream(&out: PBIO; p7: PPKCS7; in_: PBIO; flags: TIdC_INT): TIdC_INT;

//  function PKCS7_SIGNER_INFO_new: PPKCS7_SIGNER_INFO;
//  procedure PKCS7_SIGNER_INFO_free(a: PPKCS7_SIGNER_INFO);
//  function d2i_PKCS7_SIGNER_INFO(a: PPPKCS7_SIGNER_INFO; const in_: PByte; len: TIdC_LONG): PPKCS7_SIGNER_INFO;
//  function i2d_PKCS7_SIGNER_INFO(const a: PPKCS7_SIGNER_INFO; out_: PByte): TIdC_INT;
//  function PKCS7_SIGNER_INFO_it: PASN1_ITEM;
//
//  function PKCS7_RECIP_INFO_new: PPKCS7_RECIP_INFO;
//  procedure PKCS7_RECIP_INFO_free(a: PPKCS7_RECIP_INFO);
//  function d2i_PKCS7_RECIP_INFO(a: PPPKCS7_RECIP_INFO; const in_: PByte; len: TIdC_LONG): PPKCS7_RECIP_INFO;
//  function i2d_PKCS7_RECIP_INFO(const a: PPKCS7_RECIP_INFO; out_: PByte): TIdC_INT;
//  function PKCS7_RECIP_INFO_it: PASN1_ITEM;
//
//  function PKCS7_SIGNED_new: PPKCS7_SIGNED;
//  procedure PKCS7_SIGNED_free(a: PPKCS7_SIGNED);
//  function d2i_PKCS7_SIGNED(a: PPPKCS7_SIGNED; const in_: PByte; len: TIdC_LONG): PPKCS7_SIGNED;
//  function i2d_PKCS7_SIGNED(const a: PPKCS7_SIGNED; out_: PByte): TIdC_INT;
//  function PKCS7_SIGNED_it: PASN1_ITEM;
//
//  function PKCS7_ENC_CONTENT_new: PPKCS7_ENC_CONTENT;
//  procedure PKCS7_ENC_CONTENT_free(a: PPKCS7_ENC_CONTENT);
//  function d2i_PKCS7_ENC_CONTENT(a: PPPKCS7_ENC_CONTENT; const in_: PByte; len: TIdC_LONG): PPKCS7_ENC_CONTENT;
//  function i2d_PKCS7_ENC_CONTENT(const a: PPKCS7_ENC_CONTENT; out_: PByte): TIdC_INT;
//  function PKCS7_ENC_CONTENT_it: PASN1_ITEM;
//
//  function PKCS7_ENVELOPE_new: PPKCS7_ENVELOPE;
//  procedure PKCS7_ENVELOPE_free(a: PPKCS7_ENVELOPE);
//  function d2i_PKCS7_ENVELOPE(a: PPPKCS7_ENVELOPE; const in_: PByte; len: TIdC_LONG): PPKCS7_ENVELOPE;
//  function i2d_PKCS7_ENVELOPE(const a: PPKCS7_ENVELOPE; out_: PByte): TIdC_INT;
//  function PKCS7_ENVELOPE_it: PASN1_ITEM;
//
//  function PKCS7_SIGN_ENVELOPE_new: PPKCS7_SIGN_ENVELOPE;
//  procedure PKCS7_SIGN_ENVELOPE_free(a: PPKCS7_SIGN_ENVELOPE);
//  function d2i_PKCS7_SIGN_ENVELOPE(a: PPPKCS7_SIGN_ENVELOPE; const in_: PByte; len: TIdC_LONG): PPKCS7_SIGN_ENVELOPE;
//  function i2d_PKCS7_SIGN_ENVELOPE(const a: PPKCS7_SIGN_ENVELOPE; out_: PByte): TIdC_INT;
//  function PKCS7_SIGN_ENVELOPE_it: PASN1_ITEM;
//
//  function PKCS7_DIGEST_new: PPKCS7_DIGEST;
//  procedure PKCS7_DIGEST_free(a: PPKCS7_DIGEST);
//  function d2i_PKCS7_DIGEST(a: PPPKCS7_DIGEST; const in_: PByte; len: TIdC_LONG): PPKCS7_DIGEST;
//  function i2d_PKCS7_DIGEST(const a: PPKCS7_DIGEST; out_: PByte): TIdC_INT;
//  function PKCS7_DIGEST_it: PASN1_ITEM;
//
//  function PKCS7_ENCRYPT_new: PPKCS7_ENCRYPT_STRUCT;
//  procedure PKCS7_ENCRYPT_free(a: PPKCS7_ENCRYPT_STRUCT);
//  function d2i_PKCS7_ENCRYPT(a: PPPKCS7_ENCRYPT_STRUCT; const in_: PByte; len: TIdC_LONG): PPKCS7_ENCRYPT_STRUCT;
//  function i2d_PKCS7_ENCRYPT(const a: PPKCS7_ENCRYPT_STRUCT; out_: PByte): TIdC_INT;
//  function PKCS7_ENCRYPT_it: PASN1_ITEM;
//
//  function PKCS7_new: PPKCS7;
//  procedure PKCS7_free(a: PPKCS7);
//  function d2i_PKCS7(a: PPPKCS7; const in_: PByte; len: TIdC_LONG): PPKCS7;
//  function i2d_PKCS7(const a: PPKCS7; out_: PByte): TIdC_INT;
//  function PKCS7_it: PASN1_ITEM;
//
//  function PKCS7_ATTR_SIGN_it: PASN1_ITEM;
//
//  function PKCS7_ATTR_VERIFY_it: PASN1_ITEM;
//
//  function i2d_PKCS7_NDEF(const a: PPKCS7; out_: PPByte): TIdC_INT;
//  function PKCS7_print_ctx(&out: PBIO; const x: PPKCS7; indent: TIdC_INT; const pctx: PASN1_PCTX): TIdC_INT;

  function PKCS7_ctrl(p7: PPKCS7; cmd: TIdC_INT; larg: TIdC_LONG; parg: PIdAnsiChar): TIdC_LONG;

  function PKCS7_set_type(p7: PPKCS7; type_: TIdC_INT): TIdC_INT;
  function PKCS7_set0_type_other(p7: PPKCS7; type_: TIdC_INT; other: PASN1_TYPE): TIdC_INT;
  function PKCS7_set_content(p7: PPKCS7; p7_data: PPKCS7): TIdC_INT;
  function PKCS7_SIGNER_INFO_set(p7i: PPKCS7_SIGNER_INFO; x509: PX509; pkey: PEVP_PKEY; const dgst: PEVP_MD): TIdC_INT;
  function PKCS7_SIGNER_INFO_sign(si: PPKCS7_SIGNER_INFO): TIdC_INT;
  function PKCS7_add_signer(p7: PPKCS7; p7i: PPKCS7_SIGNER_INFO): TIdC_INT;
  function PKCS7_add_certificate(p7: PPKCS7; x509: PX509): TIdC_INT;
  function PKCS7_add_crl(p7: PPKCS7; x509: PX509_CRL): TIdC_INT;
  function PKCS7_content_new(p7: PPKCS7; nid: TIdC_INT): TIdC_INT;
  function PKCS7_dataVerify(cert_store: PX509_STORE; ctx: PX509_STORE_CTX; bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO): TIdC_INT;
  function PKCS7_signatureVerify(bio: PBIO; p7: PPKCS7; si: PPKCS7_SIGNER_INFO; x509: PX509): TIdC_INT;

  function PKCS7_dataInit(p7: PPKCS7; bio: PBIO): PBIO;
  function PKCS7_dataFinal(p7: PPKCS7; bio: PBIO): TIdC_INT;
  function PKCS7_dataDecode(p7: PPKCS7; pkey: PEVP_PKEY; in_bio: PBIO; pcert: PX509): PBIO;

  function PKCS7_add_signature(p7: PPKCS7; x509: PX509; pkey: PEVP_PKEY; const dgst: PEVP_MD): PPKCS7_SIGNER_INFO;
  function PKCS7_cert_from_signer_info(p7: PPKCS7; si: PPKCS7_SIGNER_INFO): PX509;
  function PKCS7_set_digest(p7: PPKCS7; const md: PEVP_MD): TIdC_INT;
//  function PKCS7_get_signer_info(p7: PPKCS7): PSTACK_OF_PKCS7_SIGNER_INFO;

  function PKCS7_add_recipient(p7: PPKCS7; x509: PX509): PPKCS7_RECIP_INFO;
  procedure PKCS7_SIGNER_INFO_get0_algs(si: PPKCS7_SIGNER_INFO; pk: PPEVP_PKEY; pdig: PPX509_ALGOR; psig: PPX509_ALGOR);
  procedure PKCS7_RECIP_INFO_get0_alg(ri: PPKCS7_RECIP_INFO; penc: PPX509_ALGOR);
  function PKCS7_add_recipient_info(p7: PPKCS7; ri: PPKCS7_RECIP_INFO): TIdC_INT;
  function PKCS7_RECIP_INFO_set(p7i: PPKCS7_RECIP_INFO; x509: PX509): TIdC_INT;
  function PKCS7_set_cipher(p7: PPKCS7; const cipher: PEVP_CIPHER): TIdC_INT;
  function PKCS7_stream(boundary: PPPByte; p7: PPKCS7): TIdC_INT;

  function PKCS7_get_issuer_and_serial(p7: PPKCS7; idx: TIdC_INT): PPKCS7_ISSUER_AND_SERIAL;
  //function PKCS7_digest_from_attributes(sk: Pointer{PSTACK_OF_X509_ATTRIBUTE}): PASN1_OCTET_STRING;
  function PKCS7_add_signed_attribute(p7si: PPKCS7_SIGNER_INFO; nid: TIdC_INT; type_: TIdC_INT; data: Pointer): TIdC_INT;
  function PKCS7_add_attribute(p7si: PPKCS7_SIGNER_INFO; nid: TIdC_INT; atrtype: TIdC_INT; value: Pointer): TIdC_INT;
  function PKCS7_get_attribute(si: PPKCS7_SIGNER_INFO; nid: TIdC_INT): PASN1_TYPE;
  function PKCS7_get_signed_attribute(si: PPKCS7_SIGNER_INFO; nid: TIdC_INT): PASN1_TYPE;
  //function PKCS7_set_signed_attributes(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_OF_X509): TIdC_INT;
  //function PKCS7_set_attributes(p7si: PPKCS7_SIGNER_INFO; sk: PSTACK_OF_X509_ATTRIBUTE): TIdC_INT;

  //function PKCS7_sign(signcert: PX509; pkey: PEVP_PKEY; certs: PSTACK_OF_X509; data: PBIO; flags: TIdC_INT): PPKCS7;

  function PKCS7_sign_add_signer(p7: PPKCS7; signcert: PX509; pkey: PEVP_PKEY; const md: PEVP_MD; flags: TIdC_INT): PPKCS7_SIGNER_INFO;

  function PKCS7_final(p7: PPKCS7; data: PBIO; flags: TIdC_INT): TIdC_INT;
  //function PKCS7_verify(p7: PPKCS7; certs: PSTACK_OF_X509; store: PX509_STORE; indata: PBIO; out_: PBIO; flags: TIdC_INT): TIdC_INT;
  //function PKCS7_get0_signers(p7: PPKCS7; certs: PSTACK_OF_X509; flags: TIdC_INT): PSTACK_OF_X509;
  //function PKCS7_encrypt(certs: PSTACK_OF_X509; in_: PBIO; const cipher: PEVP_CIPHER; flags: TIdC_INT): PPKCS7;
  function PKCS7_decrypt(p7: PPKCS7; pkey: PEVP_PKEY; cert: PX509; data: PBIO; flags: TIdC_INT): TIdC_INT;

  //function PKCS7_add_attrib_smimecap(si: PPKCS7_SIGNER_INFO; cap: PSTACK_OF_X509_ALGOR): TIdC_INT;
  //function PKCS7_get_smimecap(si: PPKCS7_SIGNER_INFO): PSTACK_OF_X509_ALGOR;
  //function PKCS7_simple_smimecap(sk: PSTACK_OF_X509_ALGOR; nid: TIdC_INT; arg: TIdC_INT): TIdC_INT;

  function PKCS7_add_attrib_content_type(si: PPKCS7_SIGNER_INFO; coid: PASN1_OBJECT): TIdC_INT;
  function PKCS7_add0_attrib_signing_time(si: PPKCS7_SIGNER_INFO; t: PASN1_TIME): TIdC_INT;
  function PKCS7_add1_attrib_digest(si: PPKCS7_SIGNER_INFO; const md: PByte; mdlen: TIdC_INT): TIdC_INT;

  function SMIME_write_PKCS7(bio: PBIO; p7: PPKCS7; data: PBIO; flags: TIdC_INT): TIdC_INT;
  function SMIME_read_PKCS7(bio: PBIO; bcont: PPBIO): PPKCS7;

  function BIO_new_PKCS7(&out: PBIO; p7: PPKCS7): PBIO;

implementation

end.
