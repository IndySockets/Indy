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

unit IdOpenSSLHeaders_rsaerr;

interface

// Headers for OpenSSL 1.1.1
// rsaerr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  (*
   * RSA function codes.
   *)
  RSA_F_CHECK_PADDING_MD = 140;
  RSA_F_ENCODE_PKCS1 = 146;
  RSA_F_INT_RSA_VERIFY = 145;
  RSA_F_OLD_RSA_PRIV_DECODE = 147;
  RSA_F_PKEY_PSS_INIT = 165;
  RSA_F_PKEY_RSA_CTRL = 143;
  RSA_F_PKEY_RSA_CTRL_STR = 144;
  RSA_F_PKEY_RSA_SIGN = 142;
  RSA_F_PKEY_RSA_VERIFY = 149;
  RSA_F_PKEY_RSA_VERIFYRECOVER = 141;
  RSA_F_RSA_ALGOR_TO_MD = 156;
  RSA_F_RSA_BUILTIN_KEYGEN = 129;
  RSA_F_RSA_CHECK_KEY = 123;
  RSA_F_RSA_CHECK_KEY_EX = 160;
  RSA_F_RSA_CMS_DECRYPT = 159;
  RSA_F_RSA_CMS_VERIFY = 158;
  RSA_F_RSA_ITEM_VERIFY = 148;
  RSA_F_RSA_METH_DUP = 161;
  RSA_F_RSA_METH_NEW = 162;
  RSA_F_RSA_METH_SET1_NAME = 163;
  RSA_F_RSA_MGF1_TO_MD = 157;
  RSA_F_RSA_MULTIP_INFO_NEW = 166;
  RSA_F_RSA_NEW_METHOD = 106;
  RSA_F_RSA_NULL = 124;
  RSA_F_RSA_NULL_PRIVATE_DECRYPT = 132;
  RSA_F_RSA_NULL_PRIVATE_ENCRYPT = 133;
  RSA_F_RSA_NULL_PUBLIC_DECRYPT = 134;
  RSA_F_RSA_NULL_PUBLIC_ENCRYPT = 135;
  RSA_F_RSA_OSSL_PRIVATE_DECRYPT = 101;
  RSA_F_RSA_OSSL_PRIVATE_ENCRYPT = 102;
  RSA_F_RSA_OSSL_PUBLIC_DECRYPT = 103;
  RSA_F_RSA_OSSL_PUBLIC_ENCRYPT = 104;
  RSA_F_RSA_PADDING_ADD_NONE = 107;
  RSA_F_RSA_PADDING_ADD_PKCS1_OAEP = 121;
  RSA_F_RSA_PADDING_ADD_PKCS1_OAEP_MGF1 = 154;
  RSA_F_RSA_PADDING_ADD_PKCS1_PSS = 125;
  RSA_F_RSA_PADDING_ADD_PKCS1_PSS_MGF1 = 152;
  RSA_F_RSA_PADDING_ADD_PKCS1_TYPE_1 = 108;
  RSA_F_RSA_PADDING_ADD_PKCS1_TYPE_2 = 109;
  RSA_F_RSA_PADDING_ADD_SSLV23 = 110;
  RSA_F_RSA_PADDING_ADD_X931 = 127;
  RSA_F_RSA_PADDING_CHECK_NONE = 111;
  RSA_F_RSA_PADDING_CHECK_PKCS1_OAEP = 122;
  RSA_F_RSA_PADDING_CHECK_PKCS1_OAEP_MGF1 = 153;
  RSA_F_RSA_PADDING_CHECK_PKCS1_TYPE_1 = 112;
  RSA_F_RSA_PADDING_CHECK_PKCS1_TYPE_2 = 113;
  RSA_F_RSA_PADDING_CHECK_SSLV23 = 114;
  RSA_F_RSA_PADDING_CHECK_X931 = 128;
  RSA_F_RSA_PARAM_DECODE = 164;
  RSA_F_RSA_PRINT = 115;
  RSA_F_RSA_PRINT_FP = 116;
  RSA_F_RSA_PRIV_DECODE = 150;
  RSA_F_RSA_PRIV_ENCODE = 138;
  RSA_F_RSA_PSS_GET_PARAM = 151;
  RSA_F_RSA_PSS_TO_CTX = 155;
  RSA_F_RSA_PUB_DECODE = 139;
  RSA_F_RSA_SETUP_BLINDING = 136;
  RSA_F_RSA_SIGN = 117;
  RSA_F_RSA_SIGN_ASN1_OCTET_STRING = 118;
  RSA_F_RSA_VERIFY = 119;
  RSA_F_RSA_VERIFY_ASN1_OCTET_STRING = 120;
  RSA_F_RSA_VERIFY_PKCS1_PSS_MGF1 = 126;
  RSA_F_SETUP_TBUF = 167;

  (*
   * RSA reason codes.
   *)
  RSA_R_ALGORITHM_MISMATCH = 100;
  RSA_R_BAD_E_VALUE = 101;
  RSA_R_BAD_FIXED_HEADER_DECRYPT = 102;
  RSA_R_BAD_PAD_BYTE_COUNT = 103;
  RSA_R_BAD_SIGNATURE = 104;
  RSA_R_BLOCK_TYPE_IS_NOT_01 = 106;
  RSA_R_BLOCK_TYPE_IS_NOT_02 = 107;
  RSA_R_DATA_GREATER_THAN_MOD_LEN = 108;
  RSA_R_DATA_TOO_LARGE = 109;
  RSA_R_DATA_TOO_LARGE_FOR_KEY_SIZE = 110;
  RSA_R_DATA_TOO_LARGE_FOR_MODULUS = 132;
  RSA_R_DATA_TOO_SMALL = 111;
  RSA_R_DATA_TOO_SMALL_FOR_KEY_SIZE = 122;
  RSA_R_DIGEST_DOES_NOT_MATCH = 158;
  RSA_R_DIGEST_NOT_ALLOWED = 145;
  RSA_R_DIGEST_TOO_BIG_FOR_RSA_KEY = 112;
  RSA_R_DMP1_NOT_CONGRUENT_TO_D = 124;
  RSA_R_DMQ1_NOT_CONGRUENT_TO_D = 125;
  RSA_R_D_E_NOT_CONGRUENT_TO_1 = 123;
  RSA_R_FIRST_OCTET_INVALID = 133;
  RSA_R_ILLEGAL_OR_UNSUPPORTED_PADDING_MODE = 144;
  RSA_R_INVALID_DIGEST = 157;
  RSA_R_INVALID_DIGEST_LENGTH = 143;
  RSA_R_INVALID_HEADER = 137;
  RSA_R_INVALID_LABEL = 160;
  RSA_R_INVALID_MESSAGE_LENGTH = 131;
  RSA_R_INVALID_MGF1_MD = 156;
  RSA_R_INVALID_MULTI_PRIME_KEY = 167;
  RSA_R_INVALID_OAEP_PARAMETERS = 161;
  RSA_R_INVALID_PADDING = 138;
  RSA_R_INVALID_PADDING_MODE = 141;
  RSA_R_INVALID_PSS_PARAMETERS = 149;
  RSA_R_INVALID_PSS_SALTLEN = 146;
  RSA_R_INVALID_SALT_LENGTH = 150;
  RSA_R_INVALID_TRAILER = 139;
  RSA_R_INVALID_X931_DIGEST = 142;
  RSA_R_IQMP_NOT_INVERSE_OF_Q = 126;
  RSA_R_KEY_PRIME_NUM_INVALID = 165;
  RSA_R_KEY_SIZE_TOO_SMALL = 120;
  RSA_R_LAST_OCTET_INVALID = 134;
  RSA_R_MISSING_PRIVATE_KEY = 179;
  RSA_R_MGF1_DIGEST_NOT_ALLOWED = 152;
  RSA_R_MODULUS_TOO_LARGE = 105;
  RSA_R_MP_COEFFICIENT_NOT_INVERSE_OF_R = 168;
  RSA_R_MP_EXPONENT_NOT_CONGRUENT_TO_D = 169;
  RSA_R_MP_R_NOT_PRIME = 170;
  RSA_R_NO_PUBLIC_EXPONENT = 140;
  RSA_R_NULL_BEFORE_BLOCK_MISSING = 113;
  RSA_R_N_DOES_NOT_EQUAL_PRODUCT_OF_PRIMES = 172;
  RSA_R_N_DOES_NOT_EQUAL_P_Q = 127;
  RSA_R_OAEP_DECODING_ERROR = 121;
  RSA_R_OPERATION_NOT_SUPPORTED_FOR_THIS_KEYTYPE = 148;
  RSA_R_PADDING_CHECK_FAILED = 114;
  RSA_R_PKCS_DECODING_ERROR = 159;
  RSA_R_PSS_SALTLEN_TOO_SMALL = 164;
  RSA_R_P_NOT_PRIME = 128;
  RSA_R_Q_NOT_PRIME = 129;
  RSA_R_RSA_OPERATIONS_NOT_SUPPORTED = 130;
  RSA_R_SLEN_CHECK_FAILED = 136;
  RSA_R_SLEN_RECOVERY_FAILED = 135;
  RSA_R_SSLV3_ROLLBACK_ATTACK = 115;
  RSA_R_THE_ASN1_OBJECT_IDENTIFIER_IS_NOT_KNOWN_FOR_THIS_MD = 116;
  RSA_R_UNKNOWN_ALGORITHM_TYPE = 117;
  RSA_R_UNKNOWN_DIGEST = 166;
  RSA_R_UNKNOWN_MASK_DIGEST = 151;
  RSA_R_UNKNOWN_PADDING_TYPE = 118;
  RSA_R_UNSUPPORTED_ENCRYPTION_TYPE = 162;
  RSA_R_UNSUPPORTED_LABEL_SOURCE = 163;
  RSA_R_UNSUPPORTED_MASK_ALGORITHM = 153;
  RSA_R_UNSUPPORTED_MASK_PARAMETER = 154;
  RSA_R_UNSUPPORTED_SIGNATURE_TYPE = 155;
  RSA_R_VALUE_MISSING = 147;
  RSA_R_WRONG_SIGNATURE_LENGTH = 119;

var
  function ERR_load_RSA_strings: TIdC_INT;

implementation

end.
