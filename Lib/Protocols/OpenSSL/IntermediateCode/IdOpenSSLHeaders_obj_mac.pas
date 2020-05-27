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

unit IdOpenSSLHeaders_obj_mac;

interface

// Headers for OpenSSL 1.1.1
// obj_mac.h

{$i IdCompilerDefines.inc}

const
  SN_undef = AnsiString('UNDEF');
  LN_undef = AnsiString('undefined');
  NID_undef = 0;

  SN_itu_t = AnsiString('ITU-T');
  LN_itu_t = AnsiString('itu-t');
  NID_itu_t = 645;

  NID_ccitt = 404;

  SN_iso = AnsiString('ISO');
  LN_iso = AnsiString('iso');
  NID_iso = 181;

  SN_joint_iso_itu_t = AnsiString('JOINT-ISO-ITU-T');
  LN_joint_iso_itu_t = AnsiString('joint-iso-itu-t');
  NID_joint_iso_itu_t = 646;

  NID_joint_iso_ccitt = 393;

  SN_member_body = AnsiString('member-body');
  LN_member_body = AnsiString('ISO Member Body');
  NID_member_body = 182;

  SN_identified_organization = AnsiString('identified-organization');
  NID_identified_organization = 676;

  SN_hmac_md5 = AnsiString('HMAC-MD5');
  LN_hmac_md5 = AnsiString('hmac-md5');
  NID_hmac_md5 = 780;

  SN_hmac_sha1 = AnsiString('HMAC-SHA1');
  LN_hmac_sha1 = AnsiString('hmac-sha1');
  NID_hmac_sha1 = 781;

  SN_x509ExtAdmission = AnsiString('x509ExtAdmission');
  LN_x509ExtAdmission = AnsiString('Professional Information or basis for Admission');
  NID_x509ExtAdmission = 1093;

  SN_certicom_arc = AnsiString('certicom-arc');
  NID_certicom_arc = 677;

  SN_ieee = AnsiString('ieee');
  NID_ieee = 1170;

  SN_ieee_siswg = AnsiString('ieee-siswg');
  LN_ieee_siswg = AnsiString('IEEE Security in Storage Working Group');
  NID_ieee_siswg = 1171;

  SN_international_organizations = AnsiString('international-organizations');
  LN_international_organizations = AnsiString('International Organizations');
  NID_international_organizations = 647;

  SN_wap = AnsiString('wap');
  NID_wap = 678;

  SN_wap_wsg = AnsiString('wap-wsg');
  NID_wap_wsg = 679;

  SN_selected_attribute_types = AnsiString('selected-attribute-types');
  LN_selected_attribute_types = AnsiString('Selected Attribute Types');
  NID_selected_attribute_types = 394;

  SN_clearance = AnsiString('clearance');
  NID_clearance = 395;

  SN_ISO_US = AnsiString('ISO-US');
  LN_ISO_US = AnsiString('ISO US Member Body');
  NID_ISO_US = 183;

  SN_X9_57 = AnsiString('X9-57');
  LN_X9_57 = AnsiString('X9.57');
  NID_X9_57 = 184;

  SN_X9cm = AnsiString('X9cm');
  LN_X9cm = AnsiString('X9.57 CM ?');
  NID_X9cm = 185;

  SN_ISO_CN = AnsiString('ISO-CN');
  LN_ISO_CN = AnsiString('ISO CN Member Body');
  NID_ISO_CN = 1140;

  SN_oscca = AnsiString('oscca');
  NID_oscca = 1141;

  SN_sm_scheme = AnsiString('sm-scheme');
  NID_sm_scheme = 1142;

  SN_dsa = AnsiString('DSA');
  LN_dsa = AnsiString('dsaEncryption');
  NID_dsa = 116;

  SN_dsaWithSHA1 = AnsiString('DSA-SHA1');
  LN_dsaWithSHA1 = AnsiString('dsaWithSHA1');
  NID_dsaWithSHA1 = 113;

  SN_ansi_X9_62 = AnsiString('ansi-X9-62');
  LN_ansi_X9_62 = AnsiString('ANSI X9.62');
  NID_ansi_X9_62 = 405;

  SN_X9_62_prime_field = AnsiString('prime-field');
  NID_X9_62_prime_field = 406;

  SN_X9_62_characteristic_two_field = AnsiString('characteristic-two-field');
  NID_X9_62_characteristic_two_field = 407;

  SN_X9_62_id_characteristic_two_basis = AnsiString('id-characteristic-two-basis');
  NID_X9_62_id_characteristic_two_basis = 680;

  SN_X9_62_onBasis = AnsiString('onBasis');
  NID_X9_62_onBasis = 681;

  SN_X9_62_tpBasis = AnsiString('tpBasis');
  NID_X9_62_tpBasis = 682;

  SN_X9_62_ppBasis = AnsiString('ppBasis');
  NID_X9_62_ppBasis = 683;

  SN_X9_62_id_ecPublicKey = AnsiString('id-ecPublicKey');
  NID_X9_62_id_ecPublicKey = 408;

  SN_X9_62_c2pnb163v1 = AnsiString('c2pnb163v1');
  NID_X9_62_c2pnb163v1 = 684;

  SN_X9_62_c2pnb163v2 = AnsiString('c2pnb163v2');
  NID_X9_62_c2pnb163v2 = 685;

  SN_X9_62_c2pnb163v3 = AnsiString('c2pnb163v3');
  NID_X9_62_c2pnb163v3 = 686;

  SN_X9_62_c2pnb176v1 = AnsiString('c2pnb176v1');
  NID_X9_62_c2pnb176v1 = 687;

  SN_X9_62_c2tnb191v1 = AnsiString('c2tnb191v1');
  NID_X9_62_c2tnb191v1 = 688;

  SN_X9_62_c2tnb191v2 = AnsiString('c2tnb191v2');
  NID_X9_62_c2tnb191v2 = 689;

  SN_X9_62_c2tnb191v3 = AnsiString('c2tnb191v3');
  NID_X9_62_c2tnb191v3 = 690;

  SN_X9_62_c2onb191v4 = AnsiString('c2onb191v4');
  NID_X9_62_c2onb191v4 = 691;

  SN_X9_62_c2onb191v5 = AnsiString('c2onb191v5');
  NID_X9_62_c2onb191v5 = 692;

  SN_X9_62_c2pnb208w1 = AnsiString('c2pnb208w1');
  NID_X9_62_c2pnb208w1 = 693;

  SN_X9_62_c2tnb239v1 = AnsiString('c2tnb239v1');
  NID_X9_62_c2tnb239v1 = 694;

  SN_X9_62_c2tnb239v2 = AnsiString('c2tnb239v2');
  NID_X9_62_c2tnb239v2 = 695;

  SN_X9_62_c2tnb239v3 = AnsiString('c2tnb239v3');
  NID_X9_62_c2tnb239v3 = 696;

  SN_X9_62_c2onb239v4 = AnsiString('c2onb239v4');
  NID_X9_62_c2onb239v4 = 697;

  SN_X9_62_c2onb239v5 = AnsiString('c2onb239v5');
  NID_X9_62_c2onb239v5 = 698;

  SN_X9_62_c2pnb272w1 = AnsiString('c2pnb272w1');
  NID_X9_62_c2pnb272w1 = 699;

  SN_X9_62_c2pnb304w1 = AnsiString('c2pnb304w1');
  NID_X9_62_c2pnb304w1 = 700;

  SN_X9_62_c2tnb359v1 = AnsiString('c2tnb359v1');
  NID_X9_62_c2tnb359v1 = 701;

  SN_X9_62_c2pnb368w1 = AnsiString('c2pnb368w1');
  NID_X9_62_c2pnb368w1 = 702;

  SN_X9_62_c2tnb431r1 = AnsiString('c2tnb431r1');
  NID_X9_62_c2tnb431r1 = 703;

  SN_X9_62_prime192v1 = AnsiString('prime192v1');
  NID_X9_62_prime192v1 = 409;

  SN_X9_62_prime192v2 = AnsiString('prime192v2');
  NID_X9_62_prime192v2 = 410;

  SN_X9_62_prime192v3 = AnsiString('prime192v3');
  NID_X9_62_prime192v3 = 411;

  SN_X9_62_prime239v1 = AnsiString('prime239v1');
  NID_X9_62_prime239v1 = 412;

  SN_X9_62_prime239v2 = AnsiString('prime239v2');
  NID_X9_62_prime239v2 = 413;

  SN_X9_62_prime239v3 = AnsiString('prime239v3');
  NID_X9_62_prime239v3 = 414;

  SN_X9_62_prime256v1 = AnsiString('prime256v1');
  NID_X9_62_prime256v1 = 415;

  SN_ecdsa_with_SHA1 = AnsiString('ecdsa-with-SHA1');
  NID_ecdsa_with_SHA1 = 416;

  SN_ecdsa_with_Recommended = AnsiString('ecdsa-with-Recommended');
  NID_ecdsa_with_Recommended = 791;

  SN_ecdsa_with_Specified = AnsiString('ecdsa-with-Specified');
  NID_ecdsa_with_Specified = 792;

  SN_ecdsa_with_SHA224 = AnsiString('ecdsa-with-SHA224');
  NID_ecdsa_with_SHA224 = 793;

  SN_ecdsa_with_SHA256 = AnsiString('ecdsa-with-SHA256');
  NID_ecdsa_with_SHA256 = 794;

  SN_ecdsa_with_SHA384 = AnsiString('ecdsa-with-SHA384');
  NID_ecdsa_with_SHA384 = 795;

  SN_ecdsa_with_SHA512 = AnsiString('ecdsa-with-SHA512');
  NID_ecdsa_with_SHA512 = 796;

  SN_secp112r1 = AnsiString('secp112r1');
  NID_secp112r1 = 704;

  SN_secp112r2 = AnsiString('secp112r2');
  NID_secp112r2 = 705;

  SN_secp128r1 = AnsiString('secp128r1');
  NID_secp128r1 = 706;

  SN_secp128r2 = AnsiString('secp128r2');
  NID_secp128r2 = 707;

  SN_secp160k1 = AnsiString('secp160k1');
  NID_secp160k1 = 708;

  SN_secp160r1 = AnsiString('secp160r1');
  NID_secp160r1 = 709;

  SN_secp160r2 = AnsiString('secp160r2');
  NID_secp160r2 = 710;

  SN_secp192k1 = AnsiString('secp192k1');
  NID_secp192k1 = 711;

  SN_secp224k1 = AnsiString('secp224k1');
  NID_secp224k1 = 712;

  SN_secp224r1 = AnsiString('secp224r1');
  NID_secp224r1 = 713;

  SN_secp256k1 = AnsiString('secp256k1');
  NID_secp256k1 = 714;

  SN_secp384r1 = AnsiString('secp384r1');
  NID_secp384r1 = 715;

  SN_secp521r1 = AnsiString('secp521r1');
  NID_secp521r1 = 716;

  SN_sect113r1 = AnsiString('sect113r1');
  NID_sect113r1 = 717;

  SN_sect113r2 = AnsiString('sect113r2');
  NID_sect113r2 = 718;

  SN_sect131r1 = AnsiString('sect131r1');
  NID_sect131r1 = 719;

  SN_sect131r2 = AnsiString('sect131r2');
  NID_sect131r2 = 720;

  SN_sect163k1 = AnsiString('sect163k1');
  NID_sect163k1 = 721;

  SN_sect163r1 = AnsiString('sect163r1');
  NID_sect163r1 = 722;

  SN_sect163r2 = AnsiString('sect163r2');
  NID_sect163r2 = 723;

  SN_sect193r1 = AnsiString('sect193r1');
  NID_sect193r1 = 724;

  SN_sect193r2 = AnsiString('sect193r2');
  NID_sect193r2 = 725;

  SN_sect233k1 = AnsiString('sect233k1');
  NID_sect233k1 = 726;

  SN_sect233r1 = AnsiString('sect233r1');
  NID_sect233r1 = 727;

  SN_sect239k1 = AnsiString('sect239k1');
  NID_sect239k1 = 728;

  SN_sect283k1 = AnsiString('sect283k1');
  NID_sect283k1 = 729;

  SN_sect283r1 = AnsiString('sect283r1');
  NID_sect283r1 = 730;

  SN_sect409k1 = AnsiString('sect409k1');
  NID_sect409k1 = 731;

  SN_sect409r1 = AnsiString('sect409r1');
  NID_sect409r1 = 732;

  SN_sect571k1 = AnsiString('sect571k1');
  NID_sect571k1 = 733;

  SN_sect571r1 = AnsiString('sect571r1');
  NID_sect571r1 = 734;

  SN_wap_wsg_idm_ecid_wtls1 = AnsiString('wap-wsg-idm-ecid-wtls1');
  NID_wap_wsg_idm_ecid_wtls1 = 735;

  SN_wap_wsg_idm_ecid_wtls3 = AnsiString('wap-wsg-idm-ecid-wtls3');
  NID_wap_wsg_idm_ecid_wtls3 = 736;

  SN_wap_wsg_idm_ecid_wtls4 = AnsiString('wap-wsg-idm-ecid-wtls4');
  NID_wap_wsg_idm_ecid_wtls4 = 737;

  SN_wap_wsg_idm_ecid_wtls5 = AnsiString('wap-wsg-idm-ecid-wtls5');
  NID_wap_wsg_idm_ecid_wtls5 = 738;

  SN_wap_wsg_idm_ecid_wtls6 = AnsiString('wap-wsg-idm-ecid-wtls6');
  NID_wap_wsg_idm_ecid_wtls6 = 739;

  SN_wap_wsg_idm_ecid_wtls7 = AnsiString('wap-wsg-idm-ecid-wtls7');
  NID_wap_wsg_idm_ecid_wtls7 = 740;

  SN_wap_wsg_idm_ecid_wtls8 = AnsiString('wap-wsg-idm-ecid-wtls8');
  NID_wap_wsg_idm_ecid_wtls8 = 741;

  SN_wap_wsg_idm_ecid_wtls9 = AnsiString('wap-wsg-idm-ecid-wtls9');
  NID_wap_wsg_idm_ecid_wtls9 = 742;

  SN_wap_wsg_idm_ecid_wtls10 = AnsiString('wap-wsg-idm-ecid-wtls10');
  NID_wap_wsg_idm_ecid_wtls10 = 743;

  SN_wap_wsg_idm_ecid_wtls11 = AnsiString('wap-wsg-idm-ecid-wtls11');
  NID_wap_wsg_idm_ecid_wtls11 = 744;

  SN_wap_wsg_idm_ecid_wtls12 = AnsiString('wap-wsg-idm-ecid-wtls12');
  NID_wap_wsg_idm_ecid_wtls12 = 745;

  SN_cast5_cbc = AnsiString('CAST5-CBC');
  LN_cast5_cbc = AnsiString('cast5-cbc');
  NID_cast5_cbc = 108;

  SN_cast5_ecb = AnsiString('CAST5-ECB');
  LN_cast5_ecb = AnsiString('cast5-ecb');
  NID_cast5_ecb = 109;

  SN_cast5_cfb64 = AnsiString('CAST5-CFB');
  LN_cast5_cfb64 = AnsiString('cast5-cfb');
  NID_cast5_cfb64 = 110;

  SN_cast5_ofb64 = AnsiString('CAST5-OFB');
  LN_cast5_ofb64 = AnsiString('cast5-ofb');
  NID_cast5_ofb64 = 111;

  LN_pbeWithMD5AndCast5_CBC = AnsiString('pbeWithMD5AndCast5CBC');
  NID_pbeWithMD5AndCast5_CBC = 112;

  SN_id_PasswordBasedMAC = AnsiString('id-PasswordBasedMAC');
  LN_id_PasswordBasedMAC = AnsiString('password based MAC');
  NID_id_PasswordBasedMAC = 782;

  SN_id_DHBasedMac = AnsiString('id-DHBasedMac');
  LN_id_DHBasedMac = AnsiString('Diffie-Hellman based MAC');
  NID_id_DHBasedMac = 783;

  SN_rsadsi = AnsiString('rsadsi');
  LN_rsadsi = AnsiString('RSA Data Security; Inc.');
  NID_rsadsi = 1;

  SN_pkcs = AnsiString('pkcs');
  LN_pkcs = AnsiString('RSA Data Security; Inc. PKCS');
  NID_pkcs = 2;

  SN_pkcs1 = AnsiString('pkcs1');
  NID_pkcs1 = 186;

  LN_rsaEncryption = AnsiString('rsaEncryption');
  NID_rsaEncryption = 6;

  SN_md2WithRSAEncryption = AnsiString('RSA-MD2');
  LN_md2WithRSAEncryption = AnsiString('md2WithRSAEncryption');
  NID_md2WithRSAEncryption = 7;

  SN_md4WithRSAEncryption = AnsiString('RSA-MD4');
  LN_md4WithRSAEncryption = AnsiString('md4WithRSAEncryption');
  NID_md4WithRSAEncryption = 396;

  SN_md5WithRSAEncryption = AnsiString('RSA-MD5');
  LN_md5WithRSAEncryption = AnsiString('md5WithRSAEncryption');
  NID_md5WithRSAEncryption = 8;

  SN_sha1WithRSAEncryption = AnsiString('RSA-SHA1');
  LN_sha1WithRSAEncryption = AnsiString('sha1WithRSAEncryption');
  NID_sha1WithRSAEncryption = 65;

  SN_rsaesOaep = AnsiString('RSAES-OAEP');
  LN_rsaesOaep = AnsiString('rsaesOaep');
  NID_rsaesOaep = 919;

  SN_mgf1 = AnsiString('MGF1');
  LN_mgf1 = AnsiString('mgf1');
  NID_mgf1 = 911;

  SN_pSpecified = AnsiString('PSPECIFIED');
  LN_pSpecified = AnsiString('pSpecified');
  NID_pSpecified = 935;

  SN_rsassaPss = AnsiString('RSASSA-PSS');
  LN_rsassaPss = AnsiString('rsassaPss');
  NID_rsassaPss = 912;

  SN_sha256WithRSAEncryption = AnsiString('RSA-SHA256');
  LN_sha256WithRSAEncryption = AnsiString('sha256WithRSAEncryption');
  NID_sha256WithRSAEncryption = 668;

  SN_sha384WithRSAEncryption = AnsiString('RSA-SHA384');
  LN_sha384WithRSAEncryption = AnsiString('sha384WithRSAEncryption');
  NID_sha384WithRSAEncryption = 669;

  SN_sha512WithRSAEncryption = AnsiString('RSA-SHA512');
  LN_sha512WithRSAEncryption = AnsiString('sha512WithRSAEncryption');
  NID_sha512WithRSAEncryption = 670;

  SN_sha224WithRSAEncryption = AnsiString('RSA-SHA224');
  LN_sha224WithRSAEncryption = AnsiString('sha224WithRSAEncryption');
  NID_sha224WithRSAEncryption = 671;

  SN_sha512_224WithRSAEncryption = AnsiString('RSA-SHA512/224');
  LN_sha512_224WithRSAEncryption = AnsiString('sha512-224WithRSAEncryption');
  NID_sha512_224WithRSAEncryption = 1145;

  SN_sha512_256WithRSAEncryption = AnsiString('RSA-SHA512/256');
  LN_sha512_256WithRSAEncryption = AnsiString('sha512-256WithRSAEncryption');
  NID_sha512_256WithRSAEncryption = 1146;

  SN_pkcs3 = AnsiString('pkcs3');
  NID_pkcs3 = 27;

  LN_dhKeyAgreement = AnsiString('dhKeyAgreement');
  NID_dhKeyAgreement = 28;

  SN_pkcs5 = AnsiString('pkcs5');
  NID_pkcs5 = 187;

  SN_pbeWithMD2AndDES_CBC = AnsiString('PBE-MD2-DES');
  LN_pbeWithMD2AndDES_CBC = AnsiString('pbeWithMD2AndDES-CBC');
  NID_pbeWithMD2AndDES_CBC = 9;

  SN_pbeWithMD5AndDES_CBC = AnsiString('PBE-MD5-DES');
  LN_pbeWithMD5AndDES_CBC = AnsiString('pbeWithMD5AndDES-CBC');
  NID_pbeWithMD5AndDES_CBC = 10;

  SN_pbeWithMD2AndRC2_CBC = AnsiString('PBE-MD2-RC2-64');
  LN_pbeWithMD2AndRC2_CBC = AnsiString('pbeWithMD2AndRC2-CBC');
  NID_pbeWithMD2AndRC2_CBC = 168;

  SN_pbeWithMD5AndRC2_CBC = AnsiString('PBE-MD5-RC2-64');
  LN_pbeWithMD5AndRC2_CBC = AnsiString('pbeWithMD5AndRC2-CBC');
  NID_pbeWithMD5AndRC2_CBC = 169;

  SN_pbeWithSHA1AndDES_CBC = AnsiString('PBE-SHA1-DES');
  LN_pbeWithSHA1AndDES_CBC = AnsiString('pbeWithSHA1AndDES-CBC');
  NID_pbeWithSHA1AndDES_CBC = 170;

  SN_pbeWithSHA1AndRC2_CBC = AnsiString('PBE-SHA1-RC2-64');
  LN_pbeWithSHA1AndRC2_CBC = AnsiString('pbeWithSHA1AndRC2-CBC');
  NID_pbeWithSHA1AndRC2_CBC = 68;

  LN_id_pbkdf2 = AnsiString('PBKDF2');
  NID_id_pbkdf2 = 69;

  LN_pbes2 = AnsiString('PBES2');
  NID_pbes2 = 161;

  LN_pbmac1 = AnsiString('PBMAC1');
  NID_pbmac1 = 162;

  SN_pkcs7 = AnsiString('pkcs7');
  NID_pkcs7 = 20;

  LN_pkcs7_data = AnsiString('pkcs7-data');
  NID_pkcs7_data = 21;

  LN_pkcs7_signed = AnsiString('pkcs7-signedData');
  NID_pkcs7_signed = 22;

  LN_pkcs7_enveloped = AnsiString('pkcs7-envelopedData');
  NID_pkcs7_enveloped = 23;

  LN_pkcs7_signedAndEnveloped = AnsiString('pkcs7-signedAndEnvelopedData');
  NID_pkcs7_signedAndEnveloped = 24;

  LN_pkcs7_digest = AnsiString('pkcs7-digestData');
  NID_pkcs7_digest = 25;

  LN_pkcs7_encrypted = AnsiString('pkcs7-encryptedData');
  NID_pkcs7_encrypted = 26;

  SN_pkcs9 = AnsiString('pkcs9');
  NID_pkcs9 = 47;

  LN_pkcs9_emailAddress = AnsiString('emailAddress');
  NID_pkcs9_emailAddress = 48;

  LN_pkcs9_unstructuredName = AnsiString('unstructuredName');
  NID_pkcs9_unstructuredName = 49;

  LN_pkcs9_contentType = AnsiString('contentType');
  NID_pkcs9_contentType = 50;

  LN_pkcs9_messageDigest = AnsiString('messageDigest');
  NID_pkcs9_messageDigest = 51;

  LN_pkcs9_signingTime = AnsiString('signingTime');
  NID_pkcs9_signingTime = 52;

  LN_pkcs9_countersignature = AnsiString('countersignature');
  NID_pkcs9_countersignature = 53;

  LN_pkcs9_challengePassword = AnsiString('challengePassword');
  NID_pkcs9_challengePassword = 54;

  LN_pkcs9_unstructuredAddress = AnsiString('unstructuredAddress');
  NID_pkcs9_unstructuredAddress = 55;

  LN_pkcs9_extCertAttributes = AnsiString('extendedCertificateAttributes');
  NID_pkcs9_extCertAttributes = 56;

  SN_ext_req = AnsiString('extReq');
  LN_ext_req = AnsiString('Extension Request');
  NID_ext_req = 172;

  SN_SMIMECapabilities = AnsiString('SMIME-CAPS');
  LN_SMIMECapabilities = AnsiString('S/MIME Capabilities');
  NID_SMIMECapabilities = 167;

  SN_SMIME = AnsiString('SMIME');
  LN_SMIME = AnsiString('S/MIME');
  NID_SMIME = 188;

  SN_id_smime_mod = AnsiString('id-smime-mod');
  NID_id_smime_mod = 189;

  SN_id_smime_ct = AnsiString('id-smime-ct');
  NID_id_smime_ct = 190;

  SN_id_smime_aa = AnsiString('id-smime-aa');
  NID_id_smime_aa = 191;

  SN_id_smime_alg = AnsiString('id-smime-alg');
  NID_id_smime_alg = 192;

  SN_id_smime_cd = AnsiString('id-smime-cd');
  NID_id_smime_cd = 193;

  SN_id_smime_spq = AnsiString('id-smime-spq');
  NID_id_smime_spq = 194;

  SN_id_smime_cti = AnsiString('id-smime-cti');
  NID_id_smime_cti = 195;

  SN_id_smime_mod_cms = AnsiString('id-smime-mod-cms');
  NID_id_smime_mod_cms = 196;

  SN_id_smime_mod_ess = AnsiString('id-smime-mod-ess');
  NID_id_smime_mod_ess = 197;

  SN_id_smime_mod_oid = AnsiString('id-smime-mod-oid');
  NID_id_smime_mod_oid = 198;

  SN_id_smime_mod_msg_v3 = AnsiString('id-smime-mod-msg-v3');
  NID_id_smime_mod_msg_v3 = 199;

  SN_id_smime_mod_ets_eSignature_88 = AnsiString('id-smime-mod-ets-eSignature-88');
  NID_id_smime_mod_ets_eSignature_88 = 200;

  SN_id_smime_mod_ets_eSignature_97 = AnsiString('id-smime-mod-ets-eSignature-97');
  NID_id_smime_mod_ets_eSignature_97 = 201;

  SN_id_smime_mod_ets_eSigPolicy_88 = AnsiString('id-smime-mod-ets-eSigPolicy-88');
  NID_id_smime_mod_ets_eSigPolicy_88 = 202;

  SN_id_smime_mod_ets_eSigPolicy_97 = AnsiString('id-smime-mod-ets-eSigPolicy-97');
  NID_id_smime_mod_ets_eSigPolicy_97 = 203;

  SN_id_smime_ct_receipt = AnsiString('id-smime-ct-receipt');
  NID_id_smime_ct_receipt = 204;

  SN_id_smime_ct_authData = AnsiString('id-smime-ct-authData');
  NID_id_smime_ct_authData = 205;

  SN_id_smime_ct_publishCert = AnsiString('id-smime-ct-publishCert');
  NID_id_smime_ct_publishCert = 206;

  SN_id_smime_ct_TSTInfo = AnsiString('id-smime-ct-TSTInfo');
  NID_id_smime_ct_TSTInfo = 207;

  SN_id_smime_ct_TDTInfo = AnsiString('id-smime-ct-TDTInfo');
  NID_id_smime_ct_TDTInfo = 208;

  SN_id_smime_ct_contentInfo = AnsiString('id-smime-ct-contentInfo');
  NID_id_smime_ct_contentInfo = 209;

  SN_id_smime_ct_DVCSRequestData = AnsiString('id-smime-ct-DVCSRequestData');
  NID_id_smime_ct_DVCSRequestData = 210;

  SN_id_smime_ct_DVCSResponseData = AnsiString('id-smime-ct-DVCSResponseData');
  NID_id_smime_ct_DVCSResponseData = 211;

  SN_id_smime_ct_compressedData = AnsiString('id-smime-ct-compressedData');
  NID_id_smime_ct_compressedData = 786;

  SN_id_smime_ct_contentCollection = AnsiString('id-smime-ct-contentCollection');
  NID_id_smime_ct_contentCollection = 1058;

  SN_id_smime_ct_authEnvelopedData = AnsiString('id-smime-ct-authEnvelopedData');
  NID_id_smime_ct_authEnvelopedData = 1059;

  SN_id_ct_asciiTextWithCRLF = AnsiString('id-ct-asciiTextWithCRLF');
  NID_id_ct_asciiTextWithCRLF = 787;

  SN_id_ct_xml = AnsiString('id-ct-xml');
  NID_id_ct_xml = 1060;

  SN_id_smime_aa_receiptRequest = AnsiString('id-smime-aa-receiptRequest');
  NID_id_smime_aa_receiptRequest = 212;

  SN_id_smime_aa_securityLabel = AnsiString('id-smime-aa-securityLabel');
  NID_id_smime_aa_securityLabel = 213;

  SN_id_smime_aa_mlExpandHistory = AnsiString('id-smime-aa-mlExpandHistory');
  NID_id_smime_aa_mlExpandHistory = 214;

  SN_id_smime_aa_contentHint = AnsiString('id-smime-aa-contentHint');
  NID_id_smime_aa_contentHint = 215;

  SN_id_smime_aa_msgSigDigest = AnsiString('id-smime-aa-msgSigDigest');
  NID_id_smime_aa_msgSigDigest = 216;

  SN_id_smime_aa_encapContentType = AnsiString('id-smime-aa-encapContentType');
  NID_id_smime_aa_encapContentType = 217;

  SN_id_smime_aa_contentIdentifier = AnsiString('id-smime-aa-contentIdentifier');
  NID_id_smime_aa_contentIdentifier = 218;

  SN_id_smime_aa_macValue = AnsiString('id-smime-aa-macValue');
  NID_id_smime_aa_macValue = 219;

  SN_id_smime_aa_equivalentLabels = AnsiString('id-smime-aa-equivalentLabels');
  NID_id_smime_aa_equivalentLabels = 220;

  SN_id_smime_aa_contentReference = AnsiString('id-smime-aa-contentReference');
  NID_id_smime_aa_contentReference = 221;

  SN_id_smime_aa_encrypKeyPref = AnsiString('id-smime-aa-encrypKeyPref');
  NID_id_smime_aa_encrypKeyPref = 222;

  SN_id_smime_aa_signingCertificate = AnsiString('id-smime-aa-signingCertificate');
  NID_id_smime_aa_signingCertificate = 223;

  SN_id_smime_aa_smimeEncryptCerts = AnsiString('id-smime-aa-smimeEncryptCerts');
  NID_id_smime_aa_smimeEncryptCerts = 224;

  SN_id_smime_aa_timeStampToken = AnsiString('id-smime-aa-timeStampToken');
  NID_id_smime_aa_timeStampToken = 225;

  SN_id_smime_aa_ets_sigPolicyId = AnsiString('id-smime-aa-ets-sigPolicyId');
  NID_id_smime_aa_ets_sigPolicyId = 226;

  SN_id_smime_aa_ets_commitmentType = AnsiString('id-smime-aa-ets-commitmentType');
  NID_id_smime_aa_ets_commitmentType = 227;

  SN_id_smime_aa_ets_signerLocation = AnsiString('id-smime-aa-ets-signerLocation');
  NID_id_smime_aa_ets_signerLocation = 228;

  SN_id_smime_aa_ets_signerAttr = AnsiString('id-smime-aa-ets-signerAttr');
  NID_id_smime_aa_ets_signerAttr = 229;

  SN_id_smime_aa_ets_otherSigCert = AnsiString('id-smime-aa-ets-otherSigCert');
  NID_id_smime_aa_ets_otherSigCert = 230;

  SN_id_smime_aa_ets_contentTimestamp = AnsiString('id-smime-aa-ets-contentTimestamp');
  NID_id_smime_aa_ets_contentTimestamp = 231;

  SN_id_smime_aa_ets_CertificateRefs = AnsiString('id-smime-aa-ets-CertificateRefs');
  NID_id_smime_aa_ets_CertificateRefs = 232;

  SN_id_smime_aa_ets_RevocationRefs = AnsiString('id-smime-aa-ets-RevocationRefs');
  NID_id_smime_aa_ets_RevocationRefs = 233;

  SN_id_smime_aa_ets_certValues = AnsiString('id-smime-aa-ets-certValues');
  NID_id_smime_aa_ets_certValues = 234;

  SN_id_smime_aa_ets_revocationValues = AnsiString('id-smime-aa-ets-revocationValues');
  NID_id_smime_aa_ets_revocationValues = 235;

  SN_id_smime_aa_ets_escTimeStamp = AnsiString('id-smime-aa-ets-escTimeStamp');
  NID_id_smime_aa_ets_escTimeStamp = 236;

  SN_id_smime_aa_ets_certCRLTimestamp = AnsiString('id-smime-aa-ets-certCRLTimestamp');
  NID_id_smime_aa_ets_certCRLTimestamp = 237;

  SN_id_smime_aa_ets_archiveTimeStamp = AnsiString('id-smime-aa-ets-archiveTimeStamp');
  NID_id_smime_aa_ets_archiveTimeStamp = 238;

  SN_id_smime_aa_signatureType = AnsiString('id-smime-aa-signatureType');
  NID_id_smime_aa_signatureType = 239;

  SN_id_smime_aa_dvcs_dvc = AnsiString('id-smime-aa-dvcs-dvc');
  NID_id_smime_aa_dvcs_dvc = 240;

  SN_id_smime_aa_signingCertificateV2 = AnsiString('id-smime-aa-signingCertificateV2');
  NID_id_smime_aa_signingCertificateV2 = 1086;

  SN_id_smime_alg_ESDHwith3DES = AnsiString('id-smime-alg-ESDHwith3DES');
  NID_id_smime_alg_ESDHwith3DES = 241;

  SN_id_smime_alg_ESDHwithRC2 = AnsiString('id-smime-alg-ESDHwithRC2');
  NID_id_smime_alg_ESDHwithRC2 = 242;

  SN_id_smime_alg_3DESwrap = AnsiString('id-smime-alg-3DESwrap');
  NID_id_smime_alg_3DESwrap = 243;

  SN_id_smime_alg_RC2wrap = AnsiString('id-smime-alg-RC2wrap');
  NID_id_smime_alg_RC2wrap = 244;

  SN_id_smime_alg_ESDH = AnsiString('id-smime-alg-ESDH');
  NID_id_smime_alg_ESDH = 245;

  SN_id_smime_alg_CMS3DESwrap = AnsiString('id-smime-alg-CMS3DESwrap');
  NID_id_smime_alg_CMS3DESwrap = 246;

  SN_id_smime_alg_CMSRC2wrap = AnsiString('id-smime-alg-CMSRC2wrap');
  NID_id_smime_alg_CMSRC2wrap = 247;

  SN_id_alg_PWRI_KEK = AnsiString('id-alg-PWRI-KEK');
  NID_id_alg_PWRI_KEK = 893;

  SN_id_smime_cd_ldap = AnsiString('id-smime-cd-ldap');
  NID_id_smime_cd_ldap = 248;

  SN_id_smime_spq_ets_sqt_uri = AnsiString('id-smime-spq-ets-sqt-uri');
  NID_id_smime_spq_ets_sqt_uri = 249;

  SN_id_smime_spq_ets_sqt_unotice = AnsiString('id-smime-spq-ets-sqt-unotice');
  NID_id_smime_spq_ets_sqt_unotice = 250;

  SN_id_smime_cti_ets_proofOfOrigin = AnsiString('id-smime-cti-ets-proofOfOrigin');
  NID_id_smime_cti_ets_proofOfOrigin = 251;

  SN_id_smime_cti_ets_proofOfReceipt = AnsiString('id-smime-cti-ets-proofOfReceipt');
  NID_id_smime_cti_ets_proofOfReceipt = 252;

  SN_id_smime_cti_ets_proofOfDelivery = AnsiString('id-smime-cti-ets-proofOfDelivery');
  NID_id_smime_cti_ets_proofOfDelivery = 253;

  SN_id_smime_cti_ets_proofOfSender = AnsiString('id-smime-cti-ets-proofOfSender');
  NID_id_smime_cti_ets_proofOfSender = 254;

  SN_id_smime_cti_ets_proofOfApproval = AnsiString('id-smime-cti-ets-proofOfApproval');
  NID_id_smime_cti_ets_proofOfApproval = 255;

  SN_id_smime_cti_ets_proofOfCreation = AnsiString('id-smime-cti-ets-proofOfCreation');
  NID_id_smime_cti_ets_proofOfCreation = 256;

  LN_friendlyName = AnsiString('friendlyName');
  NID_friendlyName = 156;

  LN_localKeyID = AnsiString('localKeyID');
  NID_localKeyID = 157;

  SN_ms_csp_name = AnsiString('CSPName');
  LN_ms_csp_name = AnsiString('Microsoft CSP Name');
  NID_ms_csp_name = 417;

  SN_LocalKeySet = AnsiString('LocalKeySet');
  LN_LocalKeySet = AnsiString('Microsoft Local Key set');
  NID_LocalKeySet = 856;

  LN_x509Certificate = AnsiString('x509Certificate');
  NID_x509Certificate = 158;

  LN_sdsiCertificate = AnsiString('sdsiCertificate');
  NID_sdsiCertificate = 159;

  LN_x509Crl = AnsiString('x509Crl');
  NID_x509Crl = 160;

  SN_pbe_WithSHA1And128BitRC4 = AnsiString('PBE-SHA1-RC4-128');
  LN_pbe_WithSHA1And128BitRC4 = AnsiString('pbeWithSHA1And128BitRC4');
  NID_pbe_WithSHA1And128BitRC4 = 144;

  SN_pbe_WithSHA1And40BitRC4 = AnsiString('PBE-SHA1-RC4-40');
  LN_pbe_WithSHA1And40BitRC4 = AnsiString('pbeWithSHA1And40BitRC4');
  NID_pbe_WithSHA1And40BitRC4 = 145;

  SN_pbe_WithSHA1And3_Key_TripleDES_CBC = AnsiString('PBE-SHA1-3DES');
  LN_pbe_WithSHA1And3_Key_TripleDES_CBC = AnsiString('pbeWithSHA1And3-KeyTripleDES-CBC');
  NID_pbe_WithSHA1And3_Key_TripleDES_CBC = 146;

  SN_pbe_WithSHA1And2_Key_TripleDES_CBC = AnsiString('PBE-SHA1-2DES');
  LN_pbe_WithSHA1And2_Key_TripleDES_CBC = AnsiString('pbeWithSHA1And2-KeyTripleDES-CBC');
  NID_pbe_WithSHA1And2_Key_TripleDES_CBC = 147;

  SN_pbe_WithSHA1And128BitRC2_CBC = AnsiString('PBE-SHA1-RC2-128');
  LN_pbe_WithSHA1And128BitRC2_CBC = AnsiString('pbeWithSHA1And128BitRC2-CBC');
  NID_pbe_WithSHA1And128BitRC2_CBC = 148;

  SN_pbe_WithSHA1And40BitRC2_CBC = AnsiString('PBE-SHA1-RC2-40');
  LN_pbe_WithSHA1And40BitRC2_CBC = AnsiString('pbeWithSHA1And40BitRC2-CBC');
  NID_pbe_WithSHA1And40BitRC2_CBC = 149;

  LN_keyBag = AnsiString('keyBag');
  NID_keyBag = 150;

  LN_pkcs8ShroudedKeyBag = AnsiString('pkcs8ShroudedKeyBag');
  NID_pkcs8ShroudedKeyBag = 151;

  LN_certBag = AnsiString('certBag');
  NID_certBag = 152;

  LN_crlBag = AnsiString('crlBag');
  NID_crlBag = 153;

  LN_secretBag = AnsiString('secretBag');
  NID_secretBag = 154;

  LN_safeContentsBag = AnsiString('safeContentsBag');
  NID_safeContentsBag = 155;

  SN_md2 = AnsiString('MD2');
  LN_md2 = AnsiString('md2');
  NID_md2 = 3;

  SN_md4 = AnsiString('MD4');
  LN_md4 = AnsiString('md4');
  NID_md4 = 257;

  SN_md5 = AnsiString('MD5');
  LN_md5 = AnsiString('md5');
  NID_md5 = 4;

  SN_md5_sha1 = AnsiString('MD5-SHA1');
  LN_md5_sha1 = AnsiString('md5-sha1');
  NID_md5_sha1 = 114;

  LN_hmacWithMD5 = AnsiString('hmacWithMD5');
  NID_hmacWithMD5 = 797;

  LN_hmacWithSHA1 = AnsiString('hmacWithSHA1');
  NID_hmacWithSHA1 = 163;

  SN_sm2 = AnsiString('SM2');
  LN_sm2 = AnsiString('sm2');
  NID_sm2 = 1172;

  SN_sm3 = AnsiString('SM3');
  LN_sm3 = AnsiString('sm3');
  NID_sm3 = 1143;

  SN_sm3WithRSAEncryption = AnsiString('RSA-SM3');
  LN_sm3WithRSAEncryption = AnsiString('sm3WithRSAEncryption');
  NID_sm3WithRSAEncryption = 1144;

  LN_hmacWithSHA224 = AnsiString('hmacWithSHA224');
  NID_hmacWithSHA224 = 798;

  LN_hmacWithSHA256 = AnsiString('hmacWithSHA256');
  NID_hmacWithSHA256 = 799;

  LN_hmacWithSHA384 = AnsiString('hmacWithSHA384');
  NID_hmacWithSHA384 = 800;

  LN_hmacWithSHA512 = AnsiString('hmacWithSHA512');
  NID_hmacWithSHA512 = 801;

  LN_hmacWithSHA512_224 = AnsiString('hmacWithSHA512-224');
  NID_hmacWithSHA512_224 = 1193;

  LN_hmacWithSHA512_256 = AnsiString('hmacWithSHA512-256');
  NID_hmacWithSHA512_256 = 1194;

  SN_rc2_cbc = AnsiString('RC2-CBC');
  LN_rc2_cbc = AnsiString('rc2-cbc');
  NID_rc2_cbc = 37;

  SN_rc2_ecb = AnsiString('RC2-ECB');
  LN_rc2_ecb = AnsiString('rc2-ecb');
  NID_rc2_ecb = 38;

  SN_rc2_cfb64 = AnsiString('RC2-CFB');
  LN_rc2_cfb64 = AnsiString('rc2-cfb');
  NID_rc2_cfb64 = 39;

  SN_rc2_ofb64 = AnsiString('RC2-OFB');
  LN_rc2_ofb64 = AnsiString('rc2-ofb');
  NID_rc2_ofb64 = 40;

  SN_rc2_40_cbc = AnsiString('RC2-40-CBC');
  LN_rc2_40_cbc = AnsiString('rc2-40-cbc');
  NID_rc2_40_cbc = 98;

  SN_rc2_64_cbc = AnsiString('RC2-64-CBC');
  LN_rc2_64_cbc = AnsiString('rc2-64-cbc');
  NID_rc2_64_cbc = 166;

  SN_rc4 = AnsiString('RC4');
  LN_rc4 = AnsiString('rc4');
  NID_rc4 = 5;

  SN_rc4_40 = AnsiString('RC4-40');
  LN_rc4_40 = AnsiString('rc4-40');
  NID_rc4_40 = 97;

  SN_des_ede3_cbc = AnsiString('DES-EDE3-CBC');
  LN_des_ede3_cbc = AnsiString('des-ede3-cbc');
  NID_des_ede3_cbc = 44;

  SN_rc5_cbc = AnsiString('RC5-CBC');
  LN_rc5_cbc = AnsiString('rc5-cbc');
  NID_rc5_cbc = 120;

  SN_rc5_ecb = AnsiString('RC5-ECB');
  LN_rc5_ecb = AnsiString('rc5-ecb');
  NID_rc5_ecb = 121;

  SN_rc5_cfb64 = AnsiString('RC5-CFB');
  LN_rc5_cfb64 = AnsiString('rc5-cfb');
  NID_rc5_cfb64 = 122;

  SN_rc5_ofb64 = AnsiString('RC5-OFB');
  LN_rc5_ofb64 = AnsiString('rc5-ofb');
  NID_rc5_ofb64 = 123;

  SN_ms_ext_req = AnsiString('msExtReq');
  LN_ms_ext_req = AnsiString('Microsoft Extension Request');
  NID_ms_ext_req = 171;

  SN_ms_code_ind = AnsiString('msCodeInd');
  LN_ms_code_ind = AnsiString('Microsoft Individual Code Signing');
  NID_ms_code_ind = 134;

  SN_ms_code_com = AnsiString('msCodeCom');
  LN_ms_code_com = AnsiString('Microsoft Commercial Code Signing');
  NID_ms_code_com = 135;

  SN_ms_ctl_sign = AnsiString('msCTLSign');
  LN_ms_ctl_sign = AnsiString('Microsoft Trust List Signing');
  NID_ms_ctl_sign = 136;

  SN_ms_sgc = AnsiString('msSGC');
  LN_ms_sgc = AnsiString('Microsoft Server Gated Crypto');
  NID_ms_sgc = 137;

  SN_ms_efs = AnsiString('msEFS');
  LN_ms_efs = AnsiString('Microsoft Encrypted File System');
  NID_ms_efs = 138;

  SN_ms_smartcard_login = AnsiString('msSmartcardLogin');
  LN_ms_smartcard_login = AnsiString('Microsoft Smartcard Login');
  NID_ms_smartcard_login = 648;

  SN_ms_upn = AnsiString('msUPN');
  LN_ms_upn = AnsiString('Microsoft User Principal Name');
  NID_ms_upn = 649;

  SN_idea_cbc = AnsiString('IDEA-CBC');
  LN_idea_cbc = AnsiString('idea-cbc');
  NID_idea_cbc = 34;

  SN_idea_ecb = AnsiString('IDEA-ECB');
  LN_idea_ecb = AnsiString('idea-ecb');
  NID_idea_ecb = 36;

  SN_idea_cfb64 = AnsiString('IDEA-CFB');
  LN_idea_cfb64 = AnsiString('idea-cfb');
  NID_idea_cfb64 = 35;

  SN_idea_ofb64 = AnsiString('IDEA-OFB');
  LN_idea_ofb64 = AnsiString('idea-ofb');
  NID_idea_ofb64 = 46;

  SN_bf_cbc = AnsiString('BF-CBC');
  LN_bf_cbc = AnsiString('bf-cbc');
  NID_bf_cbc = 91;

  SN_bf_ecb = AnsiString('BF-ECB');
  LN_bf_ecb = AnsiString('bf-ecb');
  NID_bf_ecb = 92;

  SN_bf_cfb64 = AnsiString('BF-CFB');
  LN_bf_cfb64 = AnsiString('bf-cfb');
  NID_bf_cfb64 = 93;

  SN_bf_ofb64 = AnsiString('BF-OFB');
  LN_bf_ofb64 = AnsiString('bf-ofb');
  NID_bf_ofb64 = 94;

  SN_id_pkix = AnsiString('PKIX');
  NID_id_pkix = 127;

  SN_id_pkix_mod = AnsiString('id-pkix-mod');
  NID_id_pkix_mod = 258;

  SN_id_pe = AnsiString('id-pe');
  NID_id_pe = 175;

  SN_id_qt = AnsiString('id-qt');
  NID_id_qt = 259;

  SN_id_kp = AnsiString('id-kp');
  NID_id_kp = 128;

  SN_id_it = AnsiString('id-it');
  NID_id_it = 260;

  SN_id_pkip = AnsiString('id-pkip');
  NID_id_pkip = 261;

  SN_id_alg = AnsiString('id-alg');
  NID_id_alg = 262;

  SN_id_cmc = AnsiString('id-cmc');
  NID_id_cmc = 263;

  SN_id_on = AnsiString('id-on');
  NID_id_on = 264;

  SN_id_pda = AnsiString('id-pda');
  NID_id_pda = 265;

  SN_id_aca = AnsiString('id-aca');
  NID_id_aca = 266;

  SN_id_qcs = AnsiString('id-qcs');
  NID_id_qcs = 267;

  SN_id_cct = AnsiString('id-cct');
  NID_id_cct = 268;

  SN_id_ppl = AnsiString('id-ppl');
  NID_id_ppl = 662;

  SN_id_ad = AnsiString('id-ad');
  NID_id_ad = 176;

  SN_id_pkix1_explicit_88 = AnsiString('id-pkix1-explicit-88');
  NID_id_pkix1_explicit_88 = 269;

  SN_id_pkix1_implicit_88 = AnsiString('id-pkix1-implicit-88');
  NID_id_pkix1_implicit_88 = 270;

  SN_id_pkix1_explicit_93 = AnsiString('id-pkix1-explicit-93');
  NID_id_pkix1_explicit_93 = 271;

  SN_id_pkix1_implicit_93 = AnsiString('id-pkix1-implicit-93');
  NID_id_pkix1_implicit_93 = 272;

  SN_id_mod_crmf = AnsiString('id-mod-crmf');
  NID_id_mod_crmf = 273;

  SN_id_mod_cmc = AnsiString('id-mod-cmc');
  NID_id_mod_cmc = 274;

  SN_id_mod_kea_profile_88 = AnsiString('id-mod-kea-profile-88');
  NID_id_mod_kea_profile_88 = 275;

  SN_id_mod_kea_profile_93 = AnsiString('id-mod-kea-profile-93');
  NID_id_mod_kea_profile_93 = 276;

  SN_id_mod_cmp = AnsiString('id-mod-cmp');
  NID_id_mod_cmp = 277;

  SN_id_mod_qualified_cert_88 = AnsiString('id-mod-qualified-cert-88');
  NID_id_mod_qualified_cert_88 = 278;

  SN_id_mod_qualified_cert_93 = AnsiString('id-mod-qualified-cert-93');
  NID_id_mod_qualified_cert_93 = 279;

  SN_id_mod_attribute_cert = AnsiString('id-mod-attribute-cert');
  NID_id_mod_attribute_cert = 280;

  SN_id_mod_timestamp_protocol = AnsiString('id-mod-timestamp-protocol');
  NID_id_mod_timestamp_protocol = 281;

  SN_id_mod_ocsp = AnsiString('id-mod-ocsp');
  NID_id_mod_ocsp = 282;

  SN_id_mod_dvcs = AnsiString('id-mod-dvcs');
  NID_id_mod_dvcs = 283;

  SN_id_mod_cmp2000 = AnsiString('id-mod-cmp2000');
  NID_id_mod_cmp2000 = 284;

  SN_info_access = AnsiString('authorityInfoAccess');
  LN_info_access = AnsiString('Authority Information Access');
  NID_info_access = 177;

  SN_biometricInfo = AnsiString('biometricInfo');
  LN_biometricInfo = AnsiString('Biometric Info');
  NID_biometricInfo = 285;

  SN_qcStatements = AnsiString('qcStatements');
  NID_qcStatements = 286;

  SN_ac_auditEntity = AnsiString('ac-auditEntity');
  NID_ac_auditEntity = 287;

  SN_ac_targeting = AnsiString('ac-targeting');
  NID_ac_targeting = 288;

  SN_aaControls = AnsiString('aaControls');
  NID_aaControls = 289;

  SN_sbgp_ipAddrBlock = AnsiString('sbgp-ipAddrBlock');
  NID_sbgp_ipAddrBlock = 290;

  SN_sbgp_autonomousSysNum = AnsiString('sbgp-autonomousSysNum');
  NID_sbgp_autonomousSysNum = 291;

  SN_sbgp_routerIdentifier = AnsiString('sbgp-routerIdentifier');
  NID_sbgp_routerIdentifier = 292;

  SN_ac_proxying = AnsiString('ac-proxying');
  NID_ac_proxying = 397;

  SN_sinfo_access = AnsiString('subjectInfoAccess');
  LN_sinfo_access = AnsiString('Subject Information Access');
  NID_sinfo_access = 398;

  SN_proxyCertInfo = AnsiString('proxyCertInfo');
  LN_proxyCertInfo = AnsiString('Proxy Certificate Information');
  NID_proxyCertInfo = 663;

  SN_tlsfeature = AnsiString('tlsfeature');
  LN_tlsfeature = AnsiString('TLS Feature');
  NID_tlsfeature = 1020;

  SN_id_qt_cps = AnsiString('id-qt-cps');
  LN_id_qt_cps = AnsiString('Policy Qualifier CPS');
  NID_id_qt_cps = 164;

  SN_id_qt_unotice = AnsiString('id-qt-unotice');
  LN_id_qt_unotice = AnsiString('Policy Qualifier User Notice');
  NID_id_qt_unotice = 165;

  SN_textNotice = AnsiString('textNotice');
  NID_textNotice = 293;

  SN_server_auth = AnsiString('serverAuth');
  LN_server_auth = AnsiString('TLS Web Server Authentication');
  NID_server_auth = 129;

  SN_client_auth = AnsiString('clientAuth');
  LN_client_auth = AnsiString('TLS Web Client Authentication');
  NID_client_auth = 130;

  SN_code_sign = AnsiString('codeSigning');
  LN_code_sign = AnsiString('Code Signing');
  NID_code_sign = 131;

  SN_email_protect = AnsiString('emailProtection');
  LN_email_protect = AnsiString('E-mail Protection');
  NID_email_protect = 132;

  SN_ipsecEndSystem = AnsiString('ipsecEndSystem');
  LN_ipsecEndSystem = AnsiString('IPSec End System');
  NID_ipsecEndSystem = 294;

  SN_ipsecTunnel = AnsiString('ipsecTunnel');
  LN_ipsecTunnel = AnsiString('IPSec Tunnel');
  NID_ipsecTunnel = 295;

  SN_ipsecUser = AnsiString('ipsecUser');
  LN_ipsecUser = AnsiString('IPSec User');
  NID_ipsecUser = 296;

  SN_time_stamp = AnsiString('timeStamping');
  LN_time_stamp = AnsiString('Time Stamping');
  NID_time_stamp = 133;

  SN_OCSP_sign = AnsiString('OCSPSigning');
  LN_OCSP_sign = AnsiString('OCSP Signing');
  NID_OCSP_sign = 180;

  SN_dvcs = AnsiString('DVCS');
  LN_dvcs = AnsiString('dvcs');
  NID_dvcs = 297;

  SN_ipsec_IKE = AnsiString('ipsecIKE');
  LN_ipsec_IKE = AnsiString('ipsec Internet Key Exchange');
  NID_ipsec_IKE = 1022;

  SN_capwapAC = AnsiString('capwapAC');
  LN_capwapAC = AnsiString('Ctrl/provision WAP Access');
  NID_capwapAC = 1023;

  SN_capwapWTP = AnsiString('capwapWTP');
  LN_capwapWTP = AnsiString('Ctrl/Provision WAP Termination');
  NID_capwapWTP = 1024;

  SN_sshClient = AnsiString('secureShellClient');
  LN_sshClient = AnsiString('SSH Client');
  NID_sshClient = 1025;

  SN_sshServer = AnsiString('secureShellServer');
  LN_sshServer = AnsiString('SSH Server');
  NID_sshServer = 1026;

  SN_sendRouter = AnsiString('sendRouter');
  LN_sendRouter = AnsiString('Send Router');
  NID_sendRouter = 1027;

  SN_sendProxiedRouter = AnsiString('sendProxiedRouter');
  LN_sendProxiedRouter = AnsiString('Send Proxied Router');
  NID_sendProxiedRouter = 1028;

  SN_sendOwner = AnsiString('sendOwner');
  LN_sendOwner = AnsiString('Send Owner');
  NID_sendOwner = 1029;

  SN_sendProxiedOwner = AnsiString('sendProxiedOwner');
  LN_sendProxiedOwner = AnsiString('Send Proxied Owner');
  NID_sendProxiedOwner = 1030;

  SN_cmcCA = AnsiString('cmcCA');
  LN_cmcCA = AnsiString('CMC Certificate Authority');
  NID_cmcCA = 1131;

  SN_cmcRA = AnsiString('cmcRA');
  LN_cmcRA = AnsiString('CMC Registration Authority');
  NID_cmcRA = 1132;

  SN_id_it_caProtEncCert = AnsiString('id-it-caProtEncCert');
  NID_id_it_caProtEncCert = 298;

  SN_id_it_signKeyPairTypes = AnsiString('id-it-signKeyPairTypes');
  NID_id_it_signKeyPairTypes = 299;

  SN_id_it_encKeyPairTypes = AnsiString('id-it-encKeyPairTypes');
  NID_id_it_encKeyPairTypes = 300;

  SN_id_it_preferredSymmAlg = AnsiString('id-it-preferredSymmAlg');
  NID_id_it_preferredSymmAlg = 301;

  SN_id_it_caKeyUpdateInfo = AnsiString('id-it-caKeyUpdateInfo');
  NID_id_it_caKeyUpdateInfo = 302;

  SN_id_it_currentCRL = AnsiString('id-it-currentCRL');
  NID_id_it_currentCRL = 303;

  SN_id_it_unsupportedOIDs = AnsiString('id-it-unsupportedOIDs');
  NID_id_it_unsupportedOIDs = 304;

  SN_id_it_subscriptionRequest = AnsiString('id-it-subscriptionRequest');
  NID_id_it_subscriptionRequest = 305;

  SN_id_it_subscriptionResponse = AnsiString('id-it-subscriptionResponse');
  NID_id_it_subscriptionResponse = 306;

  SN_id_it_keyPairParamReq = AnsiString('id-it-keyPairParamReq');
  NID_id_it_keyPairParamReq = 307;

  SN_id_it_keyPairParamRep = AnsiString('id-it-keyPairParamRep');
  NID_id_it_keyPairParamRep = 308;

  SN_id_it_revPassphrase = AnsiString('id-it-revPassphrase');
  NID_id_it_revPassphrase = 309;

  SN_id_it_implicitConfirm = AnsiString('id-it-implicitConfirm');
  NID_id_it_implicitConfirm = 310;

  SN_id_it_confirmWaitTime = AnsiString('id-it-confirmWaitTime');
  NID_id_it_confirmWaitTime = 311;

  SN_id_it_origPKIMessage = AnsiString('id-it-origPKIMessage');
  NID_id_it_origPKIMessage = 312;

  SN_id_it_suppLangTags = AnsiString('id-it-suppLangTags');
  NID_id_it_suppLangTags = 784;

  SN_id_regCtrl = AnsiString('id-regCtrl');
  NID_id_regCtrl = 313;

  SN_id_regInfo = AnsiString('id-regInfo');
  NID_id_regInfo = 314;

  SN_id_regCtrl_regToken = AnsiString('id-regCtrl-regToken');
  NID_id_regCtrl_regToken = 315;

  SN_id_regCtrl_authenticator = AnsiString('id-regCtrl-authenticator');
  NID_id_regCtrl_authenticator = 316;

  SN_id_regCtrl_pkiPublicationInfo = AnsiString('id-regCtrl-pkiPublicationInfo');
  NID_id_regCtrl_pkiPublicationInfo = 317;

  SN_id_regCtrl_pkiArchiveOptions = AnsiString('id-regCtrl-pkiArchiveOptions');
  NID_id_regCtrl_pkiArchiveOptions = 318;

  SN_id_regCtrl_oldCertID = AnsiString('id-regCtrl-oldCertID');
  NID_id_regCtrl_oldCertID = 319;

  SN_id_regCtrl_protocolEncrKey = AnsiString('id-regCtrl-protocolEncrKey');
  NID_id_regCtrl_protocolEncrKey = 320;

  SN_id_regInfo_utf8Pairs = AnsiString('id-regInfo-utf8Pairs');
  NID_id_regInfo_utf8Pairs = 321;

  SN_id_regInfo_certReq = AnsiString('id-regInfo-certReq');
  NID_id_regInfo_certReq = 322;

  SN_id_alg_des40 = AnsiString('id-alg-des40');
  NID_id_alg_des40 = 323;

  SN_id_alg_noSignature = AnsiString('id-alg-noSignature');
  NID_id_alg_noSignature = 324;

  SN_id_alg_dh_sig_hmac_sha1 = AnsiString('id-alg-dh-sig-hmac-sha1');
  NID_id_alg_dh_sig_hmac_sha1 = 325;

  SN_id_alg_dh_pop = AnsiString('id-alg-dh-pop');
  NID_id_alg_dh_pop = 326;

  SN_id_cmc_statusInfo = AnsiString('id-cmc-statusInfo');
  NID_id_cmc_statusInfo = 327;

  SN_id_cmc_identification = AnsiString('id-cmc-identification');
  NID_id_cmc_identification = 328;

  SN_id_cmc_identityProof = AnsiString('id-cmc-identityProof');
  NID_id_cmc_identityProof = 329;

  SN_id_cmc_dataReturn = AnsiString('id-cmc-dataReturn');
  NID_id_cmc_dataReturn = 330;

  SN_id_cmc_transactionId = AnsiString('id-cmc-transactionId');
  NID_id_cmc_transactionId = 331;

  SN_id_cmc_senderNonce = AnsiString('id-cmc-senderNonce');
  NID_id_cmc_senderNonce = 332;

  SN_id_cmc_recipientNonce = AnsiString('id-cmc-recipientNonce');
  NID_id_cmc_recipientNonce = 333;

  SN_id_cmc_addExtensions = AnsiString('id-cmc-addExtensions');
  NID_id_cmc_addExtensions = 334;

  SN_id_cmc_encryptedPOP = AnsiString('id-cmc-encryptedPOP');
  NID_id_cmc_encryptedPOP = 335;

  SN_id_cmc_decryptedPOP = AnsiString('id-cmc-decryptedPOP');
  NID_id_cmc_decryptedPOP = 336;

  SN_id_cmc_lraPOPWitness = AnsiString('id-cmc-lraPOPWitness');
  NID_id_cmc_lraPOPWitness = 337;

  SN_id_cmc_getCert = AnsiString('id-cmc-getCert');
  NID_id_cmc_getCert = 338;

  SN_id_cmc_getCRL = AnsiString('id-cmc-getCRL');
  NID_id_cmc_getCRL = 339;

  SN_id_cmc_revokeRequest = AnsiString('id-cmc-revokeRequest');
  NID_id_cmc_revokeRequest = 340;

  SN_id_cmc_regInfo = AnsiString('id-cmc-regInfo');
  NID_id_cmc_regInfo = 341;

  SN_id_cmc_responseInfo = AnsiString('id-cmc-responseInfo');
  NID_id_cmc_responseInfo = 342;

  SN_id_cmc_queryPending = AnsiString('id-cmc-queryPending');
  NID_id_cmc_queryPending = 343;

  SN_id_cmc_popLinkRandom = AnsiString('id-cmc-popLinkRandom');
  NID_id_cmc_popLinkRandom = 344;

  SN_id_cmc_popLinkWitness = AnsiString('id-cmc-popLinkWitness');
  NID_id_cmc_popLinkWitness = 345;

  SN_id_cmc_confirmCertAcceptance = AnsiString('id-cmc-confirmCertAcceptance');
  NID_id_cmc_confirmCertAcceptance = 346;

  SN_id_on_personalData = AnsiString('id-on-personalData');
  NID_id_on_personalData = 347;

  SN_id_on_permanentIdentifier = AnsiString('id-on-permanentIdentifier');
  LN_id_on_permanentIdentifier = AnsiString('Permanent Identifier');
  NID_id_on_permanentIdentifier = 858;

  SN_id_pda_dateOfBirth = AnsiString('id-pda-dateOfBirth');
  NID_id_pda_dateOfBirth = 348;

  SN_id_pda_placeOfBirth = AnsiString('id-pda-placeOfBirth');
  NID_id_pda_placeOfBirth = 349;

  SN_id_pda_gender = AnsiString('id-pda-gender');
  NID_id_pda_gender = 351;

  SN_id_pda_countryOfCitizenship = AnsiString('id-pda-countryOfCitizenship');
  NID_id_pda_countryOfCitizenship = 352;

  SN_id_pda_countryOfResidence = AnsiString('id-pda-countryOfResidence');
  NID_id_pda_countryOfResidence = 353;

  SN_id_aca_authenticationInfo = AnsiString('id-aca-authenticationInfo');
  NID_id_aca_authenticationInfo = 354;

  SN_id_aca_accessIdentity = AnsiString('id-aca-accessIdentity');
  NID_id_aca_accessIdentity = 355;

  SN_id_aca_chargingIdentity = AnsiString('id-aca-chargingIdentity');
  NID_id_aca_chargingIdentity = 356;

  SN_id_aca_group = AnsiString('id-aca-group');
  NID_id_aca_group = 357;

  SN_id_aca_role = AnsiString('id-aca-role');
  NID_id_aca_role = 358;

  SN_id_aca_encAttrs = AnsiString('id-aca-encAttrs');
  NID_id_aca_encAttrs = 399;

  SN_id_qcs_pkixQCSyntax_v1 = AnsiString('id-qcs-pkixQCSyntax-v1');
  NID_id_qcs_pkixQCSyntax_v1 = 359;

  SN_id_cct_crs = AnsiString('id-cct-crs');
  NID_id_cct_crs = 360;

  SN_id_cct_PKIData = AnsiString('id-cct-PKIData');
  NID_id_cct_PKIData = 361;

  SN_id_cct_PKIResponse = AnsiString('id-cct-PKIResponse');
  NID_id_cct_PKIResponse = 362;

  SN_id_ppl_anyLanguage = AnsiString('id-ppl-anyLanguage');
  LN_id_ppl_anyLanguage = AnsiString('Any language');

  NID_id_ppl_anyLanguage = 664;
  SN_id_ppl_inheritAll = AnsiString('id-ppl-inheritAll');

  LN_id_ppl_inheritAll = AnsiString('Inherit all');
  NID_id_ppl_inheritAll = 665;

  SN_Independent = AnsiString('id-ppl-independent');
  LN_Independent = AnsiString('Independent');
  NID_Independent = 667;

  SN_ad_OCSP = AnsiString('OCSP');
  LN_ad_OCSP = AnsiString('OCSP');
  NID_ad_OCSP = 178;

  SN_ad_ca_issuers = AnsiString('caIssuers');
  LN_ad_ca_issuers = AnsiString('CA Issuers');
  NID_ad_ca_issuers = 179;

  SN_ad_timeStamping = AnsiString('ad_timestamping');
  LN_ad_timeStamping = AnsiString('AD Time Stamping');
  NID_ad_timeStamping = 363;

  SN_ad_dvcs = AnsiString('AD_DVCS');
  LN_ad_dvcs = AnsiString('ad dvcs');
  NID_ad_dvcs = 364;

  SN_caRepository = AnsiString('caRepository');
  LN_caRepository = AnsiString('CA Repository');
  NID_caRepository = 785;

  SN_id_pkix_OCSP_basic = AnsiString('basicOCSPResponse');
  LN_id_pkix_OCSP_basic = AnsiString('Basic OCSP Response');
  NID_id_pkix_OCSP_basic = 365;

  SN_id_pkix_OCSP_Nonce = AnsiString('Nonce');
  LN_id_pkix_OCSP_Nonce = AnsiString('OCSP Nonce');
  NID_id_pkix_OCSP_Nonce = 366;

  SN_id_pkix_OCSP_CrlID = AnsiString('CrlID');
  LN_id_pkix_OCSP_CrlID = AnsiString('OCSP CRL ID');
  NID_id_pkix_OCSP_CrlID = 367;

  SN_id_pkix_OCSP_acceptableResponses = AnsiString('acceptableResponses');
  LN_id_pkix_OCSP_acceptableResponses = AnsiString('Acceptable OCSP Responses');
  NID_id_pkix_OCSP_acceptableResponses = 368;

  SN_id_pkix_OCSP_noCheck = AnsiString('noCheck');
  LN_id_pkix_OCSP_noCheck = AnsiString('OCSP No Check');
  NID_id_pkix_OCSP_noCheck = 369;

  SN_id_pkix_OCSP_archiveCutoff = AnsiString('archiveCutoff');
  LN_id_pkix_OCSP_archiveCutoff = AnsiString('OCSP Archive Cutoff');
  NID_id_pkix_OCSP_archiveCutoff = 370;

  SN_id_pkix_OCSP_serviceLocator = AnsiString('serviceLocator');
  LN_id_pkix_OCSP_serviceLocator = AnsiString('OCSP Service Locator');
  NID_id_pkix_OCSP_serviceLocator = 371;

  SN_id_pkix_OCSP_extendedStatus = AnsiString('extendedStatus');
  LN_id_pkix_OCSP_extendedStatus = AnsiString('Extended OCSP Status');
  NID_id_pkix_OCSP_extendedStatus = 372;

  SN_id_pkix_OCSP_valid = AnsiString('valid');
  NID_id_pkix_OCSP_valid = 373;

  SN_id_pkix_OCSP_path = AnsiString('path');
  NID_id_pkix_OCSP_path = 374;

  SN_id_pkix_OCSP_trustRoot = AnsiString('trustRoot');
  LN_id_pkix_OCSP_trustRoot = AnsiString('Trust Root');
  NID_id_pkix_OCSP_trustRoot = 375;

  SN_algorithm = AnsiString('algorithm');
  LN_algorithm = AnsiString('algorithm');
  NID_algorithm = 376;

  SN_md5WithRSA = AnsiString('RSA-NP-MD5');
  LN_md5WithRSA = AnsiString('md5WithRSA');
  NID_md5WithRSA = 104;

  SN_des_ecb = AnsiString('DES-ECB');
  LN_des_ecb = AnsiString('des-ecb');
  NID_des_ecb = 29;

  SN_des_cbc = AnsiString('DES-CBC');
  LN_des_cbc = AnsiString('des-cbc');
  NID_des_cbc = 31;

  SN_des_ofb64 = AnsiString('DES-OFB');
  LN_des_ofb64 = AnsiString('des-ofb');
  NID_des_ofb64 = 45;

  SN_des_cfb64 = AnsiString('DES-CFB');
  LN_des_cfb64 = AnsiString('des-cfb');
  NID_des_cfb64 = 30;

  SN_rsaSignature = AnsiString('rsaSignature');
  NID_rsaSignature = 377;

  SN_dsa_2 = AnsiString('DSA-old');
  LN_dsa_2 = AnsiString('dsaEncryption-old');
  NID_dsa_2 = 67;

  SN_dsaWithSHA = AnsiString('DSA-SHA');
  LN_dsaWithSHA = AnsiString('dsaWithSHA');
  NID_dsaWithSHA = 66;

  SN_shaWithRSAEncryption = AnsiString('RSA-SHA');
  LN_shaWithRSAEncryption = AnsiString('shaWithRSAEncryption');
  NID_shaWithRSAEncryption = 42;

  SN_des_ede_ecb = AnsiString('DES-EDE');
  LN_des_ede_ecb = AnsiString('des-ede');
  NID_des_ede_ecb = 32;

  SN_des_ede3_ecb = AnsiString('DES-EDE3');
  LN_des_ede3_ecb = AnsiString('des-ede3');
  NID_des_ede3_ecb = 33;

  SN_des_ede_cbc = AnsiString('DES-EDE-CBC');
  LN_des_ede_cbc = AnsiString('des-ede-cbc');
  NID_des_ede_cbc = 43;

  SN_des_ede_cfb64 = AnsiString('DES-EDE-CFB');
  LN_des_ede_cfb64 = AnsiString('des-ede-cfb');
  NID_des_ede_cfb64 = 60;

  SN_des_ede3_cfb64 = AnsiString('DES-EDE3-CFB');
  LN_des_ede3_cfb64 = AnsiString('des-ede3-cfb');
  NID_des_ede3_cfb64 = 61;

  SN_des_ede_ofb64 = AnsiString('DES-EDE-OFB');
  LN_des_ede_ofb64 = AnsiString('des-ede-ofb');
  NID_des_ede_ofb64 = 62;

  SN_des_ede3_ofb64 = AnsiString('DES-EDE3-OFB');
  LN_des_ede3_ofb64 = AnsiString('des-ede3-ofb');
  NID_des_ede3_ofb64 = 63;

  SN_desx_cbc = AnsiString('DESX-CBC');
  LN_desx_cbc = AnsiString('desx-cbc');
  NID_desx_cbc = 80;

  SN_sha = AnsiString('SHA');
  LN_sha = AnsiString('sha');
  NID_sha = 41;

  SN_sha1 = AnsiString('SHA1');
  LN_sha1 = AnsiString('sha1');
  NID_sha1 = 64;

  SN_dsaWithSHA1_2 = AnsiString('DSA-SHA1-old');
  LN_dsaWithSHA1_2 = AnsiString('dsaWithSHA1-old');
  NID_dsaWithSHA1_2 = 70;

  SN_sha1WithRSA = AnsiString('RSA-SHA1-2');
  LN_sha1WithRSA = AnsiString('sha1WithRSA');
  NID_sha1WithRSA = 115;

  SN_ripemd160 = AnsiString('RIPEMD160');
  LN_ripemd160 = AnsiString('ripemd160');
  NID_ripemd160 = 117;

  SN_ripemd160WithRSA = AnsiString('RSA-RIPEMD160');
  LN_ripemd160WithRSA = AnsiString('ripemd160WithRSA');
  NID_ripemd160WithRSA = 119;

  SN_blake2b512 = AnsiString('BLAKE2b512');
  LN_blake2b512 = AnsiString('blake2b512');
  NID_blake2b512 = 1056;

  SN_blake2s256 = AnsiString('BLAKE2s256');
  LN_blake2s256 = AnsiString('blake2s256');
  NID_blake2s256 = 1057;

  SN_sxnet = AnsiString('SXNetID');
  LN_sxnet = AnsiString('Strong Extranet ID');
  NID_sxnet = 143;

  SN_X500 = AnsiString('X500');
  LN_X500 = AnsiString('directory services(X.500)');
  NID_X500 = 11;

  SN_X509 = AnsiString('X509');
  NID_X509 = 12;

  SN_commonName = AnsiString('CN');
  LN_commonName = AnsiString('commonName');
  NID_commonName = 13;

  SN_surname = AnsiString('SN');
  LN_surname = AnsiString('surname');
  NID_surname = 100;

  LN_serialNumber = AnsiString('serialNumber');
  NID_serialNumber = 105;

  SN_countryName = AnsiString('C');
  LN_countryName = AnsiString('countryName');
  NID_countryName = 14;

  SN_localityName = AnsiString('L');
  LN_localityName = AnsiString('localityName');
  NID_localityName = 15;

  SN_stateOrProvinceName = AnsiString('ST');
  LN_stateOrProvinceName = AnsiString('stateOrProvinceName');
  NID_stateOrProvinceName = 16;

  SN_streetAddress = AnsiString('street');
  LN_streetAddress = AnsiString('streetAddress');
  NID_streetAddress = 660;

  SN_organizationName = AnsiString('O');
  LN_organizationName = AnsiString('organizationName');
  NID_organizationName = 17;

  SN_organizationalUnitName = AnsiString('OU');
  LN_organizationalUnitName = AnsiString('organizationalUnitName');
  NID_organizationalUnitName = 18;

  SN_title = AnsiString('title');
  LN_title = AnsiString('title');
  NID_title = 106;

  LN_description = AnsiString('description');
  NID_description = 107;

  LN_searchGuide = AnsiString('searchGuide');
  NID_searchGuide = 859;
  LN_businessCategory = AnsiString('businessCategory');
  NID_businessCategory = 860;

  LN_postalAddress = AnsiString('postalAddress');
  NID_postalAddress = 861;

  LN_postalCode = AnsiString('postalCode');
  NID_postalCode = 661;

  LN_postOfficeBox = AnsiString('postOfficeBox');
  NID_postOfficeBox = 862;

  LN_physicalDeliveryOfficeName = AnsiString('physicalDeliveryOfficeName');
  NID_physicalDeliveryOfficeName = 863;

  LN_telephoneNumber = AnsiString('telephoneNumber');
  NID_telephoneNumber = 864;

  LN_telexNumber = AnsiString('telexNumber');
  NID_telexNumber = 865;

  LN_teletexTerminalIdentifier = AnsiString('teletexTerminalIdentifier');
  NID_teletexTerminalIdentifier = 866;

  LN_facsimileTelephoneNumber = AnsiString('facsimileTelephoneNumber');
  NID_facsimileTelephoneNumber = 867;

  LN_x121Address = AnsiString('x121Address');
  NID_x121Address = 868;

  LN_internationaliSDNNumber = AnsiString('internationaliSDNNumber');
  NID_internationaliSDNNumber = 869;

  LN_registeredAddress = AnsiString('registeredAddress');
  NID_registeredAddress = 870;

  LN_destinationIndicator = AnsiString('destinationIndicator');
  NID_destinationIndicator = 871;

  LN_preferredDeliveryMethod = AnsiString('preferredDeliveryMethod');
  NID_preferredDeliveryMethod = 872;

  LN_presentationAddress = AnsiString('presentationAddress');
  NID_presentationAddress = 873;

  LN_supportedApplicationContext = AnsiString('supportedApplicationContext');
  NID_supportedApplicationContext = 874;

  SN_member = AnsiString('member');
  NID_member = 875;

  SN_owner = AnsiString('owner');
  NID_owner = 876;

  LN_roleOccupant = AnsiString('roleOccupant');
  NID_roleOccupant = 877;

  SN_seeAlso = AnsiString('seeAlso');
  NID_seeAlso = 878;

  LN_userPassword = AnsiString('userPassword');
  NID_userPassword = 879;

  LN_userCertificate = AnsiString('userCertificate');
  NID_userCertificate = 880;

  LN_cACertificate = AnsiString('cACertificate');
  NID_cACertificate = 881;

  LN_authorityRevocationList = AnsiString('authorityRevocationList');
  NID_authorityRevocationList = 882;

  LN_certificateRevocationList = AnsiString('certificateRevocationList');
  NID_certificateRevocationList = 883;

  LN_crossCertificatePair = AnsiString('crossCertificatePair');
  NID_crossCertificatePair = 884;

  SN_name = AnsiString('name');
  LN_name = AnsiString('name');
  NID_name = 173;

  SN_givenName = AnsiString('GN');
  LN_givenName = AnsiString('givenName');
  NID_givenName = 99;

  SN_initials = AnsiString('initials');
  LN_initials = AnsiString('initials');
  NID_initials = 101;

  LN_generationQualifier = AnsiString('generationQualifier');
  NID_generationQualifier = 509;

  LN_x500UniqueIdentifier = AnsiString('x500UniqueIdentifier');
  NID_x500UniqueIdentifier = 503;

  SN_dnQualifier = AnsiString('dnQualifier');
  LN_dnQualifier = AnsiString('dnQualifier');
  NID_dnQualifier = 174;

  LN_enhancedSearchGuide = AnsiString('enhancedSearchGuide');
  NID_enhancedSearchGuide = 885;

  LN_protocolInformation = AnsiString('protocolInformation');
  NID_protocolInformation = 886;

  LN_distinguishedName = AnsiString('distinguishedName');
  NID_distinguishedName = 887;

  LN_uniqueMember = AnsiString('uniqueMember');
  NID_uniqueMember = 888;

  LN_houseIdentifier = AnsiString('houseIdentifier');
  NID_houseIdentifier = 889;

  LN_supportedAlgorithms = AnsiString('supportedAlgorithms');
  NID_supportedAlgorithms = 890;

  LN_deltaRevocationList = AnsiString('deltaRevocationList');
  NID_deltaRevocationList = 891;

  SN_dmdName = AnsiString('dmdName');
  NID_dmdName = 892;

  LN_pseudonym = AnsiString('pseudonym');
  NID_pseudonym = 510;

  SN_role = AnsiString('role');
  LN_role = AnsiString('role');
  NID_role = 400;

  LN_organizationIdentifier = AnsiString('organizationIdentifier');
  NID_organizationIdentifier = 1089;

  SN_countryCode3c = AnsiString('c3');
  LN_countryCode3c = AnsiString('countryCode3c');
  NID_countryCode3c = 1090;

  SN_countryCode3n = AnsiString('n3');
  LN_countryCode3n = AnsiString('countryCode3n');
  NID_countryCode3n = 1091;

  LN_dnsName = AnsiString('dnsName');
  NID_dnsName = 1092;

  SN_X500algorithms = AnsiString('X500algorithms');
  LN_X500algorithms = AnsiString('directory services - algorithms');
  NID_X500algorithms = 378;

  SN_rsa = AnsiString('RSA');
  LN_rsa = AnsiString('rsa');
  NID_rsa = 19;

  SN_mdc2WithRSA = AnsiString('RSA-MDC2');
  LN_mdc2WithRSA = AnsiString('mdc2WithRSA');
  NID_mdc2WithRSA = 96;

  SN_mdc2 = AnsiString('MDC2');
  LN_mdc2 = AnsiString('mdc2');
  NID_mdc2 = 95;

  SN_id_ce = AnsiString('id-ce');
  NID_id_ce = 81;

  SN_subject_directory_attributes = AnsiString('subjectDirectoryAttributes');
  LN_subject_directory_attributes = AnsiString('X509v3 Subject Directory Attributes');
  NID_subject_directory_attributes = 769;

  SN_subject_key_identifier = AnsiString('subjectKeyIdentifier');
  LN_subject_key_identifier = AnsiString('X509v3 Subject Key Identifier');
  NID_subject_key_identifier = 82;

  SN_key_usage = AnsiString('keyUsage');
  LN_key_usage = AnsiString('X509v3 Key Usage');
  NID_key_usage = 83;

  SN_private_key_usage_period = AnsiString('privateKeyUsagePeriod');
  LN_private_key_usage_period = AnsiString('X509v3 Private Key Usage Period');
  NID_private_key_usage_period = 84;

  SN_subject_alt_name = AnsiString('subjectAltName');
  LN_subject_alt_name = AnsiString('X509v3 Subject Alternative Name');
  NID_subject_alt_name = 85;

  SN_issuer_alt_name = AnsiString('issuerAltName');
  LN_issuer_alt_name = AnsiString('X509v3 Issuer Alternative Name');
  NID_issuer_alt_name = 86;

  SN_basic_constraints = AnsiString('basicConstraints');
  LN_basic_constraints = AnsiString('X509v3 Basic Constraints');
  NID_basic_constraints = 87;

  SN_crl_number = AnsiString('crlNumber');
  LN_crl_number = AnsiString('X509v3 CRL Number');
  NID_crl_number = 88;

  SN_crl_reason = AnsiString('CRLReason');
  LN_crl_reason = AnsiString('X509v3 CRL Reason Code');
  NID_crl_reason = 141;

  SN_invalidity_date = AnsiString('invalidityDate');
  LN_invalidity_date = AnsiString('Invalidity Date');
  NID_invalidity_date = 142;

  SN_delta_crl = AnsiString('deltaCRL');
  LN_delta_crl = AnsiString('X509v3 Delta CRL Indicator');
  NID_delta_crl = 140;

  SN_issuing_distribution_point = AnsiString('issuingDistributionPoint');
  LN_issuing_distribution_point = AnsiString('X509v3 Issuing Distribution Point');
  NID_issuing_distribution_point = 770;

  SN_certificate_issuer = AnsiString('certificateIssuer');
  LN_certificate_issuer = AnsiString('X509v3 Certificate Issuer');
  NID_certificate_issuer = 771;

  SN_name_constraints = AnsiString('nameConstraints');
  LN_name_constraints = AnsiString('X509v3 Name Constraints');
  NID_name_constraints = 666;

  SN_crl_distribution_points = AnsiString('crlDistributionPoints');
  LN_crl_distribution_points = AnsiString('X509v3 CRL Distribution Points');
  NID_crl_distribution_points = 103;

  SN_certificate_policies = AnsiString('certificatePolicies');
  LN_certificate_policies = AnsiString('X509v3 Certificate Policies');
  NID_certificate_policies = 89;

  SN_any_policy = AnsiString('anyPolicy');
  LN_any_policy = AnsiString('X509v3 Any Policy');
  NID_any_policy = 746;

  SN_policy_mappings = AnsiString('policyMappings');
  LN_policy_mappings = AnsiString('X509v3 Policy Mappings');
  NID_policy_mappings = 747;

  SN_authority_key_identifier = AnsiString('authorityKeyIdentifier');
  LN_authority_key_identifier = AnsiString('X509v3 Authority Key Identifier');
  NID_authority_key_identifier = 90;

  SN_policy_constraints = AnsiString('policyConstraints');
  LN_policy_constraints = AnsiString('X509v3 Policy Constraints');
  NID_policy_constraints = 401;

  SN_ext_key_usage = AnsiString('extendedKeyUsage');
  LN_ext_key_usage = AnsiString('X509v3 Extended Key Usage');
  NID_ext_key_usage = 126;

  SN_freshest_crl = AnsiString('freshestCRL');
  LN_freshest_crl = AnsiString('X509v3 Freshest CRL');
  NID_freshest_crl = 857;

  SN_inhibit_any_policy = AnsiString('inhibitAnyPolicy');
  LN_inhibit_any_policy = AnsiString('X509v3 Inhibit Any Policy');
  NID_inhibit_any_policy = 748;

  SN_target_information = AnsiString('targetInformation');
  LN_target_information = AnsiString('X509v3 AC Targeting');
  NID_target_information = 402;

  SN_no_rev_avail = AnsiString('noRevAvail');
  LN_no_rev_avail = AnsiString('X509v3 No Revocation Available');
  NID_no_rev_avail = 403;

  SN_anyExtendedKeyUsage = AnsiString('anyExtendedKeyUsage');
  LN_anyExtendedKeyUsage = AnsiString('Any Extended Key Usage');
  NID_anyExtendedKeyUsage = 910;

  SN_netscape = AnsiString('Netscape');
  LN_netscape = AnsiString('Netscape Communications Corp.');
  NID_netscape = 57;

  SN_netscape_cert_extension = AnsiString('nsCertExt');
  LN_netscape_cert_extension = AnsiString('Netscape Certificate Extension');
  NID_netscape_cert_extension = 58;

  SN_netscape_data_type = AnsiString('nsDataType');
  LN_netscape_data_type = AnsiString('Netscape Data Type');
  NID_netscape_data_type = 59;

  SN_netscape_cert_type = AnsiString('nsCertType');
  LN_netscape_cert_type = AnsiString('Netscape Cert Type');
  NID_netscape_cert_type = 71;

  SN_netscape_base_url = AnsiString('nsBaseUrl');
  LN_netscape_base_url = AnsiString('Netscape Base Url');
  NID_netscape_base_url = 72;

  SN_netscape_revocation_url = AnsiString('nsRevocationUrl');
  LN_netscape_revocation_url = AnsiString('Netscape Revocation Url');
  NID_netscape_revocation_url = 73;

  SN_netscape_ca_revocation_url = AnsiString('nsCaRevocationUrl');
  LN_netscape_ca_revocation_url = AnsiString('Netscape CA Revocation Url');
  NID_netscape_ca_revocation_url = 74;

  SN_netscape_renewal_url = AnsiString('nsRenewalUrl');
  LN_netscape_renewal_url = AnsiString('Netscape Renewal Url');
  NID_netscape_renewal_url = 75;

  SN_netscape_ca_policy_url = AnsiString('nsCaPolicyUrl');
  LN_netscape_ca_policy_url = AnsiString('Netscape CA Policy Url');
  NID_netscape_ca_policy_url = 76;

  SN_netscape_ssl_server_name = AnsiString('nsSslServerName');
  LN_netscape_ssl_server_name = AnsiString('Netscape Server: SSl Name');
  NID_netscape_ssl_server_name = 77;

  SN_netscape_comment = AnsiString('nsComment');
  LN_netscape_comment = AnsiString('Netscape Comment');
  NID_netscape_comment = 78;

  SN_netscape_cert_sequence = AnsiString('nsCertSequence');
  LN_netscape_cert_sequence = AnsiString('Netscape Certificate Sequence');
  NID_netscape_cert_sequence = 79;

  SN_ns_sgc = AnsiString('nsSGC');
  LN_ns_sgc = AnsiString('Netscape Server Gated Crypto');
  NID_ns_sgc = 139;

  SN_org = AnsiString('ORG');
  LN_org = AnsiString('org');
  NID_org = 379;

  SN_dod = AnsiString('DOD');
  LN_dod = AnsiString('dod');
  NID_dod = 380;

  SN_iana = AnsiString('IANA');
  LN_iana = AnsiString('iana');
  NID_iana = 381;

  SN_Directory = AnsiString('directory');
  LN_Directory = AnsiString('Directory');
  NID_Directory = 382;

  SN_Management = AnsiString('mgmt');
  LN_Management = AnsiString('Management');
  NID_Management = 383;

  SN_Experimental = AnsiString('experimental');
  LN_Experimental = AnsiString('Experimental');
  NID_Experimental = 384;

  SN_Private = AnsiString('private');
  LN_Private = AnsiString('Private');
  NID_Private = 385;

  SN_Security = AnsiString('security');
  LN_Security = AnsiString('Security');
  NID_Security = 386;

  SN_SNMPv2 = AnsiString('snmpv2');
  LN_SNMPv2 = AnsiString('SNMPv2');
  NID_SNMPv2 = 387;

  LN_Mail = AnsiString('Mail');
  NID_Mail = 388;

  SN_Enterprises = AnsiString('enterprises');
  LN_Enterprises = AnsiString('Enterprises');
  NID_Enterprises = 389;

  SN_dcObject = AnsiString('dcobject');
  LN_dcObject = AnsiString('dcObject');
  NID_dcObject = 390;

  SN_mime_mhs = AnsiString('mime-mhs');
  LN_mime_mhs = AnsiString('MIME MHS');
  NID_mime_mhs = 504;

  SN_mime_mhs_headings = AnsiString('mime-mhs-headings');
  LN_mime_mhs_headings = AnsiString('mime-mhs-headings');
  NID_mime_mhs_headings = 505;

  SN_mime_mhs_bodies = AnsiString('mime-mhs-bodies');
  LN_mime_mhs_bodies = AnsiString('mime-mhs-bodies');
  NID_mime_mhs_bodies = 506;

  SN_id_hex_partial_message = AnsiString('id-hex-partial-message');
  LN_id_hex_partial_message = AnsiString('id-hex-partial-message');
  NID_id_hex_partial_message = 507;

  SN_id_hex_multipart_message = AnsiString('id-hex-multipart-message');
  LN_id_hex_multipart_message = AnsiString('id-hex-multipart-message');
  NID_id_hex_multipart_message = 508;

  SN_zlib_compression = AnsiString('ZLIB');
  LN_zlib_compression = AnsiString('zlib compression');
  NID_zlib_compression = 125;

  SN_aes_128_ecb = AnsiString('AES-128-ECB');
  LN_aes_128_ecb = AnsiString('aes-128-ecb');
  NID_aes_128_ecb = 418;

  SN_aes_128_cbc = AnsiString('AES-128-CBC');
  LN_aes_128_cbc = AnsiString('aes-128-cbc');
  NID_aes_128_cbc = 419;

  SN_aes_128_ofb128 = AnsiString('AES-128-OFB');
  LN_aes_128_ofb128 = AnsiString('aes-128-ofb');
  NID_aes_128_ofb128 = 420;

  SN_aes_128_cfb128 = AnsiString('AES-128-CFB');
  LN_aes_128_cfb128 = AnsiString('aes-128-cfb');
  NID_aes_128_cfb128 = 421;

  SN_id_aes128_wrap = AnsiString('id-aes128-wrap');
  NID_id_aes128_wrap = 788;

  SN_aes_128_gcm = AnsiString('id-aes128-GCM');
  LN_aes_128_gcm = AnsiString('aes-128-gcm');
  NID_aes_128_gcm = 895;

  SN_aes_128_ccm = AnsiString('id-aes128-CCM');
  LN_aes_128_ccm = AnsiString('aes-128-ccm');
  NID_aes_128_ccm = 896;

  SN_id_aes128_wrap_pad = AnsiString('id-aes128-wrap-pad');
  NID_id_aes128_wrap_pad = 897;

  SN_aes_192_ecb = AnsiString('AES-192-ECB');
  LN_aes_192_ecb = AnsiString('aes-192-ecb');
  NID_aes_192_ecb = 422;

  SN_aes_192_cbc = AnsiString('AES-192-CBC');
  LN_aes_192_cbc = AnsiString('aes-192-cbc');
  NID_aes_192_cbc = 423;

  SN_aes_192_ofb128 = AnsiString('AES-192-OFB');
  LN_aes_192_ofb128 = AnsiString('aes-192-ofb');
  NID_aes_192_ofb128 = 424;

  SN_aes_192_cfb128 = AnsiString('AES-192-CFB');
  LN_aes_192_cfb128 = AnsiString('aes-192-cfb');
  NID_aes_192_cfb128 = 425;

  SN_id_aes192_wrap = AnsiString('id-aes192-wrap');
  NID_id_aes192_wrap = 789;

  SN_aes_192_gcm = AnsiString('id-aes192-GCM');
  LN_aes_192_gcm = AnsiString('aes-192-gcm');
  NID_aes_192_gcm = 898;

  SN_aes_192_ccm = AnsiString('id-aes192-CCM');
  LN_aes_192_ccm = AnsiString('aes-192-ccm');
  NID_aes_192_ccm = 899;

  SN_id_aes192_wrap_pad = AnsiString('id-aes192-wrap-pad');
  NID_id_aes192_wrap_pad = 900;

  SN_aes_256_ecb = AnsiString('AES-256-ECB');
  LN_aes_256_ecb = AnsiString('aes-256-ecb');
  NID_aes_256_ecb = 426;

  SN_aes_256_cbc = AnsiString('AES-256-CBC');
  LN_aes_256_cbc = AnsiString('aes-256-cbc');
  NID_aes_256_cbc = 427;

  SN_aes_256_ofb128 = AnsiString('AES-256-OFB');
  LN_aes_256_ofb128 = AnsiString('aes-256-ofb');
  NID_aes_256_ofb128 = 428;

  SN_aes_256_cfb128 = AnsiString('AES-256-CFB');
  LN_aes_256_cfb128 = AnsiString('aes-256-cfb');
  NID_aes_256_cfb128 = 429;

  SN_id_aes256_wrap = AnsiString('id-aes256-wrap');
  NID_id_aes256_wrap = 790;

  SN_aes_256_gcm = AnsiString('id-aes256-GCM');
  LN_aes_256_gcm = AnsiString('aes-256-gcm');
  NID_aes_256_gcm = 901;

  SN_aes_256_ccm = AnsiString('id-aes256-CCM');
  LN_aes_256_ccm = AnsiString('aes-256-ccm');
  NID_aes_256_ccm = 902;

  SN_id_aes256_wrap_pad = AnsiString('id-aes256-wrap-pad');
  NID_id_aes256_wrap_pad = 903;

  SN_aes_128_xts = AnsiString('AES-128-XTS');
  LN_aes_128_xts = AnsiString('aes-128-xts');
  NID_aes_128_xts = 913;

  SN_aes_256_xts = AnsiString('AES-256-XTS');
  LN_aes_256_xts = AnsiString('aes-256-xts');
  NID_aes_256_xts = 914;

  SN_aes_128_cfb1 = AnsiString('AES-128-CFB1');
  LN_aes_128_cfb1 = AnsiString('aes-128-cfb1');
  NID_aes_128_cfb1 = 650;

  SN_aes_192_cfb1 = AnsiString('AES-192-CFB1');
  LN_aes_192_cfb1 = AnsiString('aes-192-cfb1');
  NID_aes_192_cfb1 = 651;

  SN_aes_256_cfb1 = AnsiString('AES-256-CFB1');
  LN_aes_256_cfb1 = AnsiString('aes-256-cfb1');
  NID_aes_256_cfb1 = 652;

  SN_aes_128_cfb8 = AnsiString('AES-128-CFB8');
  LN_aes_128_cfb8 = AnsiString('aes-128-cfb8');
  NID_aes_128_cfb8 = 653;

  SN_aes_192_cfb8 = AnsiString('AES-192-CFB8');
  LN_aes_192_cfb8 = AnsiString('aes-192-cfb8');
  NID_aes_192_cfb8 = 654;

  SN_aes_256_cfb8 = AnsiString('AES-256-CFB8');
  LN_aes_256_cfb8 = AnsiString('aes-256-cfb8');
  NID_aes_256_cfb8 = 655;

  SN_aes_128_ctr = AnsiString('AES-128-CTR');
  LN_aes_128_ctr = AnsiString('aes-128-ctr');
  NID_aes_128_ctr = 904;

  SN_aes_192_ctr = AnsiString('AES-192-CTR');
  LN_aes_192_ctr = AnsiString('aes-192-ctr');
  NID_aes_192_ctr = 905;

  SN_aes_256_ctr = AnsiString('AES-256-CTR');
  LN_aes_256_ctr = AnsiString('aes-256-ctr');
  NID_aes_256_ctr = 906;

  SN_aes_128_ocb = AnsiString('AES-128-OCB');
  LN_aes_128_ocb = AnsiString('aes-128-ocb');
  NID_aes_128_ocb = 958;

  SN_aes_192_ocb = AnsiString('AES-192-OCB');
  LN_aes_192_ocb = AnsiString('aes-192-ocb');
  NID_aes_192_ocb = 959;

  SN_aes_256_ocb = AnsiString('AES-256-OCB');
  LN_aes_256_ocb = AnsiString('aes-256-ocb');
  NID_aes_256_ocb = 960;

  SN_des_cfb1 = AnsiString('DES-CFB1');
  LN_des_cfb1 = AnsiString('des-cfb1');
  NID_des_cfb1 = 656;

  SN_des_cfb8 = AnsiString('DES-CFB8');
  LN_des_cfb8 = AnsiString('des-cfb8');
  NID_des_cfb8 = 657;

  SN_des_ede3_cfb1 = AnsiString('DES-EDE3-CFB1');
  LN_des_ede3_cfb1 = AnsiString('des-ede3-cfb1');
  NID_des_ede3_cfb1 = 658;

  SN_des_ede3_cfb8 = AnsiString('DES-EDE3-CFB8');
  LN_des_ede3_cfb8 = AnsiString('des-ede3-cfb8');
  NID_des_ede3_cfb8 = 659;

  SN_sha256 = AnsiString('SHA256');
  LN_sha256 = AnsiString('sha256');
  NID_sha256 = 672;

  SN_sha384 = AnsiString('SHA384');
  LN_sha384 = AnsiString('sha384');
  NID_sha384 = 673;

  SN_sha512 = AnsiString('SHA512');
  LN_sha512 = AnsiString('sha512');
  NID_sha512 = 674;

  SN_sha224 = AnsiString('SHA224');
  LN_sha224 = AnsiString('sha224');
  NID_sha224 = 675;

  SN_sha512_224 = AnsiString('SHA512-224');
  LN_sha512_224 = AnsiString('sha512-224');
  NID_sha512_224 = 1094;

  SN_sha512_256 = AnsiString('SHA512-256');
  LN_sha512_256 = AnsiString('sha512-256');
  NID_sha512_256 = 1095;

  SN_sha3_224 = AnsiString('SHA3-224');
  LN_sha3_224 = AnsiString('sha3-224');
  NID_sha3_224 = 1096;

  SN_sha3_256 = AnsiString('SHA3-256');
  LN_sha3_256 = AnsiString('sha3-256');
  NID_sha3_256 = 1097;

  SN_sha3_384 = AnsiString('SHA3-384');
  LN_sha3_384 = AnsiString('sha3-384');
  NID_sha3_384 = 1098;

  SN_sha3_512 = AnsiString('SHA3-512');
  LN_sha3_512 = AnsiString('sha3-512');
  NID_sha3_512 = 1099;

  SN_shake128 = AnsiString('SHAKE128');
  LN_shake128 = AnsiString('shake128');
  NID_shake128 = 1100;

  SN_shake256 = AnsiString('SHAKE256');
  LN_shake256 = AnsiString('shake256');
  NID_shake256 = 1101;

  SN_hmac_sha3_224 = AnsiString('id-hmacWithSHA3-224');
  LN_hmac_sha3_224 = AnsiString('hmac-sha3-224');
  NID_hmac_sha3_224 = 1102;

  SN_hmac_sha3_256 = AnsiString('id-hmacWithSHA3-256');
  LN_hmac_sha3_256 = AnsiString('hmac-sha3-256');
  NID_hmac_sha3_256 = 1103;

  SN_hmac_sha3_384 = AnsiString('id-hmacWithSHA3-384');
  LN_hmac_sha3_384 = AnsiString('hmac-sha3-384');
  NID_hmac_sha3_384 = 1104;

  SN_hmac_sha3_512 = AnsiString('id-hmacWithSHA3-512');
  LN_hmac_sha3_512 = AnsiString('hmac-sha3-512');
  NID_hmac_sha3_512 = 1105;

  SN_dsa_with_SHA224 = AnsiString('dsa_with_SHA224');
  NID_dsa_with_SHA224 = 802;

  SN_dsa_with_SHA256 = AnsiString('dsa_with_SHA256');
  NID_dsa_with_SHA256 = 803;

  SN_dsa_with_SHA384 = AnsiString('id-dsa-with-sha384');
  LN_dsa_with_SHA384 = AnsiString('dsa_with_SHA384');
  NID_dsa_with_SHA384 = 1106;

  SN_dsa_with_SHA512 = AnsiString('id-dsa-with-sha512');
  LN_dsa_with_SHA512 = AnsiString('dsa_with_SHA512');
  NID_dsa_with_SHA512 = 1107;

  SN_dsa_with_SHA3_224 = AnsiString('id-dsa-with-sha3-224');
  LN_dsa_with_SHA3_224 = AnsiString('dsa_with_SHA3-224');
  NID_dsa_with_SHA3_224 = 1108;

  SN_dsa_with_SHA3_256 = AnsiString('id-dsa-with-sha3-256');
  LN_dsa_with_SHA3_256 = AnsiString('dsa_with_SHA3-256');
  NID_dsa_with_SHA3_256 = 1109;

  SN_dsa_with_SHA3_384 = AnsiString('id-dsa-with-sha3-384');
  LN_dsa_with_SHA3_384 = AnsiString('dsa_with_SHA3-384');
  NID_dsa_with_SHA3_384 = 1110;

  SN_dsa_with_SHA3_512 = AnsiString('id-dsa-with-sha3-512');
  LN_dsa_with_SHA3_512 = AnsiString('dsa_with_SHA3-512');
  NID_dsa_with_SHA3_512 = 1111;

  SN_ecdsa_with_SHA3_224 = AnsiString('id-ecdsa-with-sha3-224');
  LN_ecdsa_with_SHA3_224 = AnsiString('ecdsa_with_SHA3-224');
  NID_ecdsa_with_SHA3_224 = 1112;

  SN_ecdsa_with_SHA3_256 = AnsiString('id-ecdsa-with-sha3-256');
  LN_ecdsa_with_SHA3_256 = AnsiString('ecdsa_with_SHA3-256');
  NID_ecdsa_with_SHA3_256 = 1113;

  SN_ecdsa_with_SHA3_384 = AnsiString('id-ecdsa-with-sha3-384');
  LN_ecdsa_with_SHA3_384 = AnsiString('ecdsa_with_SHA3-384');
  NID_ecdsa_with_SHA3_384 = 1114;

  SN_ecdsa_with_SHA3_512 = AnsiString('id-ecdsa-with-sha3-512');
  LN_ecdsa_with_SHA3_512 = AnsiString('ecdsa_with_SHA3-512');
  NID_ecdsa_with_SHA3_512 = 1115;

  SN_RSA_SHA3_224 = AnsiString('id-rsassa-pkcs1-v1_5-with-sha3-224');
  LN_RSA_SHA3_224 = AnsiString('RSA-SHA3-224');
  NID_RSA_SHA3_224 = 1116;

  SN_RSA_SHA3_256 = AnsiString('id-rsassa-pkcs1-v1_5-with-sha3-256');
  LN_RSA_SHA3_256 = AnsiString('RSA-SHA3-256');
  NID_RSA_SHA3_256 = 1117;

  SN_RSA_SHA3_384 = AnsiString('id-rsassa-pkcs1-v1_5-with-sha3-384');
  LN_RSA_SHA3_384 = AnsiString('RSA-SHA3-384');
  NID_RSA_SHA3_384 = 1118;

  SN_RSA_SHA3_512 = AnsiString('id-rsassa-pkcs1-v1_5-with-sha3-512');
  LN_RSA_SHA3_512 = AnsiString('RSA-SHA3-512');
  NID_RSA_SHA3_512 = 1119;

  SN_hold_instruction_code = AnsiString('holdInstructionCode');
  LN_hold_instruction_code = AnsiString('Hold Instruction Code');
  NID_hold_instruction_code = 430;

  SN_hold_instruction_none = AnsiString('holdInstructionNone');
  LN_hold_instruction_none = AnsiString('Hold Instruction None');
  NID_hold_instruction_none = 431;

  SN_hold_instruction_call_issuer = AnsiString('holdInstructionCallIssuer');
  LN_hold_instruction_call_issuer = AnsiString('Hold Instruction Call Issuer');
  NID_hold_instruction_call_issuer = 432;

  SN_hold_instruction_reject = AnsiString('holdInstructionReject');
  LN_hold_instruction_reject = AnsiString('Hold Instruction Reject');
  NID_hold_instruction_reject = 433;

  SN_data = AnsiString('data');
  NID_data = 434;

  SN_pss = AnsiString('pss');
  NID_pss = 435;

  SN_ucl = AnsiString('ucl');
  NID_ucl = 436;

  SN_pilot = AnsiString('pilot');
  NID_pilot = 437;

  LN_pilotAttributeType = AnsiString('pilotAttributeType');
  NID_pilotAttributeType = 438;

  LN_pilotAttributeSyntax = AnsiString('pilotAttributeSyntax');
  NID_pilotAttributeSyntax = 439;

  LN_pilotObjectClass = AnsiString('pilotObjectClass');
  NID_pilotObjectClass = 440;

  LN_pilotGroups = AnsiString('pilotGroups');
  NID_pilotGroups = 441;

  LN_iA5StringSyntax = AnsiString('iA5StringSyntax');
  NID_iA5StringSyntax = 442;

  LN_caseIgnoreIA5StringSyntax = AnsiString('caseIgnoreIA5StringSyntax');
  NID_caseIgnoreIA5StringSyntax = 443;

  LN_pilotObject = AnsiString('pilotObject');
  NID_pilotObject = 444;

  LN_pilotPerson = AnsiString('pilotPerson');
  NID_pilotPerson = 445;

  SN_account = AnsiString('account');
  NID_account = 446;

  SN_document = AnsiString('document');
  NID_document = 447;

  SN_room = AnsiString('room');
  NID_room = 448;

  LN_documentSeries = AnsiString('documentSeries');
  NID_documentSeries = 449;

  SN_Domain = AnsiString('domain');
  LN_Domain = AnsiString('Domain');
  NID_Domain = 392;

  LN_rFC822localPart = AnsiString('rFC822localPart');
  NID_rFC822localPart = 450;

  LN_dNSDomain = AnsiString('dNSDomain');
  NID_dNSDomain = 451;

  LN_domainRelatedObject = AnsiString('domainRelatedObject');
  NID_domainRelatedObject = 452;

  LN_friendlyCountry = AnsiString('friendlyCountry');
  NID_friendlyCountry = 453;

  LN_simpleSecurityObject = AnsiString('simpleSecurityObject');
  NID_simpleSecurityObject = 454;

  LN_pilotOrganization = AnsiString('pilotOrganization');
  NID_pilotOrganization = 455;

  LN_pilotDSA = AnsiString('pilotDSA');
  NID_pilotDSA = 456;

  LN_qualityLabelledData = AnsiString('qualityLabelledData');
  NID_qualityLabelledData = 457;

  SN_userId = AnsiString('UID');
  LN_userId = AnsiString('userId');
  NID_userId = 458;

  LN_textEncodedORAddress = AnsiString('textEncodedORAddress');
  NID_textEncodedORAddress = 459;

  SN_rfc822Mailbox = AnsiString('mail');
  LN_rfc822Mailbox = AnsiString('rfc822Mailbox');
  NID_rfc822Mailbox = 460;

  SN_info = AnsiString('info');
  NID_info = 461;

  LN_favouriteDrink = AnsiString('favouriteDrink');
  NID_favouriteDrink = 462;

  LN_roomNumber = AnsiString('roomNumber');
  NID_roomNumber = 463;

  SN_photo = AnsiString('photo');
  NID_photo = 464;

  LN_userClass = AnsiString('userClass');
  NID_userClass = 465;

  SN_host = AnsiString('host');
  NID_host = 466;

  SN_manager = AnsiString('manager');
  NID_manager = 467;

  LN_documentIdentifier = AnsiString('documentIdentifier');
  NID_documentIdentifier = 468;

  LN_documentTitle = AnsiString('documentTitle');
  NID_documentTitle = 469;

  LN_documentVersion = AnsiString('documentVersion');
  NID_documentVersion = 470;

  LN_documentAuthor = AnsiString('documentAuthor');
  NID_documentAuthor = 471;

  LN_documentLocation = AnsiString('documentLocation');
  NID_documentLocation = 472;

  LN_homeTelephoneNumber = AnsiString('homeTelephoneNumber');
  NID_homeTelephoneNumber = 473;

  SN_secretary = AnsiString('secretary');
  NID_secretary = 474;

  LN_otherMailbox = AnsiString('otherMailbox');
  NID_otherMailbox = 475;

  LN_lastModifiedTime = AnsiString('lastModifiedTime');
  NID_lastModifiedTime = 476;

  LN_lastModifiedBy = AnsiString('lastModifiedBy');
  NID_lastModifiedBy = 477;

  SN_domainComponent = AnsiString('DC');
  LN_domainComponent = AnsiString('domainComponent');
  NID_domainComponent = 391;

  LN_aRecord = AnsiString('aRecord');
  NID_aRecord = 478;

  LN_pilotAttributeType27 = AnsiString('pilotAttributeType27');
  NID_pilotAttributeType27 = 479;

  LN_mXRecord = AnsiString('mXRecord');
  NID_mXRecord = 480;

  LN_nSRecord = AnsiString('nSRecord');
  NID_nSRecord = 481;

  LN_sOARecord = AnsiString('sOARecord');
  NID_sOARecord = 482;

  LN_cNAMERecord = AnsiString('cNAMERecord');
  NID_cNAMERecord = 483;

  LN_associatedDomain = AnsiString('associatedDomain');
  NID_associatedDomain = 484;

  LN_associatedName = AnsiString('associatedName');
  NID_associatedName = 485;

  LN_homePostalAddress = AnsiString('homePostalAddress');
  NID_homePostalAddress = 486;

  LN_personalTitle = AnsiString('personalTitle');
  NID_personalTitle = 487;

  LN_mobileTelephoneNumber = AnsiString('mobileTelephoneNumber');
  NID_mobileTelephoneNumber = 488;

  LN_pagerTelephoneNumber = AnsiString('pagerTelephoneNumber');
  NID_pagerTelephoneNumber = 489;

  LN_friendlyCountryName = AnsiString('friendlyCountryName');
  NID_friendlyCountryName = 490;

  SN_uniqueIdentifier = AnsiString('uid');
  LN_uniqueIdentifier = AnsiString('uniqueIdentifier');
  NID_uniqueIdentifier = 102;

  LN_organizationalStatus = AnsiString('organizationalStatus');
  NID_organizationalStatus = 491;

  LN_janetMailbox = AnsiString('janetMailbox');
  NID_janetMailbox = 492;
  LN_mailPreferenceOption = AnsiString('mailPreferenceOption');
  NID_mailPreferenceOption = 493;

  LN_buildingName = AnsiString('buildingName');
  NID_buildingName = 494;

  LN_dSAQuality = AnsiString('dSAQuality');
  NID_dSAQuality = 495;

  LN_singleLevelQuality = AnsiString('singleLevelQuality');
  NID_singleLevelQuality = 496;

  LN_subtreeMinimumQuality = AnsiString('subtreeMinimumQuality');
  NID_subtreeMinimumQuality = 497;

  LN_subtreeMaximumQuality = AnsiString('subtreeMaximumQuality');
  NID_subtreeMaximumQuality = 498;

  LN_personalSignature = AnsiString('personalSignature');
  NID_personalSignature = 499;

  LN_dITRedirect = AnsiString('dITRedirect');
  NID_dITRedirect = 500;

  SN_audio = AnsiString('audio');
  NID_audio = 501;

  LN_documentPublisher = AnsiString('documentPublisher');
  NID_documentPublisher = 502;

  SN_id_set = AnsiString('id-set');
  LN_id_set = AnsiString('Secure Electronic Transactions');
  NID_id_set = 512;

  SN_set_ctype = AnsiString('set-ctype');
  LN_set_ctype = AnsiString('content types');
  NID_set_ctype = 513;

  SN_set_msgExt = AnsiString('set-msgExt');
  LN_set_msgExt = AnsiString('message extensions');
  NID_set_msgExt = 514;

  SN_set_attr = AnsiString('set-attr');
  NID_set_attr = 515;

  SN_set_policy = AnsiString('set-policy');
  NID_set_policy = 516;

  SN_set_certExt = AnsiString('set-certExt');
  LN_set_certExt = AnsiString('certificate extensions');
  NID_set_certExt = 517;

  SN_set_brand = AnsiString('set-brand');
  NID_set_brand = 518;

  SN_setct_PANData = AnsiString('setct-PANData');
  NID_setct_PANData = 519;

  SN_setct_PANToken = AnsiString('setct-PANToken');
  NID_setct_PANToken = 520;

  SN_setct_PANOnly = AnsiString('setct-PANOnly');
  NID_setct_PANOnly = 521;

  SN_setct_OIData = AnsiString('setct-OIData');
  NID_setct_OIData = 522;

  SN_setct_PI = AnsiString('setct-PI');
  NID_setct_PI = 523;

  SN_setct_PIData = AnsiString('setct-PIData');
  NID_setct_PIData = 524;

  SN_setct_PIDataUnsigned = AnsiString('setct-PIDataUnsigned');
  NID_setct_PIDataUnsigned = 525;

  SN_setct_HODInput = AnsiString('setct-HODInput');
  NID_setct_HODInput = 526;

  SN_setct_AuthResBaggage = AnsiString('setct-AuthResBaggage');
  NID_setct_AuthResBaggage = 527;

  SN_setct_AuthRevReqBaggage = AnsiString('setct-AuthRevReqBaggage');
  NID_setct_AuthRevReqBaggage = 528;

  SN_setct_AuthRevResBaggage = AnsiString('setct-AuthRevResBaggage');
  NID_setct_AuthRevResBaggage = 529;

  SN_setct_CapTokenSeq = AnsiString('setct-CapTokenSeq');
  NID_setct_CapTokenSeq = 530;

  SN_setct_PInitResData = AnsiString('setct-PInitResData');
  NID_setct_PInitResData = 531;

  SN_setct_PI_TBS = AnsiString('setct-PI-TBS');
  NID_setct_PI_TBS = 532;

  SN_setct_PResData = AnsiString('setct-PResData');
  NID_setct_PResData = 533;

  SN_setct_AuthReqTBS = AnsiString('setct-AuthReqTBS');
  NID_setct_AuthReqTBS = 534;

  SN_setct_AuthResTBS = AnsiString('setct-AuthResTBS');
  NID_setct_AuthResTBS = 535;

  SN_setct_AuthResTBSX = AnsiString('setct-AuthResTBSX');
  NID_setct_AuthResTBSX = 536;

  SN_setct_AuthTokenTBS = AnsiString('setct-AuthTokenTBS');
  NID_setct_AuthTokenTBS = 537;

  SN_setct_CapTokenData = AnsiString('setct-CapTokenData');
  NID_setct_CapTokenData = 538;

  SN_setct_CapTokenTBS = AnsiString('setct-CapTokenTBS');
  NID_setct_CapTokenTBS = 539;

  SN_setct_AcqCardCodeMsg = AnsiString('setct-AcqCardCodeMsg');
  NID_setct_AcqCardCodeMsg = 540;

  SN_setct_AuthRevReqTBS = AnsiString('setct-AuthRevReqTBS');
  NID_setct_AuthRevReqTBS = 541;

  SN_setct_AuthRevResData = AnsiString('setct-AuthRevResData');
  NID_setct_AuthRevResData = 542;

  SN_setct_AuthRevResTBS = AnsiString('setct-AuthRevResTBS');
  NID_setct_AuthRevResTBS = 543;

  SN_setct_CapReqTBS = AnsiString('setct-CapReqTBS');
  NID_setct_CapReqTBS = 544;

  SN_setct_CapReqTBSX = AnsiString('setct-CapReqTBSX');
  NID_setct_CapReqTBSX = 545;

  SN_setct_CapResData = AnsiString('setct-CapResData');
  NID_setct_CapResData = 546;

  SN_setct_CapRevReqTBS = AnsiString('setct-CapRevReqTBS');
  NID_setct_CapRevReqTBS = 547;

  SN_setct_CapRevReqTBSX = AnsiString('setct-CapRevReqTBSX');
  NID_setct_CapRevReqTBSX = 548;

  SN_setct_CapRevResData = AnsiString('setct-CapRevResData');
  NID_setct_CapRevResData = 549;

  SN_setct_CredReqTBS = AnsiString('setct-CredReqTBS');
  NID_setct_CredReqTBS = 550;

  SN_setct_CredReqTBSX = AnsiString('setct-CredReqTBSX');
  NID_setct_CredReqTBSX = 551;

  SN_setct_CredResData = AnsiString('setct-CredResData');
  NID_setct_CredResData = 552;

  SN_setct_CredRevReqTBS = AnsiString('setct-CredRevReqTBS');
  NID_setct_CredRevReqTBS = 553;

  SN_setct_CredRevReqTBSX = AnsiString('setct-CredRevReqTBSX');
  NID_setct_CredRevReqTBSX = 554;

  SN_setct_CredRevResData = AnsiString('setct-CredRevResData');
  NID_setct_CredRevResData = 555;

  SN_setct_PCertReqData = AnsiString('setct-PCertReqData');
  NID_setct_PCertReqData = 556;

  SN_setct_PCertResTBS = AnsiString('setct-PCertResTBS');
  NID_setct_PCertResTBS = 557;

  SN_setct_BatchAdminReqData = AnsiString('setct-BatchAdminReqData');
  NID_setct_BatchAdminReqData = 558;

  SN_setct_BatchAdminResData = AnsiString('setct-BatchAdminResData');
  NID_setct_BatchAdminResData = 559;

  SN_setct_CardCInitResTBS = AnsiString('setct-CardCInitResTBS');
  NID_setct_CardCInitResTBS = 560;

  SN_setct_MeAqCInitResTBS = AnsiString('setct-MeAqCInitResTBS');
  NID_setct_MeAqCInitResTBS = 561;

  SN_setct_RegFormResTBS = AnsiString('setct-RegFormResTBS');
  NID_setct_RegFormResTBS = 562;

  SN_setct_CertReqData = AnsiString('setct-CertReqData');
  NID_setct_CertReqData = 563;

  SN_setct_CertReqTBS = AnsiString('setct-CertReqTBS');
  NID_setct_CertReqTBS = 564;

  SN_setct_CertResData = AnsiString('setct-CertResData');
  NID_setct_CertResData = 565;

  SN_setct_CertInqReqTBS = AnsiString('setct-CertInqReqTBS');
  NID_setct_CertInqReqTBS = 566;

  SN_setct_ErrorTBS = AnsiString('setct-ErrorTBS');
  NID_setct_ErrorTBS = 567;

  SN_setct_PIDualSignedTBE = AnsiString('setct-PIDualSignedTBE');
  NID_setct_PIDualSignedTBE = 568;

  SN_setct_PIUnsignedTBE = AnsiString('setct-PIUnsignedTBE');
  NID_setct_PIUnsignedTBE = 569;

  SN_setct_AuthReqTBE = AnsiString('setct-AuthReqTBE');
  NID_setct_AuthReqTBE = 570;

  SN_setct_AuthResTBE = AnsiString('setct-AuthResTBE');
  NID_setct_AuthResTBE = 571;

  SN_setct_AuthResTBEX = AnsiString('setct-AuthResTBEX');
  NID_setct_AuthResTBEX = 572;

  SN_setct_AuthTokenTBE = AnsiString('setct-AuthTokenTBE');
  NID_setct_AuthTokenTBE = 573;

  SN_setct_CapTokenTBE = AnsiString('setct-CapTokenTBE');
  NID_setct_CapTokenTBE = 574;

  SN_setct_CapTokenTBEX = AnsiString('setct-CapTokenTBEX');
  NID_setct_CapTokenTBEX = 575;

  SN_setct_AcqCardCodeMsgTBE = AnsiString('setct-AcqCardCodeMsgTBE');
  NID_setct_AcqCardCodeMsgTBE = 576;

  SN_setct_AuthRevReqTBE = AnsiString('setct-AuthRevReqTBE');
  NID_setct_AuthRevReqTBE = 577;

  SN_setct_AuthRevResTBE = AnsiString('setct-AuthRevResTBE');
  NID_setct_AuthRevResTBE = 578;

  SN_setct_AuthRevResTBEB = AnsiString('setct-AuthRevResTBEB');
  NID_setct_AuthRevResTBEB = 579;

  SN_setct_CapReqTBE = AnsiString('setct-CapReqTBE');
  NID_setct_CapReqTBE = 580;

  SN_setct_CapReqTBEX = AnsiString('setct-CapReqTBEX');
  NID_setct_CapReqTBEX = 581;

  SN_setct_CapResTBE = AnsiString('setct-CapResTBE');
  NID_setct_CapResTBE = 582;

  SN_setct_CapRevReqTBE = AnsiString('setct-CapRevReqTBE');
  NID_setct_CapRevReqTBE = 583;

  SN_setct_CapRevReqTBEX = AnsiString('setct-CapRevReqTBEX');
  NID_setct_CapRevReqTBEX = 584;

  SN_setct_CapRevResTBE = AnsiString('setct-CapRevResTBE');
  NID_setct_CapRevResTBE = 585;

  SN_setct_CredReqTBE = AnsiString('setct-CredReqTBE');
  NID_setct_CredReqTBE = 586;

  SN_setct_CredReqTBEX = AnsiString('setct-CredReqTBEX');
  NID_setct_CredReqTBEX = 587;

  SN_setct_CredResTBE = AnsiString('setct-CredResTBE');
  NID_setct_CredResTBE = 588;

  SN_setct_CredRevReqTBE = AnsiString('setct-CredRevReqTBE');
  NID_setct_CredRevReqTBE = 589;

  SN_setct_CredRevReqTBEX = AnsiString('setct-CredRevReqTBEX');
  NID_setct_CredRevReqTBEX = 590;

  SN_setct_CredRevResTBE = AnsiString('setct-CredRevResTBE');
  NID_setct_CredRevResTBE = 591;

  SN_setct_BatchAdminReqTBE = AnsiString('setct-BatchAdminReqTBE');
  NID_setct_BatchAdminReqTBE = 592;

  SN_setct_BatchAdminResTBE = AnsiString('setct-BatchAdminResTBE');
  NID_setct_BatchAdminResTBE = 593;

  SN_setct_RegFormReqTBE = AnsiString('setct-RegFormReqTBE');
  NID_setct_RegFormReqTBE = 594;

  SN_setct_CertReqTBE = AnsiString('setct-CertReqTBE');
  NID_setct_CertReqTBE = 595;

  SN_setct_CertReqTBEX = AnsiString('setct-CertReqTBEX');
  NID_setct_CertReqTBEX = 596;

  SN_setct_CertResTBE = AnsiString('setct-CertResTBE');
  NID_setct_CertResTBE = 597;

  SN_setct_CRLNotificationTBS = AnsiString('setct-CRLNotificationTBS');
  NID_setct_CRLNotificationTBS = 598;

  SN_setct_CRLNotificationResTBS = AnsiString('setct-CRLNotificationResTBS');
  NID_setct_CRLNotificationResTBS = 599;

  SN_setct_BCIDistributionTBS = AnsiString('setct-BCIDistributionTBS');
  NID_setct_BCIDistributionTBS = 600;

  SN_setext_genCrypt = AnsiString('setext-genCrypt');
  LN_setext_genCrypt = AnsiString('generic cryptogram');
  NID_setext_genCrypt = 601;

  SN_setext_miAuth = AnsiString('setext-miAuth');
  LN_setext_miAuth = AnsiString('merchant initiated auth');
  NID_setext_miAuth = 602;

  SN_setext_pinSecure = AnsiString('setext-pinSecure');
  NID_setext_pinSecure = 603;

  SN_setext_pinAny = AnsiString('setext-pinAny');
  NID_setext_pinAny = 604;

  SN_setext_track2 = AnsiString('setext-track2');
  NID_setext_track2 = 605;

  SN_setext_cv = AnsiString('setext-cv');
  LN_setext_cv = AnsiString('additional verification');
  NID_setext_cv = 606;

  SN_set_policy_root = AnsiString('set-policy-root');
  NID_set_policy_root = 607;

  SN_setCext_hashedRoot = AnsiString('setCext-hashedRoot');
  NID_setCext_hashedRoot = 608;

  SN_setCext_certType = AnsiString('setCext-certType');
  NID_setCext_certType = 609;

  SN_setCext_merchData = AnsiString('setCext-merchData');
  NID_setCext_merchData = 610;

  SN_setCext_cCertRequired = AnsiString('setCext-cCertRequired');
  NID_setCext_cCertRequired = 611;

  SN_setCext_tunneling = AnsiString('setCext-tunneling');
  NID_setCext_tunneling = 612;

  SN_setCext_setExt = AnsiString('setCext-setExt');
  NID_setCext_setExt = 613;

  SN_setCext_setQualf = AnsiString('setCext-setQualf');
  NID_setCext_setQualf = 614;

  SN_setCext_PGWYcapabilities = AnsiString('setCext-PGWYcapabilities');
  NID_setCext_PGWYcapabilities = 615;

  SN_setCext_TokenIdentifier = AnsiString('setCext-TokenIdentifier');
  NID_setCext_TokenIdentifier = 616;

  SN_setCext_Track2Data = AnsiString('setCext-Track2Data');
  NID_setCext_Track2Data = 617;

  SN_setCext_TokenType = AnsiString('setCext-TokenType');
  NID_setCext_TokenType = 618;

  SN_setCext_IssuerCapabilities = AnsiString('setCext-IssuerCapabilities');
  NID_setCext_IssuerCapabilities = 619;

  SN_setAttr_Cert = AnsiString('setAttr-Cert');
  NID_setAttr_Cert = 620;

  SN_setAttr_PGWYcap = AnsiString('setAttr-PGWYcap');
  LN_setAttr_PGWYcap = AnsiString('payment gateway capabilities');
  NID_setAttr_PGWYcap = 621;

  SN_setAttr_TokenType = AnsiString('setAttr-TokenType');
  NID_setAttr_TokenType = 622;

  SN_setAttr_IssCap = AnsiString('setAttr-IssCap');
  LN_setAttr_IssCap = AnsiString('issuer capabilities');
  NID_setAttr_IssCap = 623;

  SN_set_rootKeyThumb = AnsiString('set-rootKeyThumb');
  NID_set_rootKeyThumb = 624;

  SN_set_addPolicy = AnsiString('set-addPolicy');
  NID_set_addPolicy = 625;

  SN_setAttr_Token_EMV = AnsiString('setAttr-Token-EMV');
  NID_setAttr_Token_EMV = 626;

  SN_setAttr_Token_B0Prime = AnsiString('setAttr-Token-B0Prime');
  NID_setAttr_Token_B0Prime = 627;

  SN_setAttr_IssCap_CVM = AnsiString('setAttr-IssCap-CVM');
  NID_setAttr_IssCap_CVM = 628;

  SN_setAttr_IssCap_T2 = AnsiString('setAttr-IssCap-T2');
  NID_setAttr_IssCap_T2 = 629;

  SN_setAttr_IssCap_Sig = AnsiString('setAttr-IssCap-Sig');
  NID_setAttr_IssCap_Sig = 630;

  SN_setAttr_GenCryptgrm = AnsiString('setAttr-GenCryptgrm');
  LN_setAttr_GenCryptgrm = AnsiString('generate cryptogram');
  NID_setAttr_GenCryptgrm = 631;

  SN_setAttr_T2Enc = AnsiString('setAttr-T2Enc');
  LN_setAttr_T2Enc = AnsiString('encrypted track 2');
  NID_setAttr_T2Enc = 632;

  SN_setAttr_T2cleartxt = AnsiString('setAttr-T2cleartxt');
  LN_setAttr_T2cleartxt = AnsiString('cleartext track 2');
  NID_setAttr_T2cleartxt = 633;

  SN_setAttr_TokICCsig = AnsiString('setAttr-TokICCsig');
  LN_setAttr_TokICCsig = AnsiString('ICC or token signature');
  NID_setAttr_TokICCsig = 634;

  SN_setAttr_SecDevSig = AnsiString('setAttr-SecDevSig');
  LN_setAttr_SecDevSig = AnsiString('secure device signature');
  NID_setAttr_SecDevSig = 635;

  SN_set_brand_IATA_ATA = AnsiString('set-brand-IATA-ATA');
  NID_set_brand_IATA_ATA = 636;

  SN_set_brand_Diners = AnsiString('set-brand-Diners');
  NID_set_brand_Diners = 637;

  SN_set_brand_AmericanExpress = AnsiString('set-brand-AmericanExpress');
  NID_set_brand_AmericanExpress = 638;

  SN_set_brand_JCB = AnsiString('set-brand-JCB');
  NID_set_brand_JCB = 639;

  SN_set_brand_Visa = AnsiString('set-brand-Visa');
  NID_set_brand_Visa = 640;

  SN_set_brand_MasterCard = AnsiString('set-brand-MasterCard');
  NID_set_brand_MasterCard = 641;

  SN_set_brand_Novus = AnsiString('set-brand-Novus');
  NID_set_brand_Novus = 642;

  SN_des_cdmf = AnsiString('DES-CDMF');
  LN_des_cdmf = AnsiString('des-cdmf');
  NID_des_cdmf = 643;

  SN_rsaOAEPEncryptionSET = AnsiString('rsaOAEPEncryptionSET');
  NID_rsaOAEPEncryptionSET = 644;

  SN_ipsec3 = AnsiString('Oakley-EC2N-3');
  LN_ipsec3 = AnsiString('ipsec3');
  NID_ipsec3 = 749;

  SN_ipsec4 = AnsiString('Oakley-EC2N-4');
  LN_ipsec4 = AnsiString('ipsec4');
  NID_ipsec4 = 750;

  SN_whirlpool = AnsiString('whirlpool');
  NID_whirlpool = 804;

  SN_cryptopro = AnsiString('cryptopro');
  NID_cryptopro = 805;

  SN_cryptocom = AnsiString('cryptocom');
  NID_cryptocom = 806;

  SN_id_tc26 = AnsiString('id-tc26');
  NID_id_tc26 = 974;

  SN_id_GostR3411_94_with_GostR3410_2001 = AnsiString('id-GostR3411-94-with-GostR3410-2001');
  LN_id_GostR3411_94_with_GostR3410_2001 = AnsiString('GOST R 34.11-94 with GOST R 34.10-2001');
  NID_id_GostR3411_94_with_GostR3410_2001 = 807;

  SN_id_GostR3411_94_with_GostR3410_94 = AnsiString('id-GostR3411-94-with-GostR3410-94');
  LN_id_GostR3411_94_with_GostR3410_94 = AnsiString('GOST R 34.11-94 with GOST R 34.10-94');
  NID_id_GostR3411_94_with_GostR3410_94 = 808;

  SN_id_GostR3411_94 = AnsiString('md_gost94');
  LN_id_GostR3411_94 = AnsiString('GOST R 34.11-94');
  NID_id_GostR3411_94 = 809;

  SN_id_HMACGostR3411_94 = AnsiString('id-HMACGostR3411-94');
  LN_id_HMACGostR3411_94 = AnsiString('HMAC GOST 34.11-94');
  NID_id_HMACGostR3411_94 = 810;

  SN_id_GostR3410_2001 = AnsiString('gost2001');
  LN_id_GostR3410_2001 = AnsiString('GOST R 34.10-2001');
  NID_id_GostR3410_2001 = 811;

  SN_id_GostR3410_94 = AnsiString('gost94');
  LN_id_GostR3410_94 = AnsiString('GOST R 34.10-94');
  NID_id_GostR3410_94 = 812;

  SN_id_Gost28147_89 = AnsiString('gost89');
  LN_id_Gost28147_89 = AnsiString('GOST 28147-89');
  NID_id_Gost28147_89 = 813;

  SN_gost89_cnt = AnsiString('gost89-cnt');
  NID_gost89_cnt = 814;

  SN_gost89_cnt_12 = AnsiString('gost89-cnt-12');
  NID_gost89_cnt_12 = 975;

  SN_gost89_cbc = AnsiString('gost89-cbc');
  NID_gost89_cbc = 1009;

  SN_gost89_ecb = AnsiString('gost89-ecb');
  NID_gost89_ecb = 1010;

  SN_gost89_ctr = AnsiString('gost89-ctr');
  NID_gost89_ctr = 1011;

  SN_id_Gost28147_89_MAC = AnsiString('gost-mac');
  LN_id_Gost28147_89_MAC = AnsiString('GOST 28147-89 MAC');
  NID_id_Gost28147_89_MAC = 815;

  SN_gost_mac_12 = AnsiString('gost-mac-12');
  NID_gost_mac_12 = 976;

  SN_id_GostR3411_94_prf = AnsiString('prf-gostr3411-94');
  LN_id_GostR3411_94_prf = AnsiString('GOST R 34.11-94 PRF');
  NID_id_GostR3411_94_prf = 816;

  SN_id_GostR3410_2001DH = AnsiString('id-GostR3410-2001DH');
  LN_id_GostR3410_2001DH = AnsiString('GOST R 34.10-2001 DH');
  NID_id_GostR3410_2001DH = 817;

  SN_id_GostR3410_94DH = AnsiString('id-GostR3410-94DH');
  LN_id_GostR3410_94DH = AnsiString('GOST R 34.10-94 DH');
  NID_id_GostR3410_94DH = 818;

  SN_id_Gost28147_89_CryptoPro_KeyMeshing = AnsiString('id-Gost28147-89-CryptoPro-KeyMeshing');
  NID_id_Gost28147_89_CryptoPro_KeyMeshing = 819;

  SN_id_Gost28147_89_None_KeyMeshing = AnsiString('id-Gost28147-89-None-KeyMeshing');
  NID_id_Gost28147_89_None_KeyMeshing = 820;

  SN_id_GostR3411_94_TestParamSet = AnsiString('id-GostR3411-94-TestParamSet');
  NID_id_GostR3411_94_TestParamSet = 821;

  SN_id_GostR3411_94_CryptoProParamSet = AnsiString('id-GostR3411-94-CryptoProParamSet');
  NID_id_GostR3411_94_CryptoProParamSet = 822;

  SN_id_Gost28147_89_TestParamSet = AnsiString('id-Gost28147-89-TestParamSet');
  NID_id_Gost28147_89_TestParamSet = 823;

  SN_id_Gost28147_89_CryptoPro_A_ParamSet = AnsiString('id-Gost28147-89-CryptoPro-A-ParamSet');
  NID_id_Gost28147_89_CryptoPro_A_ParamSet = 824;

  SN_id_Gost28147_89_CryptoPro_B_ParamSet = AnsiString('id-Gost28147-89-CryptoPro-B-ParamSet');
  NID_id_Gost28147_89_CryptoPro_B_ParamSet = 825;

  SN_id_Gost28147_89_CryptoPro_C_ParamSet = AnsiString('id-Gost28147-89-CryptoPro-C-ParamSet');
  NID_id_Gost28147_89_CryptoPro_C_ParamSet = 826;

  SN_id_Gost28147_89_CryptoPro_D_ParamSet = AnsiString('id-Gost28147-89-CryptoPro-D-ParamSet');
  NID_id_Gost28147_89_CryptoPro_D_ParamSet = 827;

  SN_id_Gost28147_89_CryptoPro_Oscar_1_1_ParamSet = AnsiString('id-Gost28147-89-CryptoPro-Oscar-1-1-ParamSet');
  NID_id_Gost28147_89_CryptoPro_Oscar_1_1_ParamSet = 828;

  SN_id_Gost28147_89_CryptoPro_Oscar_1_0_ParamSet = AnsiString('id-Gost28147-89-CryptoPro-Oscar-1-0-ParamSet');
  NID_id_Gost28147_89_CryptoPro_Oscar_1_0_ParamSet = 829;

  SN_id_Gost28147_89_CryptoPro_RIC_1_ParamSet = AnsiString('id-Gost28147-89-CryptoPro-RIC-1-ParamSet');
  NID_id_Gost28147_89_CryptoPro_RIC_1_ParamSet = 830;

  SN_id_GostR3410_94_TestParamSet = AnsiString('id-GostR3410-94-TestParamSet');
  NID_id_GostR3410_94_TestParamSet = 831;

  SN_id_GostR3410_94_CryptoPro_A_ParamSet = AnsiString('id-GostR3410-94-CryptoPro-A-ParamSet');
  NID_id_GostR3410_94_CryptoPro_A_ParamSet = 832;

  SN_id_GostR3410_94_CryptoPro_B_ParamSet = AnsiString('id-GostR3410-94-CryptoPro-B-ParamSet');
  NID_id_GostR3410_94_CryptoPro_B_ParamSet = 833;

  SN_id_GostR3410_94_CryptoPro_C_ParamSet = AnsiString('id-GostR3410-94-CryptoPro-C-ParamSet');
  NID_id_GostR3410_94_CryptoPro_C_ParamSet = 834;

  SN_id_GostR3410_94_CryptoPro_D_ParamSet = AnsiString('id-GostR3410-94-CryptoPro-D-ParamSet');
  NID_id_GostR3410_94_CryptoPro_D_ParamSet = 835;

  SN_id_GostR3410_94_CryptoPro_XchA_ParamSet = AnsiString('id-GostR3410-94-CryptoPro-XchA-ParamSet');
  NID_id_GostR3410_94_CryptoPro_XchA_ParamSet = 836;

  SN_id_GostR3410_94_CryptoPro_XchB_ParamSet = AnsiString('id-GostR3410-94-CryptoPro-XchB-ParamSet');
  NID_id_GostR3410_94_CryptoPro_XchB_ParamSet = 837;

  SN_id_GostR3410_94_CryptoPro_XchC_ParamSet = AnsiString('id-GostR3410-94-CryptoPro-XchC-ParamSet');
  NID_id_GostR3410_94_CryptoPro_XchC_ParamSet = 838;

  SN_id_GostR3410_2001_TestParamSet = AnsiString('id-GostR3410-2001-TestParamSet');
  NID_id_GostR3410_2001_TestParamSet = 839;

  SN_id_GostR3410_2001_CryptoPro_A_ParamSet = AnsiString('id-GostR3410-2001-CryptoPro-A-ParamSet');
  NID_id_GostR3410_2001_CryptoPro_A_ParamSet = 840;

  SN_id_GostR3410_2001_CryptoPro_B_ParamSet = AnsiString('id-GostR3410-2001-CryptoPro-B-ParamSet');
  NID_id_GostR3410_2001_CryptoPro_B_ParamSet = 841;

  SN_id_GostR3410_2001_CryptoPro_C_ParamSet = AnsiString('id-GostR3410-2001-CryptoPro-C-ParamSet');
  NID_id_GostR3410_2001_CryptoPro_C_ParamSet = 842;

  SN_id_GostR3410_2001_CryptoPro_XchA_ParamSet = AnsiString('id-GostR3410-2001-CryptoPro-XchA-ParamSet');
  NID_id_GostR3410_2001_CryptoPro_XchA_ParamSet = 843;

  SN_id_GostR3410_2001_CryptoPro_XchB_ParamSet = AnsiString('id-GostR3410-2001-CryptoPro-XchB-ParamSet');
  NID_id_GostR3410_2001_CryptoPro_XchB_ParamSet = 844;

  SN_id_GostR3410_94_a = AnsiString('id-GostR3410-94-a');
  NID_id_GostR3410_94_a = 845;

  SN_id_GostR3410_94_aBis = AnsiString('id-GostR3410-94-aBis');
  NID_id_GostR3410_94_aBis = 846;

  SN_id_GostR3410_94_b = AnsiString('id-GostR3410-94-b');
  NID_id_GostR3410_94_b = 847;

  SN_id_GostR3410_94_bBis = AnsiString('id-GostR3410-94-bBis');
  NID_id_GostR3410_94_bBis = 848;

  SN_id_Gost28147_89_cc = AnsiString('id-Gost28147-89-cc');
  LN_id_Gost28147_89_cc = AnsiString('GOST 28147-89 Cryptocom ParamSet');
  NID_id_Gost28147_89_cc = 849;

  SN_id_GostR3410_94_cc = AnsiString('gost94cc');
  LN_id_GostR3410_94_cc = AnsiString('GOST 34.10-94 Cryptocom');
  NID_id_GostR3410_94_cc = 850;

  SN_id_GostR3410_2001_cc = AnsiString('gost2001cc');
  LN_id_GostR3410_2001_cc = AnsiString('GOST 34.10-2001 Cryptocom');
  NID_id_GostR3410_2001_cc = 851;

  SN_id_GostR3411_94_with_GostR3410_94_cc = AnsiString('id-GostR3411-94-with-GostR3410-94-cc');
  LN_id_GostR3411_94_with_GostR3410_94_cc = AnsiString('GOST R 34.11-94 with GOST R 34.10-94 Cryptocom');
  NID_id_GostR3411_94_with_GostR3410_94_cc = 852;

  SN_id_GostR3411_94_with_GostR3410_2001_cc = AnsiString('id-GostR3411-94-with-GostR3410-2001-cc');
  LN_id_GostR3411_94_with_GostR3410_2001_cc = AnsiString('GOST R 34.11-94 with GOST R 34.10-2001 Cryptocom');
  NID_id_GostR3411_94_with_GostR3410_2001_cc = 853;

  SN_id_GostR3410_2001_ParamSet_cc = AnsiString('id-GostR3410-2001-ParamSet-cc');
  LN_id_GostR3410_2001_ParamSet_cc = AnsiString('GOST R 3410-2001 Parameter Set Cryptocom');
  NID_id_GostR3410_2001_ParamSet_cc = 854;

  SN_id_tc26_algorithms = AnsiString('id-tc26-algorithms');
  NID_id_tc26_algorithms = 977;

  SN_id_tc26_sign = AnsiString('id-tc26-sign');
  NID_id_tc26_sign = 978;

  SN_id_GostR3410_2012_256 = AnsiString('gost2012_256');
  LN_id_GostR3410_2012_256 = AnsiString('GOST R 34.10-2012 with 256 bit modulus');
  NID_id_GostR3410_2012_256 = 979;

  SN_id_GostR3410_2012_512 = AnsiString('gost2012_512');
  LN_id_GostR3410_2012_512 = AnsiString('GOST R 34.10-2012 with 512 bit modulus');
  NID_id_GostR3410_2012_512 = 980;

  SN_id_tc26_digest = AnsiString('id-tc26-digest');
  NID_id_tc26_digest = 981;

  SN_id_GostR3411_2012_256 = AnsiString('md_gost12_256');
  LN_id_GostR3411_2012_256 = AnsiString('GOST R 34.11-2012 with 256 bit hash');
  NID_id_GostR3411_2012_256 = 982;

  SN_id_GostR3411_2012_512 = AnsiString('md_gost12_512');
  LN_id_GostR3411_2012_512 = AnsiString('GOST R 34.11-2012 with 512 bit hash');
  NID_id_GostR3411_2012_512 = 983;

  SN_id_tc26_signwithdigest = AnsiString('id-tc26-signwithdigest');
  NID_id_tc26_signwithdigest = 984;

  SN_id_tc26_signwithdigest_gost3410_2012_256 = AnsiString('id-tc26-signwithdigest-gost3410-2012-256');
  LN_id_tc26_signwithdigest_gost3410_2012_256 = AnsiString('GOST R 34.10-2012 with GOST R 34.11-2012(256 bit)');
  NID_id_tc26_signwithdigest_gost3410_2012_256 = 985;

  SN_id_tc26_signwithdigest_gost3410_2012_512 = AnsiString('id-tc26-signwithdigest-gost3410-2012-512');
  LN_id_tc26_signwithdigest_gost3410_2012_512 = AnsiString('GOST R 34.10-2012 with GOST R 34.11-2012(512 bit)');
  NID_id_tc26_signwithdigest_gost3410_2012_512 = 986;

  SN_id_tc26_mac = AnsiString('id-tc26-mac');
  NID_id_tc26_mac = 987;

  SN_id_tc26_hmac_gost_3411_2012_256 = AnsiString('id-tc26-hmac-gost-3411-2012-256');
  LN_id_tc26_hmac_gost_3411_2012_256 = AnsiString('HMAC GOST 34.11-2012 256 bit');
  NID_id_tc26_hmac_gost_3411_2012_256 = 988;

  SN_id_tc26_hmac_gost_3411_2012_512 = AnsiString('id-tc26-hmac-gost-3411-2012-512');
  LN_id_tc26_hmac_gost_3411_2012_512 = AnsiString('HMAC GOST 34.11-2012 512 bit');
  NID_id_tc26_hmac_gost_3411_2012_512 = 989;

  SN_id_tc26_cipher = AnsiString('id-tc26-cipher');
  NID_id_tc26_cipher = 990;

  SN_id_tc26_cipher_gostr3412_2015_magma = AnsiString('id-tc26-cipher-gostr3412-2015-magma');
  NID_id_tc26_cipher_gostr3412_2015_magma = 1173;

  SN_id_tc26_cipher_gostr3412_2015_magma_ctracpkm = AnsiString('id-tc26-cipher-gostr3412-2015-magma-ctracpkm');
  NID_id_tc26_cipher_gostr3412_2015_magma_ctracpkm = 1174;

  SN_id_tc26_cipher_gostr3412_2015_magma_ctracpkm_omac = AnsiString('id-tc26-cipher-gostr3412-2015-magma-ctracpkm-omac');
  NID_id_tc26_cipher_gostr3412_2015_magma_ctracpkm_omac = 1175;

  SN_id_tc26_cipher_gostr3412_2015_kuznyechik = AnsiString('id-tc26-cipher-gostr3412-2015-kuznyechik');
  NID_id_tc26_cipher_gostr3412_2015_kuznyechik = 1176;

  SN_id_tc26_cipher_gostr3412_2015_kuznyechik_ctracpkm = AnsiString('id-tc26-cipher-gostr3412-2015-kuznyechik-ctracpkm');
  NID_id_tc26_cipher_gostr3412_2015_kuznyechik_ctracpkm = 1177;

  SN_id_tc26_cipher_gostr3412_2015_kuznyechik_ctracpkm_omac = AnsiString('id-tc26-cipher-gostr3412-2015-kuznyechik-ctracpkm-omac');
  NID_id_tc26_cipher_gostr3412_2015_kuznyechik_ctracpkm_omac = 1178;

  SN_id_tc26_agreement = AnsiString('id-tc26-agreement');
  NID_id_tc26_agreement = 991;

  SN_id_tc26_agreement_gost_3410_2012_256 = AnsiString('id-tc26-agreement-gost-3410-2012-256');
  NID_id_tc26_agreement_gost_3410_2012_256 = 992;

  SN_id_tc26_agreement_gost_3410_2012_512 = AnsiString('id-tc26-agreement-gost-3410-2012-512');
  NID_id_tc26_agreement_gost_3410_2012_512 = 993;

  SN_id_tc26_wrap = AnsiString('id-tc26-wrap');
  NID_id_tc26_wrap = 1179;

  SN_id_tc26_wrap_gostr3412_2015_magma = AnsiString('id-tc26-wrap-gostr3412-2015-magma');
  NID_id_tc26_wrap_gostr3412_2015_magma = 1180;

  SN_id_tc26_wrap_gostr3412_2015_magma_kexp15 = AnsiString('id-tc26-wrap-gostr3412-2015-magma-kexp15');
  NID_id_tc26_wrap_gostr3412_2015_magma_kexp15 = 1181;

  SN_id_tc26_wrap_gostr3412_2015_kuznyechik = AnsiString('id-tc26-wrap-gostr3412-2015-kuznyechik');
  NID_id_tc26_wrap_gostr3412_2015_kuznyechik = 1182;

  SN_id_tc26_wrap_gostr3412_2015_kuznyechik_kexp15 = AnsiString('id-tc26-wrap-gostr3412-2015-kuznyechik-kexp15');
  NID_id_tc26_wrap_gostr3412_2015_kuznyechik_kexp15 = 1183;

  SN_id_tc26_constants = AnsiString('id-tc26-constants');
  NID_id_tc26_constants = 994;

  SN_id_tc26_sign_constants = AnsiString('id-tc26-sign-constants');
  NID_id_tc26_sign_constants = 995;

  SN_id_tc26_gost_3410_2012_256_constants = AnsiString('id-tc26-gost-3410-2012-256-constants');
  NID_id_tc26_gost_3410_2012_256_constants = 1147;

  SN_id_tc26_gost_3410_2012_256_paramSetA = AnsiString('id-tc26-gost-3410-2012-256-paramSetA');
  LN_id_tc26_gost_3410_2012_256_paramSetA = AnsiString('GOST R 34.10-2012(256 bit)ParamSet A');
  NID_id_tc26_gost_3410_2012_256_paramSetA = 1148;

  SN_id_tc26_gost_3410_2012_256_paramSetB = AnsiString('id-tc26-gost-3410-2012-256-paramSetB');
  LN_id_tc26_gost_3410_2012_256_paramSetB = AnsiString('GOST R 34.10-2012(256 bit)ParamSet B');
  NID_id_tc26_gost_3410_2012_256_paramSetB = 1184;

  SN_id_tc26_gost_3410_2012_256_paramSetC = AnsiString('id-tc26-gost-3410-2012-256-paramSetC');
  LN_id_tc26_gost_3410_2012_256_paramSetC = AnsiString('GOST R 34.10-2012(256 bit)ParamSet C');
  NID_id_tc26_gost_3410_2012_256_paramSetC = 1185;

  SN_id_tc26_gost_3410_2012_256_paramSetD = AnsiString('id-tc26-gost-3410-2012-256-paramSetD');
  LN_id_tc26_gost_3410_2012_256_paramSetD = AnsiString('GOST R 34.10-2012(256 bit)ParamSet D');
  NID_id_tc26_gost_3410_2012_256_paramSetD = 1186;

  SN_id_tc26_gost_3410_2012_512_constants = AnsiString('id-tc26-gost-3410-2012-512-constants');
  NID_id_tc26_gost_3410_2012_512_constants = 996;

  SN_id_tc26_gost_3410_2012_512_paramSetTest = AnsiString('id-tc26-gost-3410-2012-512-paramSetTest');
  LN_id_tc26_gost_3410_2012_512_paramSetTest = AnsiString('GOST R 34.10-2012(512 bit)testing parameter set');
  NID_id_tc26_gost_3410_2012_512_paramSetTest = 997;

  SN_id_tc26_gost_3410_2012_512_paramSetA = AnsiString('id-tc26-gost-3410-2012-512-paramSetA');
  LN_id_tc26_gost_3410_2012_512_paramSetA = AnsiString('GOST R 34.10-2012(512 bit)ParamSet A');
  NID_id_tc26_gost_3410_2012_512_paramSetA = 998;

  SN_id_tc26_gost_3410_2012_512_paramSetB = AnsiString('id-tc26-gost-3410-2012-512-paramSetB');
  LN_id_tc26_gost_3410_2012_512_paramSetB = AnsiString('GOST R 34.10-2012(512 bit)ParamSet B');
  NID_id_tc26_gost_3410_2012_512_paramSetB = 999;

  SN_id_tc26_gost_3410_2012_512_paramSetC = AnsiString('id-tc26-gost-3410-2012-512-paramSetC');
  LN_id_tc26_gost_3410_2012_512_paramSetC = AnsiString('GOST R 34.10-2012(512 bit)ParamSet C');
  NID_id_tc26_gost_3410_2012_512_paramSetC = 1149;

  SN_id_tc26_digest_constants = AnsiString('id-tc26-digest-constants');
  NID_id_tc26_digest_constants = 1000;

  SN_id_tc26_cipher_constants = AnsiString('id-tc26-cipher-constants');
  NID_id_tc26_cipher_constants = 1001;

  SN_id_tc26_gost_28147_constants = AnsiString('id-tc26-gost-28147-constants');
  NID_id_tc26_gost_28147_constants = 1002;

  SN_id_tc26_gost_28147_param_Z = AnsiString('id-tc26-gost-28147-param-Z');
  LN_id_tc26_gost_28147_param_Z = AnsiString('GOST 28147-89 TC26 parameter set');
  NID_id_tc26_gost_28147_param_Z = 1003;

  SN_INN = AnsiString('INN');
  LN_INN = AnsiString('INN');
  NID_INN = 1004;

  SN_OGRN = AnsiString('OGRN');
  LN_OGRN = AnsiString('OGRN');
  NID_OGRN = 1005;

  SN_SNILS = AnsiString('SNILS');
  LN_SNILS = AnsiString('SNILS');
  NID_SNILS = 1006;

  SN_subjectSignTool = AnsiString('subjectSignTool');
  LN_subjectSignTool = AnsiString('Signing Tool of Subject');
  NID_subjectSignTool = 1007;

  SN_issuerSignTool = AnsiString('issuerSignTool');
  LN_issuerSignTool = AnsiString('Signing Tool of Issuer');
  NID_issuerSignTool = 1008;

  SN_grasshopper_ecb = AnsiString('grasshopper-ecb');
  NID_grasshopper_ecb = 1012;

  SN_grasshopper_ctr = AnsiString('grasshopper-ctr');
  NID_grasshopper_ctr = 1013;

  SN_grasshopper_ofb = AnsiString('grasshopper-ofb');
  NID_grasshopper_ofb = 1014;

  SN_grasshopper_cbc = AnsiString('grasshopper-cbc');
  NID_grasshopper_cbc = 1015;

  SN_grasshopper_cfb = AnsiString('grasshopper-cfb');
  NID_grasshopper_cfb = 1016;

  SN_grasshopper_mac = AnsiString('grasshopper-mac');
  NID_grasshopper_mac = 1017;

  SN_magma_ecb = AnsiString('magma-ecb');
  NID_magma_ecb = 1187;

  SN_magma_ctr = AnsiString('magma-ctr');
  NID_magma_ctr = 1188;

  SN_magma_ofb = AnsiString('magma-ofb');
  NID_magma_ofb = 1189;

  SN_magma_cbc = AnsiString('magma-cbc');
  NID_magma_cbc = 1190;

  SN_magma_cfb = AnsiString('magma-cfb');
  NID_magma_cfb = 1191;

  SN_magma_mac = AnsiString('magma-mac');
  NID_magma_mac = 1192;

  SN_camellia_128_cbc = AnsiString('CAMELLIA-128-CBC');
  LN_camellia_128_cbc = AnsiString('camellia-128-cbc');
  NID_camellia_128_cbc = 751;

  SN_camellia_192_cbc = AnsiString('CAMELLIA-192-CBC');
  LN_camellia_192_cbc = AnsiString('camellia-192-cbc');
  NID_camellia_192_cbc = 752;

  SN_camellia_256_cbc = AnsiString('CAMELLIA-256-CBC');
  LN_camellia_256_cbc = AnsiString('camellia-256-cbc');
  NID_camellia_256_cbc = 753;

  SN_id_camellia128_wrap = AnsiString('id-camellia128-wrap');
  NID_id_camellia128_wrap = 907;

  SN_id_camellia192_wrap = AnsiString('id-camellia192-wrap');
  NID_id_camellia192_wrap = 908;

  SN_id_camellia256_wrap = AnsiString('id-camellia256-wrap');
  NID_id_camellia256_wrap = 909;

  SN_camellia_128_ecb = AnsiString('CAMELLIA-128-ECB');
  LN_camellia_128_ecb = AnsiString('camellia-128-ecb');
  NID_camellia_128_ecb = 754;

  SN_camellia_128_ofb128 = AnsiString('CAMELLIA-128-OFB');
  LN_camellia_128_ofb128 = AnsiString('camellia-128-ofb');
  NID_camellia_128_ofb128 = 766;

  SN_camellia_128_cfb128 = AnsiString('CAMELLIA-128-CFB');
  LN_camellia_128_cfb128 = AnsiString('camellia-128-cfb');
  NID_camellia_128_cfb128 = 757;

  SN_camellia_128_gcm = AnsiString('CAMELLIA-128-GCM');
  LN_camellia_128_gcm = AnsiString('camellia-128-gcm');
  NID_camellia_128_gcm = 961;

  SN_camellia_128_ccm = AnsiString('CAMELLIA-128-CCM');
  LN_camellia_128_ccm = AnsiString('camellia-128-ccm');
  NID_camellia_128_ccm = 962;

  SN_camellia_128_ctr = AnsiString('CAMELLIA-128-CTR');
  LN_camellia_128_ctr = AnsiString('camellia-128-ctr');
  NID_camellia_128_ctr = 963;

  SN_camellia_128_cmac = AnsiString('CAMELLIA-128-CMAC');
  LN_camellia_128_cmac = AnsiString('camellia-128-cmac');
  NID_camellia_128_cmac = 964;

  SN_camellia_192_ecb = AnsiString('CAMELLIA-192-ECB');
  LN_camellia_192_ecb = AnsiString('camellia-192-ecb');
  NID_camellia_192_ecb = 755;

  SN_camellia_192_ofb128 = AnsiString('CAMELLIA-192-OFB');
  LN_camellia_192_ofb128 = AnsiString('camellia-192-ofb');
  NID_camellia_192_ofb128 = 767;

  SN_camellia_192_cfb128 = AnsiString('CAMELLIA-192-CFB');
  LN_camellia_192_cfb128 = AnsiString('camellia-192-cfb');
  NID_camellia_192_cfb128 = 758;

  SN_camellia_192_gcm = AnsiString('CAMELLIA-192-GCM');
  LN_camellia_192_gcm = AnsiString('camellia-192-gcm');
  NID_camellia_192_gcm = 965;

  SN_camellia_192_ccm = AnsiString('CAMELLIA-192-CCM');
  LN_camellia_192_ccm = AnsiString('camellia-192-ccm');
  NID_camellia_192_ccm = 966;

  SN_camellia_192_ctr = AnsiString('CAMELLIA-192-CTR');
  LN_camellia_192_ctr = AnsiString('camellia-192-ctr');
  NID_camellia_192_ctr = 967;

  SN_camellia_192_cmac = AnsiString('CAMELLIA-192-CMAC');
  LN_camellia_192_cmac = AnsiString('camellia-192-cmac');
  NID_camellia_192_cmac = 968;

  SN_camellia_256_ecb = AnsiString('CAMELLIA-256-ECB');
  LN_camellia_256_ecb = AnsiString('camellia-256-ecb');
  NID_camellia_256_ecb = 756;

  SN_camellia_256_ofb128 = AnsiString('CAMELLIA-256-OFB');
  LN_camellia_256_ofb128 = AnsiString('camellia-256-ofb');
  NID_camellia_256_ofb128 = 768;

  SN_camellia_256_cfb128 = AnsiString('CAMELLIA-256-CFB');
  LN_camellia_256_cfb128 = AnsiString('camellia-256-cfb');
  NID_camellia_256_cfb128 = 759;

  SN_camellia_256_gcm = AnsiString('CAMELLIA-256-GCM');
  LN_camellia_256_gcm = AnsiString('camellia-256-gcm');
  NID_camellia_256_gcm = 969;

  SN_camellia_256_ccm = AnsiString('CAMELLIA-256-CCM');
  LN_camellia_256_ccm = AnsiString('camellia-256-ccm');
  NID_camellia_256_ccm = 970;

  SN_camellia_256_ctr = AnsiString('CAMELLIA-256-CTR');
  LN_camellia_256_ctr = AnsiString('camellia-256-ctr');
  NID_camellia_256_ctr = 971;

  SN_camellia_256_cmac = AnsiString('CAMELLIA-256-CMAC');
  LN_camellia_256_cmac = AnsiString('camellia-256-cmac');
  NID_camellia_256_cmac = 972;

  SN_camellia_128_cfb1 = AnsiString('CAMELLIA-128-CFB1');
  LN_camellia_128_cfb1 = AnsiString('camellia-128-cfb1');
  NID_camellia_128_cfb1 = 760;

  SN_camellia_192_cfb1 = AnsiString('CAMELLIA-192-CFB1');
  LN_camellia_192_cfb1 = AnsiString('camellia-192-cfb1');
  NID_camellia_192_cfb1 = 761;

  SN_camellia_256_cfb1 = AnsiString('CAMELLIA-256-CFB1');
  LN_camellia_256_cfb1 = AnsiString('camellia-256-cfb1');
  NID_camellia_256_cfb1 = 762;

  SN_camellia_128_cfb8 = AnsiString('CAMELLIA-128-CFB8');
  LN_camellia_128_cfb8 = AnsiString('camellia-128-cfb8');
  NID_camellia_128_cfb8 = 763;

  SN_camellia_192_cfb8 = AnsiString('CAMELLIA-192-CFB8');
  LN_camellia_192_cfb8 = AnsiString('camellia-192-cfb8');
  NID_camellia_192_cfb8 = 764;

  SN_camellia_256_cfb8 = AnsiString('CAMELLIA-256-CFB8');
  LN_camellia_256_cfb8 = AnsiString('camellia-256-cfb8');
  NID_camellia_256_cfb8 = 765;

  SN_aria_128_ecb = AnsiString('ARIA-128-ECB');
  LN_aria_128_ecb = AnsiString('aria-128-ecb');
  NID_aria_128_ecb = 1065;

  SN_aria_128_cbc = AnsiString('ARIA-128-CBC');
  LN_aria_128_cbc = AnsiString('aria-128-cbc');
  NID_aria_128_cbc = 1066;

  SN_aria_128_cfb128 = AnsiString('ARIA-128-CFB');
  LN_aria_128_cfb128 = AnsiString('aria-128-cfb');
  NID_aria_128_cfb128 = 1067;

  SN_aria_128_ofb128 = AnsiString('ARIA-128-OFB');
  LN_aria_128_ofb128 = AnsiString('aria-128-ofb');
  NID_aria_128_ofb128 = 1068;

  SN_aria_128_ctr = AnsiString('ARIA-128-CTR');
  LN_aria_128_ctr = AnsiString('aria-128-ctr');
  NID_aria_128_ctr = 1069;

  SN_aria_192_ecb = AnsiString('ARIA-192-ECB');
  LN_aria_192_ecb = AnsiString('aria-192-ecb');
  NID_aria_192_ecb = 1070;

  SN_aria_192_cbc = AnsiString('ARIA-192-CBC');
  LN_aria_192_cbc = AnsiString('aria-192-cbc');
  NID_aria_192_cbc = 1071;

  SN_aria_192_cfb128 = AnsiString('ARIA-192-CFB');
  LN_aria_192_cfb128 = AnsiString('aria-192-cfb');
  NID_aria_192_cfb128 = 1072;

  SN_aria_192_ofb128 = AnsiString('ARIA-192-OFB');
  LN_aria_192_ofb128 = AnsiString('aria-192-ofb');
  NID_aria_192_ofb128 = 1073;

  SN_aria_192_ctr = AnsiString('ARIA-192-CTR');
  LN_aria_192_ctr = AnsiString('aria-192-ctr');
  NID_aria_192_ctr = 1074;

  SN_aria_256_ecb = AnsiString('ARIA-256-ECB');
  LN_aria_256_ecb = AnsiString('aria-256-ecb');
  NID_aria_256_ecb = 1075;

  SN_aria_256_cbc = AnsiString('ARIA-256-CBC');
  LN_aria_256_cbc = AnsiString('aria-256-cbc');
  NID_aria_256_cbc = 1076;

  SN_aria_256_cfb128 = AnsiString('ARIA-256-CFB');
  LN_aria_256_cfb128 = AnsiString('aria-256-cfb');
  NID_aria_256_cfb128 = 1077;

  SN_aria_256_ofb128 = AnsiString('ARIA-256-OFB');
  LN_aria_256_ofb128 = AnsiString('aria-256-ofb');
  NID_aria_256_ofb128 = 1078;

  SN_aria_256_ctr = AnsiString('ARIA-256-CTR');
  LN_aria_256_ctr = AnsiString('aria-256-ctr');
  NID_aria_256_ctr = 1079;

  SN_aria_128_cfb1 = AnsiString('ARIA-128-CFB1');
  LN_aria_128_cfb1 = AnsiString('aria-128-cfb1');
  NID_aria_128_cfb1 = 1080;

  SN_aria_192_cfb1 = AnsiString('ARIA-192-CFB1');
  LN_aria_192_cfb1 = AnsiString('aria-192-cfb1');
  NID_aria_192_cfb1 = 1081;

  SN_aria_256_cfb1 = AnsiString('ARIA-256-CFB1');
  LN_aria_256_cfb1 = AnsiString('aria-256-cfb1');
  NID_aria_256_cfb1 = 1082;

  SN_aria_128_cfb8 = AnsiString('ARIA-128-CFB8');
  LN_aria_128_cfb8 = AnsiString('aria-128-cfb8');
  NID_aria_128_cfb8 = 1083;

  SN_aria_192_cfb8 = AnsiString('ARIA-192-CFB8');
  LN_aria_192_cfb8 = AnsiString('aria-192-cfb8');
  NID_aria_192_cfb8 = 1084;

  SN_aria_256_cfb8 = AnsiString('ARIA-256-CFB8');
  LN_aria_256_cfb8 = AnsiString('aria-256-cfb8');
  NID_aria_256_cfb8 = 1085;

  SN_aria_128_ccm = AnsiString('ARIA-128-CCM');
  LN_aria_128_ccm = AnsiString('aria-128-ccm');
  NID_aria_128_ccm = 1120;

  SN_aria_192_ccm = AnsiString('ARIA-192-CCM');
  LN_aria_192_ccm = AnsiString('aria-192-ccm');
  NID_aria_192_ccm = 1121;

  SN_aria_256_ccm = AnsiString('ARIA-256-CCM');
  LN_aria_256_ccm = AnsiString('aria-256-ccm');
  NID_aria_256_ccm = 1122;

  SN_aria_128_gcm = AnsiString('ARIA-128-GCM');
  LN_aria_128_gcm = AnsiString('aria-128-gcm');
  NID_aria_128_gcm = 1123;

  SN_aria_192_gcm = AnsiString('ARIA-192-GCM');
  LN_aria_192_gcm = AnsiString('aria-192-gcm');
  NID_aria_192_gcm = 1124;

  SN_aria_256_gcm = AnsiString('ARIA-256-GCM');
  LN_aria_256_gcm = AnsiString('aria-256-gcm');
  NID_aria_256_gcm = 1125;

  SN_kisa = AnsiString('KISA');
  LN_kisa = AnsiString('kisa');
  NID_kisa = 773;

  SN_seed_ecb = AnsiString('SEED-ECB');
  LN_seed_ecb = AnsiString('seed-ecb');
  NID_seed_ecb = 776;

  SN_seed_cbc = AnsiString('SEED-CBC');
  LN_seed_cbc = AnsiString('seed-cbc');
  NID_seed_cbc = 777;

  SN_seed_cfb128 = AnsiString('SEED-CFB');
  LN_seed_cfb128 = AnsiString('seed-cfb');
  NID_seed_cfb128 = 779;

  SN_seed_ofb128 = AnsiString('SEED-OFB');
  LN_seed_ofb128 = AnsiString('seed-ofb');
  NID_seed_ofb128 = 778;

  SN_sm4_ecb = AnsiString('SM4-ECB');
  LN_sm4_ecb = AnsiString('sm4-ecb');
  NID_sm4_ecb = 1133;

  SN_sm4_cbc = AnsiString('SM4-CBC');
  LN_sm4_cbc = AnsiString('sm4-cbc');
  NID_sm4_cbc = 1134;

  SN_sm4_ofb128 = AnsiString('SM4-OFB');
  LN_sm4_ofb128 = AnsiString('sm4-ofb');
  NID_sm4_ofb128 = 1135;

  SN_sm4_cfb128 = AnsiString('SM4-CFB');
  LN_sm4_cfb128 = AnsiString('sm4-cfb');
  NID_sm4_cfb128 = 1137;

  SN_sm4_cfb1 = AnsiString('SM4-CFB1');
  LN_sm4_cfb1 = AnsiString('sm4-cfb1');
  NID_sm4_cfb1 = 1136;

  SN_sm4_cfb8 = AnsiString('SM4-CFB8');
  LN_sm4_cfb8 = AnsiString('sm4-cfb8');
  NID_sm4_cfb8 = 1138;

  SN_sm4_ctr = AnsiString('SM4-CTR');
  LN_sm4_ctr = AnsiString('sm4-ctr');
  NID_sm4_ctr = 1139;

  SN_hmac = AnsiString('HMAC');
  LN_hmac = AnsiString('hmac');
  NID_hmac = 855;

  SN_cmac = AnsiString('CMAC');
  LN_cmac = AnsiString('cmac');
  NID_cmac = 894;

  SN_rc4_hmac_md5 = AnsiString('RC4-HMAC-MD5');
  LN_rc4_hmac_md5 = AnsiString('rc4-hmac-md5');
  NID_rc4_hmac_md5 = 915;

  SN_aes_128_cbc_hmac_sha1 = AnsiString('AES-128-CBC-HMAC-SHA1');
  LN_aes_128_cbc_hmac_sha1 = AnsiString('aes-128-cbc-hmac-sha1');
  NID_aes_128_cbc_hmac_sha1 = 916;

  SN_aes_192_cbc_hmac_sha1 = AnsiString('AES-192-CBC-HMAC-SHA1');
  LN_aes_192_cbc_hmac_sha1 = AnsiString('aes-192-cbc-hmac-sha1');
  NID_aes_192_cbc_hmac_sha1 = 917;

  SN_aes_256_cbc_hmac_sha1 = AnsiString('AES-256-CBC-HMAC-SHA1');
  LN_aes_256_cbc_hmac_sha1 = AnsiString('aes-256-cbc-hmac-sha1');
  NID_aes_256_cbc_hmac_sha1 = 918;

  SN_aes_128_cbc_hmac_sha256 = AnsiString('AES-128-CBC-HMAC-SHA256');
  LN_aes_128_cbc_hmac_sha256 = AnsiString('aes-128-cbc-hmac-sha256');
  NID_aes_128_cbc_hmac_sha256 = 948;

  SN_aes_192_cbc_hmac_sha256 = AnsiString('AES-192-CBC-HMAC-SHA256');
  LN_aes_192_cbc_hmac_sha256 = AnsiString('aes-192-cbc-hmac-sha256');
  NID_aes_192_cbc_hmac_sha256 = 949;

  SN_aes_256_cbc_hmac_sha256 = AnsiString('AES-256-CBC-HMAC-SHA256');
  LN_aes_256_cbc_hmac_sha256 = AnsiString('aes-256-cbc-hmac-sha256');
  NID_aes_256_cbc_hmac_sha256 = 950;

  SN_chacha20_poly1305 = AnsiString('ChaCha20-Poly1305');
  LN_chacha20_poly1305 = AnsiString('chacha20-poly1305');
  NID_chacha20_poly1305 = 1018;

  SN_chacha20 = AnsiString('ChaCha20');
  LN_chacha20 = AnsiString('chacha20');
  NID_chacha20 = 1019;

  SN_dhpublicnumber = AnsiString('dhpublicnumber');
  LN_dhpublicnumber = AnsiString('X9.42 DH');
  NID_dhpublicnumber = 920;

  SN_brainpoolP160r1 = AnsiString('brainpoolP160r1');
  NID_brainpoolP160r1 = 921;

  SN_brainpoolP160t1 = AnsiString('brainpoolP160t1');
  NID_brainpoolP160t1 = 922;

  SN_brainpoolP192r1 = AnsiString('brainpoolP192r1');
  NID_brainpoolP192r1 = 923;

  SN_brainpoolP192t1 = AnsiString('brainpoolP192t1');
  NID_brainpoolP192t1 = 924;

  SN_brainpoolP224r1 = AnsiString('brainpoolP224r1');
  NID_brainpoolP224r1 = 925;

  SN_brainpoolP224t1 = AnsiString('brainpoolP224t1');
  NID_brainpoolP224t1 = 926;

  SN_brainpoolP256r1 = AnsiString('brainpoolP256r1');
  NID_brainpoolP256r1 = 927;

  SN_brainpoolP256t1 = AnsiString('brainpoolP256t1');
  NID_brainpoolP256t1 = 928;

  SN_brainpoolP320r1 = AnsiString('brainpoolP320r1');
  NID_brainpoolP320r1 = 929;

  SN_brainpoolP320t1 = AnsiString('brainpoolP320t1');
  NID_brainpoolP320t1 = 930;

  SN_brainpoolP384r1 = AnsiString('brainpoolP384r1');
  NID_brainpoolP384r1 = 931;

  SN_brainpoolP384t1 = AnsiString('brainpoolP384t1');
  NID_brainpoolP384t1 = 932;

  SN_brainpoolP512r1 = AnsiString('brainpoolP512r1');
  NID_brainpoolP512r1 = 933;

  SN_brainpoolP512t1 = AnsiString('brainpoolP512t1');
  NID_brainpoolP512t1 = 934;

  SN_dhSinglePass_stdDH_sha1kdf_scheme = AnsiString('dhSinglePass-stdDH-sha1kdf-scheme');
  NID_dhSinglePass_stdDH_sha1kdf_scheme = 936;

  SN_dhSinglePass_stdDH_sha224kdf_scheme = AnsiString('dhSinglePass-stdDH-sha224kdf-scheme');
  NID_dhSinglePass_stdDH_sha224kdf_scheme = 937;

  SN_dhSinglePass_stdDH_sha256kdf_scheme = AnsiString('dhSinglePass-stdDH-sha256kdf-scheme');
  NID_dhSinglePass_stdDH_sha256kdf_scheme = 938;

  SN_dhSinglePass_stdDH_sha384kdf_scheme = AnsiString('dhSinglePass-stdDH-sha384kdf-scheme');
  NID_dhSinglePass_stdDH_sha384kdf_scheme = 939;

  SN_dhSinglePass_stdDH_sha512kdf_scheme = AnsiString('dhSinglePass-stdDH-sha512kdf-scheme');
  NID_dhSinglePass_stdDH_sha512kdf_scheme = 940;

  SN_dhSinglePass_cofactorDH_sha1kdf_scheme = AnsiString('dhSinglePass-cofactorDH-sha1kdf-scheme');
  NID_dhSinglePass_cofactorDH_sha1kdf_scheme = 941;

  SN_dhSinglePass_cofactorDH_sha224kdf_scheme = AnsiString('dhSinglePass-cofactorDH-sha224kdf-scheme');
  NID_dhSinglePass_cofactorDH_sha224kdf_scheme = 942;

  SN_dhSinglePass_cofactorDH_sha256kdf_scheme = AnsiString('dhSinglePass-cofactorDH-sha256kdf-scheme');
  NID_dhSinglePass_cofactorDH_sha256kdf_scheme = 943;

  SN_dhSinglePass_cofactorDH_sha384kdf_scheme = AnsiString('dhSinglePass-cofactorDH-sha384kdf-scheme');
  NID_dhSinglePass_cofactorDH_sha384kdf_scheme = 944;

  SN_dhSinglePass_cofactorDH_sha512kdf_scheme = AnsiString('dhSinglePass-cofactorDH-sha512kdf-scheme');
  NID_dhSinglePass_cofactorDH_sha512kdf_scheme = 945;

  SN_dh_std_kdf = AnsiString('dh-std-kdf');
  NID_dh_std_kdf = 946;

  SN_dh_cofactor_kdf = AnsiString('dh-cofactor-kdf');
  NID_dh_cofactor_kdf = 947;

  SN_ct_precert_scts = AnsiString('ct_precert_scts');
  LN_ct_precert_scts = AnsiString('CT Precertificate SCTs');
  NID_ct_precert_scts = 951;

  SN_ct_precert_poison = AnsiString('ct_precert_poison');
  LN_ct_precert_poison = AnsiString('CT Precertificate Poison');
  NID_ct_precert_poison = 952;

  SN_ct_precert_signer = AnsiString('ct_precert_signer');
  LN_ct_precert_signer = AnsiString('CT Precertificate Signer');
  NID_ct_precert_signer = 953;

  SN_ct_cert_scts = AnsiString('ct_cert_scts');
  LN_ct_cert_scts = AnsiString('CT Certificate SCTs');
  NID_ct_cert_scts = 954;

  SN_jurisdictionLocalityName = AnsiString('jurisdictionL');
  LN_jurisdictionLocalityName = AnsiString('jurisdictionLocalityName');
  NID_jurisdictionLocalityName = 955;

  SN_jurisdictionStateOrProvinceName = AnsiString('jurisdictionST');
  LN_jurisdictionStateOrProvinceName = AnsiString('jurisdictionStateOrProvinceName');
  NID_jurisdictionStateOrProvinceName = 956;

  SN_jurisdictionCountryName = AnsiString('jurisdictionC');
  LN_jurisdictionCountryName = AnsiString('jurisdictionCountryName');
  NID_jurisdictionCountryName = 957;

  SN_id_scrypt = AnsiString('id-scrypt');
  LN_id_scrypt = AnsiString('scrypt');
  NID_id_scrypt = 973;

  SN_tls1_prf = AnsiString('TLS1-PRF');
  LN_tls1_prf = AnsiString('tls1-prf');
  NID_tls1_prf = 1021;

  SN_hkdf = AnsiString('HKDF');
  LN_hkdf = AnsiString('hkdf');
  NID_hkdf = 1036;

  SN_id_pkinit = AnsiString('id-pkinit');
  NID_id_pkinit = 1031;

  SN_pkInitClientAuth = AnsiString('pkInitClientAuth');
  LN_pkInitClientAuth = AnsiString('PKINIT Client Auth');
  NID_pkInitClientAuth = 1032;

  SN_pkInitKDC = AnsiString('pkInitKDC');
  LN_pkInitKDC = AnsiString('Signing KDC Response');
  NID_pkInitKDC = 1033;

  SN_X25519 = AnsiString('X25519');
  NID_X25519 = 1034;

  SN_X448 = AnsiString('X448');
  NID_X448 = 1035;

  SN_ED25519 = AnsiString('ED25519');
  NID_ED25519 = 1087;

  SN_ED448 = AnsiString('ED448');
  NID_ED448 = 1088;

  SN_kx_rsa = AnsiString('KxRSA');
  LN_kx_rsa = AnsiString('kx-rsa');
  NID_kx_rsa = 1037;

  SN_kx_ecdhe = AnsiString('KxECDHE');
  LN_kx_ecdhe = AnsiString('kx-ecdhe');
  NID_kx_ecdhe = 1038;

  SN_kx_dhe = AnsiString('KxDHE');
  LN_kx_dhe = AnsiString('kx-dhe');
  NID_kx_dhe = 1039;

  SN_kx_ecdhe_psk = AnsiString('KxECDHE-PSK');
  LN_kx_ecdhe_psk = AnsiString('kx-ecdhe-psk');
  NID_kx_ecdhe_psk = 1040;

  SN_kx_dhe_psk = AnsiString('KxDHE-PSK');
  LN_kx_dhe_psk = AnsiString('kx-dhe-psk');
  NID_kx_dhe_psk = 1041;

  SN_kx_rsa_psk = AnsiString('KxRSA_PSK');
  LN_kx_rsa_psk = AnsiString('kx-rsa-psk');
  NID_kx_rsa_psk = 1042;

  SN_kx_psk = AnsiString('KxPSK');
  LN_kx_psk = AnsiString('kx-psk');
  NID_kx_psk = 1043;

  SN_kx_srp = AnsiString('KxSRP');
  LN_kx_srp = AnsiString('kx-srp');
  NID_kx_srp = 1044;

  SN_kx_gost = AnsiString('KxGOST');
  LN_kx_gost = AnsiString('kx-gost');
  NID_kx_gost = 1045;

  SN_kx_any = AnsiString('KxANY');
  LN_kx_any = AnsiString('kx-any');
  NID_kx_any = 1063;

  SN_auth_rsa = AnsiString('AuthRSA');
  LN_auth_rsa = AnsiString('auth-rsa');
  NID_auth_rsa = 1046;

  SN_auth_ecdsa = AnsiString('AuthECDSA');
  LN_auth_ecdsa = AnsiString('auth-ecdsa');
  NID_auth_ecdsa = 1047;

  SN_auth_psk = AnsiString('AuthPSK');
  LN_auth_psk = AnsiString('auth-psk');
  NID_auth_psk = 1048;

  SN_auth_dss = AnsiString('AuthDSS');
  LN_auth_dss = AnsiString('auth-dss');
  NID_auth_dss = 1049;

  SN_auth_gost01 = AnsiString('AuthGOST01');
  LN_auth_gost01 = AnsiString('auth-gost01');
  NID_auth_gost01 = 1050;

  SN_auth_gost12 = AnsiString('AuthGOST12');
  LN_auth_gost12 = AnsiString('auth-gost12');
  NID_auth_gost12 = 1051;

  SN_auth_srp = AnsiString('AuthSRP');
  LN_auth_srp = AnsiString('auth-srp');
  NID_auth_srp = 1052;

  SN_auth_null = AnsiString('AuthNULL');
  LN_auth_null = AnsiString('auth-null');
  NID_auth_null = 1053;

  SN_auth_any = AnsiString('AuthANY');
  LN_auth_any = AnsiString('auth-any');
  NID_auth_any = 1064;

  SN_poly1305 = AnsiString('Poly1305');
  LN_poly1305 = AnsiString('poly1305');
  NID_poly1305 = 1061;

  SN_siphash = AnsiString('SipHash');
  LN_siphash = AnsiString('siphash');
  NID_siphash = 1062;

  SN_ffdhe2048 = AnsiString('ffdhe2048');
  NID_ffdhe2048 = 1126;

  SN_ffdhe3072 = AnsiString('ffdhe3072');
  NID_ffdhe3072 = 1127;

  SN_ffdhe4096 = AnsiString('ffdhe4096');
  NID_ffdhe4096 = 1128;

  SN_ffdhe6144 = AnsiString('ffdhe6144');
  NID_ffdhe6144 = 1129;

  SN_ffdhe8192 = AnsiString('ffdhe8192');
  NID_ffdhe8192 = 1130;

  SN_ISO_UA = AnsiString('ISO-UA');
  NID_ISO_UA = 1150;

  SN_ua_pki = AnsiString('ua-pki');
  NID_ua_pki = 1151;

  SN_dstu28147 = AnsiString('dstu28147');
  LN_dstu28147 = AnsiString('DSTU Gost 28147-2009');
  NID_dstu28147 = 1152;

  SN_dstu28147_ofb = AnsiString('dstu28147-ofb');
  LN_dstu28147_ofb = AnsiString('DSTU Gost 28147-2009 OFB mode');
  NID_dstu28147_ofb = 1153;

  SN_dstu28147_cfb = AnsiString('dstu28147-cfb');
  LN_dstu28147_cfb = AnsiString('DSTU Gost 28147-2009 CFB mode');
  NID_dstu28147_cfb = 1154;

  SN_dstu28147_wrap = AnsiString('dstu28147-wrap');
  LN_dstu28147_wrap = AnsiString('DSTU Gost 28147-2009 key wrap');
  NID_dstu28147_wrap = 1155;

  SN_hmacWithDstu34311 = AnsiString('hmacWithDstu34311');
  LN_hmacWithDstu34311 = AnsiString('HMAC DSTU Gost 34311-95');
  NID_hmacWithDstu34311 = 1156;

  SN_dstu34311 = AnsiString('dstu34311');
  LN_dstu34311 = AnsiString('DSTU Gost 34311-95');
  NID_dstu34311 = 1157;

  SN_dstu4145le = AnsiString('dstu4145le');
  LN_dstu4145le = AnsiString('DSTU 4145-2002 little endian');
  NID_dstu4145le = 1158;

  SN_dstu4145be = AnsiString('dstu4145be');
  LN_dstu4145be = AnsiString('DSTU 4145-2002 big endian');
  NID_dstu4145be = 1159;

  SN_uacurve0 = AnsiString('uacurve0');
  LN_uacurve0 = AnsiString('DSTU curve 0');
  NID_uacurve0 = 1160;

  SN_uacurve1 = AnsiString('uacurve1');
  LN_uacurve1 = AnsiString('DSTU curve 1');
  NID_uacurve1 = 1161;

  SN_uacurve2 = AnsiString('uacurve2');
  LN_uacurve2 = AnsiString('DSTU curve 2');
  NID_uacurve2 = 1162;

  SN_uacurve3 = AnsiString('uacurve3');
  LN_uacurve3 = AnsiString('DSTU curve 3');
  NID_uacurve3 = 1163;

  SN_uacurve4 = AnsiString('uacurve4');
  LN_uacurve4 = AnsiString('DSTU curve 4');
  NID_uacurve4 = 1164;

  SN_uacurve5 = AnsiString('uacurve5');
  LN_uacurve5 = AnsiString('DSTU curve 5');
  NID_uacurve5 = 1165;

  SN_uacurve6 = AnsiString('uacurve6');
  LN_uacurve6 = AnsiString('DSTU curve 6');
  NID_uacurve6 = 1166;

  SN_uacurve7 = AnsiString('uacurve7');
  LN_uacurve7 = AnsiString('DSTU curve 7');
  NID_uacurve7 = 1167;

  SN_uacurve8 = AnsiString('uacurve8');
  LN_uacurve8 = AnsiString('DSTU curve 8');
  NID_uacurve8 = 1168;

  SN_uacurve9 = AnsiString('uacurve9');
  LN_uacurve9 = AnsiString('DSTU curve 9');
  NID_uacurve9 = 1169;

implementation

end.
