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

unit IdOpenSSLHeaders_evperr;

interface

// Headers for OpenSSL 1.1.1
// evperr.h

{$i IdCompilerDefines.inc}

uses
  IdCTypes,
  IdGlobal,
  IdOpenSSLConsts;

const
  (*
   * EVP function codes.
   *)
  EVP_F_AESNI_INIT_KEY =        165;
  EVP_F_AESNI_XTS_INIT_KEY =       207;
  EVP_F_AES_GCM_CTRL =         196;
  EVP_F_AES_INIT_KEY =         133;
  EVP_F_AES_OCB_CIPHER =        169;
  EVP_F_AES_T4_INIT_KEY =        178;
  EVP_F_AES_T4_XTS_INIT_KEY =       208;
  EVP_F_AES_WRAP_CIPHER =        170;
  EVP_F_AES_XTS_INIT_KEY =        209;
  EVP_F_ALG_MODULE_INIT =        177;
  EVP_F_ARIA_CCM_INIT_KEY =       175;
  EVP_F_ARIA_GCM_CTRL =        197;
  EVP_F_ARIA_GCM_INIT_KEY =       176;
  EVP_F_ARIA_INIT_KEY =        185;
  EVP_F_B64_NEW =          198;
  EVP_F_CAMELLIA_INIT_KEY =       159;
  EVP_F_CHACHA20_POLY1305_CTRL =      182;
  EVP_F_CMLL_T4_INIT_KEY =        179;
  EVP_F_DES_EDE3_WRAP_CIPHER =       171;
  EVP_F_DO_SIGVER_INIT =        161;
  EVP_F_ENC_NEW =          199;
  EVP_F_EVP_CIPHERINIT_EX =       123;
  EVP_F_EVP_CIPHER_ASN1_TO_PARAM =      204;
  EVP_F_EVP_CIPHER_CTX_COPY =       163;
  EVP_F_EVP_CIPHER_CTX_CTRL =       124;
  EVP_F_EVP_CIPHER_CTX_SET_KEY_LENGTH =    122;
  EVP_F_EVP_CIPHER_PARAM_TO_ASN1 =      205;
  EVP_F_EVP_DECRYPTFINAL_EX =       101;
  EVP_F_EVP_DECRYPTUPDATE =       166;
  EVP_F_EVP_DIGESTFINALXOF =       174;
  EVP_F_EVP_DIGESTINIT_EX =       128;
  EVP_F_EVP_ENCRYPTDECRYPTUPDATE =      219;
  EVP_F_EVP_ENCRYPTFINAL_EX =       127;
  EVP_F_EVP_ENCRYPTUPDATE =       167;
  EVP_F_EVP_MD_CTX_COPY_EX =       110;
  EVP_F_EVP_MD_SIZE =         162;
  EVP_F_EVP_OPENINIT =         102;
  EVP_F_EVP_PBE_ALG_ADD =        115;
  EVP_F_EVP_PBE_ALG_ADD_TYPE =       160;
  EVP_F_EVP_PBE_CIPHERINIT =       116;
  EVP_F_EVP_PBE_SCRYPT =        181;
  EVP_F_EVP_PKCS82PKEY =        111;
  EVP_F_EVP_PKEY2PKCS8 =        113;
  EVP_F_EVP_PKEY_ASN1_ADD0 =       188;
  EVP_F_EVP_PKEY_CHECK =        186;
  EVP_F_EVP_PKEY_COPY_PARAMETERS =      103;
  EVP_F_EVP_PKEY_CTX_CTRL =       137;
  EVP_F_EVP_PKEY_CTX_CTRL_STR =      150;
  EVP_F_EVP_PKEY_CTX_DUP =        156;
  EVP_F_EVP_PKEY_CTX_MD =        168;
  EVP_F_EVP_PKEY_DECRYPT =        104;
  EVP_F_EVP_PKEY_DECRYPT_INIT =      138;
  EVP_F_EVP_PKEY_DECRYPT_OLD =       151;
  EVP_F_EVP_PKEY_DERIVE =        153;
  EVP_F_EVP_PKEY_DERIVE_INIT =       154;
  EVP_F_EVP_PKEY_DERIVE_SET_PEER =      155;
  EVP_F_EVP_PKEY_ENCRYPT =        105;
  EVP_F_EVP_PKEY_ENCRYPT_INIT =      139;
  EVP_F_EVP_PKEY_ENCRYPT_OLD =       152;
  EVP_F_EVP_PKEY_GET0_DH =        119;
  EVP_F_EVP_PKEY_GET0_DSA =       120;
  EVP_F_EVP_PKEY_GET0_EC_KEY =       131;
  EVP_F_EVP_PKEY_GET0_HMAC =       183;
  EVP_F_EVP_PKEY_GET0_POLY1305 =      184;
  EVP_F_EVP_PKEY_GET0_RSA =       121;
  EVP_F_EVP_PKEY_GET0_SIPHASH =      172;
  EVP_F_EVP_PKEY_GET_RAW_PRIVATE_KEY =     202;
  EVP_F_EVP_PKEY_GET_RAW_PUBLIC_KEY =     203;
  EVP_F_EVP_PKEY_KEYGEN =        146;
  EVP_F_EVP_PKEY_KEYGEN_INIT =       147;
  EVP_F_EVP_PKEY_METH_ADD0 =       194;
  EVP_F_EVP_PKEY_METH_NEW =       195;
  EVP_F_EVP_PKEY_NEW =         106;
  EVP_F_EVP_PKEY_NEW_CMAC_KEY =      193;
  EVP_F_EVP_PKEY_NEW_RAW_PRIVATE_KEY =     191;
  EVP_F_EVP_PKEY_NEW_RAW_PUBLIC_KEY =     192;
  EVP_F_EVP_PKEY_PARAMGEN =       148;
  EVP_F_EVP_PKEY_PARAMGEN_INIT =      149;
  EVP_F_EVP_PKEY_PARAM_CHECK =       189;
  EVP_F_EVP_PKEY_PUBLIC_CHECK =      190;
  EVP_F_EVP_PKEY_SET1_ENGINE =       187;
  EVP_F_EVP_PKEY_SET_ALIAS_TYPE =      206;
  EVP_F_EVP_PKEY_SIGN =        140;
  EVP_F_EVP_PKEY_SIGN_INIT =       141;
  EVP_F_EVP_PKEY_VERIFY =        142;
  EVP_F_EVP_PKEY_VERIFY_INIT =       143;
  EVP_F_EVP_PKEY_VERIFY_RECOVER =      144;
  EVP_F_EVP_PKEY_VERIFY_RECOVER_INIT =     145;
  EVP_F_EVP_SIGNFINAL =        107;
  EVP_F_EVP_VERIFYFINAL =        108;
  EVP_F_INT_CTX_NEW =         157;
  EVP_F_OK_NEW =          200;
  EVP_F_PKCS5_PBE_KEYIVGEN =       117;
  EVP_F_PKCS5_V2_PBE_KEYIVGEN =      118;
  EVP_F_PKCS5_V2_PBKDF2_KEYIVGEN =      164;
  EVP_F_PKCS5_V2_SCRYPT_KEYIVGEN =      180;
  EVP_F_PKEY_SET_TYPE =        158;
  EVP_F_RC2_MAGIC_TO_METH =       109;
  EVP_F_RC5_CTRL =          125;
  EVP_F_R_32_12_16_INIT_KEY =       242;
  EVP_F_S390X_AES_GCM_CTRL =       201;
  EVP_F_UPDATE =          173;

  (*
   * EVP reason codes.
   *)
  EVP_R_AES_KEY_SETUP_FAILED = 143;
  EVP_R_ARIA_KEY_SETUP_FAILED = 176;
  EVP_R_BAD_DECRYPT = 100;
  EVP_R_BAD_KEY_LENGTH = 195;
  EVP_R_BUFFER_TOO_SMALL = 155;
  EVP_R_CAMELLIA_KEY_SETUP_FAILED = 157;
  EVP_R_CIPHER_PARAMETER_ERROR = 122;
  EVP_R_COMMAND_NOT_SUPPORTED = 147;
  EVP_R_COPY_ERROR = 173;
  EVP_R_CTRL_NOT_IMPLEMENTED = 132;
  EVP_R_CTRL_OPERATION_NOT_IMPLEMENTED = 133;
  EVP_R_DATA_NOT_MULTIPLE_OF_BLOCK_LENGTH = 138;
  EVP_R_DECODE_ERROR = 114;
  EVP_R_DIFFERENT_KEY_TYPES = 101;
  EVP_R_DIFFERENT_PARAMETERS = 153;
  EVP_R_ERROR_LOADING_SECTION = 165;
  EVP_R_ERROR_SETTING_FIPS_MODE = 166;
  EVP_R_EXPECTING_AN_HMAC_KEY = 174;
  EVP_R_EXPECTING_AN_RSA_KEY = 127;
  EVP_R_EXPECTING_A_DH_KEY = 128;
  EVP_R_EXPECTING_A_DSA_KEY = 129;
  EVP_R_EXPECTING_A_EC_KEY = 142;
  EVP_R_EXPECTING_A_POLY1305_KEY = 164;
  EVP_R_EXPECTING_A_SIPHASH_KEY = 175;
  EVP_R_FIPS_MODE_NOT_SUPPORTED = 167;
  EVP_R_GET_RAW_KEY_FAILED = 182;
  EVP_R_ILLEGAL_SCRYPT_PARAMETERS = 171;
  EVP_R_INITIALIZATION_ERROR = 134;
  EVP_R_INPUT_NOT_INITIALIZED = 111;
  EVP_R_INVALID_DIGEST = 152;
  EVP_R_INVALID_FIPS_MODE = 168;
  EVP_R_INVALID_KEY = 163;
  EVP_R_INVALID_KEY_LENGTH = 130;
  EVP_R_INVALID_OPERATION = 148;
  EVP_R_KEYGEN_FAILURE = 120;
  EVP_R_KEY_SETUP_FAILED = 180;
  EVP_R_MEMORY_LIMIT_EXCEEDED = 172;
  EVP_R_MESSAGE_DIGEST_IS_NULL = 159;
  EVP_R_METHOD_NOT_SUPPORTED = 144;
  EVP_R_MISSING_PARAMETERS = 103;
  EVP_R_NOT_XOF_OR_INVALID_LENGTH = 178;
  EVP_R_NO_CIPHER_SET = 131;
  EVP_R_NO_DEFAULT_DIGEST = 158;
  EVP_R_NO_DIGEST_SET = 139;
  EVP_R_NO_KEY_SET = 154;
  EVP_R_NO_OPERATION_SET = 149;
  EVP_R_ONLY_ONESHOT_SUPPORTED = 177;
  EVP_R_OPERATION_NOT_SUPPORTED_FOR_THIS_KEYTYPE = 150;
  EVP_R_OPERATON_NOT_INITIALIZED = 151;
  EVP_R_PARTIALLY_OVERLAPPING = 162;
  EVP_R_PBKDF2_ERROR = 181;
  EVP_R_PKEY_APPLICATION_ASN1_METHOD_ALREADY_REGISTERED = 179;
  EVP_R_PRIVATE_KEY_DECODE_ERROR = 145;
  EVP_R_PRIVATE_KEY_ENCODE_ERROR = 146;
  EVP_R_PUBLIC_KEY_NOT_RSA = 106;
  EVP_R_UNKNOWN_CIPHER = 160;
  EVP_R_UNKNOWN_DIGEST = 161;
  EVP_R_UNKNOWN_OPTION = 169;
  EVP_R_UNKNOWN_PBE_ALGORITHM = 121;
  EVP_R_UNSUPPORTED_ALGORITHM = 156;
  EVP_R_UNSUPPORTED_CIPHER = 107;
  EVP_R_UNSUPPORTED_KEYLENGTH = 123;
  EVP_R_UNSUPPORTED_KEY_DERIVATION_FUNCTION = 124;
  EVP_R_UNSUPPORTED_KEY_SIZE = 108;
  EVP_R_UNSUPPORTED_NUMBER_OF_ROUNDS = 135;
  EVP_R_UNSUPPORTED_PRF = 125;
  EVP_R_UNSUPPORTED_PRIVATE_KEY_ALGORITHM = 118;
  EVP_R_UNSUPPORTED_SALT_TYPE = 126;
  EVP_R_WRAP_MODE_NOT_ALLOWED = 170;
  EVP_R_WRONG_FINAL_BLOCK_LENGTH = 109;
  EVP_R_XTS_DUPLICATED_KEYS = 183;

  function ERR_load_EVP_strings: TIdC_INT cdecl; external CLibCrypto;

implementation

end.
