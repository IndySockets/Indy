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

unit IdOpenSSLHeaders_cmserr;

interface

// Headers for OpenSSL 1.1.1
// cmserr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  //
  // CMS function codes.
  //
  CMS_F_CHECK_CONTENT                             = 99;
  CMS_F_CMS_ADD0_CERT                             = 164;
  CMS_F_CMS_ADD0_RECIPIENT_KEY                    = 100;
  CMS_F_CMS_ADD0_RECIPIENT_PASSWORD               = 165;
  CMS_F_CMS_ADD1_RECEIPTREQUEST                   = 158;
  CMS_F_CMS_ADD1_RECIPIENT_CERT                   = 101;
  CMS_F_CMS_ADD1_SIGNER                           = 102;
  CMS_F_CMS_ADD1_SIGNINGTIME                      = 103;
  CMS_F_CMS_COMPRESS                              = 104;
  CMS_F_CMS_COMPRESSEDDATA_CREATE                 = 105;
  CMS_F_CMS_COMPRESSEDDATA_INIT_BIO               = 106;
  CMS_F_CMS_COPY_CONTENT                          = 107;
  CMS_F_CMS_COPY_MESSAGEDIGEST                    = 108;
  CMS_F_CMS_DATA                                  = 109;
  CMS_F_CMS_DATAFINAL                             = 110;
  CMS_F_CMS_DATAINIT                              = 111;
  CMS_F_CMS_DECRYPT                               = 112;
  CMS_F_CMS_DECRYPT_SET1_KEY                      = 113;
  CMS_F_CMS_DECRYPT_SET1_PASSWORD                 = 166;
  CMS_F_CMS_DECRYPT_SET1_PKEY                     = 114;
  CMS_F_CMS_DIGESTALGORITHM_FIND_CTX              = 115;
  CMS_F_CMS_DIGESTALGORITHM_INIT_BIO              = 116;
  CMS_F_CMS_DIGESTEDDATA_DO_FINAL                 = 117;
  CMS_F_CMS_DIGEST_VERIFY                         = 118;
  CMS_F_CMS_ENCODE_RECEIPT                        = 161;
  CMS_F_CMS_ENCRYPT                               = 119;
  CMS_F_CMS_ENCRYPTEDCONTENT_INIT                 = 179;
  CMS_F_CMS_ENCRYPTEDCONTENT_INIT_BIO             = 120;
  CMS_F_CMS_ENCRYPTEDDATA_DECRYPT                 = 121;
  CMS_F_CMS_ENCRYPTEDDATA_ENCRYPT                 = 122;
  CMS_F_CMS_ENCRYPTEDDATA_SET1_KEY                = 123;
  CMS_F_CMS_ENVELOPEDDATA_CREATE                  = 124;
  CMS_F_CMS_ENVELOPEDDATA_INIT_BIO                = 125;
  CMS_F_CMS_ENVELOPED_DATA_INIT                   = 126;
  CMS_F_CMS_ENV_ASN1_CTRL                         = 171;
  CMS_F_CMS_FINAL                                 = 127;
  CMS_F_CMS_GET0_CERTIFICATE_CHOICES              = 128;
  CMS_F_CMS_GET0_CONTENT                          = 129;
  CMS_F_CMS_GET0_ECONTENT_TYPE                    = 130;
  CMS_F_CMS_GET0_ENVELOPED                        = 131;
  CMS_F_CMS_GET0_REVOCATION_CHOICES               = 132;
  CMS_F_CMS_GET0_SIGNED                           = 133;
  CMS_F_CMS_MSGSIGDIGEST_ADD1                     = 162;
  CMS_F_CMS_RECEIPTREQUEST_CREATE0                = 159;
  CMS_F_CMS_RECEIPT_VERIFY                        = 160;
  CMS_F_CMS_RECIPIENTINFO_DECRYPT                 = 134;
  CMS_F_CMS_RECIPIENTINFO_ENCRYPT                 = 169;
  CMS_F_CMS_RECIPIENTINFO_KARI_ENCRYPT            = 178;
  CMS_F_CMS_RECIPIENTINFO_KARI_GET0_ALG           = 175;
  CMS_F_CMS_RECIPIENTINFO_KARI_GET0_ORIG_ID       = 173;
  CMS_F_CMS_RECIPIENTINFO_KARI_GET0_REKS          = 172;
  CMS_F_CMS_RECIPIENTINFO_KARI_ORIG_ID_CMP        = 174;
  CMS_F_CMS_RECIPIENTINFO_KEKRI_DECRYPT           = 135;
  CMS_F_CMS_RECIPIENTINFO_KEKRI_ENCRYPT           = 136;
  CMS_F_CMS_RECIPIENTINFO_KEKRI_GET0_ID           = 137;
  CMS_F_CMS_RECIPIENTINFO_KEKRI_ID_CMP            = 138;
  CMS_F_CMS_RECIPIENTINFO_KTRI_CERT_CMP           = 139;
  CMS_F_CMS_RECIPIENTINFO_KTRI_DECRYPT            = 140;
  CMS_F_CMS_RECIPIENTINFO_KTRI_ENCRYPT            = 141;
  CMS_F_CMS_RECIPIENTINFO_KTRI_GET0_ALGS          = 142;
  CMS_F_CMS_RECIPIENTINFO_KTRI_GET0_SIGNER_ID     = 143;
  CMS_F_CMS_RECIPIENTINFO_PWRI_CRYPT              = 167;
  CMS_F_CMS_RECIPIENTINFO_SET0_KEY                = 144;
  CMS_F_CMS_RECIPIENTINFO_SET0_PASSWORD           = 168;
  CMS_F_CMS_RECIPIENTINFO_SET0_PKEY               = 145;
  CMS_F_CMS_SD_ASN1_CTRL                          = 170;
  CMS_F_CMS_SET1_IAS                              = 176;
  CMS_F_CMS_SET1_KEYID                            = 177;
  CMS_F_CMS_SET1_SIGNERIDENTIFIER                 = 146;
  CMS_F_CMS_SET_DETACHED                          = 147;
  CMS_F_CMS_SIGN                                  = 148;
  CMS_F_CMS_SIGNED_DATA_INIT                      = 149;
  CMS_F_CMS_SIGNERINFO_CONTENT_SIGN               = 150;
  CMS_F_CMS_SIGNERINFO_SIGN                       = 151;
  CMS_F_CMS_SIGNERINFO_VERIFY                     = 152;
  CMS_F_CMS_SIGNERINFO_VERIFY_CERT                = 153;
  CMS_F_CMS_SIGNERINFO_VERIFY_CONTENT             = 154;
  CMS_F_CMS_SIGN_RECEIPT                          = 163;
  CMS_F_CMS_SI_CHECK_ATTRIBUTES                   = 183;
  CMS_F_CMS_STREAM                                = 155;
  CMS_F_CMS_UNCOMPRESS                            = 156;
  CMS_F_CMS_VERIFY                                = 157;
  CMS_F_KEK_UNWRAP_KEY                            = 180;

  //
  // CMS reason codes.
  //
  CMS_R_ADD_SIGNER_ERROR                          = 99;
  CMS_R_ATTRIBUTE_ERROR                           = 161;
  CMS_R_CERTIFICATE_ALREADY_PRESENT               = 175;
  CMS_R_CERTIFICATE_HAS_NO_KEYID                  = 160;
  CMS_R_CERTIFICATE_VERIFY_ERROR                  = 100;
  CMS_R_CIPHER_INITIALISATION_ERROR               = 101;
  CMS_R_CIPHER_PARAMETER_INITIALISATION_ERROR     = 102;
  CMS_R_CMS_DATAFINAL_ERROR                       = 103;
  CMS_R_CMS_LIB                                   = 104;
  CMS_R_CONTENTIDENTIFIER_MISMATCH                = 170;
  CMS_R_CONTENT_NOT_FOUND                         = 105;
  CMS_R_CONTENT_TYPE_MISMATCH                     = 171;
  CMS_R_CONTENT_TYPE_NOT_COMPRESSED_DATA          = 106;
  CMS_R_CONTENT_TYPE_NOT_ENVELOPED_DATA           = 107;
  CMS_R_CONTENT_TYPE_NOT_SIGNED_DATA              = 108;
  CMS_R_CONTENT_VERIFY_ERROR                      = 109;
  CMS_R_CTRL_ERROR                                = 110;
  CMS_R_CTRL_FAILURE                              = 111;
  CMS_R_DECRYPT_ERROR                             = 112;
  CMS_R_ERROR_GETTING_PUBLIC_KEY                  = 113;
  CMS_R_ERROR_READING_MESSAGEDIGEST_ATTRIBUTE     = 114;
  CMS_R_ERROR_SETTING_KEY                         = 115;
  CMS_R_ERROR_SETTING_RECIPIENTINFO               = 116;
  CMS_R_INVALID_ENCRYPTED_KEY_LENGTH              = 117;
  CMS_R_INVALID_KEY_ENCRYPTION_PARAMETER          = 176;
  CMS_R_INVALID_KEY_LENGTH                        = 118;
  CMS_R_MD_BIO_INIT_ERROR                         = 119;
  CMS_R_MESSAGEDIGEST_ATTRIBUTE_WRONG_LENGTH      = 120;
  CMS_R_MESSAGEDIGEST_WRONG_LENGTH                = 121;
  CMS_R_MSGSIGDIGEST_ERROR                        = 172;
  CMS_R_MSGSIGDIGEST_VERIFICATION_FAILURE         = 162;
  CMS_R_MSGSIGDIGEST_WRONG_LENGTH                 = 163;
  CMS_R_NEED_ONE_SIGNER                           = 164;
  CMS_R_NOT_A_SIGNED_RECEIPT                      = 165;
  CMS_R_NOT_ENCRYPTED_DATA                        = 122;
  CMS_R_NOT_KEK                                   = 123;
  CMS_R_NOT_KEY_AGREEMENT                         = 181;
  CMS_R_NOT_KEY_TRANSPORT                         = 124;
  CMS_R_NOT_PWRI                                  = 177;
  CMS_R_NOT_SUPPORTED_FOR_THIS_KEY_TYPE           = 125;
  CMS_R_NO_CIPHER                                 = 126;
  CMS_R_NO_CONTENT                                = 127;
  CMS_R_NO_CONTENT_TYPE                           = 173;
  CMS_R_NO_DEFAULT_DIGEST                         = 128;
  CMS_R_NO_DIGEST_SET                             = 129;
  CMS_R_NO_KEY                                    = 130;
  CMS_R_NO_KEY_OR_CERT                            = 174;
  CMS_R_NO_MATCHING_DIGEST                        = 131;
  CMS_R_NO_MATCHING_RECIPIENT                     = 132;
  CMS_R_NO_MATCHING_SIGNATURE                     = 166;
  CMS_R_NO_MSGSIGDIGEST                           = 167;
  CMS_R_NO_PASSWORD                               = 178;
  CMS_R_NO_PRIVATE_KEY                            = 133;
  CMS_R_NO_PUBLIC_KEY                             = 134;
  CMS_R_NO_RECEIPT_REQUEST                        = 168;
  CMS_R_NO_SIGNERS                                = 135;
  CMS_R_PRIVATE_KEY_DOES_NOT_MATCH_CERTIFICATE    = 136;
  CMS_R_RECEIPT_DECODE_ERROR                      = 169;
  CMS_R_RECIPIENT_ERROR                           = 137;
  CMS_R_SIGNER_CERTIFICATE_NOT_FOUND              = 138;
  CMS_R_SIGNFINAL_ERROR                           = 139;
  CMS_R_SMIME_TEXT_ERROR                          = 140;
  CMS_R_STORE_INIT_ERROR                          = 141;
  CMS_R_TYPE_NOT_COMPRESSED_DATA                  = 142;
  CMS_R_TYPE_NOT_DATA                             = 143;
  CMS_R_TYPE_NOT_DIGESTED_DATA                    = 144;
  CMS_R_TYPE_NOT_ENCRYPTED_DATA                   = 145;
  CMS_R_TYPE_NOT_ENVELOPED_DATA                   = 146;
  CMS_R_UNABLE_TO_FINALIZE_CONTEXT                = 147;
  CMS_R_UNKNOWN_CIPHER                            = 148;
  CMS_R_UNKNOWN_DIGEST_ALGORITHM                  = 149;
  CMS_R_UNKNOWN_ID                                = 150;
  CMS_R_UNSUPPORTED_COMPRESSION_ALGORITHM         = 151;
  CMS_R_UNSUPPORTED_CONTENT_TYPE                  = 152;
  CMS_R_UNSUPPORTED_KEK_ALGORITHM                 = 153;
  CMS_R_UNSUPPORTED_KEY_ENCRYPTION_ALGORITHM      = 179;
  CMS_R_UNSUPPORTED_RECIPIENTINFO_TYPE            = 155;
  CMS_R_UNSUPPORTED_RECIPIENT_TYPE                = 154;
  CMS_R_UNSUPPORTED_TYPE                          = 156;
  CMS_R_UNWRAP_ERROR                              = 157;
  CMS_R_UNWRAP_FAILURE                            = 180;
  CMS_R_VERIFICATION_FAILURE                      = 158;
  CMS_R_WRAP_ERROR                                = 159;

var
  function ERR_load_CMS_strings: TIdC_INT;

implementation

end.
