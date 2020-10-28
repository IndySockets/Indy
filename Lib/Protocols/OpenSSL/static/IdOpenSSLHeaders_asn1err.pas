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

// Generation date: 28.10.2020 15:24:33

unit IdOpenSSLHeaders_asn1err;

interface

// Headers for OpenSSL 1.1.1
// asn1err.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const

// ASN1 function codes.
  ASN1_F_A2D_ASN1_OBJECT                          = 100;
  ASN1_F_A2I_ASN1_INTEGER                         = 102;
  ASN1_F_A2I_ASN1_STRING                          = 103;
  ASN1_F_APPEND_EXP                               = 176;
  ASN1_F_ASN1_BIO_INIT                            = 113;
  ASN1_F_ASN1_BIT_STRING_SET_BIT                  = 183;
  ASN1_F_ASN1_CB                                  = 177;
  ASN1_F_ASN1_CHECK_TLEN                          = 104;
  ASN1_F_ASN1_COLLECT                             = 106;
  ASN1_F_ASN1_D2I_EX_PRIMITIVE                    = 108;
  ASN1_F_ASN1_D2I_FP                              = 109;
  ASN1_F_ASN1_D2I_READ_BIO                        = 107;
  ASN1_F_ASN1_DIGEST                              = 184;
  ASN1_F_ASN1_DO_ADB                              = 110;
  ASN1_F_ASN1_DO_LOCK                             = 233;
  ASN1_F_ASN1_DUP                                 = 111;
  ASN1_F_ASN1_ENC_SAVE                            = 115;
  ASN1_F_ASN1_EX_C2I                              = 204;
  ASN1_F_ASN1_FIND_END                            = 190;
  ASN1_F_ASN1_GENERALIZEDTIME_ADJ                 = 216;
  ASN1_F_ASN1_GENERATE_V3                         = 178;
  ASN1_F_ASN1_GET_INT64                           = 224;
  ASN1_F_ASN1_GET_OBJECT                          = 114;
  ASN1_F_ASN1_GET_UINT64                          = 225;
  ASN1_F_ASN1_I2D_BIO                             = 116;
  ASN1_F_ASN1_I2D_FP                              = 117;
  ASN1_F_ASN1_ITEM_D2I_FP                         = 206;
  ASN1_F_ASN1_ITEM_DUP                            = 191;
  ASN1_F_ASN1_ITEM_EMBED_D2I                      = 120;
  ASN1_F_ASN1_ITEM_EMBED_NEW                      = 121;
  ASN1_F_ASN1_ITEM_FLAGS_I2D                      = 118;
  ASN1_F_ASN1_ITEM_I2D_BIO                        = 192;
  ASN1_F_ASN1_ITEM_I2D_FP                         = 193;
  ASN1_F_ASN1_ITEM_PACK                           = 198;
  ASN1_F_ASN1_ITEM_SIGN                           = 195;
  ASN1_F_ASN1_ITEM_SIGN_CTX                       = 220;
  ASN1_F_ASN1_ITEM_UNPACK                         = 199;
  ASN1_F_ASN1_ITEM_VERIFY                         = 197;
  ASN1_F_ASN1_MBSTRING_NCOPY                      = 122;
  ASN1_F_ASN1_OBJECT_NEW                          = 123;
  ASN1_F_ASN1_OUTPUT_DATA                         = 214;
  ASN1_F_ASN1_PCTX_NEW                            = 205;
  ASN1_F_ASN1_PRIMITIVE_NEW                       = 119;
  ASN1_F_ASN1_SCTX_NEW                            = 221;
  ASN1_F_ASN1_SIGN                                = 128;
  ASN1_F_ASN1_STR2TYPE                            = 179;
  ASN1_F_ASN1_STRING_GET_INT64                    = 227;
  ASN1_F_ASN1_STRING_GET_UINT64                   = 230;
  ASN1_F_ASN1_STRING_SET                          = 186;
  ASN1_F_ASN1_STRING_TABLE_ADD                    = 129;
  ASN1_F_ASN1_STRING_TO_BN                        = 228;
  ASN1_F_ASN1_STRING_TYPE_NEW                     = 130;
  ASN1_F_ASN1_TEMPLATE_EX_D2I                     = 132;
  ASN1_F_ASN1_TEMPLATE_NEW                        = 133;
  ASN1_F_ASN1_TEMPLATE_NOEXP_D2I                  = 131;
  ASN1_F_ASN1_TIME_ADJ                            = 217;
  ASN1_F_ASN1_TYPE_GET_INT_OCTETSTRING            = 134;
  ASN1_F_ASN1_TYPE_GET_OCTETSTRING                = 135;
  ASN1_F_ASN1_UTCTIME_ADJ                         = 218;
  ASN1_F_ASN1_VERIFY                              = 137;
  ASN1_F_B64_READ_ASN1                            = 209;
  ASN1_F_B64_WRITE_ASN1                           = 210;
  ASN1_F_BIO_NEW_NDEF                             = 208;
  ASN1_F_BITSTR_CB                                = 180;
  ASN1_F_BN_TO_ASN1_STRING                        = 229;
  ASN1_F_C2I_ASN1_BIT_STRING                      = 189;
  ASN1_F_C2I_ASN1_INTEGER                         = 194;
  ASN1_F_C2I_ASN1_OBJECT                          = 196;
  ASN1_F_C2I_IBUF                                 = 226;
  ASN1_F_C2I_UINT64_INT                           = 101;
  ASN1_F_COLLECT_DATA                             = 140;
  ASN1_F_D2I_ASN1_OBJECT                          = 147;
  ASN1_F_D2I_ASN1_UINTEGER                        = 150;
  ASN1_F_D2I_AUTOPRIVATEKEY                       = 207;
  ASN1_F_D2I_PRIVATEKEY                           = 154;
  ASN1_F_D2I_PUBLICKEY                            = 155;
  ASN1_F_DO_BUF                                   = 142;
  ASN1_F_DO_CREATE                                = 124;
  ASN1_F_DO_DUMP                                  = 125;
  ASN1_F_DO_TCREATE                               = 222;
  ASN1_F_I2A_ASN1_OBJECT                          = 126;
  ASN1_F_I2D_ASN1_BIO_STREAM                      = 211;
  ASN1_F_I2D_ASN1_OBJECT                          = 143;
  ASN1_F_I2D_DSA_PUBKEY                           = 161;
  ASN1_F_I2D_EC_PUBKEY                            = 181;
  ASN1_F_I2D_PRIVATEKEY                           = 163;
  ASN1_F_I2D_PUBLICKEY                            = 164;
  ASN1_F_I2D_RSA_PUBKEY                           = 165;
  ASN1_F_LONG_C2I                                 = 166;
  ASN1_F_NDEF_PREFIX                              = 127;
  ASN1_F_NDEF_SUFFIX                              = 136;
  ASN1_F_OID_MODULE_INIT                          = 174;
  ASN1_F_PARSE_TAGGING                            = 182;
  ASN1_F_PKCS5_PBE2_SET_IV                        = 167;
  ASN1_F_PKCS5_PBE2_SET_SCRYPT                    = 231;
  ASN1_F_PKCS5_PBE_SET                            = 202;
  ASN1_F_PKCS5_PBE_SET0_ALGOR                     = 215;
  ASN1_F_PKCS5_PBKDF2_SET                         = 219;
  ASN1_F_PKCS5_SCRYPT_SET                         = 232;
  ASN1_F_SMIME_READ_ASN1                          = 212;
  ASN1_F_SMIME_TEXT                               = 213;
  ASN1_F_STABLE_GET                               = 138;
  ASN1_F_STBL_MODULE_INIT                         = 223;
  ASN1_F_UINT32_C2I                               = 105;
  ASN1_F_UINT32_NEW                               = 139;
  ASN1_F_UINT64_C2I                               = 112;
  ASN1_F_UINT64_NEW                               = 141;
  ASN1_F_X509_CRL_ADD0_REVOKED                    = 169;
  ASN1_F_X509_INFO_NEW                            = 170;
  ASN1_F_X509_NAME_ENCODE                         = 203;
  ASN1_F_X509_NAME_EX_D2I                         = 158;
  ASN1_F_X509_NAME_EX_NEW                         = 171;
  ASN1_F_X509_PKEY_NEW                            = 173;

// ASN1 reason codes.
  ASN1_R_ADDING_OBJECT                            = 171;
  ASN1_R_ASN1_PARSE_ERROR                         = 203;
  ASN1_R_ASN1_SIG_PARSE_ERROR                     = 204;
  ASN1_R_AUX_ERROR                                = 100;
  ASN1_R_BAD_OBJECT_HEADER                        = 102;
  ASN1_R_BMPSTRING_IS_WRONG_LENGTH                = 214;
  ASN1_R_BN_LIB                                   = 105;
  ASN1_R_BOOLEAN_IS_WRONG_LENGTH                  = 106;
  ASN1_R_BUFFER_TOO_SMALL                         = 107;
  ASN1_R_CIPHER_HAS_NO_OBJECT_IDENTIFIER          = 108;
  ASN1_R_CONTEXT_NOT_INITIALISED                  = 217;
  ASN1_R_DATA_IS_WRONG                            = 109;
  ASN1_R_DECODE_ERROR                             = 110;
  ASN1_R_DEPTH_EXCEEDED                           = 174;
  ASN1_R_DIGEST_AND_KEY_TYPE_NOT_SUPPORTED        = 198;
  ASN1_R_ENCODE_ERROR                             = 112;
  ASN1_R_ERROR_GETTING_TIME                       = 173;
  ASN1_R_ERROR_LOADING_SECTION                    = 172;
  ASN1_R_ERROR_SETTING_CIPHER_PARAMS              = 114;
  ASN1_R_EXPECTING_AN_INTEGER                     = 115;
  ASN1_R_EXPECTING_AN_OBJECT                      = 116;
  ASN1_R_EXPLICIT_LENGTH_MISMATCH                 = 119;
  ASN1_R_EXPLICIT_TAG_NOT_CONSTRUCTED             = 120;
  ASN1_R_FIELD_MISSING                            = 121;
  ASN1_R_FIRST_NUM_TOO_LARGE                      = 122;
  ASN1_R_HEADER_TOO_LONG                          = 123;
  ASN1_R_ILLEGAL_BITSTRING_FORMAT                 = 175;
  ASN1_R_ILLEGAL_BOOLEAN                          = 176;
  ASN1_R_ILLEGAL_CHARACTERS                       = 124;
  ASN1_R_ILLEGAL_FORMAT                           = 177;
  ASN1_R_ILLEGAL_HEX                              = 178;
  ASN1_R_ILLEGAL_IMPLICIT_TAG                     = 179;
  ASN1_R_ILLEGAL_INTEGER                          = 180;
  ASN1_R_ILLEGAL_NEGATIVE_VALUE                   = 226;
  ASN1_R_ILLEGAL_NESTED_TAGGING                   = 181;
  ASN1_R_ILLEGAL_NULL                             = 125;
  ASN1_R_ILLEGAL_NULL_VALUE                       = 182;
  ASN1_R_ILLEGAL_OBJECT                           = 183;
  ASN1_R_ILLEGAL_OPTIONAL_ANY                     = 126;
  ASN1_R_ILLEGAL_OPTIONS_ON_ITEM_TEMPLATE         = 170;
  ASN1_R_ILLEGAL_PADDING                          = 221;
  ASN1_R_ILLEGAL_TAGGED_ANY                       = 127;
  ASN1_R_ILLEGAL_TIME_VALUE                       = 184;
  ASN1_R_ILLEGAL_ZERO_CONTENT                     = 222;
  ASN1_R_INTEGER_NOT_ASCII_FORMAT                 = 185;
  ASN1_R_INTEGER_TOO_LARGE_FOR_LONG               = 128;
  ASN1_R_INVALID_BIT_STRING_BITS_LEFT             = 220;
  ASN1_R_INVALID_BMPSTRING_LENGTH                 = 129;
  ASN1_R_INVALID_DIGIT                            = 130;
  ASN1_R_INVALID_MIME_TYPE                        = 205;
  ASN1_R_INVALID_MODIFIER                         = 186;
  ASN1_R_INVALID_NUMBER                           = 187;
  ASN1_R_INVALID_OBJECT_ENCODING                  = 216;
  ASN1_R_INVALID_SCRYPT_PARAMETERS                = 227;
  ASN1_R_INVALID_SEPARATOR                        = 131;
  ASN1_R_INVALID_STRING_TABLE_VALUE               = 218;
  ASN1_R_INVALID_UNIVERSALSTRING_LENGTH           = 133;
  ASN1_R_INVALID_UTF8STRING                       = 134;
  ASN1_R_INVALID_VALUE                            = 219;
  ASN1_R_LIST_ERROR                               = 188;
  ASN1_R_MIME_NO_CONTENT_TYPE                     = 206;
  ASN1_R_MIME_PARSE_ERROR                         = 207;
  ASN1_R_MIME_SIG_PARSE_ERROR                     = 208;
  ASN1_R_MISSING_EOC                              = 137;
  ASN1_R_MISSING_SECOND_NUMBER                    = 138;
  ASN1_R_MISSING_VALUE                            = 189;
  ASN1_R_MSTRING_NOT_UNIVERSAL                    = 139;
  ASN1_R_MSTRING_WRONG_TAG                        = 140;
  ASN1_R_NESTED_ASN1_STRING                       = 197;
  ASN1_R_NESTED_TOO_DEEP                          = 201;
  ASN1_R_NON_HEX_CHARACTERS                       = 141;
  ASN1_R_NOT_ASCII_FORMAT                         = 190;
  ASN1_R_NOT_ENOUGH_DATA                          = 142;
  ASN1_R_NO_CONTENT_TYPE                          = 209;
  ASN1_R_NO_MATCHING_CHOICE_TYPE                  = 143;
  ASN1_R_NO_MULTIPART_BODY_FAILURE                = 210;
  ASN1_R_NO_MULTIPART_BOUNDARY                    = 211;
  ASN1_R_NO_SIG_CONTENT_TYPE                      = 212;
  ASN1_R_NULL_IS_WRONG_LENGTH                     = 144;
  ASN1_R_OBJECT_NOT_ASCII_FORMAT                  = 191;
  ASN1_R_ODD_NUMBER_OF_CHARS                      = 145;
  ASN1_R_SECOND_NUMBER_TOO_LARGE                  = 147;
  ASN1_R_SEQUENCE_LENGTH_MISMATCH                 = 148;
  ASN1_R_SEQUENCE_NOT_CONSTRUCTED                 = 149;
  ASN1_R_SEQUENCE_OR_SET_NEEDS_CONFIG             = 192;
  ASN1_R_SHORT_LINE                               = 150;
  ASN1_R_SIG_INVALID_MIME_TYPE                    = 213;
  ASN1_R_STREAMING_NOT_SUPPORTED                  = 202;
  ASN1_R_STRING_TOO_LONG                          = 151;
  ASN1_R_STRING_TOO_SHORT                         = 152;
  ASN1_R_THE_ASN1_OBJECT_IDENTIFIER_IS_NOT_KNOWN_FOR_THIS_MD = 154;
  ASN1_R_TIME_NOT_ASCII_FORMAT                    = 193;
  ASN1_R_TOO_LARGE                                = 223;
  ASN1_R_TOO_LONG                                 = 155;
  ASN1_R_TOO_SMALL                                = 224;
  ASN1_R_TYPE_NOT_CONSTRUCTED                     = 156;
  ASN1_R_TYPE_NOT_PRIMITIVE                       = 195;
  ASN1_R_UNEXPECTED_EOC                           = 159;
  ASN1_R_UNIVERSALSTRING_IS_WRONG_LENGTH          = 215;
  ASN1_R_UNKNOWN_FORMAT                           = 160;
  ASN1_R_UNKNOWN_MESSAGE_DIGEST_ALGORITHM         = 161;
  ASN1_R_UNKNOWN_OBJECT_TYPE                      = 162;
  ASN1_R_UNKNOWN_PUBLIC_KEY_TYPE                  = 163;
  ASN1_R_UNKNOWN_SIGNATURE_ALGORITHM              = 199;
  ASN1_R_UNKNOWN_TAG                              = 194;
  ASN1_R_UNSUPPORTED_ANY_DEFINED_BY_TYPE          = 164;
  ASN1_R_UNSUPPORTED_CIPHER                       = 228;
  ASN1_R_UNSUPPORTED_PUBLIC_KEY_TYPE              = 167;
  ASN1_R_UNSUPPORTED_TYPE                         = 196;
  ASN1_R_WRONG_INTEGER_TYPE                       = 225;
  ASN1_R_WRONG_PUBLIC_KEY_TYPE                    = 200;
  ASN1_R_WRONG_TAG                                = 168;

  function ERR_load_ASN1_strings: TIdC_INT cdecl; external CLibCrypto;

implementation

end.
